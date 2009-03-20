package com.yanpeng.ssweb.web.admin.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.service.role.RoleManager;
import com.yanpeng.ssweb.service.user.UserManager;
import com.yanpeng.ssweb.web.BaseAction;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author calvin
 */
@SuppressWarnings("serial")
@Results( { @Result(name = BaseAction.RELOAD, location = "user.action?page.pageParam=${page.pageParam}", type = "redirect") })
public class UserAction extends BaseAction<Users> {

	// CRUD Action 基本属性

	private Page<Users> page = new Page<Users>(5);//每页5条记录

	private Users entity;

	private String id;

	@Autowired
	private UserManager userManager;
	
	@Autowired
	private RoleManager roleManager;
	
	@Autowired
	private GroupManager groupManager;

	// 用户-角色 相关属性

	private List<Roles> allRoles; //全部可选角色列表

	private List checkedRoleIds; //页面中钩选的角色id列表
	
	private List<Groups> allGroups;
	
	private List selectIds;

	


	// CRUD Action 属性访问函数

	public Users getModel() {
		return entity;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null && !id.equals("")) {
			entity = userManager.getUser(id);
		} else {
			entity = new Users();
		}
	}

	

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		page = userManager.getAllUsers(page);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		allRoles = roleManager.getAllRoles();
		checkedRoleIds = entity.getRoleIds();
		allGroups = groupManager.getAllGroup();
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
//		
		if(entity != null && entity.getId().equals("")) {
			entity.setId(null);
		}
		Groups group = groupManager.getGroupById("0");
		entity.setGroups(group);
		userManager.saveUser(entity,checkedRoleIds);
		addActionMessage("保存用户成功");
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		try {
			String []ids = id.split(",");
			List list = Arrays.asList(ids);   
	
			userManager.deleteUsers(list);
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
	public String checkLoginName() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String loginName = request.getParameter("loginName");
		String orgLoginName = request.getParameter("orgLoginName");
		
		if (userManager.isLoginNameUnique(loginName, orgLoginName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}	

	
	public void setId(String id) {
		this.id = id;
	}

	public Page<Users> getPage() {
		return page;
	}
	
	public List<Roles> getAllRoles() {
		return allRoles;
	}

	public List<Groups> getAllGroups() {
		return allGroups;
	}

	public List<Serializable> getCheckedRoleIds() {
		return checkedRoleIds;
	}

	public void setCheckedRoleIds(List<Serializable> checkedRoleIds) {
		this.checkedRoleIds = checkedRoleIds;
	}

	public List getSelectIds() {
		return selectIds;
	}

	public void setSelectIds(List selectIds) {
		this.selectIds = selectIds;
	}
	
	
}
