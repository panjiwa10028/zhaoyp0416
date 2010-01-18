package com.yanpeng.ssweb.service.user;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.core.security.springsecurity.SpringSecurityUtils;
import com.yanpeng.core.utils.BaseCodeUtils;
import com.yanpeng.ssweb.dao.role.RoleDao;
import com.yanpeng.ssweb.dao.user.UserDao;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 用户管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class UserManager extends EntityManager<Users, Long> {

	private final Logger logger = LoggerFactory.getLogger(UserManager.class);

	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	@Transactional(readOnly = true)
	public Users getUser(Long id) {
		return userDao.get(id);
	}

	@Transactional(readOnly = true)
	public Page<Users> search(Page<Users> page, final List<PropertyFilter> filters) {
		return userDao.find(page, filters);
	}

	public void saveUser(Users user) {
		userDao.save(user);
	}

	public void saveUser(Users user, Collection<Long> ids) {
		if (ids != null) {
			List<Roles> list = roleDao.find(Restrictions.in("id", ids));
			Set<Roles> set = new LinkedHashSet<Roles>(list);
			user.setRoleses(set);
		}

		String psw = BaseCodeUtils.getMd5PasswordEncoder(user.getPassword(), user.getLoginName());
		user.setPassword(psw);
		userDao.save(user);
	}

	public void deleteUser(Long id) {
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
		return userDao.getByLoginName(loginName);
	}

	/**
	 * 检查用户名是否唯一.
	 *
	 * @return loginName重复返回false.
	 */
	@Transactional(readOnly = true)
	public boolean isLoginNameUnique(String loginName, String orgLoginName) {
		return userDao.isLoginNameUnique(loginName, orgLoginName);
	}

	public void deleteUsers(Collection<String> ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("1")) {
			logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}
		for (String id : ids) {
			Long delId = Long.parseLong(id);
			Users user = userDao.get(delId);
			if (user != null) {
				userDao.delete(user);
			} else {
				logger.warn("ID=[" + id + "]的用户不存在，无法删除");
			}

		}

	}

}
