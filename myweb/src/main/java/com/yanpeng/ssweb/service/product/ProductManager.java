package com.yanpeng.ssweb.service.product;

import java.io.File;
import java.util.Collection;
import java.util.List;

import org.aspectj.util.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.dao.product.ProductDao;
import com.yanpeng.ssweb.entity.Product;

/**
 * 新闻管理
 * 
 * @author Allen
 */
@Service
//默认将类中的所有函数纳入事务管理.
@Transactional
public class ProductManager extends EntityManager<Product, Long> {

	// 统一定义所有HQL

	private final Logger logger = LoggerFactory.getLogger(ProductManager.class);

	@Autowired
	private ProductDao productDao;

	@Override
	protected ProductDao getEntityDao() {
		return productDao;
	}

	// 用户业务函数

	//不更新数据库的函数重新定义readOnly属性以加强性能.

	@Transactional(readOnly = true)
	public Page<Product> getAllProduct(Page<Product> page) {
		return productDao.getAll(page);
	}

	@Transactional(readOnly = true)
	public Page<Product> search(Page<Product> page, final List<PropertyFilter> filters) {
		return productDao.find(page, filters);
	}

	@Transactional(readOnly = true)
	public Product getProductById(Long id) {
		return productDao.get(id);
	}

	public void saveProduct(Product product) {
		productDao.save(product);
	}

	public void deleteProduct(Product product) {
		productDao.delete(product);
	}

	public void deleteProducts(Collection<String> ids) {
		String path = Struts2Utils.getRequest().getRealPath("");
		for (String id : ids) {
			Long delId = Long.parseLong(id);
			Product product = productDao.get(delId);
			if (product != null) {

				String oldPic = path + product.getPicPath() + File.separator + product.getPicName();
				FileUtil.deleteContents(new File(oldPic));
				String oldHtml = path + product.getHtmlPath() + File.separator + product.getHtmlName();
				FileUtil.deleteContents(new File(oldHtml));
				productDao.delete(product);
			} else {
				logger.warn("ID=[" + id + "]的产品不存在，无法删除");
			}
		}

	}

}
