package com.yanpeng.ssweb.service.role;

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
import com.yanpeng.core.security.SpringSecurityUtils;
import com.yanpeng.core.utils.BaseCodeUtils;
import com.yanpeng.ssweb.dao.permission.PermissionDao;
import com.yanpeng.ssweb.dao.role.RoleDao;
import com.yanpeng.ssweb.dao.user.UserDao;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.News;
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
public class RoleManager extends EntityManager<Roles, String> {

	// 统一定义所有HQL

	
	private final Logger logger = LoggerFactory.getLogger(RoleManager.class);

	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private PermissionDao permissionDao;
	
	@Override
	protected RoleDao getEntityDao() {
		return roleDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	
	
	@Transactional(readOnly = true)
	public List<Roles> findRolesByIds(Collection<Serializable> ids) {
		return roleDao.findByCriteria(Restrictions.in("id", ids));
	}

	@Transactional(readOnly = true)
	public List<Roles> getAllRoles() {
		return roleDao.getAll();
	}
	
	@Transactional(readOnly = true)
	public Page<Roles> getAllRoles(Page<Roles> page) {
		return roleDao.getAll(page);
	}
	
	@Transactional(readOnly = true)
	public Roles getRoleById(String id) {
		return roleDao.get(id);
	}

	public void saveRole(Roles role, Collection<Serializable> ids) {
		if(ids != null ) {
			List<Permissions> list = permissionDao.findByCriteria(Restrictions.in("id", ids));
			Set<Permissions> set = new LinkedHashSet<Permissions>(list); 
			role.setPermissionses(set);
		}
		
		roleDao.save(role);
	}
	
	public void deleteRoles(Collection ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("1")) {
			logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}
		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			Roles role = roleDao.get(id);
			roleDao.delete(role);
		}
		
	}
	
	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return roleDao.isPropertyUnique("name", name, orgName);
	}
	
}
