package com.yanpeng.core.orm.hibernate;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.transform.ResultTransformer;
import org.springframework.util.Assert;

import com.yanpeng.core.orm.Page;
import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.PropertyFilter.MatchType;
import com.yanpeng.core.utils.ReflectionUtils;

/**
 * 封装SpringSide扩展功能的Hibernat泛型基类.
 * 
 * 扩展功能包括分页查询,按属性过滤条件列表查询.
 * 可在Service层直接使用,也可以扩展泛型DAO子类使用,见两个构造函数的注释.
 * 
 * @param <T> DAO操作的对象类型
 * @param <PK> 主键类型
 * 
 * @author Allen
 */
public class HibernateDao<T, PK extends Serializable> extends SimpleHibernateDao<T, PK> {
	/**
	 * 用于扩展的DAO子类使用的构造函数.
	 * 
	 * 通过子类的泛型定义取得对象类型Class.
	 * eg.
	 * public class UserDao extends HibernateDao<User, Long>{
	 * }
	 */
	public HibernateDao() {
		super();
	}

	/**
	 * 用于Service层直接使用HibernateDAO的构造函数.
	 * eg.
	 * HibernateDao<User, Long> userDao = new HibernateDao<User, Long>(sessionFactory, User.class);
	 */
	public HibernateDao(final SessionFactory sessionFactory, final Class<T> entityClass) {
		super(sessionFactory, entityClass);
	}

	// 分页查询函数 //

	/**
	 * 分页获取全部对象. 
	 */
	public Page<T> getAll(final Page<T> page) {
		return findByCriteria(page);
	}

	/**
	 * 按HQL分页查询.
	 * 不支持自动获取总结果数,需用户另行执行查询.
	 * 
	 * @param page 分页参数.仅支持pageSize 和firstResult,忽略其他参数.
	 * @param hql hql语句.
	 * @param values 数量可变的查询参数.
	 * 
	 * @return 分页查询结果,附带结果列表及所有查询时的参数.
	 */
	@SuppressWarnings("unchecked")
	public Page<T> find(final Page<T> page, final String hql, final Object... values) {
		Assert.notNull(page, "page不能为空");

		Query q = createQuery(hql, values);
		setPageParameter(q, page);
		List result = q.list();
		page.setResult(result);
		return page;
	}

	/**
	 * 按Criteria分页查询.
	 * 
	 * @param page 分页参数.支持pageSize、firstResult和orderBy、order、autoCount参数.
	 *             其中autoCount指定是否动态获取总结果数.         
	 * @param criterions 数量可变的Criterion.
	 * 
	 * @return 分页查询结果.附带结果列表及所有查询时的参数.
	 */
	@SuppressWarnings("unchecked")
	public Page<T> findByCriteria(final Page<T> page, final Criterion... criterions) {
		Assert.notNull(page, "page不能为空");

		Criteria c = createCriteria(criterions);

		if (page.isAutoCount()) {
			int totalCount = countCriteriaResult(c);
			page.setTotalCount(totalCount);
		}

		setPageParameter(c, page);
		List result = c.list();
		page.setResult(result);
		return page;
	}

	/**
	* 设置分页参数到Query对象,辅助函数.
	*/
	protected Query setPageParameter(final Query q, final Page<T> page) {
		q.setFirstResult(page.getFirst());
		q.setMaxResults(page.getPageSize());
		return q;
	}

	/**
	 * 设置分页参数到Criteria对象,辅助函数.
	 */
	protected Criteria setPageParameter(final Criteria c, final Page<T> page) {
		c.setFirstResult(page.getFirst());
		c.setMaxResults(page.getPageSize());

		if (page.isOrderBySetted()) {
			String[] orderByArray = StringUtils.split(page.getOrderBy(), ',');
			String[] orderArray = StringUtils.split(page.getOrder(), ',');

			Assert.isTrue(orderByArray.length == orderArray.length, "分页多重排序参数中,排序字段与排序方向的个数不相等");

			for (int i = 0; i < orderByArray.length; i++) {
				if (Page.ASC.equals(orderArray[i])) {
					c.addOrder(Order.asc(orderByArray[i]));
				} else {
					c.addOrder(Order.desc(orderByArray[i]));
				}
			}
		}
		return c;
	}

	/**
	 * 执行count查询获得本次Criteria查询所能获得的对象总数.
	 */
	@SuppressWarnings("unchecked")
	protected int countCriteriaResult(final Criteria c) {
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
		int totalCount = 0;
		try {
			totalCount = (Integer) c.setProjection(Projections.rowCount()).uniqueResult();
		} catch (Exception exx) {
			exx.printStackTrace();
		}

		// 将之前的Projection,ResultTransformer和OrderBy条件重新设回去
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

	// 属性条件查询函数 //

	/**
	 * 按属性查找对象列表,支持多种匹配方式.
	 * 
	 * @param matchType 目前支持的取值为"EQUAL"与"LIKE".
	 */
	public List<T> findBy(final String propertyName, final Object value, final String matchTypeStr) {
		MatchType matchType = Enum.valueOf(MatchType.class, matchTypeStr);
		Criterion criterion = buildPropertyCriterion(propertyName, value, matchType);
		return find(criterion);
	}

	/**
	 * 按属性过滤条件列表查找对象列表.
	 */
	public List<T> find(final List<PropertyFilter> filters) {
		Criterion[] criterions = buildFilterCriterions(filters);
		return find(criterions);
	}

	/**
	 * 按属性过滤条件列表分页查找对象.
	 */
	public Page<T> find(final Page<T> page, final List<PropertyFilter> filters) {
		Criterion[] criterions = buildFilterCriterions(filters);
		return findByCriteria(page, criterions);
	}

	/**
	 * 按属性条件列表创建Criterion数组,辅助函数.
	 */
	protected Criterion[] buildFilterCriterions(final List<PropertyFilter> filters) {
		List<Criterion> criterionList = new ArrayList<Criterion>();
		for (PropertyFilter filter : filters) {
			String propertyName = filter.getPropertyName();

			boolean multiProperty = StringUtils.contains(propertyName, PropertyFilter.OR_SEPARATOR);
			if (!multiProperty) { //properNameName中只有一个属性的情况.
				Criterion criterion = buildPropertyCriterion(propertyName, filter.getValue(), filter.getMatchType());
				criterionList.add(criterion);
			} else {//properName中包含多个属性的情况,进行or处理.
				Disjunction disjunction = Restrictions.disjunction();
				String[] params = StringUtils.split(propertyName, PropertyFilter.OR_SEPARATOR);

				for (String param : params) {
					Criterion criterion = buildPropertyCriterion(param, filter.getValue(), filter.getMatchType());
					disjunction.add(criterion);
				}
				criterionList.add(disjunction);
			}
		}
		return criterionList.toArray(new Criterion[criterionList.size()]);
	}

	/**
	 * 按属性条件参数创建Criterion,辅助函数.
	 */
	protected Criterion buildPropertyCriterion(final String propertyName, final Object value, final MatchType matchType) {
		Assert.hasText(propertyName, "propertyName不能为空");
		Criterion criterion = null;

		if (MatchType.EQ.equals(matchType)) {
			criterion = Restrictions.eq(propertyName, value);
		} else if (MatchType.LIKE.equals(matchType)) {
			criterion = Restrictions.like(propertyName, (String) value, MatchMode.ANYWHERE);
		} else if (MatchType.NOTEQ.equals(matchType)) {
			criterion = Restrictions.not(Restrictions.eq(propertyName, value));
		}else if (MatchType.IN.equals(matchType)) {
			criterion = Restrictions.in(propertyName, (Collection)value);
		}

		return criterion;
	}
}
