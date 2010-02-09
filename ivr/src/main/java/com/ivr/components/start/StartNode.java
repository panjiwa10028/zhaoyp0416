package com.ivr.components.start;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Point;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import com.ivr.ProcessDocument;
import com.ivr.ProcessView;
import com.ivr.Processor;
import com.ivr.activity.ActivityDialog;
import com.ivr.activity.ActivityNode;
import com.ivr.activity.ActivityPort;
import com.ivr.components.ComponentsNode;
import com.ivr.components.ComponentsPort;
import com.ivr.jgo.MultiPortNode;
import com.ivr.utils.Constant;
import com.nwoods.jgo.JGoCopyEnvironment;
import com.nwoods.jgo.JGoImage;
import com.nwoods.jgo.JGoListPosition;
import com.nwoods.jgo.JGoObject;
import com.nwoods.jgo.JGoObjectCollection;
import com.nwoods.jgo.JGoView;

/**
 *
 * @author Allen
 * 
 */
public class StartNode extends MultiPortNode implements ComponentsNode {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3081120461330961470L;
	private static Dimension myStdSize = new Dimension(16, 16);
	private static Point myStdPoint = new Point(0, 0);
	private int id = -1;
	private int portCount = 0;//端口数量
	private int imgType = 0;//图片显示类型
	
	
//	属性
	private String displayName;
	  private String systemName;
	  private String description;
	  private String defaultLanguage;
	  private String timeoutSeconds;
	  private String systemVariable;
	  private List<Object[]> variable;
	  
	  
	public StartNode() {
		
	  }
	
	public void initialize(int portCount) {
		// TODO Auto-generated method stub
//		JGoImage image = new JGoImage(myStdPoint, myStdSize);
//        image.loadImage(Processor.class.getResource("images/star.gif"), true);
		super.initialize(myStdPoint, getImage(imgType), Constant.START);
		this.portCount = portCount;
		addDefaultPorts();
		 if (getLabel() != null) {
//		    	设置node名粗体
		      getLabel().setBold(true);
//		      设置node名颜色
		      getLabel().setTextColor(new Color(0, 127, 0));
		    }

		    resetEditability();
	}
	public void resetEditability()
	  {
	    if (getLabel() != null)
//	    	设置node名是否可编辑
	      getLabel().setEditable(true);
	  }
	public void addDefaultPorts() {
		if(portCount > 0) {
			Point offset =  new Point(getIcon().getWidth() + 5, getIcon().getHeight()/2);
		      ComponentsPort p = new ComponentsPort(false, true, JGoObject.SideRight,
		    		  offset, new Dimension(4, 4), getIcon(), this, 0);
		      p.setMaxLinks(999999);
		}
		
	}
	public void addScatteredPorts(int i) {
		// TODO Auto-generated method stub
		
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
	
	public JGoObject copyObject(JGoCopyEnvironment env)
	  {
		StartNode newobj = new StartNode();
		portCount = 1;
		newobj.setImgType(1);
		newobj.initialize(portCount);
//	    StartNode newobj = (StartNode)super.copyObject(env);
//	    if (newobj != null) {
//	      // the ID should *not* be copied blindly--leave as -1 so
//	      // that we can fix it up later in ownerChange
//	      // the JGoObjects that are part of this area are copied
//	      // separately by copyChildren()
//	    	newobj.initialize(portCount);
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
	public boolean doMouseDblClick(int modifiers, Point dc, Point vc, JGoView view)
	  {
	    if (view instanceof ProcessView) {
	      ProcessView processView = (ProcessView)view;
//	      processView.editActivity(this);
//	      JOptionPane.showInternalMessageDialog(processView,
//	              "A Start node id:" + getId(),
//	              "information", JOptionPane.INFORMATION_MESSAGE);
	     StartDialog activityDialog = new StartDialog(processView.getFrame(), this);
//        设置窗口相对于指定组件的位置。 为 null，则此窗口将置于屏幕的中央
	        activityDialog.setLocationRelativeTo(null);
	        activityDialog.setVisible(true);
	      return true;
	    }
	    return false;
	  }
	
	public static JGoImage getImage(int acttype)
	  {
	    JGoImage image = null;
	    switch (acttype) {
	      case 1:
	    	  myStdSize = new Dimension(32, 32);
	        image = new JGoImage(myStdPoint, myStdSize);
	        image.loadImage(Processor.class.getResource("images/StartLarge.png"), true);
	        break;
	      
	      default:
	    	  myStdSize = new Dimension(16, 16);
	    	  image = new JGoImage(myStdPoint, myStdSize);
		      image.loadImage(Processor.class.getResource("images/StartSmall.png"), true);
		      break;
	    }
	    return image;
	  }
	
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
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDefaultLanguage() {
		return defaultLanguage;
	}
	public void setDefaultLanguage(String defaultLanguage) {
		this.defaultLanguage = defaultLanguage;
	}
	public String getTimeoutSeconds() {
		return timeoutSeconds;
	}
	public void setTimeoutSeconds(String timeoutSeconds) {
		this.timeoutSeconds = timeoutSeconds;
	}
	public String getSystemVariable() {
		return systemVariable;
	}
	public void setSystemVariable(String systemVariable) {
		this.systemVariable = systemVariable;
	}

	public List<Object[]> getVariable() {
		return variable;
	}

	public void setVariable(List<Object[]> variable) {
		this.variable = variable;
	}
	
	
}
