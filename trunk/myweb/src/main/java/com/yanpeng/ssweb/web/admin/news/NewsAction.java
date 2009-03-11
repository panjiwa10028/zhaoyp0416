package com.yanpeng.ssweb.web.admin.news;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.dispatcher.ServletActionRedirectResult;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.dao.hibernate.Page;
import com.yanpeng.core.web.struts2.CRUDSupportAction;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.service.news.NewsManager;

@SuppressWarnings({ "finally", "serial","deprecation" })
@ParentPackage("fileUpload")
@Results( { @Result(name = CRUDSupportAction.RELOAD, location = "news.action?page.pageParam=${page.pageParam}", type = "redirect") })
public class NewsAction extends CRUDSupportAction {

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
		if(news!=null&&news.getId()!=null){
			news=newsManager.getNewsById(news.getId());
		}
		return INPUT;
	}
	
	
	@Override
	public String delete() throws Exception {
		try{
			if(news!=null&&news.getId()!=null){
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
			String newFileName=RandomStringUtils.randomAlphabetic(9).toLowerCase()+uploadFileName;
			String newPath=getRequest().getRealPath("") + "\\upload\\" + newFileName;
			copy(upload,newPath);
			news.setPicture(newFileName);
			newsManager.saveOrUpdateNews(news);
			addActionMessage("保存成功!");
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("保存失败!");
		}finally{
			return RELOAD;
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
		
	}

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

}
