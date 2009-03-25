package com.yanpeng.ssweb.entity;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * News entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "news", catalog = "myweb")
public class News extends BaseEntity implements java.io.Serializable {

	// Fields

	private String title;
	private String auth;
	private String content;
	private String picture;
	private Date date;
	
	
	// Constructors

	/** default constructor */
	public News() {
	}



	// Property accessors


	@Column(name = "title", length = 100)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "auth", length = 50)
	public String getAuth() {
		return this.auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	@Column(name = "content", length = 65535)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "picture")
	public String getPicture() {
		return this.picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date", length = 19)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}