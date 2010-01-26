package com.yanpeng.ssweb.service.company;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.ssweb.dao.company.CompanyDao;
import com.yanpeng.ssweb.entity.Company;

/**
 * 用户组管理
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class CompanyManager extends EntityManager<Company, Long> {

	private final Logger logger = LoggerFactory.getLogger(CompanyManager.class);

	@Autowired
	private CompanyDao companyDao;

	@Override
	protected CompanyDao getEntityDao() {
		return companyDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.

	@Transactional(readOnly = true)
	public Company getCompanyById(Long id) {
		return companyDao.get(id);
	}

	public void saveCompany(Company company) {
		companyDao.save(company);
	}

	

}
