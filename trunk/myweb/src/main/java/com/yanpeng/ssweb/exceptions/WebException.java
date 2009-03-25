package com.yanpeng.ssweb.exceptions;

/**
 * 系统级异常
 * 
 * @author Allen
 * 
 */
public class WebException extends RuntimeException {

	private static final long serialVersionUID = 5645227164781802573L;

	public WebException() {
		super();
	}
	
	public WebException(String msg) {
		super(msg);
	}

	public WebException(Throwable cause) {
		super(cause);
	}

	public WebException(String msg, Throwable cause) {
		super(msg, cause);
		setStackTrace(cause.getStackTrace());
	}

}
