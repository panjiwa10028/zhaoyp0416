/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2009-3-25 11:42:02                           */
/*==============================================================*/


drop index Index_t_groups_2 on groups;

drop index Index_t_groups_1 on groups;

drop table if exists groups;

drop index Index_t_menu_5 on menus;

drop index Index_t_menu_4 on menus;

drop index Index_t_menu_3 on menus;

drop index Index_t_menu_2 on menus;

drop index Index_t_menu_1 on menus;

drop table if exists menus;

drop table if exists news;

drop index Index_t_permissions_3 on permissions;

drop index Index_t_permissions_2 on permissions;

drop table if exists permissions;

drop index Index_t_roles_1 on roles;

drop table if exists roles;

drop index Index_t_roels_menus_2 on roles_menus;

drop index Index_t_roels_menus_1 on roles_menus;

drop table if exists roles_menus;

drop index Index_t_role_permissions_2 on roles_permissions;

drop index Index_t_role_permissions_1 on roles_permissions;

drop table if exists roles_permissions;

drop index Index_t_users_3 on users;

drop index Index_t_users_2 on users;

drop index Index_t_users_1 on users;

drop table if exists users;

drop index Index_t_users_roles_2 on users_roles;

drop index Index_t_users_roles_1 on users_roles;

drop table if exists users_roles;

/*==============================================================*/
/* Table: groups                                                */
/*==============================================================*/
create table groups
(
   id                   varchar(36) not null,
   name                 varchar(100)  not null,
   description          text,
   parent_id            varchar(36),
   update_time          datetime,
   user_id              varchar(36),
   primary key (id),
   unique key AK_Key_t_groups_2 (name)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_groups_1                                      */
/*==============================================================*/
create index Index_t_groups_1 on groups
(
   parent_id
);

/*==============================================================*/
/* Index: Index_t_groups_2                                      */
/*==============================================================*/
create index Index_t_groups_2 on groups
(
   name
);

/*==============================================================*/
/* Table: menus                                                 */
/*==============================================================*/
create table menus
(
   id                   varchar(36) not null,
   name                 varchar(50) not null,
   parent_id            varchar(36),
   display_name         varchar(100) not null,
   path                 varchar(500),
   sort                 varchar(100),
   disabled             int default 0,
   update_time          datetime,
   user_id              varchar(36),
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_menu_1                                        */
/*==============================================================*/
create index Index_t_menu_1 on menus
(
   disabled
);

/*==============================================================*/
/* Index: Index_t_menu_2                                        */
/*==============================================================*/
create index Index_t_menu_2 on menus
(
   sort
);

/*==============================================================*/
/* Index: Index_t_menu_3                                        */
/*==============================================================*/
create unique index Index_t_menu_3 on menus
(
   name
);

/*==============================================================*/
/* Index: Index_t_menu_4                                        */
/*==============================================================*/
create unique index Index_t_menu_4 on menus
(
   display_name
);

/*==============================================================*/
/* Index: Index_t_menu_5                                        */
/*==============================================================*/
create index Index_t_menu_5 on menus
(
   parent_id
);

/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news
(
   id                   varchar(36) not null,
   title                varchar(100),
   auth                 varchar(50),
   content              text,
   picture              varchar(255),
   date                 datetime,
   user_id              varchar(36),
   update_time          datetime,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Table: permissions                                           */
/*==============================================================*/
create table permissions
(
   id                   varchar(36) not null,
   name                 varchar(100) not null,
   display_name         varchar(100) not null,
   path                 varchar(255),
   update_time          datetime,
   user_id              varchar(36),
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_permissions_2                                 */
/*==============================================================*/
create unique index Index_t_permissions_2 on permissions
(
   name
);

/*==============================================================*/
/* Index: Index_t_permissions_3                                 */
/*==============================================================*/
create unique index Index_t_permissions_3 on permissions
(
   display_name
);

/*==============================================================*/
/* Table: roles                                                 */
/*==============================================================*/
create table roles
(
   id                   varchar(36) not null,
   name                 varchar(50) not null,
   description          text,
   update_time          datetime,
   user_id              varchar(36),
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_roles_1                                       */
/*==============================================================*/
create unique index Index_t_roles_1 on roles
(
   name
);

/*==============================================================*/
/* Table: roles_menus                                           */
/*==============================================================*/
create table roles_menus
(
   role_id              varchar(36) not null,
   menu_id              varchar(36) not null,
   primary key (role_id, menu_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_roels_menus_1                                 */
/*==============================================================*/
create index Index_t_roels_menus_1 on roles_menus
(
   role_id
);

/*==============================================================*/
/* Index: Index_t_roels_menus_2                                 */
/*==============================================================*/
create index Index_t_roels_menus_2 on roles_menus
(
   menu_id
);

/*==============================================================*/
/* Table: roles_permissions                                     */
/*==============================================================*/
create table roles_permissions
(
   role_id              varchar(36) not null,
   permission_id        varchar(36) not null,
   primary key (role_id, permission_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_role_permissions_1                            */
/*==============================================================*/
create index Index_t_role_permissions_1 on roles_permissions
(
   role_id
);

/*==============================================================*/
/* Index: Index_t_role_permissions_2                            */
/*==============================================================*/
create index Index_t_role_permissions_2 on roles_permissions
(
   permission_id
);

/*==============================================================*/
/* Table: users                                                 */
/*==============================================================*/
create table users
(
   id                   varchar(36) not null,
   name                 varchar(100)  not null,
   group_id             varchar(36) not null,
   login_name           varchar(100) binary not null,
   password             varchar(255) not null,
   disabled             smallint not null default 0,
   expired              smallint not null default 0,
   locked               smallint not null default 0,
   update_time          datetime,
   user_id              varchar(36),
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_users_1                                       */
/*==============================================================*/
create index Index_t_users_1 on users
(
   name
);

/*==============================================================*/
/* Index: Index_t_users_2                                       */
/*==============================================================*/
create index Index_t_users_2 on users
(
   group_id
);

/*==============================================================*/
/* Index: Index_t_users_3                                       */
/*==============================================================*/
create unique index Index_t_users_3 on users
(
   login_name
);

/*==============================================================*/
/* Table: users_roles                                           */
/*==============================================================*/
create table users_roles
(
   user_id              varchar(36) not null,
   role_id              varchar(36) not null,
   primary key (user_id, role_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_users_roles_1                                 */
/*==============================================================*/
create index Index_t_users_roles_1 on users_roles
(
   user_id
);

/*==============================================================*/
/* Index: Index_t_users_roles_2                                 */
/*==============================================================*/
create index Index_t_users_roles_2 on users_roles
(
   role_id
);

alter table groups add constraint FK_groups_groups foreign key (parent_id)
      references groups (id);

alter table menus add constraint FK_menus_menus foreign key (parent_id)
      references menus (id);

alter table news add constraint FK_users_news foreign key (user_id)
      references users (id);

alter table roles_menus add constraint FK_menus_rolesmenus foreign key (menu_id)
      references menus (id);

alter table roles_menus add constraint FK_roles_rolesmenus foreign key (role_id)
      references roles (id);

alter table roles_permissions add constraint FK_permissions_rolespermissions foreign key (permission_id)
      references permissions (id);

alter table roles_permissions add constraint FK_roles_rolespermissions foreign key (role_id)
      references roles (id);

alter table users add constraint FK_groups_users foreign key (group_id)
      references groups (id);

alter table users_roles add constraint FK_roles_usersroles foreign key (role_id)
      references roles (id);

alter table users_roles add constraint FK_users_usersroles foreign key (user_id)
      references users (id);

