package com.yanpeng.ssweb.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.ui.logout.LogoutFilter;
import org.springframework.security.ui.logout.LogoutHandler;

/**
 *
 * @author Allen
 *
 */
public class MyLogoutFilter extends LogoutFilter {

	public MyLogoutFilter(String logoutSuccessUrl, LogoutHandler[] handlers) {
		super(logoutSuccessUrl, handlers);
		// TODO Auto-generated constructor stub
	}


	 protected boolean requiresLogout(HttpServletRequest request, HttpServletResponse response) {
		 boolean condition = super.requiresLogout(request, response);
		 if(condition) {
			 System.out.println("退出操作");
		 }
		 return condition;
	 }
	
}
