package com.yanpeng.ssweb.dao.group;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.PropertyFilter.MatchType;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Groups;

/**
 * 用户组DAO
 * 
 * @author Allen
 */
//Spring DAO Bean的标识
@Repository
public class GroupDao extends HibernateDao<Groups, String> {

	@Override
	public List<Groups> getAll() {
		return this.find(Restrictions.not(Restrictions.eq("id", "0")));
	}

	public Page<Groups> getAllByPage(Page<Groups> page) {
		return this.findByCriteria(page, Restrictions.not(Restrictions.eq("id", "0")));
	}
	
	public Page<Groups> search(Page<Groups> page, final List<PropertyFilter> filters) {
		PropertyFilter proFilter = new PropertyFilter("id", "0", MatchType.EQ);
		filters.add(proFilter);
		return this.find(page, filters);
	}

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}

}
