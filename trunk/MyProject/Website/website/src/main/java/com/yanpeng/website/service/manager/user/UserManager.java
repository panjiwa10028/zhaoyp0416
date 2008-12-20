package com.yanpeng.website.service.manager.user;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.orm.hibernate.SimpleHibernateTemplate;

import com.yanpeng.website.bean.entity.TGroups;
import com.yanpeng.website.bean.entity.TUsers;
import com.yanpeng.website.service.exception.ServiceException;

/**
 * 
 * @author yanpeng
 *
 */
@Service
@Transactional
public class UserManager {
	
	private SimpleHibernateTemplate<TUsers, String> userDao;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		userDao = new SimpleHibernateTemplate<TUsers, String>(sessionFactory, TUsers.class);
	}
	
	@Transactional(readOnly = true)
	public TUsers getUser(String id){
		return userDao.get(id);
	}
	
	@Transactional(readOnly = true)
	public Page<TUsers> getAllUsers(Page<TUsers> page) {
		return userDao.findAll(page);
	}
	
	@Transactional(readOnly = true)
	public TUsers getUserByName(String name) {
		return userDao.findUniqueByProperty("name", name);
	}
	
	@Transactional(readOnly = true)
	public TUsers getUserByLoginName(String loginName) {
		return userDao.findUniqueByProperty("loginName", loginName);
	}
	
	@Transactional(readOnly = true)
	public boolean isLoginNameUnique(String loginName, String orgLoginName) {
		return userDao.isPropertyUnique("loginName", loginName, orgLoginName);
	}
	
	public void saveUser(TUsers user) {
		userDao.save(user);
	}
	
	public void deleteUser(String id) {
		if (id.equals("0")){
			throw new ServiceException("不能删除超级用户");
		}
		TUsers user = userDao.get(id);
		userDao.delete(user);
	}

}
