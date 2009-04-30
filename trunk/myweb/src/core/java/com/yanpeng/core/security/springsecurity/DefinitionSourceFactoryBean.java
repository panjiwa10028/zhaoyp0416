package com.yanpeng.core.security.springsecurity;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.ConfigAttributeDefinition;
import org.springframework.security.ConfigAttributeEditor;
import org.springframework.security.intercept.web.DefaultFilterInvocationDefinitionSource;
import org.springframework.security.intercept.web.FilterInvocationDefinitionSource;
import org.springframework.security.intercept.web.RequestKey;
import org.springframework.security.util.AntUrlPathMatcher;
import org.springframework.security.util.UrlMatcher;

import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.service.security.resource.SecurityResourceCache;

/**
 * DefinitionSource工厂,可在数据库或其它地方定义URL-授权关系.
 * 
 * 由注入的requestMapService提供LinkedHashMap<String, String>形式的URL及授权关系定义.
 * 
 * @see org.springframework.security.intercept.web.DefaultFilterInvocationDefinitionSource
 * @see RequestMapService
 * 
 * @author calvin
 */
public class DefinitionSourceFactoryBean implements FactoryBean {

	public Object getObject() throws Exception {
		LinkedHashMap<RequestKey, ConfigAttributeDefinition> requestMap = getRequestMap();
		UrlMatcher matcher = getUrlMatcher();
		DefaultFilterInvocationDefinitionSource definitionSource = new DefaultFilterInvocationDefinitionSource(matcher,
				requestMap);
		return definitionSource;
	}

	@SuppressWarnings("unchecked")
	public Class getObjectType() {
		return FilterInvocationDefinitionSource.class;
	}

	public boolean isSingleton() {
		return true;
	}

	private UrlMatcher getUrlMatcher() {
		return new AntUrlPathMatcher();
	}

	private LinkedHashMap<RequestKey, ConfigAttributeDefinition> getRequestMap() throws Exception {
		Collection<Permissions> perCol = SecurityResourceCache.getAllCache();
		//		LinkedHashMap<String, String> srcMap = requestMapService.getRequestMap();
		LinkedHashMap<RequestKey, ConfigAttributeDefinition> requestMap = new LinkedHashMap<RequestKey, ConfigAttributeDefinition>();
		ConfigAttributeEditor editor = new ConfigAttributeEditor();

		if (perCol != null) {
			for (Iterator<Permissions> it = perCol.iterator(); it.hasNext();) {
				Permissions permission = (Permissions) it.next();
				String perPath = permission.getPath();
				String perKey = permission.getName();
				RequestKey key = new RequestKey(perPath, null);
				editor.setAsText(perKey);
				requestMap.put(key, (ConfigAttributeDefinition) editor.getValue());
			}
		}
		return requestMap;
	}
}
