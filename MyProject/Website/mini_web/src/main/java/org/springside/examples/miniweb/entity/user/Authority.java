package org.springside.examples.miniweb.entity.user;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springside.examples.miniweb.entity.IdEntity;

/**
 * 权限.
 * 
 * 使用JPA annotation定义ORM关系.
 * 使用Hibernate annotation定义缓存. 
 * 
 * @author calvin
 */
@Entity
@Table(name = "AUTHORITIES") //表名默认等于类名,不相同时需重新定义.
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY) //因Authority只会增加不会修改,使用只读缓存策略.
public class Authority extends IdEntity {

	private String name;

	private String displayName;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
