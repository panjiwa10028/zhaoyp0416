package com.yanpeng.ssweb.service.group;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.Groups;

/**
 * UserManager的集成测试用例.
 * 
 * 调用实际的DAO类进行操作,默认在操作后进行回滚.
 * 
 * @author calvin
 */
public class GroupManagerTest extends SpringTransactionalTestCase {

	@Autowired
	private GroupManager groupManager;

	public void testGetAllGroup() {
		List<Groups> groupList = groupManager.getAllGroup();
		Assert.assertNotNull(groupList);
	}

	public void testGetAllGroupByPage() {
		Page<Groups> page = new Page<Groups>(5);
		page = groupManager.getAllGroup(page);
		Assert.assertEquals(1, page.getResult().size());
	}

	public void testIsNameUnique() {
		String name = "ffff";
		boolean returnValue = groupManager.isNameUnique(name, "");
		Assert.assertTrue(returnValue);
	}

	public void testDeleteByIds() {
		Collection<String> ids = new ArrayList<String>();
		ids.add("402888342037bf16012037d59c310003");
		groupManager.deleteGroups(ids);
	}

	public void testSaveGroup() {
		Groups group = new Groups();
		group = groupManager.getGroupById("40288834203bc07a01203bc370af0001");
		//		group.setName("name");
		groupManager.saveGroup(group);
		Assert.assertNotNull(group.getId());
	}
}