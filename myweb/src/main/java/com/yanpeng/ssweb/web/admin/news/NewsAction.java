package com.yanpeng.ssweb.web.admin.news;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.dao.hibernate.Page;
import com.yanpeng.core.web.struts2.CRUDSupportAction;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.service.news.NewsManager;
import com.yanpeng.ssweb.util.CommUtil;
import com.yanpeng.ssweb.util.HtmlGenerator;

@SuppressWarnings({ "finally", "serial","deprecation" })
@ParentPackage("fileUpload")
@Results( { @Result(name = CRUDSupportAction.RELOAD, location = "news.action?page.pageParam=${page.pageParam}", type = "redirect") })
public class NewsAction extends CRUDSupportAction<News> {

	@Autowired
	private NewsManager newsManager;
	private Page page = new Page(5,true,"desc","id");;
	private News news;
	private File upload;   
    private String uploadFileName;
    private List<News> allNews;
    private String search_text;

    public String search()throws Exception{
    	try{
    		if(search_text!=null&&!search_text.trim().equals("")){
    			allNews=newsManager.getText(search_text);
        	}
    	}catch (Exception e) {
    		addActionError("没有搜索到结果!");
    	}finally{
    		return "search";
    	}
    		
    }
    
	@Override
	public String list() throws Exception {
		page = newsManager.getAllNews(page);
		return SUCCESS;
	}
	
	public String input() throws Exception {		
		return INPUT;
	}
	
	
	@Override
	public String delete() throws Exception {
		try{
			if(news != null && news.getId() != null) {
				news=newsManager.getNewsById(news.getId());
				String fileName=getRequest().getRealPath("")+ "\\upload\\" + news.getPicture();
				FileUtil.deleteContents(new File(fileName));
				newsManager.removeNews(news);
				addActionMessage("删除成功!");
			}
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("删除失败!");
		}finally{
			return RELOAD;
		}
	}

	@Override
	public String save() throws Exception {
		try{
			String path = getRequest().getRealPath("");
			if(upload != null) {
				String newFileName=RandomStringUtils.randomAlphabetic(9).toLowerCase()+uploadFileName;
				String newPath=path + "\\upload\\" + newFileName;
				copy(upload,newPath);
				
				String fileName=path + "\\upload\\" + news.getPicture();
				FileUtil.deleteContents(new File(fileName));
				
				news.setPicture(newFileName);
			}
			
			newsManager.saveOrUpdateNews(news);
			HtmlGenerator htmlGenerator = new HtmlGenerator();
			htmlGenerator.setEncode("utf-8");
			htmlGenerator.setTemplateDir("/htmlskin/");
			htmlGenerator.setTemplateFile("view.ftl");
			htmlGenerator.setPreviewHtmlFileDir("preview");
			htmlGenerator.setRootDir(path);
			Map map = new HashMap();
			map.put("news", news);
//			CommUtil.ObjToMap(news, map);
			String returnValue = htmlGenerator.preview(map, "1111.html");
			if(returnValue == null) {
				addActionError("保存失败!");
				return INPUT;
			}
			addActionMessage("保存成功!");
			return RELOAD;
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("保存失败!");
			return INPUT;
		}finally{
//			return RELOAD;
		}
	}
	
	/**
	 * 拷贝文件
	 * @param upload文件流
	 * @param newPath新文件路径和名称
	 * @throws Exception
	 */
	private void copy(File upload,String newPath)throws Exception {
		FileOutputStream fos = new FileOutputStream(newPath);   
        FileInputStream fis = new FileInputStream(upload);   
        byte[] buffer = new byte[1024];   
        int len = 0;   
        while ((len = fis.read(buffer)) > 0){   
            fos.write(buffer , 0 , len);   
        }
        fos.close();
        fis.close();
	}

	// ==================================================


	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}


	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	

	public NewsManager getNewsManager() {
		return newsManager;
	}

	public void setNewsManager(NewsManager newsManager) {
		this.newsManager = newsManager;
	}

	public News getNews() {
		return news;
	}

	public void setNews(News news) {
		this.news = news;
	}

	public List<News> getAllNews() {
		return allNews;
	}

	public void setAllNews(List<News> allNews) {
		this.allNews = allNews;
	}

	public String getSearch_text() {
		return search_text;
	}

	public void setSearch_text(String search_text) {
		this.search_text = search_text;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if(news != null && news.getId() != null) {
			news=newsManager.getNewsById(news.getId());
		}else {
			news = new News();
		}
	}

	@Override
	public News getModel() {
		// TODO Auto-generated method stub
		return news;
	}

}
