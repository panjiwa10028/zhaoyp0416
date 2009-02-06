package org.springside.examples.miniweb.web.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Required;
import org.springside.examples.miniweb.entity.user.Role;
import org.springside.examples.miniweb.entity.user.User;
import org.springside.examples.miniweb.service.ServiceException;
import org.springside.examples.miniweb.service.user.UserManager;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.web.struts2.CRUDActionSupport;

/**
 * 用户管理Action.
 * 
 * @see CRUDActionSupport
 * @author calvin
 */
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "user.action?page.pageParam=${page.pageParam}", type = "redirect") })
public class UserAction extends CRUDActionSupport<User> {

	private static final long serialVersionUID = -2180690009159324387L;

	// CRUD Action 基本属性
	
	private Page<User> page = new Page<User>(5, true);//每页5项记录，自动执行count查询计算总页数.

	private User entity;

	private Long id;

	private UserManager manager;

	// 用户角色 相关属性
	
	private List<Role> allRoles; //全部可选角色列表

	private List<Long> checkedRoleIds; //页面中钩选的角色id列表
	
	@Required
	public void setUserManager(UserManager userManager) {
		manager = userManager;
	}

	// CRUD Action 属性访问函数
	
	public User getModel() {
		return entity;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = manager.getUser(id);
		} else {
			entity = new User();
		}
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Page<User> getPage() {
		return page;
	}
	
	// CRUD Action 函数
	
	@Override
	public String list() throws Exception {
		page = manager.getAllUsers(page);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		allRoles = manager.getAllRoles();
		checkedRoleIds = entity.getRoleIds();
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
		HibernateUtils.mergeByCheckedIds(entity.getRoles(), checkedRoleIds, Role.class);
		manager.saveUser(entity);
		addActionMessage("保存用户成功");
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		try {
			manager.deleteUser(id);
			addActionMessage("删除用户成功");
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(e.getMessage());
		}
		return RELOAD;
	}
	
	// 其他属性访问函数及Action函数
	
	public List<Role> getAllRoles() {
		return allRoles;
	}

	public List<Long> getCheckedRoleIds() {
		return checkedRoleIds;
	}

	public void setCheckedRoleIds(List<Long> checkedRoleIds) {
		this.checkedRoleIds = checkedRoleIds;
	}


	/**
	 * 支持使用Jquery.validate Ajax检验用户名是否重复.
	 */
	public String checkLoginName() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String loginName = request.getParameter("loginName");
		String orgLoginName = request.getParameter("orgLoginName");

		if (manager.isLoginNameUnique(loginName, orgLoginName)) {
			renderText("true");
		} else {
			renderText("false");
		}
		//因为直接输出,不使用Jsp,因此返回null.
		return null;
	}
}
