package com.yanpeng.ssweb.web.admin.news;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.utils.DateUtils;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.news.NewsManager;
import com.yanpeng.ssweb.util.HtmlGenerator;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 新闻管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CURDBaseAction.RELOAD, location = "news.action?page.pageParam=${page.pageParam}", type = "redirect") })
public class NewsAction extends CURDBaseAction<News> {

	@Autowired
	private NewsManager newsManager;
	
	private Page<News> page = new Page<News>(5);
	private News entity;
	private String id;
	
	private File upload;   
    private String uploadFileName;
    

    
	@Override
	public String list() throws Exception {
		page = newsManager.getAllNews(page);
		return SUCCESS;
	}
	
	@Override
	public String input() throws Exception {		
		return INPUT;
	}
	
	
	@Override
	public String delete() throws Exception {
		try{

				entity =newsManager.getNewsById(id);
				String fileName=Struts2Utils.getRequest().getRealPath("")+ "\\upload\\" + entity.getPicture();
				FileUtil.deleteContents(new File(fileName));
				newsManager.deleteNews(entity);
				addActionMessage("删除成功!");
			
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("删除失败!");
		}
		return RELOAD;
	}

	@Override
	@Token
	public String save() throws Exception {
		try{
			if(entity != null && entity.getId().equals("")) {
				entity.setId(null);
			}
			
			entity.setUserId(getLoginUser().getId());
			HtmlGenerator htmlGenerator = new HtmlGenerator();
//			取服务器路径
			String path = Struts2Utils.getRequest().getRealPath("");
//			生成随机的字符串
			String rnadomString = RandomStringUtils.randomAlphabetic(9).toLowerCase();
			Date date = new Date();
//			取当前日期
			String dateString = DateUtils.convertDateToString(date,"yyyy-MM-dd");
			if(upload != null) {	
				String newFileName=rnadomString;
				if(uploadFileName.indexOf(".") != -1) {
					newFileName += uploadFileName.substring(uploadFileName.lastIndexOf("."));
				}
//				创建日期文件夹
				htmlGenerator.creatDirs(path, "\\upload\\news\\" + dateString);
//				上传文件的路径
				String newPath=path + "\\upload\\news\\" + dateString + "\\" + newFileName;
//				上传
				copy(upload,newPath);
//				删除旧的上传文件
				String fileName=path + "\\upload\\news\\" + dateString + "\\" + entity.getPicture();
				FileUtil.deleteContents(new File(fileName));
				
				entity.setPicture(newFileName);
			}
			
			newsManager.saveNews(entity);
			
			htmlGenerator.setEncode("utf-8");
			htmlGenerator.setTemplateDir("/htmlskin/");
			htmlGenerator.setTemplateFile("view.ftl");
			htmlGenerator.setPreviewHtmlFileDir("html\\news\\" + dateString);
			htmlGenerator.setRootDir(path);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("news", entity);
			String returnValue = htmlGenerator.preview(map, rnadomString + ".html");
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
	
	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (id != null && !id.equals("")) {
			entity = newsManager.getNewsById(id);
		} else {
			entity = new News();
		}
	}

	@Override
	public News getModel() {
		// TODO Auto-generated method stub
		return entity;
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


	public Page<News> getPage() {
		return page;
	}

	public void setId(String id) {
		this.id = id;
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

	
	

}
