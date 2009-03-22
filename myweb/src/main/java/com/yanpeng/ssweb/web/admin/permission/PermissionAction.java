package com.yanpeng.ssweb.web.admin.permission;

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
@Results( { @Result(name = BaseAction.RELOAD, location = "permission.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class PermissionAction extends BaseAction<Permissions> {

	// CRUD Action 基本属性

	private Page<Permissions> page = new Page<Permissions>(5);//每页5条记录

	private Permissions entity;

	private String id;

		
	@Autowired
	private PermissionManager permissionManager;


	// CRUD Action 属性访问函数

	public Permissions getModel() {
		return entity;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null && !id.equals("")) {
			entity = permissionManager.getPermissionById(id);
		} else {
			entity = new Permissions();
		}
	}

	

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {		
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
			permissionManager.savePermission(entity);
			addActionMessage("保存权限成功");
			return RELOAD;
		}catch(Exception e) {
			e.printStackTrace();
			addActionMessage("保存权限失败");
			return INPUT;
		}
		
	}

	@Override
	public String delete() throws Exception {
		try {
			String []ids = id.split(",");
			List<String> list = Arrays.asList(ids);   
	
			permissionManager.deletePermissions(list);
			addActionMessage("删除权限成功");
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
		
		if (permissionManager.isNameUnique(name, orgName)) {
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

	public Page<Permissions> getPage() {
		return page;
	}

	
}
