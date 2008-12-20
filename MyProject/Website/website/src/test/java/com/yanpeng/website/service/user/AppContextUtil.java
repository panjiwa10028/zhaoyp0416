package com.yanpeng.website.service.user;

import org.springframework.beans.factory.BeanNameAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AppContextUtil {

	private final static AppContextUtil instance = new AppContextUtil();

	public final static AppContextUtil getInstance() {
		return instance;
	}

	private AppContextUtil() {
	}

	private static Class getClass(String classname)
			throws ClassNotFoundException {
		ClassLoader classLoader = Thread.currentThread()
				.getContextClassLoader();
		if (classLoader == null)
			classLoader = BeanNameAware.class.getClassLoader();
		return (classLoader.loadClass(classname));
	}

	private String[] contextPaths = { "applicationContext.xml" };
	private ApplicationContext appContext = new ClassPathXmlApplicationContext(
			contextPaths);

	public ApplicationContext getAppContext() {
		return appContext;
	}

	public Object getBean(String beanName) {
		return appContext.getBean(beanName);
	}

}
