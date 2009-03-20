package com.yanpeng.ssweb.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 *
 * @author Allen
 *
 */

public class BaseAction<T> extends CRUDActionSupport<T> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7357066429616621054L;

	@Autowired
	private UserManager userManager;
		
	public Users getLoginUser() throws Exception {
		try {
			Users user = (Users) Struts2Utils.getSession().getAttribute("LoginUser");
			if (user == null) {
				SecurityContext ctx = SecurityContextHolder.getContext();
				Authentication auth = ctx.getAuthentication();
				if (auth.getPrincipal() instanceof UserDetails) {
					org.springframework.security.userdetails.User userd = (org.springframework.security.userdetails.User) auth
							.getPrincipal();
					if (userd != null && userd.getUsername() != null) {
						user = userManager.getUserByLoginName(userd
								.getUsername());
						Struts2Utils.getSession().setAttribute("LoginUser", user);
					}
				}
			}
			return user;
		} catch (Exception e) {
			return null;
		}
	}
	
	
	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public T getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	
	

}
