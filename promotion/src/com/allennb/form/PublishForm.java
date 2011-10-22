package com.allennb.form;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.eclipse.swt.SWT;
import org.eclipse.swt.browser.Browser;
import org.eclipse.swt.browser.LocationAdapter;
import org.eclipse.swt.browser.LocationEvent;
import org.eclipse.swt.browser.ProgressAdapter;
import org.eclipse.swt.browser.ProgressEvent;
import org.eclipse.swt.custom.ScrolledComposite;
import org.eclipse.swt.events.ControlEvent;
import org.eclipse.swt.events.ControlListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.List;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.allennb.common.AccountUtils;
import com.allennb.common.FileUtils;
import com.allennb.common.RandomUtil;

public class PublishForm {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	protected Shell shell;
	private List list;
	private List typeList;
	private Browser browser;
	private ScrolledComposite scrolledComposite;
	
	private String publishTitle;
	private String publishContent;
	
	private String currentAccountName;
	private String currentUrl;

//	/**
//	 * Launch the application.
//	 * @param args
//	 */
//	public static void main(String[] args) {
//		try {
//			PublishForm window = new PublishForm();
//			window.open();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	public PublishForm(String publishTitle, String publishContent) {
		this.publishTitle = publishTitle;
		this.publishContent = publishContent;
	}
	/**
	 * Open the window.
	 */
	public void open() {
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
		shell.setSize(800, 650);
		shell.setText("SWT Application");
		
		shell.addControlListener(new ControlListener() {
			   public void controlMoved(ControlEvent e) {
//			    System.out.println("窗口位置移动了");
//			    shell.setLocation(100, 200);
			   }
			   public void controlResized(ControlEvent e) {
//			    logger.debug("shell width:" + shell.getSize().x);
//			    logger.debug("shell height:" + shell.getSize().y);
			    browser.setSize(shell.getSize().x -224, shell.getSize().y - 54);
			    scrolledComposite.setSize(168, shell.getSize().y - 156);
			   }
			  });
		
		scrolledComposite = new ScrolledComposite(shell, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL);
		scrolledComposite.setBounds(10, 112, 168, 444);
		scrolledComposite.setExpandHorizontal(true);
		scrolledComposite.setExpandVertical(true);
		
		list = new List(scrolledComposite, SWT.BORDER);
		list.setItems(AccountUtils.getAccountNames());
		scrolledComposite.setContent(list);
		scrolledComposite.setMinSize(list.computeSize(SWT.DEFAULT, SWT.DEFAULT));
		
		
		
		list.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {	
				String[] selectedItem = typeList.getSelection();
				publishTitle = "";
				publishContent = "";
				if(selectedItem == null || selectedItem.length == 0) {
					MessageBox dialog=new MessageBox(new Shell(),SWT.OK|SWT.ICON_INFORMATION); 
					dialog.setText("提示"); 
					dialog.setMessage("请选择分类"); 
					dialog.open();
				} else {
					loadMessage(selectedItem);
					currentAccountName = list.getSelection()[0];
					currentUrl = "";
					publish();
				}
				
			}
		});
		
		
		String levelType2 = FileUtils.getProp("type.level.2");
		ScrolledComposite typeScrolledComposite = new ScrolledComposite(shell, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL);
		typeScrolledComposite.setBounds(10, 10, 168, 85);
		typeScrolledComposite.setExpandHorizontal(true);
		typeScrolledComposite.setExpandVertical(true);
		
		typeList = new List(typeScrolledComposite, SWT.BORDER | SWT.MULTI);
		
		typeList.setItems(StringUtils.split(levelType2, ","));
		typeScrolledComposite.setContent(typeList);
		typeScrolledComposite.setMinSize(typeList.computeSize(SWT.DEFAULT, SWT.DEFAULT));
	
		browser = new Browser(shell, SWT.BORDER);
		browser.setBounds(197, 10, 576, 546);
		
		browser.addProgressListener(new ProgressAdapter(){
            public void completed(ProgressEvent event){
                loadParam();
            }
        });
		browser.addLocationListener(new LocationAdapter(){
			public void changed(LocationEvent locationevent) {
				logger.debug("----------------------------------");
			}
		});
		

	}

	
	private void publish() {		
		String loginUrl = AccountUtils.getAccountLoginUrlMap(currentAccountName);
		currentUrl = loginUrl;
		browser.setUrl(loginUrl);
	}
	
	/**
	 * 加载参数
	 */
	private void loadParam() {
		logger.debug("browser url:" + browser.getUrl());
		if(browser.getUrl().startsWith(AccountUtils.getAccountLoginUrlMap(currentAccountName))){
			logger.debug("Browser's address:login url." );
			java.util.List<String> loginParamList = AccountUtils.getAccountLoginParamMap(currentAccountName);
			for(String loginParam:loginParamList) {
				if("".equals(loginParam) || loginParam.split(":").length < 2) {
					continue;
				}
				String key = loginParam.split(":")[0];
				String value = loginParam.split(":")[1];
				browser.execute("document.getElementById('"+key+"').value='"+value+"';");
				logger.debug("Load parameters: key=" + key + "value=" + value );
			}
		} else if(browser.getUrl().startsWith(AccountUtils.getAccountPublishUrlMap(currentAccountName))){
			logger.debug("Browser's address:publish url." );
			java.util.List<String> publishParamList = AccountUtils.getAccountPublishParamMap(currentAccountName);
			for(String publishParam:publishParamList) {
				if("".equals(publishParam) || publishParam.split(":").length < 2) {
					continue;
				}
				String key = publishParam.split(":")[0];
				String value = publishParam.split(":")[1];
				if(value.equals("$title$")) {
					value = publishTitle;
				} else if(value.equals("$content$")){
					value = publishContent.replaceAll("\\r\\n", "\\\\r\\\\n");
				} else if(value.equals("$content1$")){
					value = publishContent.replaceAll("\\r\\n", "<br/>");
					value = value.replaceAll("\\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
				}
				
				browser.execute("document.getElementById('"+key+"').value='"+value+"';");
				logger.debug("Load parameters: key=" + key + "value=" + value );
			}
		} else {
			logger.debug("Browser's address:unknown." );
			String publishUrl = AccountUtils.getAccountPublishUrlMap(currentAccountName);
			browser.setUrl(publishUrl);
		}
		
		
		
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
