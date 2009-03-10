package com.yanpeng.ssweb.dao;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.yanpeng.core.dao.jdbc.SimpleJdbcTemplate;

@SuppressWarnings("unchecked")
public class JdbcDao extends SimpleJdbcTemplate{

	public JdbcDao(DataSource dataSource) {
		super(dataSource);
	}
	
	/**
	 * 根据sql语句，返回对象集合
	 * @param sql语句(参数用冒号加参数名，例如select * from tb where id=:id)
	 * @param clazz类型
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象集合
	 */
	public List find(String sql,Class clazz,Map parameters){
		return super.find(sql,clazz,parameters);
	}
	
	/**
	 * 根据sql语句，返回对象
	 * @param sql语句(参数用冒号加参数名，例如select * from tb where id=:id)
	 * @param clazz类型
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public Object findForObject(String sql,Class clazz,Map parameters){
		return super.findForObject(sql, clazz, parameters);
	}
	
	/**
	 * 根据sql语句，返回数值型返回结果
	 * @param sql语句(参数用冒号加参数名，例如select count(*) from tb where id=:id)
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public long findForLong(String sql,Map parameters){
		return super.findForLong(sql, parameters);
	}
	
	/**
	 * 根据sql语句，返回Map对象,对于某些项目来说，没有准备Bean对象，则可以使用Map代替Key为字段名,value为值
	 * @param sql语句(参数用冒号加参数名，例如select count(*) from tb where id=:id)
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public Map findForMap(String sql,Map parameters){
		return super.findForMap(sql, parameters);
	}
	
	/**
	 * 根据sql语句，返回Map对象集合
	 * @see findForMap
	 * @param sql语句(参数用冒号加参数名，例如select count(*) from tb where id=:id)
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public List<Map<String,Object>> findForListMap(String sql,Map parameters){
		return super.findForListMap(sql, parameters);
	}
	
	/**
	 * 执行insert，update，delete等操作<br>
	 * 例如insert into users (name,login_name,password) values(:name,:loginName,:password)<br>
	 * 参数用冒号,参数为bean的属性名
	 * @param sql
	 * @param bean
	 */
	public int executeForObject(String sql,Object bean){
		return super.executeForObject(sql, bean);
	}

	/**
	 * 执行insert，update，delete等操作<br>
	 * 例如insert into users (name,login_name,password) values(:name,:login_name,:password)<br>
	 * 参数用冒号,参数为Map的key名
	 * @param sql
	 * @param parameters
	 */
	public int executeForMap(String sql,Map parameters){
		return super.executeForMap(sql, parameters);
	}
	
	
}
