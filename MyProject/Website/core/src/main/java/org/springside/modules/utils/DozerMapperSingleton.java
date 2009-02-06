package org.springside.modules.utils;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

/**
 * dozer单例的wrapper.
 * 
 * dozer在同一jvm里使用单例即可,无需重复创建.
 * 但Dozer4自带的DozerBeanMapperSingletonWrapper必须使用dozerBeanMapping.xml作参数初始化,因此重新实现.
 * 
 * @author calvin
 */
public final class DozerMapperSingleton {

	private static MapperIF instance = new DozerBeanMapper();//使用预初始化避免同步问题.

	private DozerMapperSingleton() {
		//shoudn't invoke.
	}

	public static MapperIF getInstance() {
		return instance;
	}
}
