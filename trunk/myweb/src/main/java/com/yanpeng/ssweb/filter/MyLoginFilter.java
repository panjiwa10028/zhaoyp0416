package com.yanpeng.ssweb.filter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationException;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.ui.webapp.AuthenticationProcessingFilter;

import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.AuthenticationCodeException;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 *
 * @author Allen
 *
 */
public class MyLoginFilter extends AuthenticationProcessingFilter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3418779642801047591L;

	@Autowired
	UserManager userManager;
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request) throws AuthenticationException {

		HttpSession session = request.getSession();

	    String requestCaptcha = request.getParameter("j_code");
	    String sessionCaptcha = (String) session.getAttribute("captcha");

	    if (sessionCaptcha == null || !sessionCaptcha.equals(requestCaptcha)) {
	    	throw new AuthenticationCodeException("验证码输入不正确");
	    }
	    Authentication result = null;
	    try {
	    	result = super.attemptAuthentication(request);
	    }catch(AuthenticationException exx) {
	    	throw exx;
	    }
		return result;
	}

	@Override
	public void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException failed) throws IOException, ServletException {
		logger.debug("登录失败！！");
		super.unsuccessfulAuthentication(request, response, failed);
	}

	@Override
	public void successfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			Authentication authResult) throws IOException, ServletException {
		logger.debug("登录成功！！");
//		Users user = userManager.getUserByLoginName("admin");
		super.successfulAuthentication(request, response, authResult);
	}

}
