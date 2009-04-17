package com.yanpeng.ssweb.service.security.resource;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheException;
import net.sf.ehcache.Element;

import org.springframework.dao.DataRetrievalFailureException;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;

import com.yanpeng.ssweb.cache.SSWebCache;
import com.yanpeng.ssweb.entity.Permissions;

/**
 * security的cache
 * 
 * @author Allen
 */

public class SecurityResourceCache {

	private static Cache cache;

	static {
		if (cache == null) {
			cache = SSWebCache.getInstance().getCacheManager().getCache("security_resource");
		}
	}

	public synchronized static void putCache(Permissions permission) {
		Element element = new Element(permission.getPath(), permission);
		cache.put(element);
	}

	public synchronized static Permissions getCache(String resPath) {
		Element element = null;
		try {
			element = cache.get(resPath);
		} catch (CacheException cacheException) {
			throw new DataRetrievalFailureException("ResourceCache failure: " + cacheException.getMessage(),
					cacheException);
		}
		if (element == null) {
			return null;
		} else {
			return (Permissions) element.getValue();
		}

	}

	public synchronized static void removeCache(String resPath) {
		cache.remove(resPath);
	}

	@SuppressWarnings("unchecked")
	public synchronized static Collection<Permissions> getAllCache() {
		List<String> resources = new ArrayList<String>();
		List<Permissions> resclist = new ArrayList<Permissions>();
		try {
			if (cache != null) {
				resources = cache.getKeys();
			}

		} catch (IllegalStateException e) {
			throw new IllegalStateException(e.getMessage(), e);
		} catch (CacheException e) {
			throw new UnsupportedOperationException(e.getMessage(), e);
		}
		for (String resPath : resources) {
			Permissions rd = getCache(resPath);
			resclist.add(rd);
		}
		return resclist;
	}

	public synchronized static GrantedAuthority[] getAuthoritysInCache(String resPath) {
		Permissions resource = getCache(resPath);
		GrantedAuthority[] gas = { new GrantedAuthorityImpl(resource.getName()) };
		return gas;
	}

}
