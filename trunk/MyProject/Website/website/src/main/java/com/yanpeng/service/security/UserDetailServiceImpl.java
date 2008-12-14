package com.yanpeng.service.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.dao.DataAccessException;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;

import com.yanpeng.entity.TPermissions;
import com.yanpeng.entity.TRoles;
import com.yanpeng.entity.TUsers;
import com.yanpeng.service.manager.user.UserManager;

/**
 * 实现SpringSecurity的UserDetailsService接口,获取用户Detail信息.
 * 
 * @author calvin
 */
public class UserDetailServiceImpl implements UserDetailsService {

	private UserManager userManager;

	public UserDetails loadUserByUsername(String loginName) throws UsernameNotFoundException, DataAccessException {
		TUsers user = userManager.getUserByLoginName(loginName);
		if (user == null){
			throw new UsernameNotFoundException(loginName + " 不存在");
		}			

		List<GrantedAuthority> permissionList = new ArrayList<GrantedAuthority>();

		for (TRoles role : user.getTRoleses()) {
			for (TPermissions permission : role.getTPermissionses()) {
				permissionList.add(new GrantedAuthorityImpl(permission.getName()));
			}
		}

		// 目前在mini-web的User类中没有enabled, accountNonExpired,credentialsNonExpired, accountNonLocked等属性
		// 暂时全部设为true,在需要时才添加这些属性.
		org.springframework.security.userdetails.User userdetail = new org.springframework.security.userdetails.User(
				user.getLoginName(), user.getPassword(), user.getEnabled(), user.getExpired(), true, user.getLocked(), permissionList
						.toArray(new GrantedAuthority[permissionList.size()]));

		return userdetail;
	}

	@Required
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}
}
