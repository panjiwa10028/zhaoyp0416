package com.yanpeng.website.service.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.dao.DataAccessException;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;

import com.yanpeng.website.bean.entity.TPermissions;
import com.yanpeng.website.bean.entity.TRoles;
import com.yanpeng.website.bean.entity.TUsers;
import com.yanpeng.website.service.manager.user.UserManager;

/**
 * 实现SpringSecurity的UserDetailsService接口,获取用户Detail信息.
 * 
 * @author yanpeng
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
				user.getLoginName(), user.getPassword(), user.getDisabled().intValue()==0?true:false, user.getExpired()==0?true:false, true, user.getLocked()==0?true:false, permissionList
						.toArray(new GrantedAuthority[permissionList.size()]));

		return userdetail;
	}

	@Required
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}
}
