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

package com.ivr.activity;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Point;

import javax.swing.JOptionPane;

import com.ivr.ProcessDocument;
import com.ivr.ProcessView;
import com.ivr.jgo.MultiPortNode;
import com.nwoods.jgo.JGoCopyEnvironment;
import com.nwoods.jgo.JGoImage;
import com.nwoods.jgo.JGoListPosition;
import com.nwoods.jgo.JGoObject;
import com.nwoods.jgo.JGoObjectCollection;
import com.nwoods.jgo.JGoPort;
import com.nwoods.jgo.JGoView;


// Activities are implemented as MultiPortNodes.
//
// Properties include Text, ActivityType, and ID.
// The Text property is actually just the MultiPortNode's Label's Text.
//
// This class also supports a standard set of icons (as JGoImages)
// and the notion of a standard size for the node.
public class ActivityNode extends MultiPortNode
{
  public ActivityNode()
  {
  }

  public JGoObject copyObject(JGoCopyEnvironment env)
  {
    ActivityNode newobj = (ActivityNode)super.copyObject(env);
    if (newobj != null) {
      // the ID should *not* be copied blindly--leave as -1 so
      // that we can fix it up later in ownerChange
      // the JGoObjects that are part of this area are copied
      // separately by copyChildren()
      newobj.myActivityType = myActivityType;
      // no other fields to copy--the Text is actually on a sub-object
    }
    return newobj;
  }

  public void initialize(int acttype, int id)
  {
    super.initialize(myStdPoint, getImage(acttype), getLabelString(acttype));

    myID = id;
    myActivityType = acttype;

    if (getLabel() != null) {
//    	设置node名粗体
      getLabel().setBold(true);
//      设置node名颜色
      getLabel().setTextColor(new Color(0, 127, 0));
    }

    resetEditability();
  }

  public void addScatteredPorts(int numports)
  {
    if (getActivityType() == Start) {getIcon().getLocation();
    Point offset =  new Point(getIcon().getWidth() + 5, getIcon().getHeight()/2);
      ActivityPort p = new ActivityPort(false, true, JGoObject.SideRight,
    		  offset, new Dimension(6, 6), getIcon(), this, 0);
      p.setMaxLinks(999999);
    } else if (getActivityType() == Finish) {
    	Point offset =  new Point(- 5, getIcon().getHeight()/2);
      ActivityPort p = new ActivityPort(true, false, JGoObject.SideLeft,
    		  offset, new Dimension(6, 6), getIcon(), this, 0);
      p.setMaxLinks(999999);
    } else {
      for (int i = 0; i < numports; i++) {
//        Point offset = new Point(8*((int)(Math.random()*6)), 8*((int)(Math.random()*6)));
//    	  Point offset =  new Point((getIcon().getWidth() * i ), getIcon().getHeight()/2);
    	  Point offset;
    	  System.out.println(getIcon().getWidth());
    	  System.out.println(getIcon().getHeight());
    	  System.out.println(getIcon().getTopLeft().getX() + "--" + getIcon().getTopLeft().getY());
    	  
    	  System.out.println(60 * (i)+"--"+ 25);
        int spot = JGoObject.Center;
        if(i ==0) {
        	offset =  new Point(- 5, getIcon().getHeight()/2);
        	spot = JGoObject.SideLeft;
        	ActivityPort p = new ActivityPort(true, false, spot, offset, new Dimension(6, 6), getIcon(), this, i);
            p.setMaxLinks(1);
	  	  } else {
	  		offset =  new Point(getIcon().getWidth() + 5, getIcon().getHeight()/(numports) * (i));
	  		 spot = JGoObject.SideRight;
	  		ActivityPort p = new ActivityPort(false, true, spot, offset, new Dimension(6, 6), getIcon(), this, i);
	        p.setMaxLinks(1);
	  	  }
//        if (offset.x > offset.y) {
//          if (offset.x < 40 - offset.y)
//            spot = JGoObject.TopMiddle;
//          else
//            spot = JGoObject.SideRight;
//        } else {
//          if (offset.x > 40 - offset.y)
//            spot = JGoObject.BottomMiddle;
//          else
//            spot = JGoObject.SideLeft;
//        }
        
      }
    }
  }

  public ProcessDocument getDoc() { return (ProcessDocument)getDocument(); }

  // make sure that whenever an ActivityNode is added to a ProcessDocument,
  // it has a unique ID
  protected void ownerChange(JGoObjectCollection oldOwner, JGoObjectCollection newOwner, JGoObject mainObject)
  {
    if (oldOwner == null &&
        newOwner != null &&
        newOwner instanceof ProcessDocument) {
      if (getID() == -1) {
        ProcessDocument doc = (ProcessDocument)newOwner;
        myID = doc.getNextNodeID();
      }
    }
  }

  // Start and Finish nodes do not have editable labels
  public void resetEditability()
  {
    if (getLabel() != null)
//    	设置node名是否可编辑
      getLabel().setEditable(getActivityType() != Start &&
                             getActivityType() != Finish);
  }

  // You'll probably want to replace this with somewhat more interesting information
  public String getToolTipText()
  {
    return "a tooltip";
  }

  // Events

  public boolean doMouseDblClick(int modifiers, Point dc, Point vc, JGoView view)
  {
    if (view instanceof ProcessView) {
      ProcessView processView = (ProcessView)view;
      JOptionPane.showInternalMessageDialog(processView,
              "A Start node id:" + getID(),
              "information", JOptionPane.INFORMATION_MESSAGE);
      processView.editActivity(this);
      return true;
    }
    return false;
  }

  // Properties

  public int getID() { return myID; }

  public int getActivityType() { return myActivityType; }

  public String getText()
  {
    if (getLabel() != null)
      return getLabel().getText();
    else
      return "";
  }

  public void setText(String s)
  {
    if (getLabel() != null)
      getLabel().setText(s);
  }


  // find a port with a given ID
  public ActivityPort getPortByID(int id)
  {
    JGoListPosition pos = getFirstObjectPos();
    while (pos != null) {
      JGoObject obj = getObjectAtPos(pos);
      pos = getNextObjectPos(pos);
      if (obj instanceof ActivityPort) {
        ActivityPort p = (ActivityPort)obj;
        if (p.getID() == id) {
          return p;
        }
      }
    }
    return null;
  }


  // Static methods

  /**
   * 获得node图片
   */
  public static JGoImage getImage(int acttype)
  {
    JGoImage image = null;
    switch (acttype) {
      case Start:
        image = new JGoImage(myStdPoint, getStdSize());
        image.loadImage(ActivityNode.class.getResource("../images/star.gif"), true);
        break;
      case Finish:
        image = new JGoImage(myStdPoint, getStdSize());
        image.loadImage(ActivityNode.class.getResource("../images/star.gif"), true);
        break;
      default:
      case Activity:
        image = new JGoImage(myStdPoint, getStdSize());
        image.loadImage(ActivityNode.class.getResource("../images/doc.gif"), true);
        break;
    }
    return image;
  }

  /**
   * 获得node名
   * @param acttype
   * @return
   */
  public static String getLabelString(int acttype)
  {
    switch (acttype) {
      case Start:    return "Start";
      case Finish:   return "Finish";
      default:
      case Activity: return "Activity" + Integer.toString(acttype - Activity + 1);
    }
  }

/**
 * 获得node图标的大小
 * @return
 */
  public static Dimension getStdSize()
  {
    return myStdSize;
  }

  public static void setStdSize(int w, int h)
  {
    myStdSize.width = w;
    myStdSize.height = h;
  }


  // Icon/Activity types
  public static final int Start = 0;
  public static final int Finish = 1;
  public static final int Activity = 2;

  private static Dimension myStdSize = new Dimension(50, 50);
  private static Point myStdPoint = new Point(0, 0);  // don't care


  // State

  private int myID = -1;
  private int myActivityType = 0;
  
  private String activityNodeProperties;
  
  private String displayName;
  private String systemName;
  private String description;
  private String defaultLanguage;
  private String timeoutSeconds;
  private String systemVariable;
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
  
public String getActivityNodeProperties() {
	return activityNodeProperties;
}

public void setActivityNodeProperties(String activityNodeProperties) {
	this.activityNodeProperties = activityNodeProperties;
}


}
