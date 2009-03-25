package com.yanpeng.ssweb.service.news;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Temporal;

import org.apache.commons.lang.RandomStringUtils;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.ExpectedException;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.service.role.RoleManager;
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


	public void testGetAllNews(){
		Page<News> page = new Page<News>(5);
		page = newsManager.getAllNews(page);
		Assert.assertEquals(1, page.getResult().size());
	}
	
	public void testGetNewsById(){
		String id = "0";
		newsManager.getNewsById(id);
	}
	
	public void testSaveNews(){
		News news = new News();
		news.setAuth("news");
		news.setTitle("news");
		news.setContent("news");
		newsManager.saveNews(news);
	}

	public void testRemoveNews(){
		Collection<String> ids = new ArrayList<String>();
		ids.add("0");
		newsManager.deleteNews(ids);
	}
}