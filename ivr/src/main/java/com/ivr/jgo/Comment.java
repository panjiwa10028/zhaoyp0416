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

package com.ivr.jgo;

import com.nwoods.jgo.*;
import java.awt.*;

/**
 * A Comment is an Area containing a Text and a 3DNoteRect.
 * There are no ports.
 * <p>
 * If the text is changed, the rectangle is automatically resized to
 * "hold" the text.
 * <p>
 * By default the text is not editable by the user, but it can be
 * made editable by calling setEditable(true).
 */
public class Comment extends JGoArea implements JGoIdentifiablePart
{
  /** Create an empty Comment.  Call initialize(String) before using it. */
  public Comment()
  {
    super();
  }

  /** Create a Comment displaying the given String. */
  public Comment(String s)
  {
    super();
    initialize(s);
  }

  public void initialize(String s)
  {
    setResizable(false);

    myRect = new JGo3DNoteRect();
    myRect.setSelectable(false);
    myRect.setPen(JGoPen.lightGray);
    myRect.setBrush(JGoBrush.makeStockBrush(new Color(0xFF, 0xFF, 0xCC)));

    myLabel = new JGoText(s);
    myLabel.setMultiline(true);
    myLabel.setSelectable(false);
    myLabel.setResizable(false);
    myLabel.setDraggable(false);
    myLabel.setEditable(false);
    myLabel.setEditOnSingleClick(true);  // in case it becomes editable
    myLabel.setTransparent(true);

    addObjectAtHead(myRect);
    addObjectAtTail(myLabel);
  }

  protected void copyChildren(JGoArea newarea, JGoCopyEnvironment env)
  {
    Comment newobj = (Comment)newarea;

    newobj.myPartID = myPartID;

    super.copyChildren(newarea, env);

    newobj.myRect = (JGo3DNoteRect)env.get(myRect);
    newobj.myLabel = (JGoText)env.get(myLabel);
  }

  /**
   * When an object is removed, make sure there are no more references from fields.
   */
  public JGoObject removeObjectAtPos(JGoListPosition pos)
  {
    JGoObject child = super.removeObjectAtPos(pos);
    if (child == myRect)
      myRect = null;
    else if (child == myLabel)
      myLabel = null;
    return child;
  }

  /**
   * Position all the parts of the area relative to the text label.
   * Leave room for the JGo3DNoteRect decorations.
   */
  public void layoutChildren(JGoObject childchanged)
  {
    JGoText label = getLabel();
    if (label != null) {
      JGo3DNoteRect rect = getRect();
      if (rect != null) {
        Insets insets = getInsets();
        if (isResizable()) {
          int maxLabelWidth = Math.max(rect.getWidth() - (insets.left + insets.right), 0);
          int maxLabelHeight = Math.max(rect.getHeight() - (insets.top + insets.bottom), 0);
          label.setClipping(true);
          label.setWidth(maxLabelWidth);
          label.setWrappingWidth(maxLabelWidth);
          int labelHeight = Math.min(label.getHeight(), maxLabelHeight);
          int labelLeft = rect.getLeft() + insets.left;
          int labelTop = rect.getTop() + insets.top /* + (maxLabelHeight - labelHeight) / 2 */;
          label.setBoundingRect(labelLeft, labelTop, maxLabelWidth, labelHeight);
        } else {
          label.setClipping(false);
          rect.setBoundingRect(label.getLeft() - insets.left,
                               label.getTop() - insets.top,
                               label.getWidth() + insets.left + insets.right,
                               label.getHeight() + insets.top + insets.bottom);
        }
      }
    }
  }

  public Insets getInsets() { return myInsets; }
  private Insets myInsets = new Insets(2, 4, 8, 8);  // top, left, bottom, right


  public void SVGUpdateReference(String attr, Object referencedObject)
  {
    super.SVGUpdateReference(attr, referencedObject);
    if (attr.equals("rectobj")) {
      myRect = (JGo3DNoteRect)referencedObject;
    }
    else if (attr.equals("label")) {
      myLabel = (JGoText)referencedObject;
    }
  }

  public void SVGWriteObject(DomDoc svgDoc, DomElement jGoElementGroup)
  {
    // Add Comment element
    if (svgDoc.JGoXMLOutputEnabled()) {
      DomElement jComment = svgDoc.createJGoClassElement(
          "com.nwoods.jgo.examples.Comment", jGoElementGroup);
      jComment.setAttribute("partid", Integer.toString(myPartID));
      // The following elements are all children of this area and so will be writen out
      // by JGoArea.SVGWriteObject().  We just need to update the references to them.
      if (myRect != null) {
        svgDoc.registerReferencingNode(jComment, "rectobj", myRect);
      }
      if (myLabel != null) {
        svgDoc.registerReferencingNode(jComment, "label", myLabel);
      }
    }

    // Have superclass add to the JGoObject group
    super.SVGWriteObject(svgDoc, jGoElementGroup);
  }

  public DomNode SVGReadObject(DomDoc svgDoc, JGoDocument jGoDoc, DomElement svgElement, DomElement jGoChildElement)
  {
    if (jGoChildElement != null) {
      // This is a Comment element
      String partid = jGoChildElement.getAttribute("partid");
      if (partid.length() > 0)
        myPartID = Integer.parseInt(partid);
      String rectobj = jGoChildElement.getAttribute("rectobj");
      svgDoc.registerReferencingObject(this, "rectobj", rectobj);
      String label = jGoChildElement.getAttribute("label");
      svgDoc.registerReferencingObject(this, "label", label);
      super.SVGReadObject(svgDoc, jGoDoc, svgElement, jGoChildElement.getNextSiblingJGoClassElement());
    }
    return svgElement.getNextSibling();
  }

  /**
   */
  public int getPartID()
  {
    return myPartID;
  }

  /**
   */
  public void setPartID(int id)
  {
    int old = myPartID;
    if (old != id) {
      myPartID = id;
      update(ChangedPartID, old, null);
    }
  }

  // get access to the parts of the node
  public JGoText getLabel() { return myLabel; }
  public JGo3DNoteRect getRect() { return myRect; }


  // These are convenience methods

  public String getText() { return getLabel().getText(); }
  public void setText(String s) { getLabel().setText(s); }

  public boolean isEditable() { return getLabel().isEditable(); }
  public void setEditable(boolean e) { getLabel().setEditable(e); }


  public void copyNewValueForRedo(JGoDocumentChangedEdit e)
  {
    switch (e.getFlags()) {
      case ChangedPartID:
        e.setNewValueInt(getPartID());
        return;
      default:
        super.copyNewValueForRedo(e);
        return;
    }
  }

  public void changeValue(JGoDocumentChangedEdit e, boolean undo)
  {
    switch (e.getFlags()) {
      case ChangedPartID:
        setPartID(e.getValueInt(undo));
        return;
      default:
        super.changeValue(e, undo);
        return;
    }
  }

  /** a CHANGED JGoDocumentEvent or JGoViewEvent hint: */
  public static final int ChangedPartID = JGoDocumentEvent.LAST+301;

    // State
  private int myPartID = -1;
  private JGoText myLabel = null;
  private JGo3DNoteRect myRect = null;
}
