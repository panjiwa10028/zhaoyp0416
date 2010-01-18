package com.yanpeng.ssweb.service.role;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.ExpectedException;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.Roles;

/**
 * UserManager的集成测试用例.
 * 
 * 调用实际的DAO类进行操作,默认在操作后进行回滚.
 * 
 * @author calvin
 */
public class RoleManagerTest extends SpringTransactionalTestCase {

	@Autowired
	private RoleManager roleManager;

	public void testSaveRole() {
		Roles role = new Roles();
		role.setName("role");
		role.setDescription("");
		List<Long> ids = new ArrayList<Long>();
		ids.add(new Long(1));
		List<Long> menuIds = new ArrayList<Long>();
		menuIds.add(new Long(13));
		menuIds.add(new Long(12));
		menuIds.add(new Long(14));
		roleManager.saveRole(role, ids, menuIds);
	}

	public void testFindRolesByIds() {
		List<Long> ids = new ArrayList<Long>();
		ids.add(new Long(1));
		List<Roles> list = roleManager.findRolesByIds(ids);
		Assert.assertEquals(1, list.size());
	}

	public void testGetAllRoles() {
		List<Roles> list = roleManager.getAllRoles();
		Assert.assertEquals(1, list.size());
	}

	public void testGetAllRolesByPage() {
		Page<Roles> page = new Page<Roles>(5);
		page = roleManager.getAllRoles(page);
		Assert.assertEquals(5, page.getResult().size());
	}

	public void testGetRoleById() {
		Long id = new Long(1);
		Roles role = roleManager.getRoleById(id);
		Assert.assertNotNull(role);
	}

	@ExpectedException(value = com.yanpeng.ssweb.exceptions.ServiceException.class)
	public void testDeleteRoles() {
		List<String> ids = new ArrayList<String>();
		ids.add("1");
		ids.add("2");
		roleManager.deleteRoles(ids);

	}

	public void testIsNameUnique() {
		String name = "role";
		String orgName = "orgName";
		boolean condition = roleManager.isNameUnique(name, orgName);
		Assert.assertTrue(condition);
	}

}