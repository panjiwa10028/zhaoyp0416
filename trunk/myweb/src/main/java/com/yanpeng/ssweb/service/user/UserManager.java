package com.yanpeng.ssweb.service.user;

import java.util.Collection;
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

import com.yanpeng.core.dao.hibernate.Page;
import com.yanpeng.core.dao.hibernate.SimpleHibernateTemplate;
import com.yanpeng.core.security.SpringSecurityUtils;
import com.yanpeng.core.utils.BaseCodeUtils;
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
public class UserManager {

	// 统一定义所有HQL

	private static final String QUERY_ADMIN_HQL = "select user from Users user join user.roleses as role where role.name=?";

	private final Logger logger = LoggerFactory.getLogger(UserManager.class);

	private SimpleHibernateTemplate<Users, String> userDao;

	private SimpleHibernateTemplate<Roles, String> roleDao;

	private SimpleHibernateTemplate<Permissions, String> authDao;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		userDao = new SimpleHibernateTemplate<Users, String>(sessionFactory, Users.class);
		roleDao = new SimpleHibernateTemplate<Roles, String>(sessionFactory, Roles.class);
		authDao = new SimpleHibernateTemplate<Permissions, String>(sessionFactory, Permissions.class);
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	@Transactional(readOnly = true)
	public Users getUser(String id) {
		return userDao.get(id);
	}

	@Transactional(readOnly = true)
	public Page<Users> getAllUsers(Page<Users> page) {
		return userDao.findAll(page);
	}

	public void saveUser(Users user) {
		userDao.saveOrUpdate(user);
	}
	public void saveUser(Users user, Collection ids) {
		List<Roles> list = roleDao.findByCriteria(Restrictions.in("id", ids));
		Set set = new LinkedHashSet(list); 
		user.setRoleses(set);
		String psw=BaseCodeUtils.getMd5PasswordEncoder(user.getPassword(), user.getLoginName());
		user.setPassword(psw);
		userDao.saveOrUpdate(user);
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
	 * 查找拥有指定角色的用户.
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Users> getUserByRole(String roleName) {
		return userDao.find(QUERY_ADMIN_HQL, roleName);
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
	public List<Roles> getAllRoles() {
		return roleDao.findAll();
	}

	@Transactional(readOnly = true)
	public Roles getRole(String id) {
		return roleDao.get(id);
	}

	public void saveRole(Roles role) {
		roleDao.save(role);
	}

	public void deleteRole(String id) {
		//为演示异常处理及操作员行为日志而故意抛出的异常.
		if (id.equals("1")) {
			logger.warn("操作员{}尝试删除超级管理员用户角色", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员角色");
		}

		Roles role = roleDao.get(id);
		roleDao.delete(role);
	}

	// 权限业务函数

	@Transactional(readOnly = true)
	public List<Permissions> getAllResource() {
		return authDao.findAll();
	}

	@Transactional(readOnly = true)
	public Permissions getResource(String id) {
		return authDao.get(id);
	}
}
