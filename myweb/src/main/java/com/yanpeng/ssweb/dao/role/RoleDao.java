package com.yanpeng.ssweb.dao.role;

import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Roles;

/**
 * 角色DAO
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class RoleDao extends HibernateDao<Roles, Long> {

	public List<Roles> findByIds(Collection<Long> ids) {
		return find(Restrictions.in("id", ids));
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
