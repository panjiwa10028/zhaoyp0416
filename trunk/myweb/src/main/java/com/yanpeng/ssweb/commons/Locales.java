package com.yanpeng.ssweb.commons;

import java.util.Hashtable;
import java.util.Locale;
import java.util.Map;

/**
 *
 * @author Allen
 *
 */
public class Locales {
	public Map<String, Locale> getLocales() {
		Map<String, Locale> locales = new Hashtable<String, Locale>(2);
		locales.put("en", Locale.ENGLISH);
		locales.put("zh_CN", Locale.CHINA);
		return locales;
	}

}
