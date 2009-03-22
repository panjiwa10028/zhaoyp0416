package com.yanpeng.ssweb.service.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.ExpectedException;

import com.yanpeng.core.test.SpringTransactionalTestCase;
import com.yanpeng.ssweb.entity.Groups;
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
public class UserManagerTest extends SpringTransactionalTestCase {

	@Autowired
	private UserManager userManager;
	@Autowired
	private GroupManager groupManager;


	public void testCRUD() {
		//保存角色并验证.
		Users entity = new Users();
		// 因为LoginName要求唯一性，因此添加random字段。
		entity.setLoginName("tester" + RandomStringUtils.randomAlphabetic(5));
		entity.setName("foo");
		entity.setPassword("foo");
		
		Groups gorup = groupManager.getGroupById("0");

		entity.setGroups(gorup);
		userManager.saveUser(entity);
		flush();
		Assert.assertNotNull(entity.getId());
		//删除角色并验证
		userManager.deleteUser(entity.getId());
		flush();
	}

	public void testUserRoles() {
		//保存带角色的用户并验证
		Users entity = new Users();
		entity.setLoginName("tester" + RandomStringUtils.randomAlphabetic(5));
		entity.setName("tester" + RandomStringUtils.randomAlphabetic(5));
		entity.setPassword("tester" + RandomStringUtils.randomAlphabetic(5));
		
//		List roleList = roleManager.getAllRoles();
//		for(Iterator roles=roleList.iterator(); roles.hasNext();) {
//			Roles r = (Roles) roles.next();
//			entity.getRoleses().add(r);
//		}
		Groups gorup = groupManager.getGroupById("0");
		entity.setGroups(gorup);
		List list = new ArrayList();
		list.add("1");
		list.add("2");
		userManager.saveUser(entity, list);
//		userManager.saveUser(entity);
		flush();
		entity = userManager.getUser(entity.getId());
		Assert.assertEquals(2, entity.getRoleses().size());
//
//		//删除角色并验证
//		for(Iterator roles=roleList.iterator(); roles.hasNext();) {
//			Roles r = (Roles) roles.next();
//			entity.getRoleses().remove(r);
//		}
//		
//		flush();
//		entity = userManager.getUser(entity.getId());
//		assertEquals(0, entity.getRoleses().size());
	}

	//期望抛出ConstraintViolationException的异常.
	@ExpectedException(value = org.hibernate.exception.ConstraintViolationException.class)
	public void testSavenEntityNotUnique() {
		Users entity = new Users();
		entity.setLoginName("admin");
		userManager.saveUser(entity);
		flush();
	}

	public void testLoginNameUnique() {
		String loginName = "tt";
		String orgLoginName = "";
		boolean returnValue = userManager.isLoginNameUnique(loginName, orgLoginName);
		Assert.assertEquals(true, returnValue);
	}
	
}