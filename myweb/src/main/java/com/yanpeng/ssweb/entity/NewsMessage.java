package com.yanpeng.ssweb.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * NewsMessage entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "news_message", catalog = "myweb")
public class NewsMessage extends BaseEntity implements java.io.Serializable {

	// Fields    

	/**
	 * 
	 */
	private static final long serialVersionUID = -3040641837508623346L;
	private News news;
	private String title;
	private String content;

	// Constructors

	/** default constructor */
	public NewsMessage() {
	}

	// Property accessors

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.LAZY)
	@JoinColumn(name = "news_id", nullable = false)
	public News getNews() {
		return news;
	}

	public void setNews(News news) {
		this.news = news;
	}

	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "content", length = 65535)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}