package com.yanpeng.ssweb.web.admin;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.cache.SSWebCache;
import com.yanpeng.ssweb.web.BaseAction;

/**
 * 登出Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = "LOGOUT", location = "/j_spring_security_logout", type = "redirect") })
public class CacheAction extends BaseAction {

	@Override
	public String execute() throws Exception {
		return "LOGOUT";
	}

	public String addCache() throws Exception {
		String para = Struts2Utils.getRequest().getParameter("para");
		//		SSWebCache.getInstance();
		//		EhCacheProvider e = new EhCacheProvider();
		//		EhCache c = (EhCache) e.buildCache("sswebCaches", null);

		Cache cache = SSWebCache.getInstance().getCache();
		Element element = new Element("ttt", para);
		cache.put(element);
		Struts2Utils.renderText(para);
		return null;
	}

	public String getCache() throws Exception {
		Cache cache = SSWebCache.getInstance().getCache();
		Struts2Utils.renderText(cache.get("ttt").getValue() + "");
		return null;
	}

}
