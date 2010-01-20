package com.yanpeng.ssweb.web.admin.news;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
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
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.entity.NewsCategory;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.service.news.NewsManager;
import com.yanpeng.ssweb.service.newscategory.NewsCategoryManager;
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
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "news-category.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class NewsCategoryAction extends CURDBaseAction<NewsCategory> {

	// CRUD Action 基本属性

	@Autowired
	private NewsCategoryManager newsCategoryManager;
	private String selectedIds;
	// CRUD Action 属性访问函数

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = newsCategoryManager.getNewsCategoryById(id);
		} else {
			entity = new NewsCategory();
		}
	}

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		List<PropertyFilter> filters = HibernateWebUtils.buildPropertyFilters(Struts2Utils.getRequest(), new Groups());
		page = newsCategoryManager.search(page, filters);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		return INPUT;
	}

	@Override
	@Token
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
//		if (entity != null && entity.getId().equals("")) {
//			entity.setId(null);
//		}
		//		暂不支持多级组
		entity.setParentId(new Long(-1));
		try {
			newsCategoryManager.saveNewsCategory(entity);
			addActionMessage("保存新闻类别成功");
			return RELOAD;
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("保存新闻类别失败");
			return INPUT;
		}

	}

	@Override
	public String delete() throws Exception {
		try {
			String[] ids = selectedIds.split(",");
			List<String> list = Arrays.asList(ids);

			newsCategoryManager.deleteNewsCategorys(list);
			addActionMessage("删除新闻类别成功");
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(e.getMessage());
		}
		return RELOAD;
	}

	// 其他属性访问函数及Action函数

	/**
	 * 支持使用Jquery.validate Ajax检验用户名是否重复.
	 */
	public String checkName() throws Exception {
		String name = Struts2Utils.getRequest().getParameter("name");
		String orgName = Struts2Utils.getRequest().getParameter("orgName");

		if (newsCategoryManager.isNameUnique(name, orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}
	public String getSelectedIds() {
		return selectedIds;
	}

	public void setSelectedIds(String selectedIds) {
		this.selectedIds = selectedIds;
	}
}
