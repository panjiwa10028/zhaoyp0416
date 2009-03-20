package com.yanpeng.ssweb.dao.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yanpeng.core.orm.hibernate.HibernateDao;
import com.yanpeng.ssweb.entity.Users;

/**
 * 继承于HibernateDao的范型DAO子类.
 * 
 * 用于集中定义HQL,封装DAO细节,在Service间解耦并共享DAO操作.
 * 
 * @author calvin
 */
//Spring DAO Bean的标识
@Repository
public class UserDao extends HibernateDao<Users, String> {

	// 统一定义所有用户的HQL.
	private static final String QUERY_BY_ROLE_HQL = "select user from User user join user.roles as role where role.name=?";

	public Users loadByLoginName(String userName) {
		return findUniqueByProperty("loginName", userName);
	}

	/**
	 * 查找拥有指定角色的用户.
	 */
	public List<Users> getUsersByRole(String roleName) {
		return find(QUERY_BY_ROLE_HQL, roleName);
	}
}
