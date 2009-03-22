package com.yanpeng.ssweb.service.user;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;


import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.core.security.SpringSecurityUtils;
import com.yanpeng.core.utils.BaseCodeUtils;
import com.yanpeng.ssweb.dao.role.RoleDao;
import com.yanpeng.ssweb.dao.user.UserDao;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 整个User模块的业务逻辑Facade类.
 
 * 组合User,Role,Authority三者的DAO,DAO均直接使用泛型的SimpleHibernateTemplate.
 * 使用Spring annotation定义依赖注入和事务管理.
 * 
 * @author calvin
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class UserManager extends EntityManager<Users, String>{

	
	

	private final Logger logger = LoggerFactory.getLogger(UserManager.class);

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private RoleDao roleDao;
	
	@Override
	protected UserDao getEntityDao() {
		return userDao;
	}
	

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	@Transactional(readOnly = true)
	public Users getUser(String id) {
		return userDao.get(id);
	}

	@Transactional(readOnly = true)
	public Page<Users> getAllUsers(Page<Users> page) {
		return userDao.getAll(page);
	}

	public void saveUser(Users user) {
		userDao.save(user);
	}
	
	public void saveUser(Users user, Collection<Serializable> ids) {
		if(ids != null ) {
			List<Roles> list = roleDao.findByCriteria(Restrictions.in("id", ids));
			Set<Roles> set = new LinkedHashSet<Roles>(list); 
			user.setRoleses(set);
		}
		
		String psw=BaseCodeUtils.getMd5PasswordEncoder(user.getPassword(), user.getLoginName());
		user.setPassword(psw);
		userDao.save(user);
	}

	public void deleteUser(String id) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (id.equals("1")) {
			logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}

		Users user = userDao.get(id);
		userDao.delete(user);
	}

	@Transactional(readOnly = true)
	public Users getUserByLoginName(String loginName) {
		return userDao.findUniqueByProperty("loginName", loginName);
	}

	
	/**
	 * 检查用户名是否唯一.
	 *
	 * @return loginName重复返回false.
	 */
	@Transactional(readOnly = true)
	public boolean isLoginNameUnique(String loginName, String orgLoginName) {
		return userDao.isPropertyUnique("loginName", loginName, orgLoginName);
	}

	
	public void deleteUsers(Collection ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("1")) {
			logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}
		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			Users user = userDao.get(id);
			userDao.delete(user);
		}
		
	}

	
}
