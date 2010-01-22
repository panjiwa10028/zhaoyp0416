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
	
	private String prodcutPicPath;
	private String productHtmlPath;
	
	private String newsHtmlTemplate;
	
	private String productHtmlTemplate;

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
	

}
