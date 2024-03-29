package com.yanpeng.ssweb.service.security.resource;

import java.util.Collection;
import java.util.Iterator;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.security.ConfigAttributeDefinition;
import org.springframework.security.ConfigAttributeEditor;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.intercept.web.FilterInvocation;
import org.springframework.security.intercept.web.FilterInvocationDefinitionSource;
import org.springframework.security.util.AntUrlPathMatcher;
import org.springframework.security.util.RegexUrlPathMatcher;
import org.springframework.security.util.UrlMatcher;

import com.yanpeng.ssweb.entity.Permissions;

/**
 * spring security数据库验证的filter
 * 
 * @author Allen
 */

@SuppressWarnings("unchecked")
public class DbFilterInvocationDefinitionSource implements FilterInvocationDefinitionSource, InitializingBean {

	private UrlMatcher urlMatcher;

	private boolean useAntPath = true;

	private boolean lowercaseComparisons = true;

	private boolean stripQueryStringFromUrls;

	public void afterPropertiesSet() throws Exception {
		urlMatcher = new RegexUrlPathMatcher();
		if (useAntPath) {
			urlMatcher = new AntUrlPathMatcher();
		}
		if ("true".equals(lowercaseComparisons)) {
			if (!useAntPath) {
				((RegexUrlPathMatcher) urlMatcher).setRequiresLowerCaseUrl(true);
			}
		} else if ("false".equals(lowercaseComparisons)) {
			if (useAntPath) {
				((AntUrlPathMatcher) urlMatcher).setRequiresLowerCaseUrl(false);
			}
		}
	}

	public ConfigAttributeDefinition getAttributes(Object filter) throws IllegalArgumentException {
		FilterInvocation filterInvocation = (FilterInvocation) filter;
		String requestURI = filterInvocation.getRequestUrl();
		if (stripQueryStringFromUrls) {
			int firstQuestionMarkIndex = requestURI.indexOf("?");

			if (firstQuestionMarkIndex != -1) {
				requestURI = requestURI.substring(0, firstQuestionMarkIndex);
			}
		}
		if (urlMatcher.requiresLowerCaseUrl()) {
			requestURI = requestURI.toLowerCase();
		}
		GrantedAuthority[] authorities = new GrantedAuthority[0];
		Permissions permission = null;
		Collection resources = SecurityResourceCache.getAllCache();
		if (resources != null) {
			for (Iterator it = resources.iterator(); it.hasNext();) {
				permission = (Permissions) it.next();
				Long id = permission.getId();
				String resPath = permission.getPath();
				boolean matched = urlMatcher.pathMatchesUrl(resPath, requestURI);
				if (matched) {
					authorities = SecurityResourceCache.getAuthoritysInCache(id);
					break;
				}
			}
			if (authorities != null && authorities.length > 0) {
				String authoritiesStr = " ";
				for (GrantedAuthority authoritie : authorities) {
					authoritiesStr += authoritie.getAuthority() + ",";
				}
				String authStr = authoritiesStr.substring(0, authoritiesStr.length() - 1);
				ConfigAttributeEditor configAttrEditor = new ConfigAttributeEditor();
				configAttrEditor.setAsText(authStr.trim());
				return (ConfigAttributeDefinition) configAttrEditor.getValue();
			}
		}

		return null;
	}

	public void setUseAntPath(boolean useAntPath) {
		this.useAntPath = useAntPath;
	}

	public void setLowercaseComparisons(boolean lowercaseComparisons) {
		this.lowercaseComparisons = lowercaseComparisons;
	}

	public Collection getConfigAttributeDefinitions() {
		return null;
	}

	public boolean supports(Class clazz) {
		return true;
	}

	public void setStripQueryStringFromUrls(boolean stripQueryStringFromUrls) {
		this.stripQueryStringFromUrls = stripQueryStringFromUrls;
	}

}
