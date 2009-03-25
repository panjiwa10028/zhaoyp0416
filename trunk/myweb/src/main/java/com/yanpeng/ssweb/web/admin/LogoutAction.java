package com.yanpeng.ssweb.web.admin;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.menu.MenuManager;
import com.yanpeng.ssweb.service.user.UserManager;
import com.yanpeng.ssweb.web.BaseAction;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = "LOGOUT", location = "/j_spring_security_logout", type = "redirect") })
public class LogoutAction extends BaseAction<Users> {

	

	@Override
	public String execute() throws Exception {		
		return "LOGOUT";
	}

	
}
