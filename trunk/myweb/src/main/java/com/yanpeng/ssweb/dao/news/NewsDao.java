package com.yanpeng.ssweb.dao.news;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.News;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class NewsDao extends HibernateDao<News, Long> {
	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("title", newValue, orgValue);
	}
	
	public Page<News> getPicByPage(Page<News> page) {
		return this.findByCriteria(page, Restrictions.not(Restrictions.eq("picName", "")));
	}
}
