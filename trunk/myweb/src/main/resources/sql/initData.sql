ALTER TABLE groups DROP FOREIGN KEY FK_groups_groups;
ALTER TABLE menus DROP FOREIGN KEY FK_menus_menus;

insert into groups (id, name, parent_id, description, update_time, user_id)
values('0', 'root','-1','---',now(), '1');

insert into users(id, name, group_id, login_name, password, disabled, expired, locked, update_time, user_id)
values('1', 'administrator', '0', 'admin', 'ceb4f32325eda6142bd65215f4c0f371', 0, 0, 0, now(), '1');

insert into roles(id, name, description, update_time, user_id)
values('1', 'admin', 'admin', now(), '1');

insert into users_roles (user_id, role_id)
values('1', '1');

insert into permissions (id, name, display_name, path, update_time, user_id)
values('1', 'PER_ALL_ADMIN', '后台管理', '/admin/main.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('2', 'PER_VIEW_GROUP', '浏览用户组', '/admin/group/group.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('3', 'PER_SAVE_GROUP', '保存用户组', '/admin/group/group!save.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('4', 'PER_DELETE_GROUP', '删除用户组', '/admin/group/group!delete.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('5', 'PER_SAVE_USER', '保存用户', '/admin/user/user!save.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('6', 'PER_VIEW_USER', '浏览用户', '/admin/user/user.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('7', 'PER_DELETE_USER', '删除用户', '/admin/user/user!delete.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('8', 'PER_VIEW_NEWS', '浏览新闻', '/admin/news/news.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('9', 'PER_SAVE_NEWS', '保存新闻', '/admin/news/news!save.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('10', 'PER_DELETE_NEWS', '删除新闻', '/admin/news/news!delete.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('11', 'PER_VIEW_ROLE', '浏览角色', '/admin/role/role.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('12', 'PER_SAVE_ROLE', '保存角色', '/admin/role/role!save.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('13', 'PER_DELETE_ROLE', '删除角色', '/admin/role/role!delete.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('14', 'PER_VIEW_PERMISSION', '浏览权限', '/admin/permission/permission.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('15', 'PER_SAVE_PERMISSION', '保存权限', '/admin/permission/permission!save.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('16', 'PER_DELETE_PERMISSION', '删除权限', '/admin/permission/permission!delete.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('17', 'PER_VIEW_MENUS', '浏览菜单', '/admin/menu/menu.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('18', 'PER_SAVE_MENUS', '保存菜单', '/admin/menu/menu!save.action*', now(), '1');
insert into permissions (id, name, display_name, path, update_time, user_id)
values('19', 'PER_DELETE_MENUS', '删除菜单', '/admin/menu/menu!delete.action*', now(), '1');

insert into roles_permissions (role_id, permission_id)
values('1', '1');
insert into roles_permissions (role_id, permission_id)
values('1', '2');
insert into roles_permissions (role_id, permission_id)
values('1', '3');
insert into roles_permissions (role_id, permission_id)
values('1', '4');
insert into roles_permissions (role_id, permission_id)
values('1', '5');
insert into roles_permissions (role_id, permission_id)
values('1', '6');
insert into roles_permissions (role_id, permission_id)
values('1', '7');
insert into roles_permissions (role_id, permission_id)
values('1', '8');
insert into roles_permissions (role_id, permission_id)
values('1', '9');
insert into roles_permissions (role_id, permission_id)
values('1', '10');
insert into roles_permissions (role_id, permission_id)
values('1', '11');
insert into roles_permissions (role_id, permission_id)
values('1', '12');
insert into roles_permissions (role_id, permission_id)
values('1', '13');
insert into roles_permissions (role_id, permission_id)
values('1', '14');
insert into roles_permissions (role_id, permission_id)
values('1', '15');
insert into roles_permissions (role_id, permission_id)
values('1', '16');
insert into roles_permissions (role_id, permission_id)
values('1', '17');
insert into roles_permissions (role_id, permission_id)
values('1', '18');
insert into roles_permissions (role_id, permission_id)
values('1', '19');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('0', 'root', '-1', '---', '', '0_0', 0, now(), '1');
insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('1', 'ADMIN_SYSTEM', '0', '系统管理', '', '0_1', 0, now(), '1');
insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('2', 'ADMIN_USERS', '0', '用户管理', '', '0_2', 0, now(), '1');
insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('3', 'ADMIN_NEWS', '0', '新闻管理', '', '0_3', 0, now(), '1');
insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('4', 'ADMIN_MOCK1', '0', '占位1', '', '0_4', 0, now(), '1');
insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('5', 'ADMIN_MOCK2', '0', '占位2', '', '0_5', 0, now(), '1');
insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('6', 'ADMIN_MOCK3', '0', '占位3', '', '0_6', 0, now(), '1');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('10', 'ADMIN_SYSTEM_MENU', '1', '菜单设定', 'mainWorkArea.location=''menu/menu.action''', '0_1_', 0, now(), '1');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('11', 'ADMIN_USER_GROUP', '2', '用户组设定', 'mainWorkArea.location=''group/group.action''', '0_2_', 0, now(), '1');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('12', 'ADMIN_USER_USER', '2', '用户设定', 'mainWorkArea.location=''user/user.action''', '0_2_', 0, now(), '1');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('13', 'ADMIN_USER_ROLE', '2', '角色设定', 'mainWorkArea.location=''role/role.action''', '0_2_', 0, now(), '1');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('14', 'ADMIN_USER_PERMISSION', '2', '权限设定', 'mainWorkArea.location=''permission/permission.action''', '0_2_', 0, now(), '1');

insert into menus (id, name, parent_id, display_name, path, sort, disabled, update_time, user_id)
values('15', 'ADMIN_NEWS_ROLE', '3', '新闻设定', 'mainWorkArea.location=''news/news.action''', '0_3_', 0, now(), '1');


insert into roles_menus (role_id, menu_id)
values ('1', '1');
insert into roles_menus (role_id, menu_id)
values ('1', '2');
insert into roles_menus (role_id, menu_id)
values ('1', '3');
insert into roles_menus (role_id, menu_id)
values ('1', '10');
insert into roles_menus (role_id, menu_id)
values ('1', '11');
insert into roles_menus (role_id, menu_id)
values ('1', '12');
insert into roles_menus (role_id, menu_id)
values ('1', '13');
insert into roles_menus (role_id, menu_id)
values ('1', '14');
insert into roles_menus (role_id, menu_id)
values ('1', '15');

