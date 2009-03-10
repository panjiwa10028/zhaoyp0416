package com.yanpeng.ssweb.web.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.yanpeng.core.dao.hibernate.HibernateUtils;
import com.yanpeng.core.dao.hibernate.Page;
import com.yanpeng.core.web.struts2.CRUDSupportAction;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author calvin
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDSupportAction.RELOAD, location = "user.action?page.pageParam=${page.pageParam}", type = "redirect") })
public class UserAction extends CRUDSupportAction<Users> {

	// CRUD Action 基本属性

	private Page<Users> page = new Page<Users>(5, true);//每页5项记录，自动执行count查询计算总页数.

	private Users entity;

	private String id;

	private UserManager userManager;

	// 用户-角色 相关属性

	private List<Roles> allRoles; //全部可选角色列表

	private List checkedRoleIds; //页面中钩选的角色id列表

	@Required
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}

	// CRUD Action 属性访问函数

	public Users getModel() {
		return entity;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = userManager.getUser(id);
		} else {
			entity = new Users();
		}
	}

	public void setId(String id) {
		this.id = id;
	}

	public Page<Users> getPage() {
		return page;
	}

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		page = userManager.getAllUsers(page);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		allRoles = userManager.getAllRoles();
		checkedRoleIds = entity.getRoleIds();
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
		HibernateUtils.mergeByCheckedIds(entity.getRoleses(), checkedRoleIds, Roles.class);
		userManager.saveUser(entity);
		addActionMessage("保存用户成功");
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		try {
			userManager.deleteUser(id);
			addActionMessage("删除用户成功");
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(e.getMessage());
		}
		return RELOAD;
	}

	// 其他属性访问函数及Action函数

	public List<Roles> getAllRoles() {
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

		if (userManager.isLoginNameUnique(loginName, orgLoginName)) {
			renderText("true");
		} else {
			renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}
	
	public Users getLoginUser() throws Exception{
		try{
			Users user=(Users)getSession().getAttribute("LoginUser");
			if(user==null){
				SecurityContext ctx = SecurityContextHolder.getContext();
		        Authentication auth = ctx.getAuthentication();       
		        if(auth.getPrincipal() instanceof UserDetails){   
		        	org.springframework.security.userdetails.User userd = (org.springframework.security.userdetails.User)auth.getPrincipal();     
		        	if(userd!=null&&userd.getUsername()!=null){
		        		user=userManager.getUserByLoginName(userd.getUsername());
		        		getSession().setAttribute("LoginUser", user);
		        	}
		        }     
			}
	        return user;   
		}catch (Exception e) {
			return null;
		}
	}
}
