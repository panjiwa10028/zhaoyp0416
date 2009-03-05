package com.yanpeng.core.test;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit38.AbstractJUnit38SpringContextTests;

/**
 * Spring支持依赖注入的基于JUnit 3.8的基类的便捷简写.
 * 
 * 如果需要默认载入更多的applicatioContext.xml,在项目中重写本类.
 * 
 * @author calvin
 */
@ContextConfiguration(locations = { "/spring-base.xml" })
public class SpringTestCase extends AbstractJUnit38SpringContextTests {

}
