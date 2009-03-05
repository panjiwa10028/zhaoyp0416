package com.yanpeng.core.utils;

import org.springframework.security.providers.encoding.Md5PasswordEncoder;


public abstract class BaseCodeUtils {
	
	public static Md5PasswordEncoder md5coder=null;
	
	static{
		md5coder= new Md5PasswordEncoder();
	}
	
	public static String getMd5PasswordEncoder(String password,String salt){
		return md5coder.encodePassword(password, salt);
	}
	
	public static void main(String[] args) {
		System.out.println(getMd5PasswordEncoder("password", "admin"));
	}
}
