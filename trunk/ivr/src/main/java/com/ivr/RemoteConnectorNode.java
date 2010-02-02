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

package com.ivr;

import com.nwoods.jgo.*;
import java.awt.*;

public class RemoteConnectorNode extends JGoBasicNode
{
  /** Default constructor produces uninitialized node. */
  public RemoteConnectorNode() {}

  /** Constructor to create an initialized node. */
  public RemoteConnectorNode(Point loc, String labtext)
  {
    super(labtext);
    setLabelSpot(JGoObject.Center);
    setLocation(loc);
    getPort().setValidSource(false);
    getPort().setValidDestination(false);
    if (getLabel() != null)
      getLabel().setEditable(true);
  }
  
  public RemoteConnectorNode getOtherConnector() { return myOther; }

  // don't need to worry about undo/redo here -- only set when created in pairs
  public void setOtherConnector(RemoteConnectorNode other) { myOther = other; }
  
  private RemoteConnectorNode myOther = null;
}
