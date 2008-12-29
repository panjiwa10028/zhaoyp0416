package com.yanpeng.website.bean.entity;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * TMenus entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_menus", catalog = "website", uniqueConstraints = {
		@UniqueConstraint(columnNames = "name"),
		@UniqueConstraint(columnNames = "display_name") })
public class TMenus implements java.io.Serializable {

	// Fields

	private String id;
	private TMenus TMenus;
	private String name;
	private String displayName;
	private String url;
	private String sort;
	private Integer disabled;
	private Set<TRoles> TRoleses = new HashSet<TRoles>(0);
	private Set<TMenus> TMenuses = new HashSet<TMenus>(0);

	// Constructors

	/** default constructor */
	public TMenus() {
	}

	/** minimal constructor */
	public TMenus(String id, TMenus TMenus, String name, String displayName,
			String url, String sort, Integer disabled) {
		this.id = id;
		this.TMenus = TMenus;
		this.name = name;
		this.displayName = displayName;
		this.url = url;
		this.sort = sort;
		this.disabled = disabled;
	}

	/** full constructor */
	public TMenus(String id, TMenus TMenus, String name, String displayName,
			String url, String sort, Integer disabled, Set<TRoles> TRoleses,
			Set<TMenus> TMenuses) {
		this.id = id;
		this.TMenus = TMenus;
		this.name = name;
		this.displayName = displayName;
		this.url = url;
		this.sort = sort;
		this.disabled = disabled;
		this.TRoleses = TRoleses;
		this.TMenuses = TMenuses;
	}

	// Property accessors
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 36)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id", nullable = false)
	public TMenus getTMenus() {
		return this.TMenus;
	}

	public void setTMenus(TMenus TMenus) {
		this.TMenus = TMenus;
	}

	@Column(name = "name", unique = true, nullable = false, length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "display_name", unique = true, nullable = false, length = 100)
	public String getDisplayName() {
		return this.displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Column(name = "url", nullable = false, length = 500)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "sort", nullable = false, length = 100)
	public String getSort() {
		return this.sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	@Column(name = "disabled", nullable = false)
	public Integer getDisabled() {
		return this.disabled;
	}

	public void setDisabled(Integer disabled) {
		this.disabled = disabled;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TMenuses")
	public Set<TRoles> getTRoleses() {
		return this.TRoleses;
	}

	public void setTRoleses(Set<TRoles> TRoleses) {
		this.TRoleses = TRoleses;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TMenus")
	public Set<TMenus> getTMenuses() {
		return this.TMenuses;
	}

	public void setTMenuses(Set<TMenus> TMenuses) {
		this.TMenuses = TMenuses;
	}

}