package com.yanpeng.ssweb.dao.menu;

import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.PropertyFilter.MatchType;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Menus;

/**
 * 菜单DAO
 * 
 * @author Allen
 */
//Spring DAO Bean的标识
@Repository
public class MenuDao extends HibernateDao<Menus, Long> {

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

	public List<Menus> findByRoleIds(Collection<Long> ids) {
		Page page = new Page();
		page.setOrder("asc,asc,asc");
		page.setOrderBy("parentId,id,sort");
		return findByCriteria("roleses", 0, page, Restrictions.in("_roleses.id", ids));
	}

	public List<Menus> findFirstLevelNotId(Long id) {
		Criterion criteria;
		if (id != null && !id.equals("")) {
			criteria = Restrictions.and(Restrictions.in("parentId", new Object[] { new Long(-1), new Long(0) }), Restrictions
					.not(Restrictions.eq("id", id)));
		} else {
			criteria = Restrictions.in("parentId", new Object[] { new Long(-1), new Long(0) });
		}
		return find(criteria);
	}

	public List<Menus> findSub() {
		return find(Restrictions.not(Restrictions.in("parentId", new Object[] { new Long(-1), new Long(0) })));
	}

	public boolean isNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("name", newValue, orgValue);
	}

	public boolean isDisplayNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("displayName", newValue, orgValue);
	}

	public List<Menus> findByIds(Collection<Long> ids) {
		return find(Restrictions.in("id", ids));
	}

	public Page<Menus> getAllByPage(Page<Menus> page) {
		return findByCriteria(page, Restrictions.not(Restrictions.eq("id", new Long(-1))));
	}

	public Page<Menus> search(Page<Menus> page, final List<PropertyFilter> filters) {
		PropertyFilter proFilter = new PropertyFilter("id", new Long(-1), MatchType.NOTEQ);
		filters.add(proFilter);
		return find(page, filters);
	}
}
