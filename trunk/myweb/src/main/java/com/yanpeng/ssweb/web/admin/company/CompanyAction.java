package com.yanpeng.ssweb.web.admin.company;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.HibernateWebUtils;
import com.yanpeng.core.utils.DateUtils;
import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Company;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.company.CompanyManager;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.util.HtmlGenerator;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 用户组管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "group.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class CompanyAction extends CURDBaseAction<Company> {

	// CRUD Action 基本属性

	@Autowired
	private CompanyManager companyManager;
	// CRUD Action 属性访问函数

	@Override
	protected void prepareModel() throws Exception {
		if (id != null ) {
			entity = companyManager.getCompanyById(id);
		} else {
			entity = new Company();
		}
	}

	// CRUD Action 函数


	@Override
	public String input() throws Exception {
		return INPUT;
	}

	@Override
	@Token
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set

		try {
			generatorHtml();
			companyManager.saveCompany(entity);
			addActionMessage("保存信息成功");
			return INPUT;
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("保存信息失败");
			return INPUT;
		}

	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	private String generatorHtml() throws Exception{
		HtmlGenerator htmlGenerator = new HtmlGenerator();
		//			取服务器路径
		String path = Struts2Utils.getRequest().getRealPath("");
		//			生成随机的字符串
		
	
		htmlGenerator.setEncode("utf-8");
		htmlGenerator.setTemplateDir("/htmlskin/");
		htmlGenerator.setTemplateFile("company-info.ftl");
		htmlGenerator.setRootDir(path);


		htmlGenerator.setPreviewHtmlFileDir("");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("company", entity);
		String returnValue = htmlGenerator.preview(map, "company-info.shtml");
		
		htmlGenerator.setTemplateFile("company-service.ftl");
		returnValue = htmlGenerator.preview(map, "company-service.shtml");
		
		htmlGenerator.setTemplateFile("company-training.ftl");
		returnValue = htmlGenerator.preview(map, "company-training.shtml");
		
		htmlGenerator.setTemplateFile("company-job.ftl");
		returnValue = htmlGenerator.preview(map, "company-job.shtml");
		htmlGenerator.setTemplateFile("company-contact.ftl");
		returnValue = htmlGenerator.preview(map, "company-contact.shtml");
		if (returnValue == null) {
			return "error";
		}
		
		return null;
	}

	// 其他属性访问函数及Action函数


}
