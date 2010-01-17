package com.yanpeng.ssweb.dao.newscategory;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.PropertyFilter.MatchType;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.NewsCategory;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class NewsCategoryDao extends HibernateDao<NewsCategory, String> {

	@Override
	public List<NewsCategory> getAll() {
		return this.find(Restrictions.not(Restrictions.eq("id", "0")));
	}

	public Page<NewsCategory> getAllByPage(Page<NewsCategory> page) {
		return this.findByCriteria(page, Restrictions.not(Restrictions.eq("id", "0")));
	}

	public Page<NewsCategory> search(Page<NewsCategory> page, final List<PropertyFilter> filters) {
		PropertyFilter proFilter = new PropertyFilter("id", "0", MatchType.NOTEQ);
		filters.add(proFilter);
		return this.find(page, filters);
	}

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}
}
