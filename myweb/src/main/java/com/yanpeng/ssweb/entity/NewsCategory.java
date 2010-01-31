package com.yanpeng.ssweb.entity;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * NewsCategory entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "news_category", catalog = "myweb")
public class NewsCategory extends BaseEntity implements java.io.Serializable {

	// Fields    

	/**
	 * 
	 */
	private static final long serialVersionUID = 2606838415704378401L;
	private String name;
	private String sort;
	private String description;
	private Set<News> newses = new LinkedHashSet<News>(0);
	private Long parentId;
	// Constructors

	/** default constructor */
	public NewsCategory() {
	}

	// Property accessors

	@Column(name = "name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", length = 65535)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@OneToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "newsCategory", fetch = FetchType.LAZY)
	public Set<News> getNewses() {
		return newses;
	}

	public void setNewses(Set<News> newses) {
		this.newses = newses;
	}
	@Column(name = "sort", length = 100)
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	@Column(name = "parent_id")
	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
}