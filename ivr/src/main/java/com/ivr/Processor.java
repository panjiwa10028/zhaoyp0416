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

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.swing.event.*;
import java.util.HashMap;
import java.net.URL;
import com.nwoods.jgo.*;
import com.ivr.activity.ActivityNode;
import com.ivr.jgo.*;


/**
 * This example app is a simple process flow editor
 */
public class Processor extends JApplet implements Runnable
{
  public Processor()
  {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
System.out.println(UIManager.getSystemLookAndFeelClassName());
      mainMenuBar = new JMenuBar();
      toolBar = new JToolBar();
      filemenu = new JMenu();
      editmenu = new JMenu();
      viewmenu = new JMenu();
      insertmenu = new JMenu();
      helpmenu = new JMenu();

      initMenus();
      initToolbar();

//      右容器
      myDesktop = new JDesktopPane();
//      左容器
      myPalette = new JGoPalette();
//      设置左容器的默认尺寸Dimension(int width, int height)
      myPalette.setPreferredSize(new Dimension(100, 300));
//      设置左容器的最小尺寸Dimension(int width, int height)
      myPalette.setMinimumSize(new Dimension(100, 100));
//      实例化一个用于分隔两个并且可以由用户交互式调整大小的容器
//      JSplitPane.HORIZONTAL_SPLIT 从左到右排列
//      JSplitPane.VERTICAL_SPLIT 从上到下排列
      JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
//      设置 continuousLayout 属性的值，在用户干预期要使子组件连续地重新显示和布局子组件，此值必须为 true。
      splitPane.setContinuousLayout(true);
//      将组件设置到分隔条的左边
      splitPane.setLeftComponent(getPalette());
//      将组件设置到分隔条的左边
      splitPane.setRightComponent(getDesktop());
//      设置分隔条的位置
      splitPane.setDividerLocation(100);

//      返回此窗体的 contentPane 对象
      Container contentPane = getContentPane();
//      BorderLayout 类定义了五个约束：BorderLayout.NORTH、BorderLayout.SOUTH、
//      BorderLayout.EAST、BorderLayout.WEST 和 BorderLayout.CENTER。
      contentPane.setLayout(new BorderLayout());
//      将toolbar放在容器的北面
      contentPane.add(toolBar, BorderLayout.NORTH);
//      将该组件放到容器的中间
      contentPane.add(splitPane, BorderLayout.CENTER);
//      验证此容器及其所有子组件
      contentPane.validate();
    } catch (Throwable t) {
      System.err.println(t);
      t.printStackTrace();
    }
  }


  //==============================================================
  // Define all the command actions
  //==============================================================

    static private Icon iconImage(String resourceName)
    {
      URL url = Processor.class.getResource(resourceName);
      if (url != null)
        return new ImageIcon(url);
      return null;
    }

    AppAction FileNewAction = new AppAction("New", iconImage("images/new.gif"), this) {
      public void actionPerformed(ActionEvent e) { newProcess(); }
      public boolean canAct() { return true; } };  // doesn't depend on a view

    AppAction FileOpenAction = new AppAction("Open", iconImage("images/open.gif"), this) {
      public void actionPerformed(ActionEvent e) { openProcess(); }
      public boolean canAct() { return true; } };  // doesn't depend on a view

    AppAction FileCloseAction = new AppAction("Close", this) {
      public void actionPerformed(ActionEvent e) { closeProcess(); } };

    AppAction FileSaveAction = new AppAction("Save", iconImage("images/save.gif"), this) {
      public void actionPerformed(ActionEvent e) { saveProcess(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isLocationModifiable(); } };  // doesn't depend on a view

    AppAction FileSaveAsAction = new AppAction("Save As", this) {
      public void actionPerformed(ActionEvent e) { saveAsProcess(); } };

    AppAction FilePropertiesAction = new AppAction("Properties", this) {
      public void actionPerformed(ActionEvent e) { editProcessProperties(); } };

    AppAction PrintAction = new AppAction("Print", iconImage("images/print.gif"), this) {
      public void actionPerformed(ActionEvent e) { getView().print(); } };

    AppAction CutAction = new AppAction("Cut", iconImage("images/remove.gif"), this) {
      public void actionPerformed(ActionEvent e) { getView().cut(); }
      public boolean canAct() { return super.canAct() && !getView().getSelection().isEmpty() && getView().getDoc().isModifiable(); } };  // doesn't depend on a view

    AppAction CopyAction = new AppAction("Copy", iconImage("images/copy.gif"), this) {
      public void actionPerformed(ActionEvent e) { getView().copy(); }
      public boolean canAct() { return super.canAct() && !getView().getSelection().isEmpty(); } };  // doesn't depend on a view

    AppAction PasteAction = new AppAction("Paste", iconImage("images/paste.gif"), this) {
      public void actionPerformed(ActionEvent e) { getView().paste(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };  // doesn't depend on a view

    AppAction DeleteAction = new AppAction("Delete", this) {
      public void actionPerformed(ActionEvent e) { getView().deleteSelection(); }
      public boolean canAct() { return super.canAct() && !getView().getSelection().isEmpty() && getView().getDoc().isModifiable(); } };

    AppAction SelectAllAction = new AppAction("Select All", this) {
      public void actionPerformed(ActionEvent e) { getView().selectAll(); } };

  JMenuItem UndoMenuItem = null;

    AppAction UndoAction = new AppAction("Undo", this) {
      public void actionPerformed(ActionEvent e) { getView().getDocument().undo(); AppAction.updateAllActions(); }
      public boolean canAct() { return super.canAct() && (getView().getDocument().canUndo()); }
      public void updateEnabled()
      {
        super.updateEnabled();
        if (UndoMenuItem != null && getView() != null)
          UndoMenuItem.setText(getView().getDocument().getUndoManager().getUndoPresentationName());
      } };

  JMenuItem RedoMenuItem = null;

    AppAction RedoAction = new AppAction("Redo", this) {
      public void actionPerformed(ActionEvent e) { getView().getDocument().redo(); AppAction.updateAllActions(); }
      public boolean canAct() { return super.canAct() && (getView().getDocument().canRedo()); }
      public void updateEnabled()
      {
        super.updateEnabled();
        if (RedoMenuItem != null && getView() != null)
          RedoMenuItem.setText(getView().getDocument().getUndoManager().getRedoPresentationName());
      } };

    AppAction DrawRoutedLinkAction = new AppAction("Draw Routed Link", this) {
      public void actionPerformed(ActionEvent e) { getView().editDrawRoutedLink(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };

    AppAction MovePortAction = new AppAction("Move Port", this) {
      public void actionPerformed(ActionEvent e) { getView().editMovePort(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };

    AppAction ObjectPropertiesAction = new AppAction("Properties", this) {
      public void actionPerformed(ActionEvent e) { getView().editObjectProperties(); }
      public boolean canAct() { return super.canAct() && !getView().getSelection().isEmpty(); } };

  JCheckBoxMenuItem LinksJumpOverMenuItem = null;

    AppAction LinksJumpOverAction = new AppAction("Links Jump Over", this) {
      public void actionPerformed(ActionEvent e) {
        getView().getDoc().setLinksJumpOver(!getView().getDoc().getLinksJumpOver());
      }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); }
      public void updateEnabled()
      {
        super.updateEnabled();
        if (LinksJumpOverMenuItem != null && getView() != null)
          LinksJumpOverMenuItem.setSelected(getView().getDoc().getLinksJumpOver());
      } };

    AppAction ZoomNormalAction = new AppAction("Normal Zoom", this) {
      public void actionPerformed(ActionEvent e) { getView().zoomNormal(); } };

    AppAction ZoomInAction = new AppAction("Zoom In", this) {
      public void actionPerformed(ActionEvent e) { getView().zoomIn(); }
      public boolean canAct() { return super.canAct() && (getView().getScale() < 8.0f); } };

    AppAction ZoomOutAction = new AppAction("Zoom Out", this) {
      public void actionPerformed(ActionEvent e) { getView().zoomOut(); }
      public boolean canAct() { return super.canAct() && (getView().getScale() > 0.13f); } };

    AppAction ZoomToFitAction = new AppAction("Zoom To Fit", this) {
      public void actionPerformed(ActionEvent e) { getView().zoomToFit(); } };

    AppAction InsertCommentAction = new AppAction("Comment", this) {
      public void actionPerformed(ActionEvent e) { getView().insertComment(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };

    AppAction InsertInputAction = new AppAction("Start", this) {
      public void actionPerformed(ActionEvent e) { getView().insertInput(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };

    AppAction InsertOutputAction = new AppAction("Finish", this) {
      public void actionPerformed(ActionEvent e) { getView().insertOutput(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };

    AppAction InsertActivityAction = new AppAction("Activity", this) {
      public void actionPerformed(ActionEvent e) { getView().insertActivity(); }
      public boolean canAct() { return super.canAct() && getView().getDoc().isModifiable(); } };

    AppAction AboutAction = new AppAction("About", iconImage("images/tb_07_u.gif"), this) {
      public void actionPerformed(ActionEvent e) { showAbout(); }
      public boolean canAct() { return true; } };  // doesn't depend on a view


  void initMenus()
  {
    //==============================================================
    // Define all the command actions and setup the menus
    //==============================================================
    JMenuItem item = null;

    filemenu.setText("File");
    filemenu.setMnemonic('F');

    item = filemenu.add(FileNewAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N,Event.CTRL_MASK));
    item.setMnemonic('N');
    item.setIcon(null);  //choose not to use icon in menu

    item = filemenu.add(FileOpenAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_O,Event.CTRL_MASK));
    item.setMnemonic('O');
    item.setIcon(null);  //choose not to use icon in menu

    item = filemenu.add(FileCloseAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F4,Event.CTRL_MASK));
    item.setMnemonic('C');

    item = filemenu.add(FileSaveAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S,Event.CTRL_MASK));
    item.setMnemonic('S');
    item.setIcon(null);  //choose not to use icon in menu

    item = filemenu.add(FileSaveAsAction);
    item.setMnemonic('A');

    filemenu.addSeparator();

    item = filemenu.add(FilePropertiesAction);
    item.setMnemonic('r');

    filemenu.addSeparator();

    item = filemenu.add(PrintAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_P,Event.CTRL_MASK));
    item.setMnemonic('P');
    item.setIcon(null);  //choose not to use icon in menu

    mainMenuBar.add(filemenu);


    editmenu.setText("Edit");
    editmenu.setMnemonic('E');

    item = editmenu.add(CutAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_X,Event.CTRL_MASK));
    item.setMnemonic('t');
    item.setIcon(null);  //choose not to use icon in menu

    item = editmenu.add(CopyAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C,Event.CTRL_MASK));
    item.setMnemonic('C');
    item.setIcon(null);  //choose not to use icon in menu

    item = editmenu.add(PasteAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_V,Event.CTRL_MASK));
    item.setMnemonic('P');
    item.setIcon(null);  //choose not to use icon in menu

    item = editmenu.add(DeleteAction);
    item.setMnemonic('D');

    item = editmenu.add(SelectAllAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_A,Event.CTRL_MASK));
    item.setMnemonic('l');

    editmenu.addSeparator();

    UndoMenuItem = editmenu.add(UndoAction);
    UndoMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Z,Event.CTRL_MASK));
    UndoMenuItem.setMnemonic('U');

    RedoMenuItem = editmenu.add(RedoAction);
    RedoMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Y,Event.CTRL_MASK));
    RedoMenuItem.setMnemonic('R');

    editmenu.addSeparator();
    
    item = editmenu.add(ObjectPropertiesAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER,Event.CTRL_MASK));
    item.setMnemonic('o');

    editmenu.addSeparator();
    
    item = editmenu.add(DrawRoutedLinkAction);
    item.setMnemonic('w');

    item = editmenu.add(MovePortAction);
    item.setMnemonic('v');

    mainMenuBar.add(editmenu);


    viewmenu.setText("View");
    viewmenu.setMnemonic('V');

    item = viewmenu.add(ZoomNormalAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F6,Event.CTRL_MASK | Event.SHIFT_MASK));
    item.setMnemonic('N');

    item = viewmenu.add(ZoomInAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F6,Event.CTRL_MASK));
    item.setMnemonic('I');

    item = viewmenu.add(ZoomOutAction);
    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F6,Event.SHIFT_MASK));
    item.setMnemonic('O');

    item = viewmenu.add(ZoomToFitAction);
//    item.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F6, 0));
    item.setMnemonic('Z');
    
    viewmenu.addSeparator();

    LinksJumpOverMenuItem = new JCheckBoxMenuItem(LinksJumpOverAction);
    viewmenu.add(LinksJumpOverMenuItem);
    LinksJumpOverMenuItem.setMnemonic('j');

    mainMenuBar.add(viewmenu);


    insertmenu.setText("Insert");
    insertmenu.setMnemonic('I');

    item = insertmenu.add(InsertCommentAction);
    item.setMnemonic('C');

    item = insertmenu.add(InsertInputAction);
    item.setMnemonic('S');

    item = insertmenu.add(InsertOutputAction);
    item.setMnemonic('F');

    item = insertmenu.add(InsertActivityAction);
    item.setMnemonic('A');

    mainMenuBar.add(insertmenu);
    

    helpmenu.setText("Help");
    helpmenu.setMnemonic('H');

    item = helpmenu.add(AboutAction);
    item.setMnemonic('A');
    item.setIcon(null);  //choose not to use icon in menu

    mainMenuBar.add(helpmenu);

    setJMenuBar(mainMenuBar);
  }
  
  protected JToolBar initToolbar()
  {
    JButton button = null;
    button = toolBar.add(FileNewAction);
    button.setToolTipText("Create a new work-flow window");
    button = toolBar.add(FileOpenAction);
    button.setToolTipText("Open a previously saved work-flow window");
    button = toolBar.add(FileSaveAction);
    button.setToolTipText("Save a work-flow window");
    toolBar.addSeparator();
    button = toolBar.add(CutAction);
    button.setToolTipText("Cut to clipboard");
    button = toolBar.add(CopyAction);
    button.setToolTipText("Copy to clipboard");
    button = toolBar.add(PasteAction);
    button.setToolTipText("Paste from clipboard");
    toolBar.addSeparator();
    button = toolBar.add(PrintAction);
    button.setToolTipText("Print selected work-flow window");
    toolBar.addSeparator();
    button = toolBar.add(AboutAction);
    button.setToolTipText("Display help about this application");
    return toolBar;
  }

  public void addExitCommand()
  {
    filemenu.addSeparator();

    AppAction ExitAction = new AppAction("Exit", this) {
      public void actionPerformed(ActionEvent e) { exit(); }
      public boolean canAct() { return true; } };  // doesn't depend on a view

    JMenuItem item = filemenu.add(ExitAction);
    item.setMnemonic('x');
  }

  /**
   * 初始化左面窗口
   */
  void initPalette()
  {
    getPalette().setBorder(new TitledBorder("Activities"));

    JGoDocument doc = getPalette().getDocument();

    Comment cmnt = new Comment("a comment");
    cmnt.setEditable(true);
    doc.addObjectAtTail(cmnt);

    ActivityNode snode;
    for (int i = 0; i < 3; i++) {
      ActivityNode n = makePaletteNode(i, -1);
      doc.addObjectAtTail(n);
    }
  }
  
  ActivityNode makePaletteNode(int acttype, int id)
  {
    ActivityNode snode = new ActivityNode();
//    JGoImage nodeicon = new JGoImage(new Rectangle(0,0,40,40));
//    nodeicon.loadImage(Processor.class.getResource("./images/doc.gif"), true);
//    初始化Node
    snode.initialize(acttype, id);
//    给node添加输入输出端口
    snode.addScatteredPorts(4);
//    snode.addScatteredPorts((int)(Math.random()*5)+1);
    snode.getLabel().setSelectable(false);
    return snode;
  }

  public void init()  // Applet initialization
  {
    JGoImage.setDefaultBase(getCodeBase());
  }

  public void start()
  {
    // enable drag-and-drop from separate thread
    new Thread(this).start();

    initPalette();
    MultiPortNodePort.FULL = new JGoBrush(JGoBrush.SOLID, Color.green);
  }

  public void run() {
    getPalette().initializeDragDropHandling();
//    返回桌面中当前显示的所有 JInternalFrames
    if (getDesktop().getAllFrames().length == 0) {
//    	在右工作区创建一个新窗口
      newProcess();
    }

    AppAction.updateAllActions();
  }

  public void destroy() {
    JInternalFrame[] frames = getDesktop().getAllFrames();
    for (int i = 0; i < frames.length; i++) {
      JInternalFrame f = frames[i];
      try {
        f.setClosed(true);
      } catch (Exception x) {
      }
    }
  }

  static public void main(String args[])
  {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());

      final Processor app = new Processor();
      final JFrame mainFrame = new JFrame();

      // close the application when the main window closes
//      添加窗体的监听事件
      mainFrame.addWindowListener(new WindowAdapter() {
//    	  激活窗口时调用
        public void windowActivated(WindowEvent evt) {
          if (app.getCurrentView() != null) {
            app.getCurrentView().getDoc().updateLocationModifiable();
          }
        }
//        窗口正处在关闭过程中时调用
        public void windowClosing(WindowEvent event) {
          Object object = event.getSource();
          if (object == mainFrame) {
            app.exit();
          }
        }
      });

//      在file菜单中添加退出的菜单项
      app.addExitCommand();

//      设置窗体的标题
      mainFrame.setTitle("Process Flow Editor");
//      获取屏幕的大小
      Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
//      重绘组件的指定矩形区域。x - 组件的新 x 坐标， y - 组件的新 y 坐标，width - 组件的新 width，height - 组件的新 height
      mainFrame.setBounds(0, 0, screensize.width, screensize.height);

      Container contentPane = mainFrame.getContentPane();
      contentPane.setLayout(new BorderLayout());
      contentPane.add(app, BorderLayout.CENTER);
      contentPane.validate();
//      根据参数 b 的值显示或隐藏此组件。
      mainFrame.setVisible(true);

      app.start();
    } catch (Throwable t) {
      System.err.println(t);
      t.printStackTrace();
      System.exit(1);
    }
  }


  void exit()
  {
    destroy();
    System.exit(0);
  }

  void showAbout()
  {
    HelpDlg helpDlg = new HelpDlg(null, "About", true);
    helpDlg.setVisible(true);
  }

  void editProcessProperties()
  {
    ProcessView v = getCurrentView();
    if (v != null) {
      v.getDoc().startTransaction();
      new ProcessDialog(v.getFrame(), v.getDoc()).setVisible(true);
      v.getDoc().endTransaction("Process Properties");
    }
  }

  /**
   * 添加右侧的窗口
   * @param doc
   */
  public void createFrame(ProcessDocument doc)
  {
    final ProcessView view = new ProcessView(doc);
//    创建不可图标化的，但具有指定标题、可调整大小、可关闭和可最大化的 JInternalFrame。
    final JInternalFrame frame = new JInternalFrame(doc.getName(), true, true, true);
    frame.setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
    view.initialize(this, frame);

    // keep track of the "current" view, even if it doesn't have focus
    // try to give focus to a view when it becomes activated
    // enable/disable all the command actions appropriately for the view
//    添加指定的侦听器，以从此内部窗体接收内部窗体事件
    frame.addInternalFrameListener(new InternalFrameListener()
      {
        public void internalFrameActivated(InternalFrameEvent e)
          {
            myCurrentView = view;
            view.requestFocus();
            view.getDoc().updateLocationModifiable();
            AppAction.updateAllActions();
          }
        public void internalFrameDeactivated(InternalFrameEvent e) {}
        public void internalFrameOpened(InternalFrameEvent e) {}
        public void internalFrameClosing(InternalFrameEvent e) {}
        public void internalFrameClosed(InternalFrameEvent e)
          {
            myCurrentView = null;
            AppAction.updateAllActions();
          }
        public void internalFrameIconified(InternalFrameEvent e) {}
        public void internalFrameDeiconified(InternalFrameEvent e) {}
      }
    );

    frame.addVetoableChangeListener(new java.beans.VetoableChangeListener()
      {
        public void vetoableChange(java.beans.PropertyChangeEvent evt)
               throws java.beans.PropertyVetoException {
//        	当窗体关闭时触发事件
          if (evt.getPropertyName().equals(JInternalFrame.IS_CLOSED_PROPERTY) &&
              evt.getOldValue() == Boolean.FALSE &&
              evt.getNewValue() == Boolean.TRUE) {
            if (view.getDoc().isModified()) {
              String msg = "Save changes to ";
              if (view.getDoc().getName().equals(""))
                msg += "modified document?";
              else
                msg += view.getDoc().getName();
              msg += "\n  (";
              if (view.getDoc().getLocation().equals(""))
                msg += "<no location>";
              else
                msg += view.getDoc().getLocation();
              msg += ")";
              int answer = JOptionPane.showConfirmDialog(view.getFrame(),
                                msg, "Closing modified document",
                                JOptionPane.YES_NO_CANCEL_OPTION,
                                JOptionPane.QUESTION_MESSAGE);
              if (answer == JOptionPane.NO_OPTION ||
                  answer == JOptionPane.YES_OPTION) {
                if (answer == JOptionPane.YES_OPTION) {
                  if (view.getDoc().isLocationModifiable())
                    view.getDoc().save();
                  else
                    view.getDoc().saveAs(".wfl");
                }
                // then allow the internal frame to close
                getDesktop().remove(frame);
                getDesktop().repaint();
              } else {
                // CANCEL_OPTION--don't close
                throw new java.beans.PropertyVetoException("", evt);
              }
            }
          }
        }
      }
    );

    Container contentPane = frame.getContentPane();
    contentPane.setLayout(new BorderLayout());
    contentPane.add(view);

    frame.setSize(500, 400);
    getDesktop().add(frame);
    frame.show();
    view.initializeDragDropHandling();
  }

  void newProcess()
  {
    ProcessDocument doc = new ProcessDocument();
    String t = "Untitled" + Integer.toString(myDocCount++);
    doc.setName(t);
    createFrame(doc);
    doc.setModified(false);
    doc.discardAllEdits();
  }

  void openProcess()
  {
    String defaultLoc = null;
    ProcessView view = getCurrentView();
    if (view != null) {
      ProcessDocument doc = view.getDoc();
      defaultLoc = doc.getLocation();
    }
    ProcessDocument doc = ProcessDocument.open(this, defaultLoc);
    if (doc != null)
      createFrame(doc);
  }

  void closeProcess()
  {
    if (getCurrentView() != null) {
      JInternalFrame frame = getCurrentView().getInternalFrame();
      if (frame != null) {
        try {
          frame.setClosed(true);
        } catch (Exception x) {
        }
      }
    }
  }

  void saveProcess()
  {
    if (getCurrentView() != null) {
      ProcessDocument doc = getCurrentView().getDoc();
      doc.save();
    }
  }

  void saveAsProcess()
  {
    if (getCurrentView() != null) {
      ProcessDocument doc = getCurrentView().getDoc();
      doc.saveAs(".wfl");
    }
  }

  ProcessDocument findProcessDocument(String path)
  {
    Object val = myMap.get(path);
    if (val != null && val instanceof ProcessDocument)
      return (ProcessDocument)val;
    else
      return null;
  }
  

  ProcessView getCurrentView()
  {
    return myCurrentView;
  }


  JDesktopPane getDesktop() { return myDesktop; }
  JGoPalette getPalette() { return myPalette; }


  // State
  protected HashMap myMap = new HashMap();
  protected ProcessView myCurrentView;
  protected JDesktopPane myDesktop;
  protected JGoPalette myPalette;

  protected JMenuBar mainMenuBar;
  protected JToolBar toolBar;
  protected JMenu filemenu;
  protected JMenu editmenu;
  protected JMenu viewmenu;
  protected JMenu insertmenu;
  protected JMenu helpmenu;

  private int myDocCount = 1;
}
