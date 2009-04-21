package com.yanpeng.ssweb.entity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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

	/**
	 * 
	 */
	private static final long serialVersionUID = 5325416673214159517L;
	private NewsCategory newsCategory;
	private String title;
	private String auth;
	private String content;
	private Date date;
	private String htmlPath;
	private String picPath;
	private String htmlName;
	private String picName;
	private Set<NewsMessage> newsMessages = new LinkedHashSet<NewsMessage>(0);
	
	private String categoryId;

	// Constructors

	/** default constructor */
	public News() {
	}

	
	// Property accessors
	
	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinColumn(name = "category_id", insertable = false, updatable = false)
	public NewsCategory getNewsCategory() {
		return this.newsCategory;
	}

	public void setNewsCategory(NewsCategory newsCategory) {
		this.newsCategory = newsCategory;
	}

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

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date", length = 19)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	

	@Column(name = "html_path", length = 512)
	public String getHtmlPath() {
		return this.htmlPath;
	}

	public void setHtmlPath(String htmlPath) {
		this.htmlPath = htmlPath;
	}

	@Column(name = "pic_path", length = 512)
	public String getPicPath() {
		return this.picPath;
	}

	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}

	@Column(name = "html_name")
	public String getHtmlName() {
		return this.htmlName;
	}

	public void setHtmlName(String htmlName) {
		this.htmlName = htmlName;
	}

	@Column(name = "pic_name")
	public String getPicName() {
		return this.picName;
	}

	public void setPicName(String picName) {
		this.picName = picName;
	}

	

	@OneToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "news")
	public Set<NewsMessage> getNewsMessages() {
		return this.newsMessages;
	}

	public void setNewsMessages(Set<NewsMessage> newsMessages) {
		this.newsMessages = newsMessages;
	}

	@Column(name = "category_id")
	public String getCategoryId() {
		return categoryId;
	}


	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	
}