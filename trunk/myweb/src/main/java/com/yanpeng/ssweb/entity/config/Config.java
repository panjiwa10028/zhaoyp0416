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

	private String newsPicPath;//新闻图片路径

	private String newsHtmlPath;//新闻静态页路径
	
	private String prodcutPicPath;//产品图片路径
	private String productHtmlPath;//产品静态页路径
	
	private String newsHtmlTemplate;//新闻静态页模板名
	
	private String productHtmlTemplate;//产品静态页模板名
	
	private String backupPath;//数据库备份目录
	
	private String webRootPath;//工程根目录
	
	private int autoBackup;//是否自动备份。1：自动，0：手动

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

	public String getProdcutPicPath() {
		return prodcutPicPath;
	}

	public void setProdcutPicPath(String prodcutPicPath) {
		this.prodcutPicPath = prodcutPicPath;
	}

	public String getProductHtmlPath() {
		return productHtmlPath;
	}

	public void setProductHtmlPath(String productHtmlPath) {
		this.productHtmlPath = productHtmlPath;
	}

	public String getNewsHtmlTemplate() {
		return newsHtmlTemplate;
	}

	public void setNewsHtmlTemplate(String newsHtmlTemplate) {
		this.newsHtmlTemplate = newsHtmlTemplate;
	}

	public String getProductHtmlTemplate() {
		return productHtmlTemplate;
	}

	public void setProductHtmlTemplate(String productHtmlTemplate) {
		this.productHtmlTemplate = productHtmlTemplate;
	}

	public String getBackupPath() {
		return backupPath;
	}

	public void setBackupPath(String backupPath) {
		this.backupPath = backupPath;
	}

	public String getWebRootPath() {
		return webRootPath;
	}

	public void setWebRootPath(String webRootPath) {
		this.webRootPath = webRootPath;
	}

	public int getAutoBackup() {
		return autoBackup;
	}

	public void setAutoBackup(int autoBackup) {
		this.autoBackup = autoBackup;
	}
	
	

}
