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
 * 整个User模块的业务逻辑Facade类.
 
 * 组合User,Role,Authority三者的DAO,DAO均直接使用泛型的SimpleHibernateTemplate.
 * 使用Spring annotation定义依赖注入和事务管理.
 * 
 * @author calvin
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
	public List<Menus> findMenusByRoleIds(Collection<Serializable> ids) {
		StringBuffer strbf=new StringBuffer();
		for(Serializable pk:ids){
			if(pk instanceof String||pk instanceof Character){
				strbf.append("'"+pk+"',");
			}else{
				strbf.append(pk+",");
			}
		}
		String parms=strbf.substring(0, strbf.length()-1).toString();
		return menuDao.createQuery("select m from Menus as m inner join m.roleses as r where r.id in ("+parms+") order by sort asc").list();
		
	}
	public void deleteMenus(Collection ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("1")) {
			logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}
		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			Menus menu = menuDao.get(id);
			menuDao.delete(menu);
		}
		
	}
	
	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return menuDao.isPropertyUnique("name", name, orgName);
	}
	
	@Transactional(readOnly = true)
	public List<Menus> findFirstLevelMenus() {
		return menuDao.findByCriteria(Restrictions.lt("parentId", "1"));
	}

	
}
