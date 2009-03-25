package com.yanpeng.ssweb.interceptor;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.StrutsStatics;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.yanpeng.ssweb.config.ConfigLoader;
import com.yanpeng.ssweb.entity.config.Config;

/**
 * Action拦截器
 * 
 * @author Allen
 *
 */
public class SSWebInterceptor extends AbstractInterceptor implements StrutsStatics {

	private static final long serialVersionUID = 491815684932676174L;
	private static final Logger logger = LoggerFactory.getLogger(SSWebInterceptor.class);

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		final Object action = invocation.getAction();

		// Base路径
		String basePath = ServletActionContext.getRequest().getScheme() + "://"
				+ ServletActionContext.getRequest().getServerName() + ":"
				+ ServletActionContext.getRequest().getServerPort()
				+ ServletActionContext.getRequest().getContextPath() + "/";
		ServletActionContext.getRequest().setAttribute("SSWEBPATH", basePath);

		

		if (action instanceof ConfigAware) { // 初始化配置信息
			Config config = ConfigLoader.getConfig();
			((ConfigAware) action).setConfig(config);			
		}

		
		return invocation.invoke();
	}
}
