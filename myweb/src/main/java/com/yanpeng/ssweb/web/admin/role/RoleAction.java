package com.yanpeng.ssweb.web.admin.role;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.permission.PermissionManager;
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
@Results( { @Result(name = BaseAction.RELOAD, location = "role.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class RoleAction extends BaseAction<Roles> {

	// CRUD Action 基本属性

	private Page<Roles> page = new Page<Roles>(5);//每页5条记录

	private Roles entity;

	private String id;

	
	@Autowired
	private RoleManager roleManager;
	
	@Autowired
	private PermissionManager permissionManager;

	// 用户-角色 相关属性

	private List<Permissions> allPermissions; //全部可选角色列表

	private List<Serializable> checkedIds; //页面中钩选的角色id列表
	
	

	// CRUD Action 属性访问函数

	public Roles getModel() {
		return entity;
	}

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
			roleManager.saveRole(entity,checkedIds);
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
			List list = Arrays.asList(ids);   
	
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

	
	public void setId(String id) {
		this.id = id;
	}

	public Page<Roles> getPage() {
		return page;
	}

	public List<Permissions> getAllPermissions() {
		return allPermissions;
	}

	public void setAllPermissions(List<Permissions> allPermissions) {
		this.allPermissions = allPermissions;
	}

	public List getCheckedIds() {
		return checkedIds;
	}

	public void setCheckedIds(List checkedIds) {
		this.checkedIds = checkedIds;
	}
	
	
	
}
