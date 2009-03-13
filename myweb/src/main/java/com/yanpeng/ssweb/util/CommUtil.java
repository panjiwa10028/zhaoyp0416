package com.yanpeng.ssweb.util;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;



public class CommUtil {
	
	public static void ObjToMap(Object obj, Map map) {
		if (map == null)
			map = new HashMap();
		PropertyDescriptor descriptors[] = BeanUtilsBean.getInstance()
				.getPropertyUtils().getPropertyDescriptors(obj);
		for (int i = 0; i < descriptors.length; i++) {
			String name = descriptors[i].getName();
			try {
				if (descriptors[i].getReadMethod() != null)
					map.put(name, BeanUtilsBean.getInstance()
							.getPropertyUtils().getProperty(obj, name));
			} catch (Exception e) {
				System.out.println(name + ":" + e);
			}
		}

	}

	public static void MapToObj(Map map, Object obj) {
		for (Iterator names = map.keySet().iterator(); names.hasNext();) {
			String name = (String) names.next();
			if (BeanUtilsBean.getInstance().getPropertyUtils().isWriteable(obj,
					name)) {
				Object value = map.get(name);
				try {
					BeanUtilsBean.getInstance().copyProperty(obj, name, value);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	
}
