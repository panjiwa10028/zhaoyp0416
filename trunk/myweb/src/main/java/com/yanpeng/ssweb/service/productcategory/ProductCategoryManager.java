package com.yanpeng.ssweb.service.productcategory;

import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.EntityManager;
import com.yanpeng.ssweb.dao.productcategory.ProductCategoryDao;
import com.yanpeng.ssweb.entity.ProductCategory;
import com.yanpeng.ssweb.exceptions.ServiceException;

/**
 *
 * @author Allen
 *
 */
@Service
@Transactional
public class ProductCategoryManager extends EntityManager<ProductCategory, Long> {

	private final Logger logger = LoggerFactory.getLogger(ProductCategoryManager.class);

	@Autowired
	private ProductCategoryDao productCategoryDao;

	@Override
	protected ProductCategoryDao getEntityDao() {
		// TODO Auto-generated method stub
		return productCategoryDao;
	}

	@Transactional(readOnly = true)
	public List<ProductCategory> getAllProductCategory() {
		return productCategoryDao.getAll();
	}


	@Transactional(readOnly = true)
	public Page<ProductCategory> getAllProductCategory(Page<ProductCategory> page) {
		return productCategoryDao.getAllByPage(page);
	}

	@Transactional(readOnly = true)
	public Page<ProductCategory> search(Page<ProductCategory> page, final List<PropertyFilter> filters) {
		return productCategoryDao.search(page, filters);
	}

	@Transactional(readOnly = true)
	public ProductCategory getProductCategoryById(Long id) {
		return productCategoryDao.get(id);
	}

	public void saveProductCategory(ProductCategory productCategory) {

		ProductCategory parentCategory = productCategoryDao.get(productCategory.getParentId());
		productCategory.setSort(parentCategory.getSort() + "-");
		productCategoryDao.save(productCategory);
		productCategory.setSort(productCategory.getSort() + productCategory.getId());
		productCategoryDao.save(productCategory);
	}

	public void deleteProductCategory(ProductCategory productCategory) {
		productCategoryDao.delete(productCategory);
	}

	@Transactional(readOnly = true)
	public boolean isNameUnique(String name, String orgName) {
		return productCategoryDao.isNameUnique(name, orgName);
	}

	public void deleteProductCategorys(Collection<String> ids) {
		//		if (ids.contains("0")) {
		//			logger.warn("不能删除root", SpringSecurityUtils.getCurrentUserName());
		//			throw new ServiceException("不能删除root");
		//		}

		for (String id : ids) {
			Long delId = Long.parseLong(id);
			ProductCategory productCategory = productCategoryDao.get(delId);
			if (productCategory != null) {
				if (productCategory.getProducts().size() > 0) {
					throw new ServiceException("删除失败。原因：" + productCategory.getName() + "类别下有新闻");
				}
				productCategoryDao.delete(productCategory);
			} else {
				logger.warn("ID=[" + id + "]的用户组不存在，无法删除");
			}

		}

	}

}
