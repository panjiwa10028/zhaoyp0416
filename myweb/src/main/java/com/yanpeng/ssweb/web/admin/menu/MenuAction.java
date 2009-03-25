package com.yanpeng.ssweb.web.admin.menu;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.exceptions.ServiceException;
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
@Results( { @Result(name = CURDBaseAction.RELOAD, location = "menu.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class MenuAction extends CURDBaseAction<Menus> {

	// CRUD Action 基本属性
	
	private List<Menus> allMenus;
	
	private String menuId;

	
	@Autowired
	private MenuManager menuManager;
	
	
	

	// CRUD Action 属性访问函数

	@Override
	protected void prepareModel() throws Exception {
		if (id != null && !id.equals("")) {
			entity = menuManager.getMenuById(id);
			menuId = entity.getParentId();
		} else {
			entity = new Menus();
		}
	}

	

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		page = menuManager.getAllMenus(page);		
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {		
		allMenus = menuManager.findFirstLevelMenus();
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
//		
		if(entity != null && entity.getId().equals("")) {
			entity.setId(null);
		}
		
		try{
			menuManager.saveMenu(entity);
			addActionMessage("保存角色成功");
			return RELOAD;
		}catch(Exception e) {
			e.printStackTrace();
			addActionMessage("保存角色失败");
			return INPUT;
		}
		
	}

	@Override
	public String delete() throws Exception {
		try {
			String []ids = id.split(",");
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
		HttpServletRequest request = ServletActionContext.getRequest();
		String name = request.getParameter("name");
		String orgName = request.getParameter("orgName");
		
		if (menuManager.isNameUnique(name, orgName)) {
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

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setAllMenus(List<Menus> allMenus) {
		this.allMenus = allMenus;
	}

		
	
}
