package com.yanpeng.ssweb.dao.product;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.entity.Product;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class ProductDao extends HibernateDao<Product, Long> {

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}
	
	public Page<Product> getPicByPage(Page<Product> page) {
		return this.findByCriteria(page, Restrictions.not(Restrictions.eq("picName", "")));
	}
}
