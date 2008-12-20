insert into t_groups (id, name, parent_id, description, modify_time)
values('0', 'root','-1','root',now());

insert into t_users(id, name, group_id, login_name, password, disabled, expired, locked, modify_time)
values(uuid(), 'administrator', '0', 'admin', 'admin', 0, 0, 0, now());

insert into t_roles(id, name, description, modify_time)
values(uuid(), 'admin', 'admin', now());

insert into t_users_roles (user_id, role_id)
(select id ,(select id from t_roles where name='admin') from t_users where login_name='admin');

insert into t_permissions (id, name, display_name)
values(uuid(), 'ROLE_SAVE_USER', '修改用户');
insert into t_permissions (id, name, display_name)
values(uuid(), 'ROLE_VIEW_USER', '浏览用户');
insert into t_permissions (id, name, display_name)
values(uuid(), 'ROLE_DELETE_USER', '删除用户');
insert into t_permissions (id, name, display_name)
values(uuid(), 'ROLE_ALL_ADMIN', '后台管理');

insert into t_roles_permissions (role_id, permission_id)
(select id, (select id from t_permissions where name='ROLE_ALL_ADMIN') from t_roles where name='admin');


