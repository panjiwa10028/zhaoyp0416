package com.yanpeng.ssweb.service.menu;

import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.ssweb.dao.menu.MenuDao;
import com.yanpeng.ssweb.entity.Menus;
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
		return menuDao.getAllByPage(page);
	}

	@Transactional(readOnly = true)
	public Page<Menus> search(Page<Menus> page, final List<PropertyFilter> filters) {
		return menuDao.search(page, filters);
	}

	public void saveMenu(Menus menu) {
		menuDao.save(menu);
	}

	@Transactional(readOnly = true)
	public List<Menus> findMenusByRoleIds(Collection<String> ids) {
		return menuDao.findByRoleIds(ids);

	}

	public void deleteMenus(Collection<String> ids) {

		//		if (ids.contains("1")) {
		//			logger.warn("不能删除系统菜单", SpringSecurityUtils.getCurrentUserName());
		//			throw new ServiceException("删除失败。原因：不能删除系统菜单");
		//		}
		for (String string : ids) {
			String id = string;
			Menus menu = menuDao.get(id);
			if (menu != null) {
				if (menu.getMenuses().size() > 0) {
					throw new ServiceException("删除菜单" + menu.getName() + "失败。原因：有下级菜单存在");
				}
				menuDao.delete(menu);
			} else {
				logger.warn("ID=[" + id + "]的菜单不存在，无法删除");
			}

		}

	}

	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return menuDao.isNameUnique(name, orgName);
	}

	@Transactional(readOnly = true)
	public boolean isDisplayNameUnique(String name, String orgName) {
		return menuDao.isDisplayNameUnique(name, orgName);
	}

	@Transactional(readOnly = true)
	public List<Menus> findFirstLevelMenusNotId(String id) {
		return menuDao.findFirstLevelNotId(id);
	}

	@Transactional(readOnly = true)
	public List<Menus> findSubMenus() {
		return menuDao.findSub();
	}

}
