package com.yanpeng.ssweb.service.menu;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
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
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 菜单管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class MenuManager extends EntityManager<Menus, String> {

	// 统一定义所有HQL

	private final Logger logger = LoggerFactory.getLogger(MenuManager.class);

	@Autowired
	private MenuDao menuDao;
	
	@Override
	protected MenuDao getEntityDao() {
		return menuDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	@Transactional(readOnly = true)
	public Menus getMenuById(String id) {
		return menuDao.get(id);
	}

	@Transactional(readOnly = true)
	public Page<Menus> getAllMenus(Page<Menus> page) {
		return menuDao.getAll(page);
	}

	public void saveMenu(Menus menu) {
		menuDao.save(menu);
	}
	
	@Transactional(readOnly = true)
	public List<Menus> findMenusByRoleIds(Collection<String> ids) {		
		return menuDao.findByRoleIds(ids);
		
	}
	public void deleteMenus(Collection<String> ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("1")) {
			logger.warn("不能删除系统菜单", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除系统菜单");
		}
		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			Menus menu = menuDao.get(id);
			if(menu != null) {
				menuDao.delete(menu);
			}else {
				logger.warn("ID=[" + id + "]的菜单不存在，无法删除");
			}
			
		}
		
	}
	
	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return menuDao.isNameUnique(name, orgName);
	}
	
	@Transactional(readOnly = true)
	public List<Menus> findFirstLevelMenus() {
		return menuDao.findFirstLevel();
	}
	
	@Transactional(readOnly = true)
	public List<Menus> findSubMenus() {
		return menuDao.findSub();
	}

	
}
