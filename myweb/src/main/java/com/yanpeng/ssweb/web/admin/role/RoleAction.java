package com.yanpeng.ssweb.web.admin.role;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.menu.MenuManager;
import com.yanpeng.ssweb.service.permission.PermissionManager;
import com.yanpeng.ssweb.service.role.RoleManager;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 角色管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CURDBaseAction.RELOAD, location = "role.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class RoleAction extends CURDBaseAction<Roles> {

	// CRUD Action 基本属性

	@Autowired
	private RoleManager roleManager;
	
	@Autowired
	private PermissionManager permissionManager;
	
	@Autowired
	private MenuManager menuManager;

	// 用户-角色 相关属性

	private List<Permissions> allPermissions; //全部可选角色列表

	private List<String> checkedIds; //页面中钩选的角色id列表
	
	private List<Menus> allMenus;
	private List<String> checkedMenuIds;
	
	

	// CRUD Action 属性访问函数

	@Override
	protected void prepareModel() throws Exception {
		if (id != null && !id.equals("")) {
			entity = roleManager.getRoleById(id);
		} else {
			entity = new Roles();
		}
	}

	

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		page = roleManager.getAllRoles(page);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		allPermissions = permissionManager.getAllPermissions();
		checkedIds = entity.getPermissionIds();
		allMenus = menuManager.findSubMenus();
		checkedMenuIds = entity.getMenuIds();
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		
//		
		if(entity != null && entity.getId().equals("")) {
			entity.setId(null);
		}
		
		try{
			roleManager.saveRole(entity,checkedIds,checkedMenuIds);
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
	
			roleManager.deleteRoles(list);
			addActionMessage("删除用户成功");
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
	public String checkRoleName() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String name = request.getParameter("name");
		String orgName = request.getParameter("orgName");
		
		if (roleManager.isNameUnique(name, orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}	

	public List<Permissions> getAllPermissions() {
		return allPermissions;
	}

	public void setAllPermissions(List<Permissions> allPermissions) {
		this.allPermissions = allPermissions;
	}

	public List<Menus> getAllMenus() {
		return allMenus;
	}

	public void setCheckedIds(List<String> checkedIds) {
		this.checkedIds = checkedIds;
	}

	public void setCheckedMenuIds(List<String> checkedMenuIds) {
		this.checkedMenuIds = checkedMenuIds;
	}

	public List<String> getCheckedIds() {
		return checkedIds;
	}

	public List<String> getCheckedMenuIds() {
		return checkedMenuIds;
	}

	
	
}
