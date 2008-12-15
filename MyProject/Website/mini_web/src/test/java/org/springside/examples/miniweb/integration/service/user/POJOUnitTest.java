package org.springside.examples.miniweb.integration.service.user;

import java.text.SimpleDateFormat;
import java.util.Date;
import junit.framework.TestCase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springside.examples.miniweb.service.user.UserManager;


public class POJOUnitTest extends TestCase {

	@Autowired
	private UserManager userManager;
	
	
	protected void setUp() throws Exception {
		String a = new String("applicationContext.xml");
		ApplicationContext contexta =   new ClassPathXmlApplicationContext(a);
		userManager = (UserManager) contexta.getBean("userManager");
		System.out.println(userManager.getAllRoles());
	}

	public void testEmployee() throws java.text.ParseException  {
		assertEquals(10, 10);
	}
  
}
