package com.yanpeng.ssweb.web.admin.menu;

import java.util.Arrays;
import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.HibernateWebUtils;
import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.menu.MenuManager;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 菜单管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( {
		@Result(name = CRUDActionSupport.RELOAD, location = "menu.action?page.pageRequest=${page.pageRequest}", type = "redirect"),
		@Result(name = "errorss", location = "/error.jsp", type = "redirect") })
public class MenuAction extends CURDBaseAction<Menus> {

	// CRUD Action 基本属性

	private List<Menus> allMenus;

	private Long menuId;

	@Autowired
	private MenuManager menuManager;
	
	private String selectedIds;

	// CRUD Action 属性访问函数

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = menuManager.getMenuById(id);
			menuId = entity.getParentId();
		} else {
			entity = new Menus();
		}
	}

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		List<PropertyFilter> filters = HibernateWebUtils.buildPropertyFilters(Struts2Utils.getRequest(), new Menus());
		if (page.getOrderBy() == null || page.getOrderBy().equals("")) {
			page.setOrderBy("updateTime,id,sort");
			page.setOrder("desc,asc,asc");
		}
		page = menuManager.search(page, filters);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		allMenus = menuManager.findFirstLevelMenusNotId(id);
		return INPUT;
	}

	@Override
	@Token
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set

//		if (entity != null && entity.getId().equals("")) {
//			entity.setId(null);
//		}

		String isDisabled = Struts2Utils.getRequest().getParameter("isDisabled");
		if (isDisabled == null || isDisabled.equals("")) {
			entity.setIsDisabled(0);
		}
		try {
			entity.setName(entity.getName().toUpperCase());
			menuManager.saveMenu(entity);
			addActionMessage("保存角色成功");
			return RELOAD;
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("保存角色失败");
			return INPUT;
		}

	}

	@Override
	public String delete() throws Exception {
		try {
			String[] ids = selectedIds.split(",");
			List<String> list = Arrays.asList(ids);

			menuManager.deleteMenus(list);
			addActionMessage("删除菜单成功");
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

		if (menuManager.isNameUnique(name.toUpperCase(), orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}

	public String checkDisplayName() throws Exception {
		String name = Struts2Utils.getRequest().getParameter("displayName");
		String orgName = Struts2Utils.getRequest().getParameter("orgName");

		if (menuManager.isDisplayNameUnique(name, orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}

	public List<Menus> getAllMenus() {
		return allMenus;
	}

	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}

	public Long getMenuId() {
		return menuId;
	}

	public void setAllMenus(List<Menus> allMenus) {
		this.allMenus = allMenus;
	}
	public String getSelectedIds() {
		return selectedIds;
	}

	public void setSelectedIds(String selectedIds) {
		this.selectedIds = selectedIds;
	}
}
