package com.yanpeng.ssweb.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.opensymphony.xwork2.ActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.BaseEntity;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.entity.config.Config;
import com.yanpeng.ssweb.interceptor.ConfigAware;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 * 不带CURD操作的基类Action
 *
 * @author Allen
 *
 */

public class BaseAction extends ActionSupport implements ConfigAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7357066429616621054L;

	protected Config config;
	
	@Autowired
	private UserManager userManager;
		
	public Users getLoginUser() throws Exception {
		try {
			Users user = (Users) Struts2Utils.getSession().getAttribute("LOGINUSER");
			if (user == null) {
				SecurityContext ctx = SecurityContextHolder.getContext();
				Authentication auth = ctx.getAuthentication();
				if (auth.getPrincipal() instanceof UserDetails) {
					org.springframework.security.userdetails.User userd = (org.springframework.security.userdetails.User) auth
							.getPrincipal();
					if (userd != null && userd.getUsername() != null) {
						user = userManager.getUserByLoginName(userd
								.getUsername());
						Struts2Utils.getSession().setAttribute("LOGINUSER", user);
					}
				}
			}
			return user;
		} catch (Exception e) {
			return null;
		}
	}
	

	@Override
	public void setConfig(Config config) {
		this.config = config;		
	}

}
