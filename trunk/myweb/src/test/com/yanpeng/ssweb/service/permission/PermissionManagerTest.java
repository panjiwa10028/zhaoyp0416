package com.yanpeng.ssweb.service.permission;

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
import com.yanpeng.core.security.SpringSecurityUtils;
import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.service.role.RoleManager;
/**
 * UserManager的集成测试用例.
 * 
 * 调用实际的DAO类进行操作,默认在操作后进行回滚.
 * 
 * @author calvin
 */
public class PermissionManagerTest extends SpringTransactionalTestCase {

	@Autowired
	private PermissionManager permissionManager;


	public void testGetAllPermissions() {
		List<Permissions> list = permissionManager.getAllPermissions();
		Assert.assertEquals(19, list.size());
	}
	
	public void testGetPermissionById() {
		String id = "1";
		Permissions per = permissionManager.getPermissionById(id);
		Assert.assertNotNull(per);
	}
	
	public void testSavePermission() {
		Permissions per = new Permissions();
		per.setName("per");
		per.setDisplayName("per");
		per.setPath("per");
		permissionManager.savePermission(per);
	}
	
	@ExpectedException(value = com.yanpeng.ssweb.exceptions.ServiceException.class)
	public void testDeletePermissions() {
		List<String> ids = new ArrayList<String>();
		ids.add("0");
		ids.add("1");
		permissionManager.deletePermissions(ids);
		
	}

	public void testIsNameUnique() {
		String name = "per";
		String orgName = "orgName";
		boolean condition = permissionManager.isNameUnique(name, orgName);
		Assert.assertTrue(condition);
	}
	
	public void testGetPermissions() {
		Page<Permissions> page = new Page<Permissions>(5);
		page = permissionManager.getPermissions(page);
		Assert.assertEquals(5, page.getResult().size());
	}
	
}