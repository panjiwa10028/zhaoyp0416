package com.ivr.components.prompt;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Point;

import com.ivr.ProcessDocument;
import com.ivr.Processor;
import com.ivr.activity.ActivityPort;
import com.ivr.components.ComponentsNode;
import com.ivr.components.ComponentsPort;
import com.ivr.components.start.StartNode;
import com.ivr.components.stop.StopNode;
import com.ivr.jgo.MultiPortNode;
import com.ivr.utils.Constant;
import com.nwoods.jgo.JGoCopyEnvironment;
import com.nwoods.jgo.JGoImage;
import com.nwoods.jgo.JGoListPosition;
import com.nwoods.jgo.JGoObject;
import com.nwoods.jgo.JGoObjectCollection;

/**
 *
 * @author Allen
 * 
 */
public class PromptNode extends MultiPortNode implements ComponentsNode {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6789985025376385413L;
	private static Dimension myStdSize = new Dimension(32, 32);
	private static Point myStdPoint = new Point(0, 0);
	private int id = -1;
	private int portCount = 0;
	private int imgType = 0;//图片显示类型

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public int getPortCount() {
		return portCount;
	}

	public void setPortCount(int portCount) {
		this.portCount = portCount;
	}
	public int getImgType() {
		return imgType;
	}
	public void setImgType(int imgType) {
		this.imgType = imgType;
	}
	@Override
	public ComponentsPort getPortByID(int portId) {
		// TODO Auto-generated method stub
		JGoListPosition pos = getFirstObjectPos();
	    while (pos != null) {
	      JGoObject obj = getObjectAtPos(pos);
	      pos = getNextObjectPos(pos);
	      if (obj instanceof ComponentsPort) {
	    	  ComponentsPort p = (ComponentsPort)obj;
	        if (p.getID() == portId) {
	          return p;
	        }
	      }
	    }
	    return null;
	}

	@Override
	public void initialize(int portCount) {
		// TODO Auto-generated method stub
//		JGoImage image = new JGoImage(myStdPoint, myStdSize);
//        image.loadImage(Processor.class.getResource("images/star.gif"), true);
		super.initialize(myStdPoint, getImage(imgType), Constant.PROMPT);
		this.portCount = portCount;
		addDefaultPorts();
		if (getLabel() != null) {
//	    	设置node名粗体
	      getLabel().setBold(true);
//	      设置node名颜色
	      getLabel().setTextColor(new Color(0, 127, 0));
	    }

	    resetEditability();
}
public void resetEditability()
  {
    if (getLabel() != null)
//    	设置node名是否可编辑
      getLabel().setEditable(true);
  }

	@Override
	public void addDefaultPorts() {
		// TODO Auto-generated method stub

		 for (int i = 0; i < portCount; i++) {
	    	  Point offset;
	        int spot = JGoObject.Center;
	        if(i ==0) {
	        	offset =  new Point(- 5, getIcon().getHeight()/2);
	        	spot = JGoObject.SideLeft;
	        	ComponentsPort p = new ComponentsPort(true, false, spot, offset, new Dimension(4, 4), getIcon(), this, i);
	            p.setMaxLinks(1);
		  	  } else {
		  		offset =  new Point(getIcon().getWidth() + 5, getIcon().getHeight()/(portCount) * (i));
		  		 spot = JGoObject.SideRight;
		  		ComponentsPort p = new ComponentsPort(false, true, spot, offset, new Dimension(4, 4), getIcon(), this, i);
		        p.setMaxLinks(1);
		  	  }
	        
	      }
	}
	
	public JGoObject copyObject(JGoCopyEnvironment env)
	  {
		PromptNode newobj = new PromptNode();
		portCount = 2;
		newobj.setImgType(1);
		newobj.initialize(portCount);
//	    PromptNode newobj = (PromptNode)super.copyObject(env);
//	    if (newobj != null) {
//	      // the ID should *not* be copied blindly--leave as -1 so
//	      // that we can fix it up later in ownerChange
//	      // the JGoObjects that are part of this area are copied
//	      // separately by copyChildren()
//	    	newobj.portCount = portCount;
//	      // no other fields to copy--the Text is actually on a sub-object
//	    }
	    return newobj;
	  }
	protected void ownerChange(JGoObjectCollection oldOwner, JGoObjectCollection newOwner, JGoObject mainObject)
	  {
	    if (oldOwner == null &&
	        newOwner != null &&
	        newOwner instanceof ProcessDocument) {
	      if (getId() == -1) {
	        ProcessDocument doc = (ProcessDocument)newOwner;
	        id = doc.getNextNodeID();
	      }
	    }
	  }
	public static JGoImage getImage(int acttype)
	  {
	    JGoImage image = null;
	    switch (acttype) {
	      case 1:
	    	  myStdSize = new Dimension(32, 32);
	        image = new JGoImage(myStdPoint, myStdSize);
	        image.loadImage(Processor.class.getResource("images/PromptLarge.png"), true);
	        break;
	      
	      default:
	    	  myStdSize = new Dimension(16, 16);
	    	  image = new JGoImage(myStdPoint, myStdSize);
		      image.loadImage(Processor.class.getResource("images/PromptSmall.png"), true);
		      break;
	    }
	    return image;
	  }
}
