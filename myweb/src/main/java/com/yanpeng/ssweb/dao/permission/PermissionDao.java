package com.yanpeng.ssweb.dao.permission;

import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Permissions;

/**
 * 权限DAO
 * @author Allen
 */
//Spring DAO Bean的标识
@Repository
public class PermissionDao extends HibernateDao<Permissions, Long> {

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}

	public boolean isDisplayNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("displayName", newValue, orgValue);
	}

	public List<Permissions> findByIds(Collection<Long> ids) {
		return find(Restrictions.in("id", ids));
	}
	
	public boolean isNameUniqueById(final Long id,final String nameValue) {
		Criterion criteria;
		criteria = Restrictions.and(Restrictions.eq("name", nameValue), Restrictions
					.not(Restrictions.eq("id", id)));

		return find(criteria).size() == 0;
	}
	
	public boolean isDisplayNameUniqueById(final Long id,final String displayNameValue) {
		Criterion criteria;
		criteria = Restrictions.and(Restrictions.eq("displayName", displayNameValue), Restrictions
					.not(Restrictions.eq("id", id)));

		return find(criteria).size() == 0;
	}
}
