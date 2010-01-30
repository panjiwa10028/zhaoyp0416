insert into company(id, info, service, training, job, contact, update_time, user_id)
values(1, ' ', ' ', ' ', ' ',' ', now(), 1);


insert into groups (id, name, parent_id, description, sort, update_time, user_id)
values(-1, 'root',-1,'---', '0', now(), 1);

insert into users(id, name, group_id, login_name, password, is_disabled, is_expired, is_locked, update_time, user_id)
values(1, 'administrator', -1, 'admin', 'ceb4f32325eda6142bd65215f4c0f371', 0, 0, 0, now(), 1);

insert into roles(id, name, description, update_time, user_id)
values(1, 'admin', 'admin', now(), 1);

insert into users_roles (user_id, role_id)
values(1, 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(1, 'PER_ALL_ADMIN', '后台管理　　', '/admin/*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(2, 'PER_VIEW_GROUP', '浏览用户组　', '/admin/group/group.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(3, 'PER_SAVE_GROUP', '保存用户组　', '/admin/group/group!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(4, 'PER_DELETE_GROUP', '删除用户组　', '/admin/group/group!delete.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(5, 'PER_SAVE_USER', '保存用户　　', '/admin/user/user!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(6, 'PER_VIEW_USER', '浏览用户　　', '/admin/user/user.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(7, 'PER_DELETE_USER', '删除用户　　', '/admin/user/user!delete.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(8, 'PER_VIEW_NEWS', '浏览新闻　　', '/admin/news/news.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(9, 'PER_SAVE_NEWS', '保存新闻　　', '/admin/news/news!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(10, 'PER_DELETE_NEWS', '删除新闻　　', '/admin/news/news!delete.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(11, 'PER_VIEW_ROLE', '浏览角色　　', '/admin/role/role.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(12, 'PER_SAVE_ROLE', '保存角色　　', '/admin/role/role!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(13, 'PER_DELETE_ROLE', '删除角色　　', '/admin/role/role!delete.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(14, 'PER_VIEW_PERMISSION', '浏览权限　　', '/admin/permission/permission.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(15, 'PER_SAVE_PERMISSION', '保存权限　　', '/admin/permission/permission!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(16, 'PER_DELETE_PERMISSION', '删除权限　　', '/admin/permission/permission!delete.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(17, 'PER_VIEW_MENUS', '浏览菜单　　', '/admin/menu/menu.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(18, 'PER_SAVE_MENUS', '保存菜单　　', '/admin/menu/menu!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(19, 'PER_DELETE_MENUS', '删除菜单　　', '/admin/menu/menu!delete.action*', now(), 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(20, 'PER_VIEW_NEWS_CATEGORY', '浏览新闻分类', '/admin/news/news-category.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(21, 'PER_SAVE_NEWS_CATEGORY', '保存新闻分类', '/admin/news/news-category!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(22, 'PER_DELETE_NEWS_CATEGORY', '删除新闻分类', '/admin/news/news-category!delete.action*', now(), 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(23, 'PER_VIEW_PRODUCT_CATEGORY', '浏览产品分类', '/admin/product/product-category.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(24, 'PER_SAVE_PRODUCT_CATEGORY', '保存产品分类', '/admin/product/product-category!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(25, 'PER_DELETE_PRODUCT_CATEGORY', '删除产品分类', '/admin/product/product-category!delete.action*', now(), 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(26, 'PER_VIEW_PRODUCT', '浏览产品　　', '/admin/product/product.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(27, 'PER_SAVE_PRODUCT', '保存产品　　', '/admin/product/product!save.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(28, 'PER_DELETE_PRODUCT', '删除产品　　', '/admin/product/product!delete.action*', now(), 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(29, 'PER_SET_COMPANY', '设定公司信息　', '/admin/company/company!save.action*', now(), 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(30, 'PER_SET_SYSTEM', '系统设定　', '/admin/system/system!save.action*', now(), 1);

insert into permissions (id, name, display_name, path, update_time, user_id)
values(31, 'PER_BACKUP_SYSTEM', '数据备份　', '/admin/system/system!backup.action*', now(), 1);
insert into permissions (id, name, display_name, path, update_time, user_id)
values(32, 'PER_RECOVER_SYSTEM', '数据恢复　', '/admin/system/system!recover.action*', now(), 1);

insert into roles_permissions (role_id, permission_id)
values(1, 1);
insert into roles_permissions (role_id, permission_id)
values(1, 2);
insert into roles_permissions (role_id, permission_id)
values(1, 3);
insert into roles_permissions (role_id, permission_id)
values(1, 4);
insert into roles_permissions (role_id, permission_id)
values(1, 5);
insert into roles_permissions (role_id, permission_id)
values(1, 6);
insert into roles_permissions (role_id, permission_id)
values(1, 7);
insert into roles_permissions (role_id, permission_id)
values(1, 8);
insert into roles_permissions (role_id, permission_id)
values(1, 9);
insert into roles_permissions (role_id, permission_id)
values(1, 10);
insert into roles_permissions (role_id, permission_id)
values(1, 11);
insert into roles_permissions (role_id, permission_id)
values(1, 12);
insert into roles_permissions (role_id, permission_id)
values(1, 13);
insert into roles_permissions (role_id, permission_id)
values(1, 14);
insert into roles_permissions (role_id, permission_id)
values(1, 15);
insert into roles_permissions (role_id, permission_id)
values(1, 16);
insert into roles_permissions (role_id, permission_id)
values(1, 17);
insert into roles_permissions (role_id, permission_id)
values(1, 18);
insert into roles_permissions (role_id, permission_id)
values(1, 19);

insert into roles_permissions (role_id, permission_id)
values(1, 20);
insert into roles_permissions (role_id, permission_id)
values(1, 21);
insert into roles_permissions (role_id, permission_id)
values(1, 22);
insert into roles_permissions (role_id, permission_id)
values(1, 23);
insert into roles_permissions (role_id, permission_id)
values(1, 24);
insert into roles_permissions (role_id, permission_id)
values(1, 25);
insert into roles_permissions (role_id, permission_id)
values(1, 26);
insert into roles_permissions (role_id, permission_id)
values(1, 27);
insert into roles_permissions (role_id, permission_id)
values(1, 28);
insert into roles_permissions (role_id, permission_id)
values(1, 29);

insert into roles_permissions (role_id, permission_id)
values(1, 30);
insert into roles_permissions (role_id, permission_id)
values(1, 31);
insert into roles_permissions (role_id, permission_id)
values(1, 32);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(-1, 'root', -1, '---', '', '0', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(1, 'ADMIN_SYSTEM', -1, '系统管理　　', '', '0-1', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(2, 'ADMIN_USERS', -1, '用户管理　　', '', '0-2', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(3, 'ADMIN_NEWS', -1, '新闻管理　　', '', '0-3', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(4, 'ADMIN_PRODUCT', -1, '产品管理　　', '', '0-4', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(5, 'ADMIN_COMPANY', -1, '信息管理　　', '', '0-5', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(6, 'ADMIN_MOCK3', -1, '占位3　　　', '', '0-6', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(10, 'ADMIN_SYSTEM_MENU', 1, '菜单设定　　', 'mainWorkArea.location=''menu/menu.action''', '0-1-10', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(11, 'ADMIN_USER_GROUP', 2, '用户组设定　', 'mainWorkArea.location=''group/group.action''', '0-2-11', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(12, 'ADMIN_USER_USER', 2, '用户设定　　', 'mainWorkArea.location=''user/user.action''', '0-2-12', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(13, 'ADMIN_USER_ROLE', 2, '角色设定　　', 'mainWorkArea.location=''role/role.action''', '0-2-13', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(14, 'ADMIN_USER_PERMISSION', 2, '权限设定　　', 'mainWorkArea.location=''permission/permission.action''', '0-2-14', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(15, 'ADMIN_NEWS_CATEGORY_ROLE', 3, '新闻类型设定', 'mainWorkArea.location=''news/news-category.action''', '0-3-15', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(16, 'ADMIN_NEWS_ROLE', 3, '新闻设定　　', 'mainWorkArea.location=''news/news.action''', '0-3-16', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(17, 'ADMIN_PRODUCT_CATEGORY_ROLE', 4, '产品类型设定', 'mainWorkArea.location=''product/product-category.action''', '0-4-17', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(18, 'ADMIN_PRODUCT_ROLE', 4, '产品设定　　', 'mainWorkArea.location=''product/product.action''', '0-4-18', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(19, 'ADMIN_COMPANY_SET', 5, '信息设定　　', 'mainWorkArea.location=''company/company!input.action?id=1''', '0-5-19', 0, now(), 1);

insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(20, 'ADMIN_SYSTEM_SET', 5, '系统设定　　', 'mainWorkArea.location=''system/system.action''', '0-1-20', 0, now(), 1);
insert into menus (id, name, parent_id, display_name, path, sort, is_disabled, update_time, user_id)
values(21, 'ADMIN_BACKUP_RECOVER_SET', 5, '数据备份/恢复', 'mainWorkArea.location=''system/system!backupAndRecover.action''', '0-1-21', 0, now(), 1);


insert into roles_menus (role_id, menu_id)
values (1, 1);
insert into roles_menus (role_id, menu_id)
values (1, 2);
insert into roles_menus (role_id, menu_id)
values (1, 3);
insert into roles_menus (role_id, menu_id)
values (1, 4);
insert into roles_menus (role_id, menu_id)
values (1, 5);
insert into roles_menus (role_id, menu_id)
values (1, 10);
insert into roles_menus (role_id, menu_id)
values (1, 11);
insert into roles_menus (role_id, menu_id)
values (1, 12);
insert into roles_menus (role_id, menu_id)
values (1, 13);
insert into roles_menus (role_id, menu_id)
values (1, 14);
insert into roles_menus (role_id, menu_id)
values (1, 15);
insert into roles_menus (role_id, menu_id)
values (1, 16);
insert into roles_menus (role_id, menu_id)
values (1, 17);
insert into roles_menus (role_id, menu_id)
values (1, 18);
insert into roles_menus (role_id, menu_id)
values (1, 19);
insert into roles_menus (role_id, menu_id)
values (1, 20);
insert into roles_menus (role_id, menu_id)
values (1, 21);

insert into news_category (id, name, parent_id, description, sort, update_time, user_id)
values(-1, 'root',-1,'---', '0', now(), 1);

insert into product_category (id, name, parent_id, description, sort, update_time, user_id)
values(-1, 'root',-1,'---', '0', now(), 1);