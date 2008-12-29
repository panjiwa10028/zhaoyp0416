package com.yanpeng.website.service.manager.menu;

import java.util.List;

import org.hibernate.SessionFactory;
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
}
