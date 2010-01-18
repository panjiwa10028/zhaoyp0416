package com.yanpeng.ssweb.service.news;

import java.util.ArrayList;
import java.util.Collection;

import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.News;

/**
 * UserManager的集成测试用例.
 * 
 * 调用实际的DAO类进行操作,默认在操作后进行回滚.
 * 
 * @author calvin
 */
public class NewsManagerTest extends SpringTransactionalTestCase {

	@Autowired
	private NewsManager newsManager;

	public void testGetAllNews() {
		Page<News> page = new Page<News>(5);
		page = newsManager.getAllNews(page);
		Assert.assertEquals(1, page.getResult().size());
	}

	public void testGetNewsById() {
		Long id = new Long(0);
		newsManager.getNewsById(id);
	}

	public void testSaveNews() {
		News news = new News();
		news.setAuth("news");
		news.setTitle("news");
		news.setContent("news");
		newsManager.saveNews(news);
	}

	public void testRemoveNews() {
		Collection<String> ids = new ArrayList<String>();
		ids.add("0");
		newsManager.deleteNews(ids);
	}
}