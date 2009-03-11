ALTER TABLE groups DROP FOREIGN KEY FK_groups_groups;
ALTER TABLE menus DROP FOREIGN KEY FK_menus_menus;

insert into groups (id, name, parent_id, description, update_date)
values('0', 'root','-1','root',now());

insert into users(id, name, group_id, login_name, password, disabled, expired, locked, update_date)
values('1', 'administrator', '0', 'admin', 'ceb4f32325eda6142bd65215f4c0f371', 0, 0, 0, now());

insert into roles(id, name, description, update_date)
values('1', 'admin', 'admin', now());
insert into roles(id, name, description, update_date)
values('2', 'user', 'user', now());

insert into users_roles (user_id, role_id)
values('1', '1');
insert into users_roles (user_id, role_id)
values('1', '2');

insert into permissions (id, name, display_name, path)
values('1', 'PER_SAVE_USER', '保存用户', '/admin/user/user!save.action*');
insert into permissions (id, name, display_name, path)
values('2', 'PER_VIEW_USER', '浏览用户', '/admin/user/user.action*');
insert into permissions (id, name, display_name, path)
values('3', 'PER_DELETE_USER', '删除用户', '/admin/user/user!delete.action*');
insert into permissions (id, name, display_name, path)
values('4', 'PER_ALL_ADMIN', '后台管理', '/admin/main.action*');
insert into permissions (id, name, display_name, path)
values('5', 'PER_VIEW_NEWS', '浏览新闻', '/admin/news/news.action*');
insert into permissions (id, name, display_name, path)
values('6', 'PER_SAVE_NEWS', '保存新闻', '/admin/news/news!save.action*');
insert into permissions (id, name, display_name, path)
values('7', 'PER_DELETE_NEWS', '删除新闻', '/admin/news/news!delete.action*');

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

insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('0', 'root', '-1', 'root', '', '0_0', 0);
insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('1', 'ADMIN_SYSTEM', '0', '系统管理', '', '0_1', 0);
insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('2', 'ADMIN_USERS', '0', '用户管理', '', '0_2', 0);
insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('3', 'ADMIN_NEWS', '0', '新闻管理', '', '0_3', 0);
insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('4', 'ADMIN_MOCK1', '0', '占位1', '', '0_4', 0);
insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('5', 'ADMIN_MOCK2', '0', '占位2', '', '0_5', 0);
insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('6', 'ADMIN_MOCK3', '0', '占位3', '', '0_6', 0);

insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('10', 'ADMIN_SYSTEM_MENU', '1', '菜单设定', 'mainWorkArea.location=''menu/menu.action''', '0_1_1', 0);

insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('11', 'ADMIN_USER_USER', '2', '用户设定', 'mainWorkArea.location=''user/user.action''', '0_2_1', 0);

insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('12', 'ADMIN_USER_ROLE', '2', '角色设定', 'mainWorkArea.location=''role/role.action''', '0_2_2', 0);

insert into menus (id, name, parent_id, display_name, url, sort, disabled)
values('13', 'ADMIN_NEWS_ROLE', '3', '新闻设定', 'mainWorkArea.location=''news/news.action''', '0_3_1', 0);


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

