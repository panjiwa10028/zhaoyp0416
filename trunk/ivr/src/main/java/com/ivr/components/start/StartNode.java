package com.ivr.components.start;

import java.awt.Dimension;
import java.awt.Point;

import com.ivr.Processor;
import com.ivr.activity.ActivityNode;
import com.ivr.components.ComponentsNode;
import com.ivr.components.ComponentsPort;
import com.ivr.jgo.MultiPortNode;
import com.ivr.utils.Constant;
import com.nwoods.jgo.JGoCopyEnvironment;
import com.nwoods.jgo.JGoImage;
import com.nwoods.jgo.JGoObject;

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
	private static Dimension myStdSize = new Dimension(32, 32);
	private static Point myStdPoint = new Point(0, 0);
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void initialize() {
		// TODO Auto-generated method stub
		this.id = 22;
		JGoImage image = new JGoImage(myStdPoint, myStdSize);
        image.loadImage(Processor.class.getResource("images/star.gif"), true);
		super.initialize(myStdPoint, image, Constant.START);
		addDefaultPorts();
	}

	public void addDefaultPorts() {
		Point offset =  new Point(getIcon().getWidth() + 5, getIcon().getHeight()/2);
	      ComponentsPort p = new ComponentsPort(false, true, JGoObject.SideRight,
	    		  offset, new Dimension(4, 4), getIcon(), this, 0);
	      p.setMaxLinks(999999);
	}
	public void addScatteredPorts(int i) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ComponentsPort getPortByID(int fromPort) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public JGoObject copyObject(JGoCopyEnvironment env)
	  {
	    StartNode newobj = (StartNode)super.copyObject(env);
	    if (newobj != null) {
	      // the ID should *not* be copied blindly--leave as -1 so
	      // that we can fix it up later in ownerChange
	      // the JGoObjects that are part of this area are copied
	      // separately by copyChildren()
	
	      // no other fields to copy--the Text is actually on a sub-object
	    }
	    return newobj;
	  }
}
