package com.yanpeng.ssweb.web.admin.user;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.HibernateWebUtils;
import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.service.role.RoleManager;
import com.yanpeng.ssweb.service.user.UserManager;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "user.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class UserAction extends CURDBaseAction<Users> {

	// CRUD Action 基本属性

	@Autowired
	private UserManager userManager;

	@Autowired
	private RoleManager roleManager;

	@Autowired
	private GroupManager groupManager;

	// 用户-角色 相关属性

	private List<Roles> allRoles; //全部可选角色列表

	private List<String> checkedRoleIds; //页面中钩选的角色id列表

	private List<Groups> allGroups;

	private List<String> selectIds;

	private String groupId;

	// CRUD Action 属性访问函数

	@Override
	protected void prepareModel() throws Exception {
		if (id != null && !id.equals("")) {
			entity = userManager.getUser(id);
			groupId = entity.getGroups().getId();
		} else {
			entity = new Users();
		}		

		allRoles = roleManager.getAllRoles();
		checkedRoleIds = entity.getRoleIds();
		allGroups = groupManager.getAllGroup();

	}

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		List<PropertyFilter> filters = HibernateWebUtils.buildPropertyFilters(Struts2Utils.getRequest(), new Users());
		page = userManager.search(page, filters);
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
		Groups group = groupManager.getGroupById(groupId);
		entity.setGroups(group);
		try {
			userManager.saveUser(entity, checkedRoleIds);
			addActionMessage("保存用户成功");
			return RELOAD;
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("保存用户失败");
			return INPUT;
		}

	}

	@Override
	public String delete() throws Exception {
		try {
			String[] ids = id.split(",");
			List<String> list = Arrays.asList(ids);

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

	public List<Roles> getAllRoles() {
		return allRoles;
	}

	public List<Groups> getAllGroups() {
		return allGroups;
	}

	public List<String> getCheckedRoleIds() {
		return checkedRoleIds;
	}

	public void setCheckedRoleIds(List<String> checkedRoleIds) {
		this.checkedRoleIds = checkedRoleIds;
	}

	public List<String> getSelectIds() {
		return selectIds;
	}

	public void setSelectIds(List<String> selectIds) {
		this.selectIds = selectIds;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

}
