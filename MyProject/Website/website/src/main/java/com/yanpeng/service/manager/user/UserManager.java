package com.yanpeng.service.manager.user;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.orm.hibernate.SimpleHibernateTemplate;

import com.yanpeng.entity.TGroups;
import com.yanpeng.entity.TUsers;
import com.yanpeng.service.exception.ServiceException;

/**
 * 
 * @author yanpeng
 *
 */
@Service
@Transactional
public class UserManager {
	
	private SimpleHibernateTemplate<TUsers, Long> userDao;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		userDao = new SimpleHibernateTemplate<TUsers, Long>(sessionFactory, TUsers.class);
	}
	
	@Transactional(readOnly = true)
	public TUsers getUser(Long id){
		return userDao.get(id);
	}
	
	@Transactional(readOnly = true)
	public Page<TUsers> getAllUsers(Page<TUsers> page) {
		return userDao.findAll(page);
	}
	
	@Transactional(readOnly = true)
	public TUsers getUserByName(String name) {
		return userDao.findUniqueByProperty("NAME", name);
	}
	
	@Transactional(readOnly = true)
	public TUsers getUserByLoginName(String loginName) {
		return userDao.findUniqueByProperty("LOGIN_NAME", loginName);
	}
	
	@Transactional(readOnly = true)
	public boolean isLoginNameUnique(String loginName, String orgLoginName) {
		return userDao.isPropertyUnique("LOGIN_NAME", loginName, orgLoginName);
	}
	
	public void saveUser(TUsers user) {
		userDao.save(user);
	}
	
	public void deleteUser(Long id) {
		if (id == 0){
			throw new ServiceException("不能删除超级用户");
		}
		TUsers user = userDao.get(id);
		userDao.delete(user);
	}

}
