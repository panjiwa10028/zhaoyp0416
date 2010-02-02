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

package com.ivr;

import com.nwoods.jgo.*;
import java.awt.*;

// Flows are implemented as labeled links
//
// For this example app, the only property, Text, is
// actually just the label's Text.
public class FlowLink extends JGoLabeledLink
{
  public FlowLink()
  {
    init();
  }

  public FlowLink(JGoPort from, JGoPort to)
  {
    super(from, to);
    init();

    FlowLabel text = new FlowLabel();
    text.setText("label");
    setMidLabel(text);
  }
  
  private void init()
  {
    setOrthogonal(true);
    setJumpsOver(true);
    setRoundedCorners(true);
    setAvoidsNodes(true);
    setGrabChildSelection(false);  // let the label be selectable
  }

  public ProcessDocument getDoc() { return (ProcessDocument)getDocument(); }

  public ActivityNode getFromNode()
  {
    if (getFromPort() != null)
      return (ActivityNode)(getFromPort().getParent());
    return null;
  }
  public ActivityNode getToNode()
  {
    if (getToPort() != null)
      return (ActivityNode)(getToPort().getParent());
    return null;
  }


  // Events

  public boolean doMouseDblClick(int modifiers, Point dc, Point vc, JGoView view)
  {
    ProcessView processView = (ProcessView)view;
    processView.editFlow(this);
    return true;
  }

  public void calculateStroke()
  {
    super.calculateStroke();
    // add extra points near the ends so that users can have more flexibility
    // manually rerouting each link
    int oldnum = getNumPoints();
    if (oldnum >= 5 && isOrthogonal() && getAdjustingStyle() == JGoLink.AdjustingStyleCalculate) {
      Point p0 = getPoint(oldnum-1);
      Point p1 = getPoint(oldnum-2);
      Point p2 = getPoint(oldnum-3);
      Point p3 = getPoint(oldnum-4);
      // don't leave three points in a row--add another at the same point as P1
      if ((p0.x == p1.x && p1.x == p2.x && p2.x != p3.x) ||
          (p0.y == p1.y && p1.y == p2.y && p2.y != p3.y)) {
        insertPoint(oldnum-2, p1);
      }
      p0 = getPoint(0);
      p1 = getPoint(1);
      p2 = getPoint(2);
      p3 = getPoint(3);
      if ((p0.x == p1.x && p1.x == p2.x && p2.x != p3.x) ||
          (p0.y == p1.y && p1.y == p2.y && p2.y != p3.y)) {
        insertPoint(1, p1);
      }
    }
  }

  protected void positionMidLabel(JGoObject lab, int ax, int ay, int bx, int by)
  {
    if (lab instanceof FlowLabel) {
      FlowLabel flab = (FlowLabel)lab;
      Point off = flab.getOffset();
      Point midpt = flab.getMidLabelConnectionPoint(null);
      if (midpt != null) {
        lab.setSpotLocationOffset(Center, midpt.x, midpt.y, off.x, off.y);
      }
    } else {
      super.positionMidLabel(lab, ax, ay, bx, by);
    }
  }
  
  protected void gainedSelection(JGoSelection selection)
  {
    super.gainedSelection(selection);
    setSkipsUndoManager(true);
    Color c;
    if (selection.getPrimarySelection() == this)
      c = selection.getView().getPrimarySelectionColor();
    else
      c = selection.getView().getSecondarySelectionColor();
    setHighlight(JGoPen.make(JGoPen.SOLID, 6, c));
    setSkipsUndoManager(false);
  }

  protected void lostSelection(JGoSelection selection)
  {
    super.lostSelection(selection);
    ProcessDocument doc = (ProcessDocument)getDocument();
    if (doc != null) {
      setSkipsUndoManager(true);
      setHighlight(doc.getLinkHighlightPen());
      setSkipsUndoManager(false);
    }
  }
  
  // Properties

  public String getText()
  {
    JGoText obj = (JGoText)getMidLabel();
    if (obj != null)
      return obj.getText();
    else
      return "";
  }

  public void setText(String s)
  {
    JGoText obj = (JGoText)getMidLabel();
    if (obj != null)
      obj.setText(s);
  }
}
