package com.yanpeng.ssweb.entity;

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
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * Menus entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "menus", catalog = "myweb", uniqueConstraints = { @UniqueConstraint(columnNames = "name"),
		@UniqueConstraint(columnNames = "display_name") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Menus extends BaseEntity implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 982653934337815041L;
	private Menus menus;
	private String name;
	private String displayName;
	private String path;
	private String sort;
	private Integer isDisabled;
	private Set<Roles> roleses = new LinkedHashSet<Roles>(0);
	private Set<Menus> menuses = new LinkedHashSet<Menus>(0);

	private Long parentId;

	// Constructors

	/** default constructor */
	public Menus() {
	}

	// Property accessors

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id", unique = true, nullable = false, insertable = false, updatable = false)
	public Menus getMenus() {
		return menus;
	}

	public void setMenus(Menus menus) {
		this.menus = menus;
	}

	@Column(name = "name", unique = true, nullable = false, length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "display_name", unique = true, nullable = false, length = 100)
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Column(name = "path", length = 500)
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Column(name = "sort", length = 100)
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	@Column(name = "isDisabled")
	public Integer getIsDisabled() {
		return isDisabled;
	}

	public void setIsDisabled(Integer isDisabled) {
		this.isDisabled = isDisabled;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "menuses", fetch = FetchType.LAZY)
	public Set<Roles> getRoleses() {
		return roleses;
	}

	public void setRoleses(Set<Roles> roleses) {
		this.roleses = roleses;
	}

	@OneToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "menus", fetch = FetchType.LAZY)
	public Set<Menus> getMenuses() {
		return menuses;
	}

	public void setMenuses(Set<Menus> menuses) {
		this.menuses = menuses;
	}

	@Column(name = "parent_id")
	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

}