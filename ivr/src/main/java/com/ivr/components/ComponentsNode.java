package com.ivr.components;

import com.nwoods.jgo.JGoObject;

/**
 *
 * @author Allen
 * 
 */
public interface ComponentsNode {

	/**
	 * 获得组件的id
	 * @return
	 */
	public int getId();
	
	/**
	 * 获得组件图标
	 * @return
	 */
	public JGoObject getIcon();

	/**
	 * 根据端口id获得端口
	 * @param fromPort
	 * @return
	 */
	public ComponentsPort getPortByID(int fromPort);
	/**
	 * 组件初始化
	 */
	public void initialize();
	
	/**
	 * 添加默认端口
	 */
	public void addDefaultPorts();
}
