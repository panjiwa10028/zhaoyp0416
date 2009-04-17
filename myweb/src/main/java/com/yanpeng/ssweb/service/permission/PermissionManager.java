package com.yanpeng.ssweb.service.permission;

import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.ssweb.dao.permission.PermissionDao;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 权限管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class PermissionManager extends EntityManager<Permissions, String> {

	private final Logger logger = LoggerFactory.getLogger(PermissionManager.class);

	@Autowired
	private PermissionDao permissionsDao;

	@Override
	protected PermissionDao getEntityDao() {
		return permissionsDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.

	@Transactional(readOnly = true)
	public List<Permissions> getAllPermissions() {
		return permissionsDao.getAll();
	}

	@Transactional(readOnly = true)
	public Permissions getPermissionById(String id) {
		return permissionsDao.get(id);
	}

	public void savePermission(Permissions entity) {
		permissionsDao.save(entity);
	}

	public void deletePermissions(Collection<String> ids) {
		//		if (ids.contains("1")) {
		//			logger.warn("不能删除系统权限", SpringSecurityUtils.getCurrentUserName());
		//			throw new ServiceException("不能删除系统权限");
		//		}
		for (String string : ids) {
			String id = string;
			Permissions per = permissionsDao.get(id);
			if (per != null) {
				if (per.getRoleses().size() > 0) {
					throw new ServiceException("删除[" + per.getDisplayName() + "]权限失败。原因：还有拥有该权限的角色");
				}
				permissionsDao.delete(per);
			} else {
				logger.warn("ID=[" + id + "]的权限不存在，无法删除");
			}

		}
	}

	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return permissionsDao.isNameUnique(name, orgName);
	}

	@Transactional(readOnly = true)
	public boolean isDisplayNameUnique(String name, String orgName) {
		return permissionsDao.isDisplayNameUnique(name, orgName);
	}

	@Transactional(readOnly = true)
	public Page<Permissions> getPermissions(Page<Permissions> page) {
		return permissionsDao.getAll(page);
	}

}
