package com.yanpeng.ssweb.web.admin;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.yanpeng.ssweb.web.BaseAction;

/**
 * 登出Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = "LOGOUT", location = "/j_spring_security_logout", type = "redirect") })
public class LogoutAction extends BaseAction {

	@Override
	public String execute() throws Exception {
		return "LOGOUT";
	}

}
