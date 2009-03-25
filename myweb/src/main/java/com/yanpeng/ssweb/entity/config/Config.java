package com.yanpeng.ssweb.entity.config;

/**
 * 配置文件Bean
 * 
 * @author Allen
 *
 */
public class Config {
	
	private String appPath;
	
	private int pageSize;//每页显示数量

	
	public String getAppPath() {
		return appPath;
	}

	public void setAppPath(String appPath) {
		this.appPath = appPath;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	

}
