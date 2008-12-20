package com.yanpeng.website.service.manager.group;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.orm.hibernate.SimpleHibernateTemplate;
import com.yanpeng.website.service.exception.ServiceException;

import com.yanpeng.website.bean.entity.TGroups;

/**
 * 
 * @author yanpeng
 *
 */
@Service
@Transactional
public class GroupManager {
	
	private SimpleHibernateTemplate<TGroups, Long> groupDao;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		groupDao = new SimpleHibernateTemplate<TGroups, Long>(sessionFactory, TGroups.class);
	}
	
	@Transactional(readOnly = true)
	public TGroups getGroup(Long id){
		return groupDao.get(id);
	}
	
	@Transactional(readOnly = true)
	public Page<TGroups> getAllGroups(Page<TGroups> page) {
		return groupDao.findAll(page);
	}
	
	@Transactional(readOnly = true)
	public TGroups getUserByName(String name) {
		return groupDao.findUniqueByProperty("NAME", name);
	}
	
	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return groupDao.isPropertyUnique("NAME", name, orgName);
	}
	
	public void saveGroup(TGroups user) {
		groupDao.save(user);
	}
	
	public void deleteGroup(Long id) {
		if (id == 0){
			throw new ServiceException("不能删除超级用户");
		}
		TGroups group = groupDao.get(id);
		groupDao.delete(group);
	}

}
