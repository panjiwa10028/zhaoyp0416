package com.yanpeng.ssweb.service.backup;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import com.yanpeng.core.web.struts2.Struts2Utils;

/**
 *
 * @author Allen
 * 
 */
public class BackupManager {

	private String databaseUserName;
	private String databasePassword;
	private String databaseName;
	
	public int backup(String backupPath, String backupName) throws Exception {
		int exitVal = -1;
		try {
			Runtime rt = Runtime.getRuntime();
			
		    Process proc;
			proc = rt.exec("cmd /c mysqldump -l -u"+databaseUserName+" -p" + databasePassword + " --opt "+databaseName+" > " + backupPath + "/" + backupName);
			InputStreamReader isr = new InputStreamReader(proc.getErrorStream()); 
			BufferedReader br = new BufferedReader(isr); 
			String line=null; 
			while ( (line = br.readLine()) != null) 
			System.out.println( ">" + line); 



			// any error??? 
			exitVal = proc.waitFor(); 
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return exitVal;
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
	public void setDatabaseUserName(String databaseUserName) {
		this.databaseUserName = databaseUserName;
	}
	public void setDatabasePassword(String databasePassword) {
		this.databasePassword = databasePassword;
	}
	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	}
	
	
}
