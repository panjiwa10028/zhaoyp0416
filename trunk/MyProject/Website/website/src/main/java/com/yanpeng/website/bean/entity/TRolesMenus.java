package com.yanpeng.website.bean.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * TRolesMenus entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_roles_menus", catalog = "website")
public class TRolesMenus implements java.io.Serializable {

	// Fields

	private TRolesMenusId id;

	// Constructors

	/** default constructor */
	public TRolesMenus() {
	}

	/** full constructor */
	public TRolesMenus(TRolesMenusId id) {
		this.id = id;
	}

	// Property accessors
	@EmbeddedId
	@AttributeOverrides( {
			@AttributeOverride(name = "roleId", column = @Column(name = "role_id", nullable = false, length = 36)),
			@AttributeOverride(name = "menuId", column = @Column(name = "menu_id", nullable = false, length = 36)) })
	public TRolesMenusId getId() {
		return this.id;
	}

	public void setId(TRolesMenusId id) {
		this.id = id;
	}

}