package com.yanpeng.ssweb.dao.permission;

import java.util.Collection;
import java.util.List;

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
public class PermissionDao extends HibernateDao<Permissions, String> {

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}
	
	public List<Permissions> findByIds(Collection<String> ids) {
		return findByCriteria(Restrictions.in("id", ids));
	}
}
