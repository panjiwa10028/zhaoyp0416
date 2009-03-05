package com.yanpeng.core.dao.hibernate;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.transform.ResultTransformer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

import com.yanpeng.core.utils.ReflectionUtils;

/**
 * Hibernate的范型基类.
 * 
 * 可以在service类中直接创建使用.也可以继承出DAO子类,在多个Service类中共享DAO操作.
 * 参考Spring2.5自带的Petlinc例子,取消了HibernateTemplate,直接使用Hibernate原生API.
 * 通过Hibernate的sessionFactory.getCurrentSession()获得session,.
 * 
 * @param <T> DAO操作的对象类型
 * @param <PK> 主键类型
 * 
 * @author calvin
 */
@SuppressWarnings("unchecked")
public class SimpleHibernateTemplate<T, PK extends Serializable> {

	protected Logger logger = LoggerFactory.getLogger(getClass());

	protected SessionFactory sessionFactory;

	protected Class<T> entityClass;

	public SimpleHibernateTemplate(final SessionFactory sessionFactory, final Class<T> entityClass) {
		this.sessionFactory = sessionFactory;
		this.entityClass = entityClass;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void save(final T entity) {
		Assert.notNull(entity);
		getSession().saveOrUpdate(entity);
		logger.debug("save entity: {}", entity);
	}

	public void delete(final T entity) {
		Assert.notNull(entity);
		getSession().delete(entity);
		logger.debug("delete entity: {}", entity);
	}

	public void delete(final PK id) {
		Assert.notNull(id);
		delete(get(id));
	}

	public List<T> findAll() {
		return findByCriteria();
	}

	public Page<T> findAll(final Page<T> page) {
		return findByCriteria(page);
	}

	/**
	 * 按id获取对象.
	 */
	public T get(final PK id) {
		return (T) getSession().load(entityClass, id);
	}

	/**
	 * 按属性查找对象列表.
	 */
	public List<T> findByProperty(final String propertyName, final Object value) {
		Assert.hasText(propertyName);
		return createCriteria(Restrictions.eq(propertyName, value)).list();
	}

	/**
	 * 按属性查找唯一对象.
	 */
	public T findUniqueByProperty(final String propertyName, final Object value) {
		Assert.hasText(propertyName);
		return (T) createCriteria(Restrictions.eq(propertyName, value)).uniqueResult();
	}

	/**
	 * 按HQL查询对象列表.
	 * 
	 * @param hql hql语句
	 * @param values 数量可变的参数
	 */
	public List find(final String hql, final Object... values) {
		return createQuery(hql, values).list();
	}

	/**
	 * 按HQL分页查询.
	 * 不支持自动获取总结果数,需用户另行执行查询.
	 * 
	 * @param page 分页参数.仅包括pageSize 和firstResult,忽略其他参数.
	 * @param hql hql语句.
	 * @param values 数量可变的查询参数.
	 * 
	 * @return 分页查询结果,附带结果列表及所有查询时的参数.
	 */
	public Page<T> find(final Page<T> page, final String hql, final Object... values) {
		Assert.notNull(page);

		if (page.isAutoCount()) {
			logger.warn("HQL查询暂不支持自动获取总结果数,hql语句为{}", hql);
		}
		Query q = createQuery(hql, values);
		if (page.isFirstSetted()) {
			q.setFirstResult(page.getFirst());
		}
		if (page.isPageSizeSetted()) {
			q.setMaxResults(page.getPageSize());
		}
		page.setResult(q.list());
		return page;
	}

	/**
	 * 按HQL查询唯一对象.
	 */
	public Object findUnique(final String hql, final Object... values) {
		return createQuery(hql, values).uniqueResult();
	}

	/**
	 * 按HQL查询Integer类型结果. 
	 */
	public Integer findInt(final String hql, final Object... values) {
		return (Integer) findUnique(hql, values);
	}

	/**
	 * 按HQL查询Long类型结果. 
	 */
	public Long findLong(final String hql, final Object... values) {
		return (Long) findUnique(hql, values);
	}

	/**
	 * 按Criterion查询对象列表.
	 * 
	 * @param criterion 数量可变的Criterion.
	 */
	public List<T> findByCriteria(final Criterion... criterion) {
		return createCriteria(criterion).list();
	}

	/**
	 * 按Criterion分页查询.
	 * 
	 * @param page 分页参数.包括pageSize、firstResult、orderBy、asc、autoCount.
	 *             autoCount指定是否动态获取总结果数.         
	 * @param criterion 数量可变的Criterion.
	 * @return 分页查询结果.附带结果列表及所有查询时的参数.
	 */
	public Page<T> findByCriteria(final Page page, final Criterion... criterion) {
		Assert.notNull(page);

		Criteria c = createCriteria(criterion);

		if (page.isAutoCount()) {
			page.setTotalCount(countQueryResult(page, c));
		}
		if (page.isFirstSetted()) {
			c.setFirstResult(page.getFirst());
		}
		if (page.isPageSizeSetted()) {
			c.setMaxResults(page.getPageSize());
		}

		if (page.isOrderBySetted()) {
			if (page.getOrder().equals(Page.ASC)) {
				c.addOrder(Order.asc(page.getOrderBy()));
			} else {
				c.addOrder(Order.desc(page.getOrderBy()));
			}
		}

		page.setResult(c.list());
		return page;
	}

	/**
	 * 根据查询HQL与参数列表创建Query对象,辅助函数.
	 */
	public Query createQuery(final String queryString, final Object... values) {
		Assert.hasText(queryString);
		Query queryObject = getSession().createQuery(queryString);
		if (values != null) {
			for (int i = 0; i < values.length; i++) {
				queryObject.setParameter(i, values[i]);
			}
		}
		return queryObject;
	}

	/**
	 * 根据Criterion条件创建Criteria,辅助函数.
	 */
	public Criteria createCriteria(final Criterion... criterions) {
		Criteria criteria = getSession().createCriteria(entityClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}

	/**
	 * 判断对象的属性值在数据库内是否唯一.
	 * 
	 * 在修改对象的情景下,如果属性新修改的值(value)等于属性原来的值(orgValue)则不作比较.
	 * 相对于SS2里那种以对象ID作为第3个参数查找数据库中原属性值的做法，以orgValue做第3个参数的做法侧重于从页面上发出Ajax判断请求的场景.
	 */
	public boolean isPropertyUnique(final String propertyName, final Object newValue, final Object orgValue) {
		if (newValue == null || newValue.equals(orgValue))
			return true;

		Object object = findUniqueByProperty(propertyName, newValue);
		return (object == null);
	}

	/**
	 * 执行count查询获得本次查询所能获得的对象总数.
	 * 
	 * @return page对象中的totalCount属性将赋值.
	 */
	protected int countQueryResult(final Page<T> page, final Criteria c) {
		CriteriaImpl impl = (CriteriaImpl) c;

		// 先把Projection、ResultTransformer、OrderBy取出来,清空三者后再执行Count操作
		Projection projection = impl.getProjection();
		ResultTransformer transformer = impl.getResultTransformer();

		List<CriteriaImpl.OrderEntry> orderEntries = null;
		try {
			orderEntries = (List) ReflectionUtils.getFieldValue(impl, "orderEntries");
			ReflectionUtils.setFieldValue(impl, "orderEntries", new ArrayList());
		} catch (Exception e) {
			logger.error("不可能抛出的异常:{}", e.getMessage());
		}

		// 执行Count查询
		int totalCount = (Integer) c.setProjection(Projections.rowCount()).uniqueResult();

		// 将之前的Projection和OrderBy条件重新设回去
		c.setProjection(projection);

		if (projection == null) {
			c.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		}
		if (transformer != null) {
			c.setResultTransformer(transformer);
		}

		try {
			ReflectionUtils.setFieldValue(impl, "orderEntries", orderEntries);
		} catch (Exception e) {
			logger.error("不可能抛出的异常:{}", e.getMessage());
		}

		return totalCount;
	}
}