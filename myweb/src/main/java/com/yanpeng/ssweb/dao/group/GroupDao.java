package com.yanpeng.ssweb.dao.group;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Roles;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class GroupDao extends HibernateDao<Groups, String> {

	public List<Groups> getAll() {
		return this.findByCriteria(Restrictions.not(Restrictions.eq("id", "0")));
	}
	
	public Page<Groups> getAll(Page<Groups> page) {
		return this.findByCriteria(page, Restrictions.not(Restrictions.eq("id", "0")));
	}
	
	public boolean isNameUnique(Object newValue, Object orgValue) {
		return this.isPropertyUnique("name", newValue, orgValue);
	}
	
}
