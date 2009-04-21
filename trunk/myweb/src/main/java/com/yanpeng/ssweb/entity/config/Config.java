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
	
	private String newsPicPath;
	
	private String newsHtmlPath;

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

	public String getNewsPicPath() {
		return newsPicPath;
	}

	public void setNewsPicPath(String newsPicPath) {
		this.newsPicPath = newsPicPath;
	}

	public String getNewsHtmlPath() {
		return newsHtmlPath;
	}

	public void setNewsHtmlPath(String newsHtmlPath) {
		this.newsHtmlPath = newsHtmlPath;
	}

}
