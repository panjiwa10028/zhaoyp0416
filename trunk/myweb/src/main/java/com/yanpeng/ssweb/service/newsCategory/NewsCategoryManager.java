package com.yanpeng.ssweb.service.newsCategory;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.ssweb.dao.newsCategory.NewsCategoryDao;
import com.yanpeng.ssweb.entity.NewsCategory;

/**
 *
 * @author Allen
 *
 */
@Service
@Transactional
public class NewsCategoryManager extends EntityManager<NewsCategory, String>{

	private final Logger logger = LoggerFactory.getLogger(NewsCategoryManager.class);
	
	@Autowired
	private NewsCategoryDao newsCategoryDao;

	@Override
	protected NewsCategoryDao getEntityDao() {
		// TODO Auto-generated method stub
		return newsCategoryDao;
	}
	
	@Transactional(readOnly = true)
	public List<NewsCategory> getAllNewsCategory() {
		return newsCategoryDao.getAll();
	}

}
