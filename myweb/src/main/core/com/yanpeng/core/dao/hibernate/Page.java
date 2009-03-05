package com.yanpeng.core.dao.hibernate;

import java.util.List;

import org.apache.commons.lang.StringUtils;

/**
 * 封装分页查询的参数与结果.
 * 
 * 扩展提示:如果需要有多个排序字段,可扩展orderBy2,order2字段并修改SimpleHibernateTemplate中做相应修改.
 * 
 * @param <T> Page中记录的类型.
 * 
 * @author calvin
 */
public class Page<T> {
	public static final String ASC = "asc"; //升序
	public static final String DESC = "desc"; //降序

	// 查询参数变量

	private int pageNo = 1;
	private int pageSize = -1;
	private String orderBy = null; //仅在Criterion查询时有效
	private String order = ASC; //仅在Criterion查询时有效
	private boolean autoCount = false; //查询对象时是否自动另外执行count查询获取总记录数,仅在Criterion查询时有效.

	// 返回结果变量

	private List<T> result = null;
	private int totalCount = -1;

	// 构造函数

	public Page() {
	}

	public Page(final int pageSize) {
		this.pageSize = pageSize;
	}

	public Page(final int pageSize, final boolean autoCount) {
		this.pageSize = pageSize;
		this.autoCount = autoCount;
	}

	// 查询参数相关函数

	/**
	 * 获得当前页的页号,序号从1开始,默认为1.
	 */
	public int getPageNo() {
		return pageNo;
	}

	/**
	 * 设置当前页的页号,序号从1开始.
	 */
	public void setPageNo(final int pageNo) {
		this.pageNo = pageNo;
	}

	/**
	 * 获得每页的记录数量,无默认值,值小于1时为未设置.
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * 设置每页的记录数量,参数值小于1时为不设置.
	 */
	public void setPageSize(final int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 是否已设置每页的记录数量.
	 */
	public boolean isPageSizeSetted() {
		return pageSize > 0;
	}

	/**
	* 根据pageNo和pageSize计算当前页第一条记录在总结果集中的位置,序号从0开始.
	*/
	public int getFirst() {
		if (pageNo < 1 || pageSize < 1)
			return -1;
		else
			return ((pageNo - 1) * pageSize);
	}

	/**
	 * 是否已设置第一条记录记录在总结果集中的位置.
	 */
	public boolean isFirstSetted() {
		return (pageNo > 0 && pageSize > 0);
	}

	/**
	 * 获得排序字段,无默认值,仅在Criterion查询时有效.
	 */
	public String getOrderBy() {
		return orderBy;
	}

	/**
	 * 设置排序字段,仅在Criterion查询时有效.
	 */
	public void setOrderBy(final String orderBy) {
		this.orderBy = orderBy;
	}

	/**
	 * 是否已设置排序字段,仅在Criterion查询时有效.
	 */
	public boolean isOrderBySetted() {
		return StringUtils.isNotBlank(orderBy);
	}

	/**
	 * 获得排序方向,默认为asc,仅在Criterion查询时有效.
	 */
	public String getOrder() {
		return order;
	}

	/**
	 * 设置排序方式向,仅在Criterion查询时有效.
	 * 
	 * @param order 可选值为desc或asc.
	 */
	public void setOrder(final String order) {
		if (ASC.equalsIgnoreCase(order) || DESC.equalsIgnoreCase(order)) {
			this.order = order.toLowerCase();
		} else
			throw new IllegalArgumentException("Order should be 'desc' or 'asc'");
	}

	/**
	 * 取得分页参数的组合字符串.
	 * 组合字符串方便参数的传递,格式为pageNo|orderBy|order.
	 */
	public String getPageParam() {
		return getPageNo() + "|" + StringUtils.defaultString(getOrderBy()) + "|" + getOrder();
	}

	/**
	 * 设置分页参数的组合字符串.
	 * 组合字符串方便参数的传递,格式为pageNo|orderBy|order.
	 */
	public void setPageParam(String pageParam) {

		if (StringUtils.isBlank(pageParam))
			return;

		String[] params = StringUtils.splitPreserveAllTokens(pageParam, '|');

		if (StringUtils.isNumeric(params[0])) {
			setPageNo(Integer.valueOf(params[0]));
		}

		if (StringUtils.isNotBlank(params[1])) {
			setOrderBy(params[1]);
		}

		if (StringUtils.isNotBlank(params[2])) {
			setOrder(params[2]);
		}
	}

	/**
	 * 查询对象时是否自动另外执行count查询获取总记录数,默认为false,仅在Criterion查询时有效.
	 */
	public boolean isAutoCount() {
		return autoCount;
	}

	public void setAutoCount(final boolean autoCount) {
		this.autoCount = autoCount;
	}

	// 返回结果函数//

	/**
	 * 取得页内的记录列表.
	 */
	public List<T> getResult() {
		return result;
	}

	public void setResult(final List<T> result) {
		this.result = result;
	}

	/**
	 * 取得总记录数.
	 */
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(final int totalCount) {
		this.totalCount = totalCount;
	}

	/**
	 * 计算总页数.
	 */
	public int getTotalPages() {
		if (totalCount == -1)
			return -1;

		int count = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			count++;
		}
		return count;
	}

	/**
	 * 取得倒转的排序方向.
	 */
	public String getInverseOrder() {
		if (order.endsWith(DESC))
			return ASC;
		else
			return DESC;
	}

	/**
	 * 是否还有下一页.
	 */
	public boolean isHasNext() {
		return (pageNo + 1 <= getTotalPages());
	}

	/**
	 * 取得下页的页号,序号从1开始.
	 */
	public int getNextPage() {
		if (isHasNext())
			return pageNo + 1;
		else
			return pageNo;
	}

	/**
	 * 是否还有上一页. 
	 */
	public boolean isHasPre() {
		return (pageNo - 1 >= 1);
	}

	/**
	 * 取得上页的页号,序号从1开始.
	 */
	public int getPrePage() {
		if (isHasPre())
			return pageNo - 1;
		else
			return pageNo;
	}
}
