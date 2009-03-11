package com.yanpeng.ssweb.dao;

import org.hibernate.SessionFactory;

import com.yanpeng.core.dao.lucene.SimpleLuceneTemplate;


public class LuceneTextQuery extends SimpleLuceneTemplate{

	public LuceneTextQuery(SessionFactory sessionFactory, Class entityClass) {
		super(sessionFactory, entityClass);
		// TODO Auto-generated constructor stub
	}

//	public LuceneTextQuery(SessionFactory sessionFactory) {
//		super(sessionFactory);
//	}

}
