package com.yanpeng.ssweb.service.menu;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.Menus;

/**
 * UserManager的集成测试用例.
 * 
 * 调用实际的DAO类进行操作,默认在操作后进行回滚.
 * 
 * @author calvin
 */
public class MenuManagerTest extends SpringTransactionalTestCase {

	@Autowired
	private MenuManager menuManager;

	public void testFindFirstLevelMenus() {
		List<Menus> list = menuManager.findFirstLevelMenusNotId(null);
		Assert.assertNotNull(list);
	}

	public void testFindMenusByRoleIds() {
		Collection<Long> ids = new ArrayList<Long>();
		ids.add(new Long(1));
		List<Menus> list = menuManager.findMenusByRoleIds(ids);
		Assert.assertNotNull(list);
	}

	public void testIsNameUnique() {
		String name = "fd";
		boolean condition = menuManager.isNameUnique(name, "");
		Assert.assertTrue(condition);
	}

	public void testFindSubMenus() {
		//		List<Menus> list = menuManager.findFirstLevelMenus();
		//		Assert.assertNotNull(list);
	}
}