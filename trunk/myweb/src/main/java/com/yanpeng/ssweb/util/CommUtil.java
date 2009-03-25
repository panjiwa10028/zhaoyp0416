package com.yanpeng.ssweb.util;

import java.beans.PropertyDescriptor;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtilsBean;



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
