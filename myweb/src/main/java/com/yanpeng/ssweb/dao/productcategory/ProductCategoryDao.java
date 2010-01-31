package com.yanpeng.ssweb.dao.productcategory;

import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.PropertyFilter.MatchType;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.ProductCategory;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class ProductCategoryDao extends HibernateDao<ProductCategory, Long> {

	@Override
	public List<ProductCategory> getAll() {
		return this.find(Restrictions.not(Restrictions.eq("id", new Long(-1))));
	}

	public Page<ProductCategory> getAllByPage(Page<ProductCategory> page) {
		return this.findByCriteria(page, Restrictions.not(Restrictions.eq("id", new Long(-1))));
	}

	public Page<ProductCategory> search(Page<ProductCategory> page, final List<PropertyFilter> filters) {
		PropertyFilter proFilter = new PropertyFilter("id", new Long(-1), MatchType.NOTEQ);
		filters.add(proFilter);
		return this.find(page, filters);
	}

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}
	
	public boolean isNameUniqueById(final Long id,final String nameValue) {
		Criterion criteria;
		criteria = Restrictions.and(Restrictions.eq("name", nameValue), Restrictions
					.not(Restrictions.eq("id", id)));

		return find(criteria).size() == 0;
	}
}
