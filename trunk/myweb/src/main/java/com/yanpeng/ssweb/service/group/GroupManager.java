package com.yanpeng.ssweb.service.group;

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
import com.yanpeng.ssweb.dao.group.GroupDao;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 用户组管理
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class GroupManager extends EntityManager<Groups, String> {

	private final Logger logger = LoggerFactory.getLogger(GroupManager.class);

	@Autowired
	private GroupDao groupDao;

	@Override
	protected GroupDao getEntityDao() {
		return groupDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.

	@Transactional(readOnly = true)
	public List<Groups> getAllGroup() {
		return groupDao.getAll();
	}

	@Transactional(readOnly = true)
	public Page<Groups> getAllGroup(Page<Groups> page) {
		return groupDao.getAllByPage(page);
	}

	@Transactional(readOnly = true)
	public Page<Groups> search(Page<Groups> page, final List<PropertyFilter> filters) {
		return groupDao.search(page, filters);
	}

	@Transactional(readOnly = true)
	public Groups getGroupById(String id) {
		return groupDao.get(id);
	}

	public void saveGroup(Groups group) {
		groupDao.save(group);
	}

	public void deleteGroup(Groups group) {
		groupDao.delete(group);
	}

	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return groupDao.isNameUnique(name, orgName);
	}

	public void deleteGroups(Collection<String> ids) {
		//		if (ids.contains("0")) {
		//			logger.warn("不能删除root", SpringSecurityUtils.getCurrentUserName());
		//			throw new ServiceException("不能删除root");
		//		}

		for (String string : ids) {
			String id = string;
			Groups group = groupDao.get(id);
			if (group != null) {
				if (group.getUserses().size() > 0) {
					throw new ServiceException("删除失败。原因：" + group.getName() + "部门下有用户");
				}
				groupDao.delete(group);
			} else {
				logger.warn("ID=[" + id + "]的用户组不存在，无法删除");
			}

		}

	}

}
