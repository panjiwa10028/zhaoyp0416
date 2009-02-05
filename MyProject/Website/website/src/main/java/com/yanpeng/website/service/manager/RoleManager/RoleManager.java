package com.yanpeng.website.service.manager.RoleManager;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.orm.hibernate.SimpleHibernateTemplate;

import com.yanpeng.website.bean.entity.TGroups;
import com.yanpeng.website.bean.entity.TMenus;
import com.yanpeng.website.bean.entity.TRoles;
import com.yanpeng.website.bean.entity.TUsers;
import com.yanpeng.website.service.exception.ServiceException;

/**
 * 
 * @author yanpeng
 *
 */
@Service
@Transactional
public class RoleManager {
	
	private SimpleHibernateTemplate<TRoles, String> roleDao;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		roleDao = new SimpleHibernateTemplate<TRoles, String>(sessionFactory, TRoles.class);
	}
	
	@Transactional(readOnly = true)
	public TRoles getRole(String id) {
		return roleDao.get(id);
	}
	
	
}
