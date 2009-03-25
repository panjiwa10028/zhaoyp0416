package com.yanpeng.ssweb.interceptor;

import com.yanpeng.ssweb.entity.config.Config;


/**
 * Action如果想获得配置信息则实现本类
 * 
 * @author 黄磊
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
