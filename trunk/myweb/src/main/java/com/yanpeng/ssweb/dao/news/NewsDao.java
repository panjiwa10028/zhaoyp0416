package com.yanpeng.ssweb.dao.news;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.entity.Users;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class NewsDao extends HibernateDao<News, String> {


}
