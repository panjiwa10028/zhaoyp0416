package com.ivr.components;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Point;

import com.ivr.ActivityNode;
import com.ivr.ProcessView;
import com.ivr.jgo.MultiPortNode;
import com.nwoods.jgo.JGoCopyEnvironment;
import com.nwoods.jgo.JGoImage;
import com.nwoods.jgo.JGoObject;
import com.nwoods.jgo.JGoView;

/**
 *
 * @author Allen
 * 
 */
public class Start extends MultiPortNode implements Node {

	private long id;
	public final static int type = 0;
	private static Point myStdPoint = new Point(0, 0);

	private static Dimension myStdSize = new Dimension(50, 50);
	
	
	public long getId() {
		return id;
	}



	public static int getType() {
		return type;
	}



	public static Point getMyStdPoint() {
		return myStdPoint;
	}



	public static Dimension getMyStdSize() {
		return myStdSize;
	}


	public void initialize() {
		
		super.initialize(myStdPoint, Resource.getImage(type), Resource.getLabelString(type));

		if (getLabel() != null) {
		      getLabel().setBold(true);
		      getLabel().setTextColor(new Color(0, 127, 0));
		}
		resetEditability();
	}
	
	
	
	//开始和结束组件不用编辑名字
	  public void resetEditability()
	  {
	    if (getLabel() != null)
	      getLabel().setEditable(false);
	  }
	  
	  public JGoObject copyObject(JGoCopyEnvironment env) {
	    Start newNode = (Start)super.copyObject(env);
	    if (newNode != null) {
	      // the ID should *not* be copied blindly--leave as -1 so
	      // that we can fix it up later in ownerChange
	      // the JGoObjects that are part of this area are copied
	      // separately by copyChildren(
	      // no other fields to copy--the Text is actually on a sub-object
	    }
	    return newNode;
	  }
	public boolean doMouseDblClick(int modifiers, Point dc, Point vc, JGoView view)
	  {
	    if (view instanceof ProcessView) {
	      ProcessView processView = (ProcessView)view;
//	      processView.editActivity(this);
	      return true;
	    }
	    return false;
	  }
}
