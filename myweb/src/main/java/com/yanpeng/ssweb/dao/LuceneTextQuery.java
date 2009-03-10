package com.yanpeng.ssweb.dao;

import org.hibernate.SessionFactory;

import com.yanpeng.core.dao.lucene.SimpleLuceneTemplate;


public class LuceneTextQuery extends SimpleLuceneTemplate{

	public LuceneTextQuery(SessionFactory sessionFactory) {
		super(sessionFactory);
	}

}
