package org.springside.examples.miniweb.web.user;

import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Required;
import org.springside.examples.miniweb.entity.user.Authority;
import org.springside.examples.miniweb.entity.user.Role;
import org.springside.examples.miniweb.service.ServiceException;
import org.springside.examples.miniweb.service.user.UserManager;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.CRUDActionSupport;

/**
 * 角色管理Action.
 * 
 * @see CRUDActionSupport
 * @author calvin
 */

@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "role.action", type = "redirect") })
public class RoleAction extends CRUDActionSupport<Role> {

	private static final long serialVersionUID = 8517636900960039101L;

	// CRUD Action 基本属性

	private Role entity;

	private Long id;

	private List<Role> allRoles;

	private UserManager manager;

	// 角色权限相关属性

	private List<Authority> allAuths; //全部可选权限列表

	private List<Long> checkedAuthIds;//页面中钩选的权限id列表
	
	@Required
	public void setUserManager(UserManager userManager) {
		manager = userManager;
	}

	// CRUD Action 属性访问函数

	public Role getModel() {
		return entity;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = manager.getRole(id);
		} else {
			entity = new Role();
		}
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Role> getAllRoles() {
		return allRoles;
	}

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		allRoles = manager.getAllRoles();
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		allAuths = manager.getAllAuths();
		checkedAuthIds = entity.getAuthIds();
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的auth Set.
		HibernateUtils.mergeByCheckedIds(entity.getAuths(), checkedAuthIds, Authority.class);
		manager.saveRole(entity);
		addActionMessage("保存角色成功");
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		try {
			manager.deleteRole(id);
			addActionMessage("删除角色成功");
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(e.getMessage());
		}
		return RELOAD;
	}

	// 其他属性访问函数及Action函数

	public List<Authority> getAllAuths() {
		return allAuths;
	}

	public List<Long> getCheckedAuthIds() {
		return checkedAuthIds;
	}

	public void setCheckedAuthIds(List<Long> checkedAuthIds) {
		this.checkedAuthIds = checkedAuthIds;
	}
}