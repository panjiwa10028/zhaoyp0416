package com.yanpeng.ssweb.entity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Menus entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "menus", catalog = "myweb", uniqueConstraints = {
		@UniqueConstraint(columnNames = "name"),
		@UniqueConstraint(columnNames = "display_name") })
public class Menus extends BaseEntity implements java.io.Serializable {

	// Fields

	private Menus menus;
	private String name;
	private String displayName;
	private String url;
	private String sort;
	private Integer disabled;
	private Date updateDate;
	private Set<Roles> roleses = new LinkedHashSet<Roles>(0);
	private Set<Menus> menuses = new LinkedHashSet<Menus>(0);

	// Constructors

	/** default constructor */
	public Menus() {
	}

	

	// Property accessors
	

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id", unique = true, nullable = false, insertable = false, updatable = false)
	public Menus getMenus() {
		return this.menus;
	}

	public void setMenus(Menus menus) {
		this.menus = menus;
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

	@Column(name = "url", length = 500)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "sort", length = 100)
	public String getSort() {
		return this.sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	@Column(name = "disabled")
	public Integer getDisabled() {
		return this.disabled;
	}

	public void setDisabled(Integer disabled) {
		this.disabled = disabled;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_date", length = 19)
	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "menuses")
	public Set<Roles> getRoleses() {
		return this.roleses;
	}

	public void setRoleses(Set<Roles> roleses) {
		this.roleses = roleses;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "menuses")
	public Set<Menus> getMenuses() {
		return this.menuses;
	}

	public void setMenuses(Set<Menus> menuses) {
		this.menuses = menuses;
	}

}