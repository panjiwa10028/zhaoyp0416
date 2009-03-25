package com.yanpeng.ssweb.service.news;

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
import com.yanpeng.ssweb.dao.news.NewsDao;
import com.yanpeng.ssweb.dao.user.UserDao;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 * 新闻管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class NewsManager extends EntityManager<News, String> {

	// 统一定义所有HQL

	
	private final Logger logger = LoggerFactory.getLogger(NewsManager.class);

	@Autowired
	private NewsDao newsDao;
	
	@Override
	protected NewsDao getEntityDao() {
		return newsDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.
	
	
	@Transactional(readOnly=true)
	public Page<News> getAllNews(Page<News> page){
		return newsDao.getAll(page);
	}
	
	@Transactional(readOnly=true)
	public News getNewsById(String id){
		return (News)newsDao.get(id);
	}
	
	public void saveNews(News news){
		newsDao.save(news);
	}

	public void deleteNews(News news){
		newsDao.delete(news);
	}
	
	public void deleteNews(Collection<String> ids) {

		for(Iterator<String> it =  ids.iterator();it.hasNext();) {
			String id = (String) it.next();
			News news = newsDao.get(id);
			if(news != null) {
				newsDao.delete(news);
			}else {
				logger.warn("ID=[" + id + "]的新闻不存在，无法删除");
			}			
		}
		
	}
	
	
}
