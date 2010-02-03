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
package com.ivr.activity;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import javax.swing.text.*;


public class ActivityDialog extends JDialog {
  public ActivityNode myObject;
  
  private javax.swing.JButton jButton1;
	private javax.swing.JButton jButton2;
	private javax.swing.JButton jButton3;
	private javax.swing.JButton jButton4;
	private javax.swing.JComboBox jComboBox1;
	private javax.swing.JLabel jLabel1;
	private javax.swing.JLabel jLabel2;
	private javax.swing.JLabel jLabel3;
	private javax.swing.JLabel jLabel4;
	private javax.swing.JLabel jLabel5;
	private javax.swing.JLabel jLabel6;
	private javax.swing.JLabel jLabel7;
	private javax.swing.JPanel jPanel1;
	private javax.swing.JPanel jPanel2;
	private javax.swing.JPanel jPanel3;
	private javax.swing.JScrollPane jScrollPane1;
	private javax.swing.JScrollPane jScrollPane2;
	private javax.swing.JTabbedPane jTabbedPane1;
	private javax.swing.JTable jTable1;
	private javax.swing.JTextArea jTextArea1;
	private javax.swing.JTextField jTextField1;
	private javax.swing.JTextField jTextField2;
	private javax.swing.JTextField jTextField3;
	private javax.swing.JTextField jTextField4;
	
  private void initComponents() {

		jTabbedPane1 = new javax.swing.JTabbedPane();
		jPanel1 = new javax.swing.JPanel();
		jLabel1 = new javax.swing.JLabel();
		jTextField1 = new javax.swing.JTextField();
		jLabel2 = new javax.swing.JLabel();
		jTextField2 = new javax.swing.JTextField();
		jLabel3 = new javax.swing.JLabel();
		jScrollPane1 = new javax.swing.JScrollPane();
		jTextArea1 = new javax.swing.JTextArea();
		jPanel2 = new javax.swing.JPanel();
		jLabel4 = new javax.swing.JLabel();
		jComboBox1 = new javax.swing.JComboBox();
		jLabel5 = new javax.swing.JLabel();
		jTextField3 = new javax.swing.JTextField();
		jPanel3 = new javax.swing.JPanel();
		jLabel6 = new javax.swing.JLabel();
		jTextField4 = new javax.swing.JTextField();
		jLabel7 = new javax.swing.JLabel();
		jScrollPane2 = new javax.swing.JScrollPane();
		jTable1 = new javax.swing.JTable();
		jButton3 = new javax.swing.JButton();
		jButton4 = new javax.swing.JButton();
		jButton1 = new javax.swing.JButton();
		jButton2 = new javax.swing.JButton();

		setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

		jLabel1.setText("\u663e\u793a\u540d\u79f0");

		jTextField1.setText("jTextField1");

		jLabel2.setText("\u7cfb\u7edf\u540d\u79f0");

		jTextField2.setText("jTextField2");

		jLabel3.setText("\u63cf\u8ff0");

		jTextArea1.setColumns(20);
		jTextArea1.setRows(5);
		jScrollPane1.setViewportView(jTextArea1);

		javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
		jPanel1.setLayout(jPanel1Layout);
		jPanel1Layout.setHorizontalGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(
						jPanel1Layout.createSequentialGroup().addContainerGap().addGroup(
								jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
										.addGroup(
												jPanel1Layout.createSequentialGroup().addComponent(jLabel1)
														.addPreferredGap(
																javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
														.addComponent(jTextField1,
																javax.swing.GroupLayout.PREFERRED_SIZE, 280,
																javax.swing.GroupLayout.PREFERRED_SIZE)).addGroup(
												jPanel1Layout.createSequentialGroup().addGroup(
														jPanel1Layout.createParallelGroup(
																javax.swing.GroupLayout.Alignment.TRAILING)
																.addComponent(jLabel3).addComponent(jLabel2))
														.addPreferredGap(
																javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
														.addGroup(
																jPanel1Layout.createParallelGroup(
																		javax.swing.GroupLayout.Alignment.LEADING)
																		.addComponent(jScrollPane1,
																				javax.swing.GroupLayout.DEFAULT_SIZE,
																				280, Short.MAX_VALUE).addComponent(
																				jTextField2)))).addContainerGap(51,
								Short.MAX_VALUE)));
		jPanel1Layout.setVerticalGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(
						jPanel1Layout.createSequentialGroup().addContainerGap().addGroup(
								jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
										.addComponent(jLabel1).addComponent(jTextField1,
												javax.swing.GroupLayout.PREFERRED_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.PREFERRED_SIZE)).addPreferredGap(
								javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addGroup(
								jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
										.addComponent(jLabel2).addComponent(jTextField2,
												javax.swing.GroupLayout.PREFERRED_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.PREFERRED_SIZE)).addPreferredGap(
								javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addGroup(
								jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jLabel3).addComponent(jScrollPane1,
												javax.swing.GroupLayout.PREFERRED_SIZE, 137,
												javax.swing.GroupLayout.PREFERRED_SIZE)).addContainerGap(23,
								Short.MAX_VALUE)));

		jTabbedPane1.addTab("\u901a\u7528\u5c5e\u6027", jPanel1);

		jLabel4.setText("\u9ed8\u8ba4\u8bed\u8a00");

		jComboBox1.setModel(new javax.swing.DefaultComboBoxModel(
				new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));

		jLabel5.setText("\u7b49\u5f85\u8f93\u5165\u65f6\u957f(\u79d2)");

		jTextField3.setText("jTextField3");

		javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
		jPanel2.setLayout(jPanel2Layout);
		jPanel2Layout.setHorizontalGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(
						jPanel2Layout.createSequentialGroup().addContainerGap().addGroup(
								jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
										.addComponent(jLabel5).addComponent(jLabel4)).addPreferredGap(
								javax.swing.LayoutStyle.ComponentPlacement.RELATED).addGroup(
								jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
										.addComponent(jTextField3).addComponent(jComboBox1, 0, 151, Short.MAX_VALUE))
								.addContainerGap(138, Short.MAX_VALUE)));
		jPanel2Layout.setVerticalGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(
						jPanel2Layout.createSequentialGroup().addContainerGap().addGroup(
								jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
										.addComponent(jLabel4).addComponent(jComboBox1,
												javax.swing.GroupLayout.PREFERRED_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.PREFERRED_SIZE)).addPreferredGap(
								javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addGroup(
								jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
										.addComponent(jLabel5).addComponent(jTextField3,
												javax.swing.GroupLayout.PREFERRED_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.PREFERRED_SIZE)).addContainerGap(170,
								Short.MAX_VALUE)));

		jTabbedPane1.addTab("\u5f00\u59cb", jPanel2);

		jLabel6.setText("\u7cfb\u7edf\u53d8\u91cf");

		jTextField4.setText("jTextField4");

		jLabel7.setText("\u7ec4\u4ef6");

		jTable1.setModel(new javax.swing.table.DefaultTableModel(new Object[][] { { null, null },{ null, null }}, new String[] {
				"Title 1", "Title 2"}));
		
		jScrollPane2.setViewportView(jTable1);

		jButton3.setText("\u65b0\u589e");
		jButton3.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				jButton3ActionPerformed(evt);
			}
		});

		jButton4.setText("\u5220\u9664");

		javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
		jPanel3.setLayout(jPanel3Layout);
		jPanel3Layout.setHorizontalGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(
						jPanel3Layout.createSequentialGroup().addContainerGap().addGroup(
								jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
										.addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 288,
												javax.swing.GroupLayout.PREFERRED_SIZE).addGroup(
												jPanel3Layout.createSequentialGroup().addGroup(
														jPanel3Layout.createParallelGroup(
																javax.swing.GroupLayout.Alignment.TRAILING)
																.addComponent(jLabel7).addComponent(jLabel6))
														.addPreferredGap(
																javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
														.addComponent(jTextField4))).addPreferredGap(
								javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addGroup(
								jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jButton3).addComponent(jButton4)).addContainerGap(34,
								Short.MAX_VALUE)));
		jPanel3Layout
				.setVerticalGroup(jPanel3Layout
						.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
						.addGroup(
								jPanel3Layout
										.createSequentialGroup()
										.addContainerGap()
										.addGroup(
												jPanel3Layout.createParallelGroup(
														javax.swing.GroupLayout.Alignment.BASELINE).addComponent(
														jLabel6).addComponent(jTextField4,
														javax.swing.GroupLayout.PREFERRED_SIZE,
														javax.swing.GroupLayout.DEFAULT_SIZE,
														javax.swing.GroupLayout.PREFERRED_SIZE))
										.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
										.addComponent(jLabel7)
										.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
										.addGroup(
												jPanel3Layout
														.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
														.addGroup(
																jPanel3Layout
																		.createSequentialGroup()
																		.addComponent(jButton3)
																		.addPreferredGap(
																				javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
																		.addComponent(jButton4)).addComponent(
																jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE,
																155, javax.swing.GroupLayout.PREFERRED_SIZE))
										.addContainerGap(15, Short.MAX_VALUE)));

		jTabbedPane1.addTab("\u53d8\u91cf", jPanel3);

		jButton1.setText("\u53d6\u6d88");

		jButton2.setText("\u786e\u5b9a");
		jButton2.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				OKButton_actionPerformed(evt);
			}
		});

		javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
		getContentPane().setLayout(layout);
		layout.setHorizontalGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGroup(
				javax.swing.GroupLayout.Alignment.TRAILING,
				layout.createSequentialGroup().addContainerGap(274, Short.MAX_VALUE).addComponent(jButton2)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jButton1)
						.addContainerGap()).addComponent(jTabbedPane1));
		layout.setVerticalGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGroup(
				layout.createSequentialGroup().addComponent(jTabbedPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 261,
						javax.swing.GroupLayout.PREFERRED_SIZE).addPreferredGap(
						javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addGroup(
						layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE).addComponent(jButton1)
								.addComponent(jButton2)).addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE,
						Short.MAX_VALUE)));

		pack();
	}// </editor-fold>
	//GEN-END:initComponents

	private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {
		// TODO add your handling code here:
	}

	private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {
		// TODO add your handling code here:
	}
  public ActivityDialog(Frame frame, String title, boolean modal) {
    super(frame, title, modal);
    try  {
    	initComponents();
      pack();
    }
    catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  public ActivityDialog() {
    this(null, "", false);
  }

  public ActivityDialog(Frame frame, ActivityNode obj)
  {
    super(frame, "Activity Properties", true);
    try  {
      myObject = obj;
//    调整此窗口的大小，以适合其子组件的首选大小和布局。
      initComponents();
      pack();
//      把组件的值带入到窗体中
      updateDialog();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  
  
  void updateDialog()
  {
    if (myObject == null) return;
    jTextField1.setText(myObject.getDisplayName());
    jTextField1.setEnabled(myObject.getDocument().isModifiable());
    
    jTextField2.setText(myObject.getSystemName());
    jTextArea1.setText(myObject.getDescription());
   
  }

  void updateData()
  {
    if (myObject == null) return;
    myObject.setDisplayName(jTextField1.getText());
    myObject.setSystemName(jTextField2.getText());
    myObject.setDescription(jTextArea1.getText());
  }

  void OKButton_actionPerformed(ActionEvent e) {
      try {
        updateData();
//        释放由此 Window、其子组件及其拥有的所有子组件所使用的所有本机屏幕资源。
        this.dispose();             // Free system resources
      } catch (Exception ex) {
    }
  }

  void CancelButton_actionPerformed(ActionEvent e) {
      try {
        this.dispose();             // Free system resources
      } catch (Exception ex) {
    }
  }
}
              
