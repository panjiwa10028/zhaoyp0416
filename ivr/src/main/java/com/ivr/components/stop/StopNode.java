package com.ivr.components.stop;

import java.awt.Dimension;
import java.awt.Point;

import com.ivr.Processor;
import com.ivr.components.ComponentsNode;
import com.ivr.components.ComponentsPort;
import com.ivr.components.prompt.PromptNode;
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
public class StopNode extends MultiPortNode implements ComponentsNode {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2560825277821191806L;
	private static Dimension myStdSize = new Dimension(32, 32);
	private static Point myStdPoint = new Point(0, 0);
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public ComponentsPort getPortByID(int fromPort) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub
		id = Processor.getPrimaryKeyId();
		JGoImage image = new JGoImage(myStdPoint, myStdSize);
        image.loadImage(Processor.class.getResource("images/star.gif"), true);
		super.initialize(myStdPoint, image, Constant.STOP);
		addDefaultPorts();
	}

	@Override
	public void addDefaultPorts() {
		// TODO Auto-generated method stub
		Point offset =  new Point(- 5, getIcon().getHeight()/2);
		ComponentsPort p = new ComponentsPort(true, false, JGoObject.SideLeft,
	    		  offset, new Dimension(4, 4), getIcon(), this, 0);
	      p.setMaxLinks(999999);
	}
	
	public JGoObject copyObject(JGoCopyEnvironment env)
	  {
	    StopNode newobj = (StopNode)super.copyObject(env);
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
