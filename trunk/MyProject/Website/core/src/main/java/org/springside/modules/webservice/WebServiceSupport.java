package org.springside.modules.webservice;

import javax.annotation.PostConstruct;

import net.sf.dozer.util.mapping.MapperIF;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springside.modules.utils.DozerMapperSingleton;

/**
 * 可选的WebService辅助基类.
 * 
 * 暂时只提供了公共的logger和dozer.
 * 
 * @author calvin
 */
public abstract class WebServiceSupport {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	protected MapperIF dozer;

	public void setDozer(final MapperIF dozer) {
		this.dozer = dozer;
	}

	@PostConstruct
	public void initDozer() {
		// 如果Spring初始化后dozer未注入,获取无配置文件的mapper单例.
		if (dozer == null) {
			logger.info("ApplicationContext中不存在dozer mapper,使用无配置文件的默认dozer.");
			dozer = DozerMapperSingleton.getInstance();
		}
	}
}
