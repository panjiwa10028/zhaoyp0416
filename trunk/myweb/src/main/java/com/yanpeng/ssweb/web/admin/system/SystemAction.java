package com.yanpeng.ssweb.web.admin.system;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.utils.DateUtils;
import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.service.config.ConfigLoader;
import com.yanpeng.ssweb.service.system.SystemManager;
import com.yanpeng.ssweb.web.BaseAction;

/**
 * 用户组管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "group.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class SystemAction extends BaseAction {

	private final Logger logger = LoggerFactory.getLogger(SystemAction.class);
	// CRUD Action 基本属性

	@Autowired
	private SystemManager systemManager;
	
	private List fileList;
	@Override
	public String execute() throws Exception {
		fileList = new ArrayList();
		File backupPath = new File(config.getBackupPath());
		if(!backupPath.exists()){
			backupPath.mkdirs();
		}
		File []files = backupPath.listFiles();
		for(File file:files) {
			if(file.isFile()) {
				String fileName = file.getName();
				if(fileName.indexOf(".") != -1) {
					fileName = fileName.substring(0, fileName.lastIndexOf("."));
				}
				fileList.add(fileName);
			}
		}
		return SUCCESS;
	}
	
	public String save() throws Exception {
		int autoBackup = 1;
		String webRootPath = "";
		String backupPath = "";
		try {
			autoBackup = Integer.parseInt(Struts2Utils.getRequest().getParameter("autoBackup"));
		} catch(Exception exx) {}
		
		try {
			webRootPath = Struts2Utils.getRequest().getParameter("webRootPath");
			backupPath = Struts2Utils.getRequest().getParameter("backupPath");
			config.setWebRootPath(webRootPath);
			config.setAutoBackup(autoBackup);
			config.setBackupPath(backupPath);
			// 读取全局配置文件
				ConfigLoader loader = new ConfigLoader(config.getAppPath());
				loader.saveConfig(config);
				logger.debug("系统设置成功。");
				Struts2Utils.renderText("系统设置成功。");
		

		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("系统设置失败。/n" + e.getMessage());
			Struts2Utils.renderText("系统设置失败。");
		}


		return null;
	}
	
	public String backup() throws Exception {
		
		try {	
			Date date = new Date();
			String dateString = DateUtils.convertDateToString(date, "yyyy-MM-dd");
			int returnValue = systemManager.backup(config.getBackupPath(), dateString + ".sql");

			if(returnValue == 0) {
				Struts2Utils.renderText("备份成功。");
			} else {
				Struts2Utils.renderText("备份失败。");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return null;
	}
	
	public String recover() throws Exception {
		String recoverDate;
		try {
			recoverDate = Struts2Utils.getRequest().getParameter("recoverDate");
			if(recoverDate == null || "".equals(recoverDate)) {
				Struts2Utils.renderText("恢复失败");
				return null;
			}
			int returnValue = systemManager.recover(config.getBackupPath(), recoverDate + ".sql");
		
		  

			if(returnValue == 0) {
				Struts2Utils.renderText("恢复成功");
			} else {
				Struts2Utils.renderText("恢复失败");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return null;
	}

	public void setFileList(List fileList) {
		this.fileList = fileList;
	}

	public List getFileList() {
		return fileList;
	}
	
	
}
