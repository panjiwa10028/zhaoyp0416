package com.yanpeng.ssweb.service.role;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;

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
		Collection ids = new ArrayList();
		ids.add("1");
		Collection menuIds = new ArrayList();
		menuIds.add("13");
		menuIds.add("12");
		menuIds.add("14");
		roleManager.saveRole(role, ids, menuIds);
	}
	
}