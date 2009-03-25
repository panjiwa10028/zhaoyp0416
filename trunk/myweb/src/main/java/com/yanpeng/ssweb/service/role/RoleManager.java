package com.yanpeng.ssweb.service.role;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.core.security.SpringSecurityUtils;
import com.yanpeng.ssweb.dao.menu.MenuDao;
import com.yanpeng.ssweb.dao.permission.PermissionDao;
import com.yanpeng.ssweb.dao.role.RoleDao;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 角色管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class RoleManager extends EntityManager<Roles, String> {

	private final Logger logger = LoggerFactory.getLogger(RoleManager.class);

	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private PermissionDao permissionDao;
	
	@Autowired
	private MenuDao menuDao;
	
	@Override
	protected RoleDao getEntityDao() {
		return roleDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	
	
	@Transactional(readOnly = true)
	public List<Roles> findRolesByIds(Collection<String> ids) {
		return roleDao.findByIds(ids);
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

	public void saveRole(Roles role, Collection<String> ids, Collection<String> menuIds) {
		if(ids != null ) {
			List<Permissions> list = permissionDao.findByIds(ids);
			Set<Permissions> set = new LinkedHashSet<Permissions>(list); 
			role.setPermissionses(set);
			
			List<Menus> menuList = menuDao.findByIds(menuIds);
			Set<Menus> menuSet = new LinkedHashSet<Menus>(); 
			menuSet.addAll(menuList);
			for(Menus menu:menuList) {
				Menus m = menu.getMenus();
				if(!menuSet.contains(m)) {
					menuSet.add(menu.getMenus());
				}
			}
			
			role.setMenuses(menuSet);
		}
		
		roleDao.save(role);
	}
	
	public void deleteRoles(Collection<String> ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("1")) {
			logger.warn("不能删除系统角色", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除系统角色");
		}
		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			Roles role = roleDao.get(id);
			if(role != null) {
				roleDao.delete(role);
			}else {
				logger.warn("ID=[" + id + "]的角色不存在，无法删除");
			}
			
		}
		
	}
	
	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return roleDao.isNameUnique(name, orgName);
	}
	
}
