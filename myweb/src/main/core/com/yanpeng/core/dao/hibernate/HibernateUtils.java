package com.yanpeng.core.dao.hibernate;

import java.util.Collection;
import java.util.Iterator;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.util.Assert;

/**
 * Hibernate的Utils函数集合.
 * 
 * @author calvin
 */
public class HibernateUtils {
	private HibernateUtils() {
	}

	/**
	 * 根据对象ID集合,整理合并集合.
	 * 
	 * http请求发送变更后的子对象id列表时，hibernate不适宜删除原来的子对象集合再创建一个全新的集合,
	 * 需采用如此的整合算法：在源集合中删除id不在ID集合中的对象,根据ID集合中的id创建对象并添加到源集合中.
	 * 默认对象的id属性名为"id".
	 *  
	 * @param collection 源对象集合
	 * @param retainIds  目标集合
	 * @param clazz  集合中对象的类型
	 */
	public static <T, ID> void mergeByCheckedIds(final Collection<T> collection, final Collection<ID> checkedIds,
			final Class<T> clazz) throws Exception {
		mergeByCheckedIds(collection, checkedIds, "id", clazz);
	}

	/**
	 * 根据对象ID集合,整理合并集合.
	 * 
	 * http请求发送变更后的子对象id列表时，hibernate不适宜删除原来的子对象集合再创建一个全新的集合,
	 * 需采用如此的整合算法：在源集合中删除id不在ID集合中的对象,根据ID集合中的id创建对象并添加到源集合中.
	 * 
	 * @param collection 源对象集合
	 * @param retainIds  目标集合
	 * @param clazz  集合中对象的类型
	 * @param idName 对象中ID的属性名. 
	 */
	public static <T, ID> void mergeByCheckedIds(final Collection<T> collection, final Collection<ID> checkedIds,
			final String idName, final Class<T> clazz) throws Exception {

		//参数校验
		Assert.notNull(collection);
		Assert.hasLength(idName);
		Assert.notNull(clazz);

		if (checkedIds == null) {
			collection.clear();
			return;
		}

		//在源集合中删除id不在ID集合中的对象,在ID集合中删除已在源集合中的id.
		Iterator<T> it = collection.iterator();

		while (it.hasNext()) {
			T obj = it.next();
			if (checkedIds.contains(PropertyUtils.getProperty(obj, idName))) {
				checkedIds.remove(PropertyUtils.getProperty(obj, idName));
			} else {
				it.remove();
			}
		}

		//ID集合目前剩余的id均不在源集合中,创建对象,为id属性赋值并添加到源集合中.
		for (ID id : checkedIds) {
			T obj = clazz.newInstance();
			PropertyUtils.setProperty(obj, idName, id);
			collection.add(obj);
		}
	}
}
