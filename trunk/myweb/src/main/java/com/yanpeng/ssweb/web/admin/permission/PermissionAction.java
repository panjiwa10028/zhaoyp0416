package com.yanpeng.ssweb.web.admin.permission;

import java.util.Arrays;
import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.permission.PermissionManager;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 权限管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "permission.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class PermissionAction extends CURDBaseAction<Permissions> {

	// CRUD Action 基本属性

	@Autowired
	private PermissionManager permissionManager;

	// CRUD Action 属性访问函数

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
		if (page.getOrderBy() == null) {
			page.setOrderBy("displayName");
			page.setOrder("asc");
		}
		page = permissionManager.getPermissions(page);
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
		//		
		if (entity != null && entity.getId().equals("")) {
			entity.setId(null);
		}

		try {
			permissionManager.savePermission(entity);
			addActionMessage("保存权限成功");
			return RELOAD;
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("保存权限失败");
			return INPUT;
		}

	}

	@Override
	public String delete() throws Exception {
		try {
			String[] ids = id.split(",");
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
	public String checkName() throws Exception {
		String name = Struts2Utils.getRequest().getParameter("name");
		String orgName = Struts2Utils.getRequest().getParameter("orgName");

		if (permissionManager.isNameUnique(name.toUpperCase(), orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}

	public String checkDisplayName() throws Exception {
		String displayName = Struts2Utils.getRequest().getParameter("displayName");
		String orgName = Struts2Utils.getRequest().getParameter("orgName");

		if (permissionManager.isDisplayNameUnique(displayName, orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}

}
