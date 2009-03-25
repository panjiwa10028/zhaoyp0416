package com.yanpeng.ssweb.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.service.permission.PermissionManager;
import com.yanpeng.ssweb.service.security.resource.SecurityResourceCache;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 * 系统初始化操作，读取所有permission权限放入cache
 * 
 * @author Allen
 */
@SuppressWarnings("unused")
public class InitSystemData {


	@Autowired
	private PermissionManager permissionManager;
	
	private boolean isRun;

	public void init() throws Exception {
		if (!isRun) {
			initCache();
		}else{
			//每次启动内存库为true
		}
	}
	
	public void initCache(){
		List<Permissions> pers=permissionManager.getAllPermissions();
		for(Permissions r:pers){
			SecurityResourceCache.putCache(r);
		}
	}


	public boolean isRun() {
		return isRun;
	}

	public void setRun(boolean isRun) {
		this.isRun = isRun;
	}

}
