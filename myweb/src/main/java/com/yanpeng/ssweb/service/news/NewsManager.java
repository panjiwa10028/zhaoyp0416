package com.yanpeng.ssweb.service.news;

import java.io.File;
import java.util.Collection;
import java.util.List;

import org.aspectj.util.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.dao.news.NewsDao;
import com.yanpeng.ssweb.entity.News;

/**
 * 新闻管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class NewsManager extends EntityManager<News, Long> {

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

	@Transactional(readOnly = true)
	public Page<News> getAllNews(Page<News> page) {
		return newsDao.getAll(page);
	}
	
	@Transactional(readOnly = true)
	public Page<News> getPic(Page<News> page) {
		return newsDao.getPicByPage(page);
	}
	@Transactional(readOnly = true)
	public List<News> getFindByIds(Collection ids) {
		return newsDao.findBy("id", ids, "IN");
	}
	
	public List<News> getFindByPic() {
		return newsDao.findBy("picName", "", "NOTEQ");
	}

	@Transactional(readOnly = true)
	public Page<News> search(Page<News> page, final List<PropertyFilter> filters) {
		return newsDao.find(page, filters);
	}

	@Transactional(readOnly = true)
	public News getNewsById(Long id) {
		return newsDao.get(id);
	}

	public void saveNews(News news) {
		newsDao.save(news);
	}

	public void deleteNews(News news) {
		newsDao.delete(news);
	}
	
	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return newsDao.isNameUnique(name, orgName);
	}
	
	public void deleteNews(Collection<String> ids) {
		String path = Struts2Utils.getRequest().getRealPath("");
		for (String id : ids) {
			Long delId = Long.parseLong(id);
			News news = newsDao.get(delId);
			if (news != null) {

				String oldPic = path + news.getPicPath() + File.separator + news.getPicName();
				FileUtil.deleteContents(new File(oldPic));
				String oldHtml = path + news.getHtmlPath() + File.separator + news.getHtmlName();
				FileUtil.deleteContents(new File(oldHtml));
				newsDao.delete(news);
			} else {
				logger.warn("ID=[" + id + "]的新闻不存在，无法删除");
			}
		}

	}

}
