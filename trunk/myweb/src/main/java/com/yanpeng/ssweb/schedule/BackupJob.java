package com.yanpeng.ssweb.schedule;

import java.util.Date;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.ServletContextAware;

import com.yanpeng.core.utils.DateUtils;
import com.yanpeng.ssweb.commons.Constants;
import com.yanpeng.ssweb.entity.config.Config;
import com.yanpeng.ssweb.service.config.ConfigLoader;
import com.yanpeng.ssweb.service.system.SystemManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 *
 * @author Allen
 * 
 */
public class BackupJob implements ServletContextAware {
	
	private static Logger logger = LoggerFactory.getLogger(BackupJob.class);

	private ServletContext servletContext;

	public void setServletContext(ServletContext sc) {
		this.servletContext=sc;
		System.out.println("项目的绝对路径为："+servletContext.getRealPath("/"));
	}

	@Autowired
	private SystemManager systemManager;
	
	public void executeBackup() {
		

		Config config = (Config) servletContext.getAttribute(Constants.WEB_CONFIG);
		logger.debug("目前是" + (String.valueOf(config.getAutoBackup()).equals("1")?"自动":"手动") +"备份");
		if("".equals(config.getBackupPath())) {
			logger.debug("备份失败。原因：备份路径为空。");
			return;
		}
		if(config.getAutoBackup() != 1) {
			return;
		}
		Date date = new Date();
		String dateString = DateUtils.convertDateToString(date, "yyyy-MM-dd");
		try {
			systemManager.backup(config.getBackupPath(), dateString + ".sql");
			logger.debug(dateString + "备份成功。");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error(dateString + "备份失败。原因：" + e.getMessage());
		}
	}

}
