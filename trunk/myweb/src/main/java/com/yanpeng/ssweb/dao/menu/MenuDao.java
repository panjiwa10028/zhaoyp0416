package com.yanpeng.ssweb.dao.menu;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.hibernate.HibernateDao;
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
public class MenuDao extends HibernateDao<Menus, String> {

	public List<Menus> findMenusByRoleIds(String ids) {
		String queryString = "select m from Menus as m inner join m.roleses as r where r.id in ("+ids+") order by m.sort asc,m.id asc";
		return this.createQuery(queryString).list();
	}
}
