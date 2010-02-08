/*
 *  Copyright (c) Northwoods Software Corporation, 1999-2008. All Rights
 *  Reserved.
 *
 *  Restricted Rights: Use, duplication, or disclosure by the U.S.
 *  Government is subject to restrictions as set forth in subparagraph
 *  (c) (1) (ii) of DFARS 252.227-7013, or in FAR 52.227-19, or in FAR
 *  52.227-14 Alt. III, as applicable.
 *
 */

package com.ivr.components;

import com.nwoods.jgo.*;
import com.ivr.jgo.*;
import java.awt.*;

/**
 * ActivityPort implements the kind of port used in ActivityNode.
 */
public class ComponentsPort extends MultiPortNodePort
{
  /** Call initialize() before using. */
  public ComponentsPort()
  {
  }

  /**
   * This creates a light gray ellipse port of the appropriate direction
   * at the given offset relative to the icon.
   * input:是否可以进
   * ouput:是否可以出
   * linkspot：连接线的方向
   * offset：表示 (x,y) 坐标空间中的位置的点
   * size：宽度和高度
   * icon：图标
   * parent：
   * id:这个组件上的这个端口id
   */
  public ComponentsPort(boolean input, boolean output, int linkspot, Point offset, Dimension size, JGoObject icon, JGoArea parent, int id)
  {
    super(input, output, linkspot, offset, size, icon, parent);
    initialize(input, output, linkspot, offset, icon, parent, id);
  }

  public void initialize(boolean input, boolean output, int linkspot, Point offset, JGoObject icon, JGoArea parent, int id)
  {
    initialize(input, output, linkspot, offset, icon, parent);
    myID = id;
    myOrigSpot = linkspot;
  }

  public JGoObject copyObject(JGoCopyEnvironment env)
  {
    ComponentsPort p = (ComponentsPort)super.copyObject(env);
    if (p != null) {
      p.myID = myID;
      p.myOrigSpot = myOrigSpot;
    }
    return p;
  }

  /**
   * Change the appearance of the port according to how many links it has,
   * and the direction that they are going (in or out).
   * This method is called whenever a link has been added or removed from this port.
   */
  public void linkChange()
  {
    int numlinks = getNumLinks();
    if (numlinks <= 0) {
      setStyle(JGoPort.StyleEllipse);
      setToSpot(myOrigSpot);
    } else {
      setStyle(JGoPort.StyleTriangle);
      JGoListPosition pos = getFirstLinkPos();
      while (pos != null) {
        JGoLink link = getLinkAtPos(pos);
        if (link.getFromPort() == this) {
          setToSpot(JGoObject.spotOpposite(myOrigSpot));
        } else {
          setToSpot(myOrigSpot);
        }
        break;
      }
    }
  }
  
  
  // Property
  public int getID() { return myID; }


  // State
  private int myID = -1;
  private int myOrigSpot = NoSpot;
}
