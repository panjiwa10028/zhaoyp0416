package com.yanpeng.ssweb.service.group;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.dao.lucene.SimpleLuceneTemplate;
import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.core.security.SpringSecurityUtils;
import com.yanpeng.ssweb.dao.group.GroupDao;
import com.yanpeng.ssweb.dao.role.RoleDao;
import com.yanpeng.ssweb.entity.Groups;
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
public class GroupManager extends EntityManager<Groups, String> {

	// 统一定义所有HQL

	
	private final Logger logger = LoggerFactory.getLogger(GroupManager.class);

	@Autowired
	private GroupDao groupDao;
	
	@Override
	protected GroupDao getEntityDao() {
		return groupDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	
	@Transactional(readOnly=true)
	public List<Groups> getAllGroup(){
		return groupDao.findByCriteria(Restrictions.not(Restrictions.eq("id", "0")));
	}
	
	@Transactional(readOnly=true)
	public Page<Groups> getAllGroup(Page<Groups> page){		
		return groupDao.findByCriteria(page, Restrictions.not(Restrictions.eq("id", "0")));
	}
	
	@Transactional(readOnly=true)
	public Groups getGroupById(String id){
		return (Groups)groupDao.get(id);
	}
	
	public void saveGroup(Groups group){
		groupDao.save(group);
	}

	@SuppressWarnings("unchecked")
	public void removeGroup(Groups group){
		groupDao.delete(group);
	}
	

	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return groupDao.isPropertyUnique("name", name, orgName);
	}
	
	public void deleteGroups(Collection<String> ids) {
		//为演示异常处理及用户行为日志而故意抛出的异常.
		if (ids.contains("0")) {
			logger.warn("不能删除root组", SpringSecurityUtils.getCurrentUserName());
			throw new ServiceException("不能删除root组");
		}
		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			Groups group = groupDao.get(id);
			groupDao.delete(group);
		}
		
	}
	
	
}
