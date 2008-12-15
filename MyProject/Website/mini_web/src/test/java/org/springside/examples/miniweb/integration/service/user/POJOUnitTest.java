package org.springside.examples.miniweb.integration.service.user;

import java.text.SimpleDateFormat;
import java.util.Date;
import junit.framework.TestCase;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit38.AbstractJUnit38SpringContextTests;
import org.springside.examples.miniweb.entity.user.User;
import org.springside.examples.miniweb.service.user.UserManager;
import org.springside.modules.test.SpringTransactionalTestCase;


public class POJOUnitTest extends  TestCase{

	@Autowired
	private UserManager userManager;
	
	protected void setUp() throws Exception {
//		String a = new String("applicationContext.xml");
//		ApplicationContext contexta =   new ClassPathXmlApplicationContext(a);
//		userManager = (UserManager) contexta.getBean("userManager");
		userManager = (UserManager) AppContextUtil.getInstance().getBean("userManager");
	}

	public void testCRUD() {
		//保存角色并验证.
		User entity = new User();
		// 因为LoginName要求唯一性，因此添加random字段。
		entity.setLoginName("tester" + RandomStringUtils.randomAlphabetic(5));
		entity.setName("foo");
		entity.setEmail("foo@bar.com");
		entity.setPassword("foo");
		userManager.saveUser(entity);
//		flush();
		assertNotNull(entity.getId());

		//删除角色并验证
		userManager.deleteUser(entity.getId());
//		flush();
	}
  
}
