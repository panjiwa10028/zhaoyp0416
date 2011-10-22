package com.allennb.form;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.ScrolledComposite;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.List;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.allennb.common.FileUtils;
import com.allennb.common.RandomUtil;

public class MaterialForm {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	protected Shell shell;
	private Text text;
	private Text text_1;
	private List list;
	
	private String publishTitle = "";
	private String publishContent = "";;

//	/**
//	 * Launch the application.
//	 * @param args
//	 */
//	public static void main(String[] args) {
//		try {
//			MaterialForm window = new MaterialForm();
//			window.open();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	/**
	 * Open the window.
	 */
	public void open() {
		logger.debug(" open material form");
		Display display = Display.getDefault();
		createContents();
		shell.open();
		shell.layout();
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
	}

	/**
	 * Create contents of the window.
	 * @wbp.parser.entryPoint
	 */
	protected void createContents() {
		shell = new Shell();
		shell.setSize(714, 579);
		shell.setText("SWT Application");
		String levelType2 = FileUtils.getProp("type.level.2");
		
		Button btnNewButton = new Button(shell, SWT.NONE);
		btnNewButton.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				String[] selectedItem = list.getSelection();
				publishTitle = "";
				publishContent = "";
				if(selectedItem == null || selectedItem.length == 0) {
					MessageBox dialog=new MessageBox(new Shell(),SWT.OK|SWT.ICON_INFORMATION); 
					dialog.setText("提示"); 
					dialog.setMessage("请选择分类"); 
					dialog.open();
				} else {
					loadMessage(selectedItem);
					text.setText(getPublishTitle());
					text_1.setText(getPublishContent());
				}
				
			}
		});
		btnNewButton.setBounds(441, 96, 80, 27);
		btnNewButton.setText("下一条");
		
		Button btnNewButton_1 = new Button(shell, SWT.NONE);
		btnNewButton_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				publishTitle = text.getText();
				publishContent = text_1.getText();
				PublishForm publishForm = new PublishForm(publishTitle, publishContent);
				publishForm.open();
			}
		});
		btnNewButton_1.setBounds(567, 96, 80, 27);
		btnNewButton_1.setText("发布");
		
		Label lblNewLabel = new Label(shell, SWT.NONE);
		lblNewLabel.setBounds(52, 152, 34, 17);
		lblNewLabel.setText("标题：");
		
		Label lblNewLabel_1 = new Label(shell, SWT.NONE);
		lblNewLabel_1.setBounds(52, 41, 34, 17);
		lblNewLabel_1.setText("分类：");
		
		text = new Text(shell, SWT.BORDER);
		text.setBounds(92, 149, 555, 23);
		
		Label lblNewLabel_2 = new Label(shell, SWT.NONE);
		lblNewLabel_2.setBounds(52, 205, 34, 17);
		lblNewLabel_2.setText("内容：");
		
		ScrolledComposite scrolledComposite = new ScrolledComposite(shell, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL);
		scrolledComposite.setBounds(92, 38, 85, 85);
		scrolledComposite.setExpandHorizontal(true);
		scrolledComposite.setExpandVertical(true);
		
		list = new List(scrolledComposite, SWT.BORDER | SWT.MULTI);
		
		list.setItems(StringUtils.split(levelType2, ","));
		scrolledComposite.setContent(list);
		scrolledComposite.setMinSize(list.computeSize(SWT.DEFAULT, SWT.DEFAULT));
		
	
		
		text_1 = new Text(shell, SWT.BORDER | SWT.MULTI);
		text_1.setBounds(92, 205, 555, 304);
		text_1.addKeyListener(new KeyListener() {	
			public void keyReleased(KeyEvent e) {}	
			public void keyPressed(KeyEvent e) {	
				 if (e.stateMask == SWT.CTRL && e.keyCode == 'a') {
			            text_1.selectAll();
			        }
			}
			});

	}
	
	/**
	 * 加载要发布的资源信息
	 * @param selectedItem
	 */
	private void loadMessage(String[] selectedItem) {
		logger.debug("load message");
		int cnt = RandomUtil.getRandomNumber(selectedItem.length) - 1;
		String folderName = "";
		int errorCount = 0;
		while("".equals(folderName)) {
			try{
				folderName = selectedItem[cnt];
			} catch(Exception e){
				errorCount++;
			}
			if(errorCount == 5) {
				break;
			}
		}

		try{
			File files = new File("头标题/" + folderName);
			if(files.isDirectory()) {
				File[] subFiles = files.listFiles();
				int randomNum = RandomUtil.getRandomNumber(subFiles.length) - 1;
				java.util.List<String>  beginTitleList = FileUtils.getFileContent(subFiles[randomNum]);
				
				randomNum = RandomUtil.getRandomNumber(beginTitleList.size()) - 1;
				publishTitle = beginTitleList.get(randomNum);
			}
			
			files = new File("尾标题/" + folderName);
			if(files.isDirectory()) {
				File[] subFiles = files.listFiles();
				int randomNum = RandomUtil.getRandomNumber(subFiles.length) - 1;
				java.util.List<String>  endTitleList = FileUtils.getFileContent(subFiles[randomNum]);
				
				randomNum = RandomUtil.getRandomNumber(endTitleList.size()) - 1;
				publishTitle += "|" + endTitleList.get(randomNum);
			}
			logger.debug("load message publishTitle:" + publishTitle);
			StringBuffer content = new StringBuffer();			
			
			content.append(publishTitle);
			content.append("\r\n");
			
			files = new File("头模板/" + folderName);
			if(files.isDirectory()) {
				File[] subFiles = files.listFiles();
				int randomNum = RandomUtil.getRandomNumber(subFiles.length) - 1;
				java.util.List<String>  beginTemplateList = FileUtils.getFileContent(subFiles[randomNum]);
				
				for(String readLine:beginTemplateList) {
					content.append(readLine);
					content.append("\r\n");
				}
				content.append("\r\n");
			}
			
			files = new File("内容/" + folderName);
			if(files.isDirectory()) {
				File[] subFiles = files.listFiles();
				int randomNum = RandomUtil.getRandomNumber(subFiles.length) - 1;
				java.util.List<String>  contentsList = FileUtils.getFileContent(subFiles[randomNum]);
				
				for(String readLine:contentsList) {
					content.append(readLine);
					content.append("\r\n");
				}
				content.append("\r\n");
			}
			
			files = new File("尾模板/" + folderName);
			if(files.isDirectory()) {
				File[] subFiles = files.listFiles();
				int randomNum = RandomUtil.getRandomNumber(subFiles.length) - 1;
				java.util.List<String>  endTemplateList = FileUtils.getFileContent(subFiles[randomNum]);
				
				for(String readLine:endTemplateList) {
					content.append(readLine);
					content.append("\r\n");
				}
				content.append("\r\n");
			} 
			content.append("\r\n");
			content.append(publishTitle);
			publishContent = content.toString();
			logger.debug("load message publishContent:" + publishContent);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		
		
	}

	public String getPublishTitle() {
		return publishTitle;
	}

	public void setPublishTitle(String publishTitle) {
		this.publishTitle = publishTitle;
	}

	public String getPublishContent() {
		return publishContent;
	}

	public void setPublishContent(String publishContent) {
		this.publishContent = publishContent;
	}
}
