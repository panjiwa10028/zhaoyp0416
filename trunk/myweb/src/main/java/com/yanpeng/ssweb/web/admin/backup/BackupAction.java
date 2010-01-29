package com.yanpeng.ssweb.web.admin.backup;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.HibernateWebUtils;
import com.yanpeng.core.utils.DateUtils;
import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.backup.BackupManager;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.web.BaseAction;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 用户组管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "group.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class BackupAction extends BaseAction {

	// CRUD Action 基本属性

	private String selectedIds;
	// CRUD Action 属性访问函数
	@Autowired
	private BackupManager backupManager;
	
	public String backup() throws Exception {
		
		try {
			Runtime rt = Runtime.getRuntime();
//			
//		    Process proc;
//			proc = rt.exec("cmd /c mysqldump -l -u"+dataSource.getUrl().getUsername()+" -p" + dataSource.getPassword() + " --opt test > ../../backup/b.sql");
//			InputStreamReader isr = new InputStreamReader(proc.getErrorStream()); 
//			BufferedReader br = new BufferedReader(isr); 
//			String line=null; 
//			while ( (line = br.readLine()) != null) 
//			System.out.println( ">" + line); 
			Date date = new Date();
			String dateString = DateUtils.convertDateToString(date, "yyyyMMddHHmmss");
			int returnValue = backupManager.backup(config.getBackupPath(), "back-" + dateString + ".sql");

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
		
		try {
			Runtime rt = Runtime.getRuntime();
			
		    Process proc;
			proc = rt.exec("cmd /c mysql -uroot -proot test < d:\bak.sql");
			InputStreamReader isr = new InputStreamReader(proc.getErrorStream()); 
			BufferedReader br = new BufferedReader(isr); 
			String line=null; 
			while ( (line = br.readLine()) != null) 
			System.out.println( ">" + line); 



			// any error??? 
			int exitVal = proc.waitFor(); 
			if(exitVal == 0) {
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
}
