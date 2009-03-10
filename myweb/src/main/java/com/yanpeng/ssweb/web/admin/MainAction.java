package com.yanpeng.ssweb.web.admin;

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

import com.yanpeng.core.dao.hibernate.HibernateUtils;
import com.yanpeng.core.dao.hibernate.Page;
import com.yanpeng.core.web.struts2.CRUDSupportAction;
import com.yanpeng.core.web.struts2.SimpleSupportAction;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
public class MainAction extends SimpleSupportAction {

	// 基本属性
	private Users users;
	
	@Autowired
	public UserManager userManager;

	
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}
	
	
	public Users getUsers() {
		return users;
	}


	@Override
	public String execute() throws Exception {
		users = getLoginUser();
		if(users == null) {
			users = new Users();
		}
		return SUCCESS;
	}
	
	public Users getLoginUser() throws Exception{
		try{
			Users user = (Users)getSession().getAttribute("LoginUser");
			if(user == null) {
				SecurityContext ctx = SecurityContextHolder.getContext();
		        Authentication auth = ctx.getAuthentication();       
		        if(auth.getPrincipal() instanceof UserDetails){   
		        	org.springframework.security.userdetails.User userd = (org.springframework.security.userdetails.User)auth.getPrincipal();     
		        	if(userd != null && userd.getUsername()!= null){
		        		user = userManager.getUserByLoginName(userd.getUsername());
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
