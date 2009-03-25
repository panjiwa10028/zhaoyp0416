package com.yanpeng.ssweb.dao.menu;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Permissions;
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

//	public List<Menus> findByRoleIds(Collection<String> ids) {
//		
//		StringBuffer strbf=new StringBuffer();
//		for(Serializable pk:ids){
//			if(pk instanceof String||pk instanceof Character){
//				strbf.append("'"+pk+"',");
//			}else{
//				strbf.append(pk+",");
//			}
//		}
//		String parms=strbf.substring(0, strbf.length()-1).toString();
//		String queryString = "select m from Menus as m inner join m.roleses as r where r.id in ("+parms+") order by m.sort asc,m.id asc";
//		
//		return this.createQuery(queryString).list();
//	}
	
	public List<Menus> findByRoleIds(Collection<String> ids) {
		Page page = new Page();
		page.setOrder("asc,asc");
		page.setOrderBy("sort,id");
		return findByCriteria("roleses", 0, page, Restrictions.in("_roleses.id", ids) );
	}
	
	public List<Menus> findFirstLevel() {
		return findByCriteria(Restrictions.in("parentId", new Object[]{"-1,1"}));
	}
	
	public List<Menus> findSub() {
		return findByCriteria(Restrictions.not(Restrictions.in("parentId", new Object[]{"-1","0"})));
	}
	
	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}
	
	public List<Menus> findByIds(Collection<String> ids) {
		return findByCriteria(Restrictions.in("id", ids));
	}
	
	public Page<Menus> getAllByPage(Page<Menus> page) {
		return findByCriteria(page, Restrictions.not(Restrictions.eq("id", "0")));
	}
}
