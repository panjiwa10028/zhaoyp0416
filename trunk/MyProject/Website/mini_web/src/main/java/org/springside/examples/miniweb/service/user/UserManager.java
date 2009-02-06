package org.springside.examples.miniweb.service.user;

import java.util.List;

import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.examples.miniweb.entity.user.Authority;
import org.springside.examples.miniweb.entity.user.Role;
import org.springside.examples.miniweb.entity.user.User;
import org.springside.examples.miniweb.service.ServiceException;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.orm.hibernate.SimpleHibernateTemplate;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

/**
 * 整个User模块内的业务逻辑Facade类.
 
 * 组合User,Role,Authority三者的DAO.DAO均直接使用泛型的SimpleHibernateTemplate.
 * 使用Spring的@Service/@Autowired 进行IOC设置.
 * 使用Spring的@Transactional设置事务管理.
 * 
 * @author calvin
 */
@Service
@Transactional
public class UserManager {

	private static final String QUERY_ADMIN_HQL = "select user from User user join user.roles as role where role.name=?";

	private SimpleHibernateTemplate<User, Long> userDao;

	private SimpleHibernateTemplate<Role, Long> roleDao;

	private SimpleHibernateTemplate<Authority, Long> authDao;

	private final Logger logger = LoggerFactory.getLogger(UserManager.class);

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		userDao = new SimpleHibernateTemplate<User, Long>(sessionFactory, User.class);
		roleDao = new SimpleHibernateTemplate<Role, Long>(sessionFactory, Role.class);
		authDao = new SimpleHibernateTemplate<Authority, Long>(sessionFactory, Authority.class);
	}

	// 用户业务函数
	
	@Transactional(readOnly = true)
	public User getUser(Long id) {
		return userDao.get(id);
	}

	@Transactional(readOnly = true)
	public Page<User> getAllUsers(Page<User> page) {
		return userDao.findAll(page);
	}

	public void saveUser(User user) {
		userDao.save(user);
	}

	public void deleteUser(Long id) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (id == 1) {
			logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}

		User user = userDao.get(id);
		userDao.delete(user);
	}

	@Transactional(readOnly = true)
	public User getUserByLoginName(String loginName) {
		return userDao.findUniqueByProperty("loginName", loginName);
	}
	
	/**
	 * 查找拥有指定角色的用户.
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<User> getUserByRole(String roleName) {
		return userDao.find(QUERY_ADMIN_HQL,roleName);
	}

	/**
	 * 检查用户名是否唯一.
	 *
	 * @return loginName在数据库中唯一或等于orgLoginName时返回true.
	 */
	@Transactional(readOnly = true)
	public boolean isLoginNameUnique(String loginName, String orgLoginName) {
		return userDao.isPropertyUnique("loginName", loginName, orgLoginName);
	}

	// 角色业务函数
	
	@Transactional(readOnly = true)
	public List<Role> getAllRoles() {
		return roleDao.findAll();
	}

	@Transactional(readOnly = true)
	public Role getRole(Long id) {
		return roleDao.get(id);
	}

	public void saveRole(Role role) {
		roleDao.save(role);
	}

	public void deleteRole(Long id) {
		//为演示异常处理及操作员行为日志而故意抛出的异常.
		if (id == 1) {
			logger.warn("操作员{}尝试删除超级管理员用户角色", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员角色");
		}

		Role role = roleDao.get(id);
		roleDao.delete(role);
	}

	// 权限业务函数
	
	@Transactional(readOnly = true)
	public List<Authority> getAllAuths() {
		return authDao.findAll();
	}

	@Transactional(readOnly = true)
	public Authority getAuthority(Long id) {
		return authDao.get(id);
	}
}
