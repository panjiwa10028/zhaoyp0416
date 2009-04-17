package com.yanpeng.ssweb.interceptor;

import java.lang.reflect.Method;

import com.opensymphony.xwork2.ActionInvocation;
import com.yanpeng.ssweb.interceptor.annotations.Token;

public class TokenInterceptor extends org.apache.struts2.interceptor.TokenInterceptor {

	private static final long serialVersionUID = 1L;

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Object action = invocation.getAction();
		if (action != null) {
			Method method = getActionMethod(action.getClass(), invocation.getProxy().getMethod());
			Token token = method.getAnnotation(Token.class);
			if (token != null) {
				String result = super.doIntercept(invocation);
				//				if (INVALID_TOKEN_CODE.equals(result)) {
				//					System.out.println("---------------------------");
				//					return "error";
				//				}
				return result;
			}
		}
		return invocation.invoke();
	}

	public static final Method getActionMethod(Class<? extends Object> actionClass, String methodName)
			throws NoSuchMethodException {
		Method method;
		try {
			method = actionClass.getMethod(methodName, new Class[0]);
		} catch (NoSuchMethodException e) {
			String altMethodName = "do" + methodName.substring(0, 1).toUpperCase() + methodName.substring(1);
			method = actionClass.getMethod(altMethodName, new Class[0]);
		}
		return method;
	}

}
