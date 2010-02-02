package com.ivr.components;

import com.nwoods.jgo.JGoImage;

/**
 *
 * @author Allen
 * 
 */
public class Resource {
	public static JGoImage getImage(int nodeType) {
	    JGoImage image = null;
	    switch (nodeType) {
	      case Start.type:
	        image = new JGoImage(Start.getMyStdPoint(), Start.getMyStdSize());
	        image.loadImage(Start.class.getResource("images/star.gif"), true);
	        break;
	      
	    }
	    return image;
	  }
	
	 public static String getLabelString(int nodeType)
	  {
	    switch (nodeType) {
	      case Start.type:
	    	  return "Start";
	      default:
	       return "Activity";
	    }
	  }
}
