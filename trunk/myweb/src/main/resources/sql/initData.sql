insert into groups (id, name, parent_id, description, update_date)
values('0', 'root','-1','root',now());

insert into users(id, name, group_id, login_name, password, disabled, expired, locked, update_date)
values('1', 'administrator', '0', 'admin', 'admin', 0, 0, 0, now());

insert into roles(id, name, description, update_date)
values('1', 'admin', 'admin', now());

insert into users_roles (user_id, role_id)
values('1', '1');

insert into permissions (id, name, display_name, path)
values('1', 'PER_SAVE_USER', '保存用户', '/system/user!save.action*');
insert into permissions (id, name, display_name, path)
values('2', 'PER_VIEW_USER', '浏览用户', '/system/user.action*');
insert into permissions (id, name, display_name, path)
values('3', 'PER_DELETE_USER', '删除用户', '/system/user!delete.action*');
insert into permissions (id, name, display_name, path)
values('4', 'PER_ALL_ADMIN', '后台管理', '/');

insert into roles_permissions (role_id, permission_id)
values('1', '1');
insert into roles_permissions (role_id, permission_id)
values('1', '2');
insert into roles_permissions (role_id, permission_id)
values('1', '3');
insert into roles_permissions (role_id, permission_id)
values('1', '4');





