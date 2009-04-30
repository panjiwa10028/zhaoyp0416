package com.yanpeng.core.test;

import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit38.AbstractJUnit38SpringContextTests;

/**
 * Spring的支持Test annotation扩展的JUnit3.8 TestCase基类简写,但不载入Spring AplicationContext.
 * 
 * @author Allen
 */
@TestExecutionListeners(value = {}, inheritListeners = false)
public class SpringAnnotationTestCase extends AbstractJUnit38SpringContextTests {
}
