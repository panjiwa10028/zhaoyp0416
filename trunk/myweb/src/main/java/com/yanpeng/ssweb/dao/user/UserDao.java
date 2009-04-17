package com.yanpeng.ssweb.dao.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Users;

/**
 * 用户DAO
 * @author Allen
 */
//Spring DAO Bean的标识
@Repository
public class UserDao extends HibernateDao<Users, String> {

	// 统一定义所有用户的HQL.
	private static final String QUERY_BY_ROLE_HQL = "select user from User user join user.roles as role where role.name=?";

	public Users getByLoginName(String loginName) {
		return findUniqueByProperty("loginName", loginName);
	}

	public boolean isLoginNameUnique(String newValue, String orgValue) {
		return isPropertyUnique("loginName", newValue, orgValue);
	}

	/**
	 * 查找拥有指定角色的用户.
	 */
	public List<Users> getUsersByRole(String roleName) {
		return find(QUERY_BY_ROLE_HQL, roleName);
	}
}
