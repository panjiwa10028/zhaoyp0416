package com.yanpeng.ssweb.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;

@SuppressWarnings("unchecked")
public class JdbcGenericSupportDao {

	public JdbcDao jdbcDao;

	@Autowired
	public void setDataSource(DataSource dataSource) {
		jdbcDao = new JdbcDao(dataSource);
	}

}
