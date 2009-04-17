package com.yanpeng.ssweb.exceptions;

import org.springframework.security.AuthenticationException;

/**
 * 验证码错误异常
 * @author Allen
 *
 */
public class AuthenticationCodeException extends AuthenticationException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6710011713681546717L;

	public AuthenticationCodeException(String msg) {
		super(msg);
		// TODO Auto-generated constructor stub
	}

	public AuthenticationCodeException(String msg, Object extraInformation) {
		super(msg, extraInformation);
	}

	public AuthenticationCodeException(String msg, Throwable t) {
		super(msg, t);
	}

}
