package com.yanpeng.ssweb.service.news;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.dao.hibernate.Page;
import com.yanpeng.core.dao.hibernate.SimpleHibernateTemplate;
import com.yanpeng.core.dao.lucene.SimpleLuceneTemplate;
import com.yanpeng.core.security.SpringSecurityUtils;
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
public class NewsManager {

	// 统一定义所有HQL

	
	private final Logger logger = LoggerFactory.getLogger(NewsManager.class);

	private SimpleHibernateTemplate<News, String> newsDao;
	private SimpleLuceneTemplate<News, String> newsLuceneDao;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		newsDao = new SimpleHibernateTemplate<News, String>(sessionFactory, News.class);
		newsLuceneDao = new SimpleLuceneTemplate<News, String>(sessionFactory, News.class);
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	
	
	@Transactional(readOnly=true)
	public Page getAllNews(Page page){
		return newsDao.findAll(page);
	}
	
	@Transactional(readOnly=true)
	public News getNewsById(String id){
		return (News)newsDao.get(id);
	}
	
	public void saveOrUpdateNews(News news){
		newsDao.saveOrUpdate(news);
	}

	@SuppressWarnings("unchecked")
	public void removeNews(News news){
		newsDao.delete(news);
	}
	
	public List<News> getText(String text){
		return newsLuceneDao.findByFullText(new String[]{"news_title","news_auth","news_content"}, text);
	}

	
}
