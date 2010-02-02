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

public class ExternalConnectorNode extends JGoBasicNode
{
  /** Default constructor produces uninitialized node. */
  public ExternalConnectorNode() {}

  /** Constructor to create an initialized node. */
  public ExternalConnectorNode(Point loc, String labtext, boolean out)
  {
    super(labtext); 
    setLocation(loc);
    if (out) {
      getPort().setValidSource(false);
      getPort().setToSpot(JGoObject.CenterLeft);
    } else {
      getPort().setValidDestination(false);
      getPort().setFromSpot(JGoObject.CenterRight);
    }
    if (getLabel() != null)
      getLabel().setEditable(true);
  }
}
