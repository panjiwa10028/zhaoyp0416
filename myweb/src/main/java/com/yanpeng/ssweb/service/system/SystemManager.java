package com.yanpeng.ssweb.service.system;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import com.yanpeng.core.web.struts2.Struts2Utils;
import java.net.URL;   
import java.net.URLClassLoader; 

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method; 
/**
 *
 * @author Allen
 * 
 */
public class SystemManager {

	private String databaseUserName;
	private String databasePassword;
	private String databaseName;
	

	public int backup(String backupPath, String backupName) throws Exception {
		int exitVal = -1;
		try {
			Runtime rt = Runtime.getRuntime();

		    Process proc;
		    String cmdarray = new String();
		    cmdarray = "cmd /c mysqldump -l -u"+databaseUserName+" -p" + databasePassword + " --opt "+databaseName+" > " + backupPath + "/"+ backupName;
		   
		    File path = new File(backupPath);
		    if(!path.exists()) {
		    	path.mkdirs();
		    }
			proc = rt.exec(cmdarray);
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
	
	public int recover(String backupPath, String backupName) throws Exception {
		int exitVal = -1;
		try {
			Runtime rt = Runtime.getRuntime();
			
		    Process proc;
			proc = rt.exec("cmd /c mysql -u"+databaseUserName+" -p" + databasePassword + " "+databaseName+" < " + backupPath + "/" + backupName);
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
