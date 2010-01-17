package com.yanpeng.ssweb.service.newscategory;

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
import com.yanpeng.ssweb.dao.newscategory.NewsCategoryDao;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.NewsCategory;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 *
 * @author Allen
 *
 */
@Service
@Transactional
public class NewsCategoryManager extends EntityManager<NewsCategory, String> {

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


	@Transactional(readOnly = true)
	public Page<NewsCategory> getAllNewsCategory(Page<NewsCategory> page) {
		return newsCategoryDao.getAllByPage(page);
	}

	@Transactional(readOnly = true)
	public Page<NewsCategory> search(Page<NewsCategory> page, final List<PropertyFilter> filters) {
		return newsCategoryDao.search(page, filters);
	}

	@Transactional(readOnly = true)
	public NewsCategory getNewsCategoryById(String id) {
		return newsCategoryDao.get(id);
	}

	public void saveNewsCategory(NewsCategory newsCategory) {
		newsCategoryDao.save(newsCategory);
	}

	public void deleteNewsCategory(NewsCategory newsCategory) {
		newsCategoryDao.delete(newsCategory);
	}

	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return newsCategoryDao.isNameUnique(name, orgName);
	}

	public void deleteNewsCategorys(Collection<String> ids) {
		//		if (ids.contains("0")) {
		//			logger.warn("不能删除root", SpringSecurityUtils.getCurrentUserName());
		//			throw new ServiceException("不能删除root");
		//		}

		for (String string : ids) {
			String id = string;
			NewsCategory newsCategory = newsCategoryDao.get(id);
			if (newsCategory != null) {
				if (newsCategory.getNewses().size() > 0) {
					throw new ServiceException("删除失败。原因：" + newsCategory.getName() + "类别下有新闻");
				}
				newsCategoryDao.delete(newsCategory);
			} else {
				logger.warn("ID=[" + id + "]的用户组不存在，无法删除");
			}

		}

	}

}
