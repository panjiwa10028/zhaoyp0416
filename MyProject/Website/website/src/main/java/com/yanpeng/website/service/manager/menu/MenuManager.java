package com.yanpeng.website.service.manager.menu;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.orm.hibernate.SimpleHibernateTemplate;

import com.yanpeng.website.bean.entity.TGroups;
import com.yanpeng.website.bean.entity.TMenus;
import com.yanpeng.website.bean.entity.TUsers;
import com.yanpeng.website.service.exception.ServiceException;

/**
 * 
 * @author yanpeng
 *
 */
@Service
@Transactional
public class MenuManager {
	
	private SimpleHibernateTemplate<TMenus, String> menuDao;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		menuDao = new SimpleHibernateTemplate<TMenus, String>(sessionFactory, TMenus.class);
	}
	
	@Transactional(readOnly = true)
	public List<TMenus> getMenusByIds(List rolesList) {
		Page page = new Page();
		page.setOrder("asc");
		page.setOrderBy("sort");
		return menuDao.findByCriteria(page, Restrictions.in("id", rolesList)).getResult();
//		return menuDao.createQuery("", rolesList.toArray()).list();
//		return menuDao.findByCriteria(Restrictions.in("id", rolesList));
	}	
	
	@Transactional(readOnly = true)
	public Page<TMenus> findList(Page<TMenus> page, Map<String, Object> conditionsMap) {
		Criterion []criterion = new Criterion[conditionsMap.size()];
		int cnt = 0;
		for(Iterator<String> names = conditionsMap.keySet().iterator();names.hasNext();) {
			String key = (String) names.next();
			if(key.equals("displayName")) {
				criterion[cnt] = Restrictions.like("displayName", (String) conditionsMap.get(key), MatchMode.ANYWHERE);
				cnt++;
			}else if(key.equals("disabled")) {
				criterion[cnt] = Restrictions.eq("disabled", conditionsMap.get(key));
				cnt++;
			}
			else if(key.equals("parentId")) {
				criterion[cnt] = Restrictions.like("TMenus.id", (String) conditionsMap.get(key), MatchMode.EXACT);
				cnt++;
			}
		}
		
		return menuDao.findByCriteria(page, criterion);
	}
	
	@Transactional(readOnly = true)
	public TMenus getMenu(String id) {
		return menuDao.get(id);
	}
	
	@Transactional(readOnly = true)
	public Page<TMenus> getAllMenus(Page<TMenus> page) {
		page.setOrder("asc");
		page.setOrderBy("sort");
		return menuDao.findAll(page);
	}

	public void saveMenu(TMenus menu) {
		menuDao.save(menu);
	}
	
	@Transactional(readOnly = true)
	public boolean isDisplayNameUnique(String displayName, String oldDisplayName) {
		return menuDao.isPropertyUnique("displayName", displayName, oldDisplayName);
	}

//	private void OrganizationalConditions(List<Map<String, Object>> conditionList, Criterion criterions){
//		
//	}
}
