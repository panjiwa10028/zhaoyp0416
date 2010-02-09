/*
 *  Copyright (c) Northwoods Software Corporation, 2000-2008. All Rights
 *  Reserved.
 *
 *  Restricted Rights: Use, duplication, or disclosure by the U.S.
 *  Government is subject to restrictions as set forth in subparagraph
 *  (c) (1) (ii) of DFARS 252.227-7013, or in FAR 52.227-19, or in FAR
 *  52.227-14 Alt. III, as applicable.
 *
 */

package com.ivr;

import java.awt.Color;
import java.awt.Component;
import java.awt.Rectangle;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import com.ivr.components.ComponentsNode;
import com.ivr.components.ComponentsPort;
import com.ivr.components.prompt.PromptNode;
import com.ivr.components.start.StartNode;
import com.ivr.components.stop.StopNode;
import com.ivr.flow.FlowLink;
import com.ivr.utils.Constant;
import com.nwoods.jgo.JGoBasicNode;
import com.nwoods.jgo.JGoDocument;
import com.nwoods.jgo.JGoDocumentChangedEdit;
import com.nwoods.jgo.JGoDocumentEvent;
import com.nwoods.jgo.JGoLink;
import com.nwoods.jgo.JGoListPosition;
import com.nwoods.jgo.JGoObject;
import com.nwoods.jgo.JGoPen;
import com.nwoods.jgo.JGoPort;
import com.nwoods.jgo.JGoText;
import com.nwoods.jgo.JGoUndoManager;


// Implement the Process model data structure container.
// This class is responsible for loading and storing documents to files,
// and for creating activities (nodes) and flows (links).
//
// ProcessDocument, for this example app, has just a few properties:
// Name, Location and Link Pen.
// The latter two may appear to belong to a view instead of being
// part of a document, but here these attributes can be conveniently
// stored persistently.
public class ProcessDocument extends JGoDocument
{
  public ProcessDocument()
  {
    setMaintainsPartID(true);
    setUndoManager(new JGoUndoManager());
    setLinksLayer(addLayerAfter(getFirstLayer()));
  }


  // Basic properties: name and location (pathname)

  public String getName()
  {
    return myName;
  }

  public void setName(String newname)
  {
    String oldName = myName;
    if (!oldName.equals(newname)) {
      myName = newname;
      fireUpdate(NAME_CHANGED, 0, null, 0, oldName);
    }
  }


  public String getLocation()
  {
    return myLocation;
  }

  public void setLocation(String newloc)
  {
    String oldLocation = myLocation;
    if (!oldLocation.equals(newloc)) {
      myLocation = newloc;
      fireUpdate(LOCATION_CHANGED, 0, null, 0, oldLocation);

      updateLocationModifiable();
    }
  }
  
  public boolean getLinksJumpOver()
  {
    return myLinksJumpOver;
  }
  
  public void setLinksJumpOver(boolean b)
  {
    boolean old = myLinksJumpOver;
    if (old != b) {
      myLinksJumpOver = b;
      fireUpdate(LINKS_JUMP_OVER_CHANGED, 0, null, (old ? 1 : 0), null);

      // now update all links
      JGoListPosition pos = getFirstObjectPos();
      while (pos != null) {
        JGoObject obj = getObjectAtPos(pos);
        // only consider top-level objects
        pos = getNextObjectPosAtTop(pos);
        if (obj instanceof JGoLink) {
          JGoLink link = (JGoLink)obj;
          link.setJumpsOver(b);
        }
      }
    }
  }
  
  
  // read-only property--can the file be written?
  public boolean isLocationModifiable()
  {
    return myIsLocationModifiable;  // just return cached value
  }

  // There's no setLocationModifiable, because that's controlled externally
  // in the file system.  But because we're caching the writableness,
  // we need a method to update the cache.

  public void updateLocationModifiable()
  {
    boolean canwrite = true;
    if (!getLocation().equals("")) {
      File file = new File(getLocation());
      if (file.exists() && !file.canWrite())
        canwrite = false;
    }
    if (isLocationModifiable() != canwrite) {
      boolean oldIsModifiable = isModifiable();
      myIsLocationModifiable = canwrite;
      if (oldIsModifiable != isModifiable())
        fireUpdate(JGoDocumentEvent.MODIFIABLE_CHANGED, 0, null, (oldIsModifiable ? 1 : 0), null);
    }
  }

  // override to include whether the file can be written
  public boolean isModifiable()
  {
    return super.isModifiable() && isLocationModifiable();
  }


  public void updatePaperColor()
  {
    if (isModifiable())
      setPaperColor(Color.white);
    else
      setPaperColor(new Color(0xDD, 0xDD, 0xDD));

    if (myHighlightPen != null && !getPaperColor().equals(myHighlightPen.getColor())) {
      myHighlightPen = JGoPen.make(JGoPen.SOLID, 6, getPaperColor());
      // now update all links
      JGoListPosition pos = getFirstObjectPos();
      while (pos != null) {
        JGoObject obj = getObjectAtPos(pos);
        // only consider top-level objects
        pos = getNextObjectPosAtTop(pos);
        if (obj instanceof JGoLink) {
          JGoLink link = (JGoLink)obj;
          link.setHighlight(myHighlightPen);
        }
      }
    }
  }


  // new property--has the document been changed?
  public boolean isModified()
  {
    return myIsModified;
  }

  public void setModified(boolean b)
  {
    if (myIsModified != b) {
      myIsModified = b;
      // don't need to notify document listeners
    }
  }


  // Some, but not all, changes to the document should make it "modified"
  public void fireUpdate(int hint, int flags, Object object, int prevInt, Object prevVal)
  {
    // changing the read-only-ness isn't considered modifying the document
    if (hint == JGoDocumentEvent.MODIFIABLE_CHANGED) {
      updatePaperColor();
    } else if (hint != JGoDocumentEvent.PAPER_COLOR_CHANGED) {
      // don't consider the paper color as part of the document, either
      setModified(true);
    }
    if (hint == JGoDocumentEvent.REMOVED && object instanceof JGoLink) {
      JGoLink l = (JGoLink)object;
      if (l.getToPort() != null && l.getToPort().getParent() instanceof JGoBasicNode) {
        JGoBasicNode bn = (JGoBasicNode)l.getToPort().getParent();
        if (bn.getPort().getNumLinks() == 0) {
          removeObject(bn);
          if (bn instanceof RemoteConnectorNode) {
            RemoteConnectorNode other = ((RemoteConnectorNode)bn).getOtherConnector();
            removeObject(other);
          }
        }
      }
      if (l.getFromPort() != null && l.getFromPort().getParent() instanceof JGoBasicNode) {
        JGoBasicNode bn = (JGoBasicNode)l.getFromPort().getParent();
        if (bn.getPort().getNumLinks() == 0) {
          removeObject(bn);
          if (bn instanceof RemoteConnectorNode) {
            RemoteConnectorNode other = ((RemoteConnectorNode)bn).getOtherConnector();
            removeObject(other);
          }
        }
      }
    } else if (hint == JGoDocumentEvent.CHANGED) {
      if (flags == JGoText.ChangedText &&
          object instanceof JGoText) {
        JGoText lab = (JGoText)object;
        if (lab.getParent() != null &&
            lab.getParent() instanceof RemoteConnectorNode) {
          RemoteConnectorNode bn = (RemoteConnectorNode)lab.getParent();
          RemoteConnectorNode other = bn.getOtherConnector();
          if (other != null) {
            other.setText(bn.getText());
          }
        }
      }
    }
    super.fireUpdate(hint, flags, object, prevInt, prevVal);
  }


  // creating a new activity
  public ComponentsNode newNode(int acttype)
  {
//    ActivityNode snode = new ActivityNode();
//    snode.initialize(acttype, getNextNodeID());
//    addObjectAtTail(snode);
//    snode.addScatteredPorts((int)(Math.random()*5)+1);
//    return snode;
	  return null;
  }

  public int getNextNodeID()
  {
    return ++myLastNodeID;
  }

  public ComponentsNode findNodeByID(int id)
  {
    // for larger documents, it would be more efficient to keep a
    // hash table mapping id to ActivityNode
    // for this example, we won't bother with the hash table
    JGoListPosition pos = getFirstObjectPos();
    ComponentsNode node;
    while (pos != null) {
      JGoObject obj = getObjectAtPos(pos);
      // only consider top-level objects
      pos = getNextObjectPosAtTop(pos);
      
      if(obj instanceof StartNode) {
    	  node = (StartNode)obj;
    	  if(node.getId() == id) {
    		  return node;
    	  }
      } else if(obj instanceof PromptNode) {
    	  node = (PromptNode)obj;
    	  if(node.getId() == id) {
    		  return node;
    	  }
      } else if(obj instanceof StopNode) {
    	  node = (StopNode)obj;
    	  if(node.getId() == id) {
    		  return node;
    	  }
      }

    }
    return null;
  }


  // creating a new flow between activities
  public FlowLink newLink(JGoPort from, JGoPort to)
  {
    FlowLink ll = new FlowLink(from, to);
    ll.setPen(getLinkPen());
    ll.setHighlight(myHighlightPen);
    ll.setJumpsOver(getLinksJumpOver());
    getLinksLayer().addObjectAtTail(ll);

    // force the path to be recalculated, now that the link
    // is part of the document, and can thus be routed
    // around any existing nodes in the document.
    ll.calculateStroke();

    return ll;
  }

  public JGoPen getLinkPen()
  {
    return myPen;
  }

  public void setLinkPen(JGoPen p)
  {
    if (!myPen.equals(p)) {
      myPen = p;
      // now update all links
      JGoListPosition pos = getFirstObjectPos();
      while (pos != null) {
        JGoObject obj = getObjectAtPos(pos);
        // only consider top-level objects
        pos = getNextObjectPosAtTop(pos);
        if (obj instanceof JGoLink) {
          JGoLink link = (JGoLink)obj;
          link.setPen(p);
        }
      }
    }
  }
  
  public JGoPen getLinkHighlightPen()
  {
    return myHighlightPen;
  }

  public void setLinkHighlightPen(JGoPen p)
  {
    if (!myHighlightPen.equals(p)) {
      myHighlightPen = p;
      // now update all links
      JGoListPosition pos = getFirstObjectPos();
      while (pos != null) {
        JGoObject obj = getObjectAtPos(pos);
        // only consider top-level objects
        pos = getNextObjectPosAtTop(pos);
        if (obj instanceof JGoLink) {
          JGoLink link = (JGoLink)obj;
          link.setHighlight(p);
        }
      }
    }
  }
  

  // override these for application-specific smarts about routing constraints
  
  public boolean isAvoidable(JGoObject obj) {
    if (!obj.isVisible()) return false;
//    return (obj instanceof ActivityNode);
    return (obj instanceof ComponentsNode);
  }

  public Rectangle getAvoidableRectangle(JGoObject obj, Rectangle rect) {
    if (rect == null) rect = new Rectangle(0, 0, 0, 0);
//    if (obj instanceof ActivityNode) {
//      ActivityNode node = (ActivityNode)obj;
//      if (node.getIcon() != null) {
//        Rectangle r = node.getIcon().getBoundingRect();
//        rect.x = r.x;
//        rect.y = r.y;
//        rect.width = r.width;
//        rect.height = r.height;
//      }
//    }
    ComponentsNode node;
    if(obj instanceof StartNode) {
  	  node = (StartNode)obj;
	  	if (node.getIcon() != null) {
	      Rectangle r = node.getIcon().getBoundingRect();
	      rect.x = r.x;
	      rect.y = r.y;
	      rect.width = r.width;
	      rect.height = r.height;
	    }
    } else if(obj instanceof PromptNode) {
  	  node = (PromptNode)obj;
  	  if (node.getIcon() != null) {
	      Rectangle r = node.getIcon().getBoundingRect();
	      rect.x = r.x;
	      rect.y = r.y;
	      rect.width = r.width;
	      rect.height = r.height;
	    }
    } else if(obj instanceof StopNode) {
  	  node = (StopNode)obj;
  	  if (node.getIcon() != null) {
	      Rectangle r = node.getIcon().getBoundingRect();
	      rect.x = r.x;
	      rect.y = r.y;
	      rect.width = r.width;
	      rect.height = r.height;
	    }
    }
    return rect;
  }


  public int getNextConnectorID()
  {
    return ++myLastConnectorID;
  }


  // For this sample application, just read and write process documents
  // as files using the default serialization or as a simple XML document.

  public static ProcessDocument open(Component parent, String defaultLocation)
  {
    JFileChooser chooser = new JFileChooser();
    if ((defaultLocation != null) && (!defaultLocation.equals(""))) {
      File currentFile = new File(defaultLocation);
      chooser.setCurrentDirectory(currentFile);
    }
    else
      chooser.setCurrentDirectory(null);
    WFLFilter wflFilter = new WFLFilter();
    XMLFilter xmlFilter = new XMLFilter();
    chooser.addChoosableFileFilter(wflFilter);
    chooser.addChoosableFileFilter(xmlFilter);
    chooser.setFileFilter(wflFilter);
    int returnVal = chooser.showOpenDialog(parent);
    if (returnVal == JFileChooser.APPROVE_OPTION) {
      String name = chooser.getSelectedFile().getName();
      String loc = chooser.getSelectedFile().getAbsolutePath();
      FileInputStream fstream = null;
      try {
        fstream = new FileInputStream(loc);
        ProcessDocument doc = null;
        if (loc.endsWith(".xml"))
          doc = loadXML(fstream);
        else
          doc = loadObjects(fstream);
        if (doc == null)
          return null;
        doc.setName(name);
        doc.updateLocationModifiable();
        doc.updatePaperColor();
        doc.setModified(false);
        // the UndoManager is transient and must be setup again when
        // created from serialization
        // but we also need to ignore all changes up to now anyway,
        // so we'll just throw away the old manager and create a new one
        doc.setUndoManager(new JGoUndoManager());
        return doc;
      } catch (IOException x) {
        JOptionPane.showMessageDialog(null,
          x,
          "Open Document Error",
          javax.swing.JOptionPane.ERROR_MESSAGE);
        return null;
      } catch (Exception x) {
        JOptionPane.showMessageDialog(null,
          x,
          "Loading Document Exception",
          javax.swing.JOptionPane.ERROR_MESSAGE);
        return null;
      } finally {
        try { if (fstream != null) fstream.close(); } catch (Exception x) {}
      }
    } else {
      return null;
    }
  }

  public void save()
  {
    if (getLocation().equals("")) {
      saveAs(".wfl");
    } else {
      store();
    }
  }

  public void store()
  {
    if (!getLocation().equals("")) {
      FileOutputStream fstream = null;
      try {
        fstream = new FileOutputStream(getLocation());
        if (getLocation().endsWith(".xml"))
          storeXML(fstream);
        else
          storeObjects(fstream);
      } catch (Exception x) {
        JOptionPane.showMessageDialog(null,
          x,
          "Save Document Error",
          javax.swing.JOptionPane.ERROR_MESSAGE);
      } finally {
        try { if (fstream != null) fstream.close(); } catch (Exception x) {}
        setModified(false);
      }
    }
  }

  public void saveAs(String fileType)
  {
    JFileChooser chooser = new JFileChooser();
    String loc = getLocation();
    File currentFile = new File(loc);
    chooser.setCurrentDirectory(currentFile);
    WFLFilter wflFilter = new WFLFilter();
    XMLFilter xmlFilter = new XMLFilter();
    chooser.addChoosableFileFilter(wflFilter);
    chooser.addChoosableFileFilter(xmlFilter);
    if (fileType.equalsIgnoreCase(".xml"))
      chooser.setFileFilter(xmlFilter);
    else
      chooser.setFileFilter(wflFilter);
    int returnVal = chooser.showSaveDialog(null);
    if (returnVal == JFileChooser.APPROVE_OPTION) {
      String ext = ".wfl";
      javax.swing.filechooser.FileFilter fileFilter = chooser.getFileFilter();
      if (fileFilter.getDescription() == ".xml")
        ext = ".xml";
      String name = chooser.getSelectedFile().getName();
      setName(name);
      loc = chooser.getSelectedFile().getAbsolutePath();
      String loc2 = loc.toLowerCase();
      if (loc2.indexOf(".") == -1) {
        loc += ext;
      }

      setLocation(loc);
      store();
    }
  }


  static public ProcessDocument loadObjects(InputStream ins)
    throws IOException, ClassNotFoundException
  {
    ObjectInputStream istream = new ObjectInputStream(ins);
    Object newObj = istream.readObject();
    if (newObj instanceof ProcessDocument) {
      ProcessDocument doc = (ProcessDocument)newObj;
      return doc;
    } else {
      return null;
    }
  }

  public void storeObjects(OutputStream outs)
    throws IOException
  {
    ObjectOutputStream ostream = new ObjectOutputStream(outs);
    ostream.writeObject(this);
    ostream.flush();
  }


  static public ProcessDocument loadXML(InputStream ins)
    throws IOException, UnsupportedOperationException
  {
//    throw new UnsupportedOperationException("XML support not enabled.  Edit ProcessDocument.java to un-comment-out /*XML ... XML*/ code.");

	    ProcessDocument doc = new ProcessDocument();
	    Document document = null;
	    try {
	      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	      DocumentBuilder builder = factory.newDocumentBuilder();
	      document = builder.parse(ins);

	      Element process = document.getDocumentElement();
	      if (process != null) {
	        // If the root element isn't what we expect, just leave
	        if (!process.getTagName().equals("Process"))
	          return null;
	        // first handle the ProcessDocument attributes
	        doc.setName(process.getAttribute("name"));
	        doc.setLocation(process.getAttribute("location"));
	        String v = process.getAttribute("lastnodeid");
	        doc.myLastNodeID = Integer.parseInt(v);
//	        doc.setOrthogonalFlows(process.getAttribute("ortholinks").equals("1"));

	        // then create the ActivityNodes and FlowLinks
	        NodeList elts = process.getElementsByTagName("*");
	        for (int i = 0; i < elts.getLength(); i++) {
	          Node item = elts.item(i);
	          if (item.getNodeType() == Node.ELEMENT_NODE) {
	            Element elt = (Element)item;
	            if(elt.getTagName().equalsIgnoreCase(Constant.START)) {
	            	StartNode startNode = new StartNode();
	            	int actid = Integer.parseInt(elt.getAttribute("id"));
		            int acttype = Integer.parseInt(elt.getAttribute("type"));
		            int x = Integer.parseInt(elt.getAttribute("x"));
		            int y = Integer.parseInt(elt.getAttribute("y"));
		            String text = elt.getAttribute("text");
		            int protCount = Integer.parseInt(elt.getAttribute("portcount"));
		            startNode.setImgType(1);
		            startNode.initialize(protCount);		            
		            startNode.setId(actid);
		            startNode.setTopLeft(x, y);
		            startNode.setText(text);
		            
//		            添加属性
		            startNode.setDisplayName(elt.getAttribute("displayname"));
		            startNode.setSystemName(elt.getAttribute("systemname"));
		            startNode.setDescription(elt.getAttribute("description"));
		            startNode.setDefaultLanguage(elt.getAttribute("defaultlanguage"));
		            startNode.setTimeoutSeconds(elt.getAttribute("timeoutseconds"));
		            startNode.setSystemVariable(elt.getAttribute("systemvariable"));
		            NodeList chirdNodeList = elt.getChildNodes();
		            List<Object[]> list = new ArrayList();
		            for(int j=0;j<chirdNodeList.getLength();j++) {
		            	Node chirdNode = chirdNodeList.item(j);
		            	 if (chirdNode.getNodeType() == Node.ELEMENT_NODE) {
		            		 Element chirdElt = (Element)chirdNode;
					            if(chirdElt.getTagName().equalsIgnoreCase("variable")) {
					            	Object[] obj = new Object[2];
					            	obj[0] = chirdElt.getAttribute("name");
					            	obj[1] = chirdElt.getAttribute("value");
					            	list.add(obj);
					            }
		            	 }
		            	
		            }
		            startNode.setVariable(list);
			         
//		            ---------
//		            添加属性
		            doc.addObjectAtTail(startNode);
	            } else if(elt.getTagName().equalsIgnoreCase(Constant.PROMPT)) {
	            	PromptNode promptNode = new PromptNode();
	            	int actid = Integer.parseInt(elt.getAttribute("id"));
		            int acttype = Integer.parseInt(elt.getAttribute("type"));
		            int x = Integer.parseInt(elt.getAttribute("x"));
		            int y = Integer.parseInt(elt.getAttribute("y"));
		            String text = elt.getAttribute("text");
		            int protCount = Integer.parseInt(elt.getAttribute("portcount"));
		            promptNode.setImgType(1);
		            promptNode.initialize(protCount);	
		            promptNode.setId(actid);
		            promptNode.setTopLeft(x, y);
		            promptNode.setText(text);
//		            添加属性
//		            ---------
//		            添加属性
		            doc.addObjectAtTail(promptNode);
	            	
	            } else if(elt.getTagName().equalsIgnoreCase(Constant.STOP)) {
	            	StopNode stopNode = new StopNode();
	            	int actid = Integer.parseInt(elt.getAttribute("id"));
		            int acttype = Integer.parseInt(elt.getAttribute("type"));
		            int x = Integer.parseInt(elt.getAttribute("x"));
		            int y = Integer.parseInt(elt.getAttribute("y"));
		            String text = elt.getAttribute("text");
		            int protCount = Integer.parseInt(elt.getAttribute("portcount"));
		            stopNode.setImgType(1);
		            stopNode.initialize(protCount);		
		            stopNode.setId(actid);
		            stopNode.setTopLeft(x, y);
		            stopNode.setText(text);
//		            添加属性
//		            ---------
//		            添加属性
		            doc.addObjectAtTail(stopNode);
	            	
	            } else if(elt.getTagName().equalsIgnoreCase(Constant.FLOW)) {
	            	int fromid = Integer.parseInt(elt.getAttribute("from"));
		            int toid = Integer.parseInt(elt.getAttribute("to"));
		            
		              ComponentsNode from = doc.findNodeByID(fromid);
		              ComponentsNode to = doc.findNodeByID(toid);
		              
		              if (from != null && to != null) {
		            	  int size = Integer.parseInt(elt.getAttribute("numpoints"));
		            	  int fromPort = Integer.parseInt(elt.getAttribute("fromport"));
		            	  int toPort = Integer.parseInt(elt.getAttribute("toport"));
		            	  int width = Integer.parseInt(elt.getAttribute("width"));
		            	  int style = Integer.parseInt(elt.getAttribute("style"));
		            	  int r = Integer.parseInt(elt.getAttribute("r"));
		            	  int g = Integer.parseInt(elt.getAttribute("g"));
		            	  int b = Integer.parseInt(elt.getAttribute("b"));
		            	  Color color = new Color(r, g, b);
		            	  
		            	  ComponentsPort fromActivityPort = from.getPortByID(fromPort);
		            	 
		            	  ComponentsPort toActivityPort = to.getPortByID(toPort);
		            	
		                FlowLink flow = new FlowLink(fromActivityPort, toActivityPort);
//		                flow.setWidth(8);
		               JGoPen jGoPen = new JGoPen(style, width, color);
		               flow.setPen(jGoPen);
		                flow.removeAllPoints();
		                for(int point=0; point<size; point++) {
		                	int pointX = Integer.parseInt(elt.getAttribute("pointsx" + point));
		                	int pointY = Integer.parseInt(elt.getAttribute("pointsy" + point));
		                	flow.addPoint(pointX, pointY);
		                }
		                String text = elt.getAttribute("text");
		                flow.setText(text);
		                doc.addObjectAtTail(flow);
		              }
	            }
	            
	            
//	            if (elt.getTagName().equals(activityTag)) {
//	              ActivityNode act = new ActivityNode();
//	              int actid = Integer.parseInt(elt.getAttribute("id"));
//	              int acttype = Integer.parseInt(elt.getAttribute("type"));
//	              int x = Integer.parseInt(elt.getAttribute("x"));
//	              int y = Integer.parseInt(elt.getAttribute("y"));
//	              String text = elt.getAttribute("text");
//	              String prop = elt.getAttribute("prop");
//	              act.initialize(acttype, actid);
//	              act.addScatteredPorts(2);
//	              act.setTopLeft(x, y);
//	              act.setText(text);
//	              act.setActivityNodeProperties(prop);
//	              doc.addObjectAtTail(act);
//	            } else if (elt.getTagName().equals(flowTag)) {
//	              int fromid = Integer.parseInt(elt.getAttribute("from"));
//	              int toid = Integer.parseInt(elt.getAttribute("to"));
//	              ActivityNode from = doc.findNodeByID(fromid);
//	              ActivityNode to = doc.findNodeByID(toid);
//	              if (from != null && to != null) {
//	            	  int size = Integer.parseInt(elt.getAttribute("numpoints"));
//	            	  int fromPort = Integer.parseInt(elt.getAttribute("fromport"));
//	            	  int toPort = Integer.parseInt(elt.getAttribute("toport"));
//	            	  int width = Integer.parseInt(elt.getAttribute("width"));
//	            	  int style = Integer.parseInt(elt.getAttribute("style"));
//	            	  int r = Integer.parseInt(elt.getAttribute("r"));
//	            	  int g = Integer.parseInt(elt.getAttribute("g"));
//	            	  int b = Integer.parseInt(elt.getAttribute("b"));
//	            	  Color color = new Color(r, g, b);
//	            	  ComponentsPort fromActivityPort = from.getPortByID(fromPort);
//	            	 
//	            	  ComponentsPort toActivityPort = to.getPortByID(toPort);
//	            	
//	                FlowLink flow = new FlowLink(fromActivityPort, toActivityPort);
////	                flow.setWidth(8);
//	               JGoPen jGoPen = new JGoPen(style, width, color);
//	               flow.setPen(jGoPen);
//	                flow.removeAllPoints();
//	                for(int point=0; point<size; point++) {
//	                	int pointX = Integer.parseInt(elt.getAttribute("pointsx" + point));
//	                	int pointY = Integer.parseInt(elt.getAttribute("pointsy" + point));
//	                	flow.addPoint(pointX, pointY);
//	                }
//	                String text = elt.getAttribute("text");
//	                flow.setText(text);
//	                doc.addObjectAtTail(flow);
//	              }
//	            }
	          }
	        }
	      }
	    } catch (SAXParseException spe) {
	      // Error generated by the parser
	      System.err.println ("\n** Parsing error"
	         + ", line " + spe.getLineNumber ()
	         + ", uri " + spe.getSystemId ());
	      System.err.println("   " + spe.getMessage() );

	      // Use the contained exception, if any
	      Exception  x = spe;
	      if (spe.getException() != null)
	        x = spe.getException();
	      x.printStackTrace();
	    } catch (SAXException sxe) {
	      // Error generated by this application
	      // (or a parser-initialization error)
	      Exception  x = sxe;
	      if (sxe.getException() != null)
	        x = sxe.getException();
	      x.printStackTrace();
	    } catch (ParserConfigurationException pce) {
	      // Parser with specified options can't be built
	      pce.printStackTrace();
	    } catch (IOException ioe) {
	      // I/O error
	      ioe.printStackTrace();
	    } catch (Exception x) {
	      x.printStackTrace();
	    }
	    return doc;
	  
  }

  public void storeXML(OutputStream outs)
    throws IOException, UnsupportedOperationException
  {
//    throw new UnsupportedOperationException("XML support not enabled.  Edit ProcessDocument.java to un-comment-out /*XML ... XML*/ code.");
	  Document document = null;
	    try {
	      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	      DocumentBuilder builder = factory.newDocumentBuilder();
	      document = builder.newDocument();

	      Element process = (Element)document.createElement(processTag);
	      process.setAttribute("name", getName());
	      process.setAttribute("location", getLocation());
	      process.setAttribute("lastnodeid", Integer.toString(myLastNodeID));
	      process.setAttribute("ortholinks", "1" );
	      document.appendChild(process);

	      // first produce all of the nodes
	      JGoListPosition pos = getFirstObjectPos();
	      while (pos != null) {
	        JGoObject obj = getObjectAtPos(pos);
	        pos = getNextObjectPosAtTop(pos);

//	        if (obj instanceof ActivityNode) {
//	          ActivityNode node = (ActivityNode)obj;
//	          Element act = document.createElement(activityTag);
//	          act.setAttribute("id", Integer.toString(node.getID()));
//	          act.setAttribute("type", Integer.toString(node.getActivityType()));
//	          act.setAttribute("x", Integer.toString(node.getLeft()));
//	          act.setAttribute("y", Integer.toString(node.getTop()));
//	          act.setAttribute("text", node.getText());
//	          act.setAttribute("prop", node.getActivityNodeProperties());
//	     
//	          process.appendChild(act);
//	        }
	        
	        if (obj instanceof StartNode) {
		          StartNode node = (StartNode)obj;
		          Element act = document.createElement(Constant.START);
		          act.setAttribute("id", Integer.toString(node.getId()));
		          act.setAttribute("type", Integer.toString(Constant.START_TYPE));
		          act.setAttribute("x", Integer.toString(node.getLeft()));
		          act.setAttribute("y", Integer.toString(node.getTop()));
		          act.setAttribute("text", node.getText());
		          act.setAttribute("portcount", String.valueOf(node.getPortCount()));
//			添加属性
		          act.setAttribute("displayname", node.getDisplayName());
		          act.setAttribute("systemname", node.getSystemName());
		          act.setAttribute("description", node.getDescription());
		          act.setAttribute("defaultlanguage", node.getDefaultLanguage());
		          act.setAttribute("timeoutseconds", node.getTimeoutSeconds());
		          act.setAttribute("systemvariable", node.getSystemVariable());
		          List<Object[]> list =  node.getVariable();
		          
		          for(Object[] startVariable:list) {
		        	  Element startEl = document.createElement("variable");
		        	  startEl.setAttribute("name", startVariable[0].toString());
		        	  startEl.setAttribute("value", startVariable[1].toString());
		        	  act.appendChild(startEl);
		          }
		          
//			添加属性
		     
		          process.appendChild(act);
	        } else if (obj instanceof PromptNode) {
	        	PromptNode node = (PromptNode)obj;
		          Element act = document.createElement(Constant.PROMPT);
		          act.setAttribute("id", Integer.toString(node.getId()));
		          act.setAttribute("type", Integer.toString(Constant.PROMPT_TYPE));
		          act.setAttribute("x", Integer.toString(node.getLeft()));
		          act.setAttribute("y", Integer.toString(node.getTop()));
		          act.setAttribute("text", node.getText());
		          act.setAttribute("portcount", String.valueOf(node.getPortCount()));
//			添加属性
		          
		          
		         
//			添加属性
		     
		          process.appendChild(act);
	        } else if (obj instanceof StopNode) {
	        	StopNode node = (StopNode)obj;
		          Element act = document.createElement(Constant.STOP);
		          act.setAttribute("id", Integer.toString(node.getId()));
		          act.setAttribute("type", Integer.toString(Constant.STOP_TYPE));
		          act.setAttribute("x", Integer.toString(node.getLeft()));
		          act.setAttribute("y", Integer.toString(node.getTop()));
		          act.setAttribute("text", node.getText());
		          act.setAttribute("portcount", String.valueOf(node.getPortCount()));
//			添加属性
//			添加属性
		     
		          process.appendChild(act);
	        }
	        
	      }

	      // then produce all of the links
	      pos = getFirstObjectPos();
	      while (pos != null) {
	        JGoObject obj = getObjectAtPos(pos);
	        pos = getNextObjectPosAtTop(pos);

	        if (obj instanceof FlowLink) {
	          FlowLink link = (FlowLink)obj; 
	          Element flow = document.createElement(Constant.FLOW);
	          flow.setAttribute("from", Integer.toString(link.getFromNode().getId()));
	          flow.setAttribute("to", Integer.toString(link.getToNode().getId()));
	          flow.setAttribute("text", link.getText());
//	          取从组件的第几个口出
	          flow.setAttribute("fromport", Integer.toString(((ComponentsPort)link.getFromPort()).getID()));
//	          取到组件的第几个口
	          flow.setAttribute("toport", Integer.toString(((ComponentsPort)link.getToPort()).getID()));
//	          取连线的坐标的总数量
	          int size = link.getNumPoints();
	          flow.setAttribute("numpoints", Integer.toString(size));
	          for(int i=0; i<size; i++) {
//	        	  记录每个坐标
	        	  flow.setAttribute("pointsx" + i, Integer.toString(link.getPointX(i)));
		          flow.setAttribute("pointsy" + i, Integer.toString(link.getPointY(i)));
	          }
//	          取连线的宽度
	          flow.setAttribute("width", Integer.toString(link.getPen().getWidth()));
//	          取连线的样式
	          flow.setAttribute("style", Integer.toString(link.getPen().getStyle()));
//	          取连线的颜色
	          flow.setAttribute("r", Integer.toString(link.getPen().getColor().getRed()));
	          flow.setAttribute("g", Integer.toString(link.getPen().getColor().getGreen()));
	          flow.setAttribute("b", Integer.toString(link.getPen().getColor().getBlue()));
	          
//	          link.getPen().getWidth();link.getPen().getStyle();link.getPen().getColor().toString()
	          process.appendChild(flow);
	        }
	      }
	    } catch (ParserConfigurationException pce) {
	      // Parser with specified options can't be built
	      pce.printStackTrace();
	    }

	    if (document != null) {
	      try {
	        TransformerFactory transformerFactory = TransformerFactory.newInstance();
	        Transformer serializer = transformerFactory.newTransformer();
	        serializer.setOutputProperty(OutputKeys.METHOD, "xml");
	        serializer.setOutputProperty(OutputKeys.INDENT, "yes");
	        serializer.transform(new DOMSource(document), new StreamResult(outs));
	      } catch (Exception x) {
	        x.printStackTrace();
	      }
	    }
  }


  public void copyNewValueForRedo(JGoDocumentChangedEdit e)
  {
    switch (e.getHint()) {
      case NAME_CHANGED:
        e.setNewValue(getName());
        return;
      case LOCATION_CHANGED:
        e.setNewValue(getLocation());
        return;
      case LINKS_JUMP_OVER_CHANGED:
        e.setNewValueBoolean(getLinksJumpOver());
        return;
      default:
        super.copyNewValueForRedo(e);
        return;
    }
  }

  public void changeValue(JGoDocumentChangedEdit e, boolean undo)
  {
    switch (e.getHint()) {
      case NAME_CHANGED:
        setName((String)e.getValue(undo));
        return;
      case LOCATION_CHANGED:
        setLocation((String)e.getValue(undo));
        return;
      case LINKS_JUMP_OVER_CHANGED:
        setLinksJumpOver(e.getValueBoolean(undo));
        return;
      default:
        super.changeValue(e, undo);
        return;
    }
  }

  public void endTransaction(String pname)
  {
    super.endTransaction(pname);
    AppAction.updateAllActions();
  }

  // Constants
  private static final String processTag = "Process";
  private static final String activityTag = "Activity";
  private static final String flowTag = "Flow";

  // Event hints
  public static final int NAME_CHANGED = JGoDocumentEvent.LAST + 1;
  public static final int LOCATION_CHANGED = JGoDocumentEvent.LAST + 2;
  public static final int LINKS_JUMP_OVER_CHANGED = JGoDocumentEvent.LAST + 3;


  // State
  private String myName = "";
  private String myLocation = "";
  private boolean myLinksJumpOver = true;

  private int myLastNodeID = -1;
  private int myLastConnectorID = 0;
  private JGoPen myPen = JGoPen.make(JGoPen.SOLID, 2, Color.blue);
  private JGoPen myHighlightPen = JGoPen.make(JGoPen.SOLID, 6, Color.white);

  private transient boolean myIsLocationModifiable = true;
  private transient boolean myIsModified = false;
}

