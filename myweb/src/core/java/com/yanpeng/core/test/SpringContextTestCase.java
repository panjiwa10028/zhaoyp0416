package com.yanpeng.core.test;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit38.AbstractJUnit38SpringContextTests;

/**
 * Spring的支持依赖注入的JUnit 3.8 TestCase基类简写.
 * 
 * @author Allen
 */
//默认载入applicationContext.xml,子类中的@ContextConfiguration定义将合并父类的定义.
@ContextConfiguration(locations = { "/applicationContext.xml" })
public class SpringContextTestCase extends AbstractJUnit38SpringContextTests {
}
