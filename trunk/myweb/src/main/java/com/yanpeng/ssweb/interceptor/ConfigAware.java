package com.yanpeng.ssweb.interceptor;

import com.yanpeng.ssweb.entity.config.Config;


/**
 * 
 * @author Allen
 *
 */
public interface ConfigAware {

	/**
	 * 设置配置信息
	 * 
	 * @param config 配置信息
	 */
	public void setConfig(Config config);
}
