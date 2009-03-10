/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2009-3-6 17:55:08                            */
/*==============================================================*/


drop index Index_t_groups_2 on groups;

drop index Index_t_groups_1 on groups;

drop table if exists groups;

drop index Index_t_permissions_3 on permissions;

drop index Index_t_permissions_2 on permissions;

drop table if exists permissions;

drop index Index_t_roles_1 on roles;

drop table if exists roles;

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
   id                   char(32) not null,
   name                 varchar(100)  not null,
   description          text not null,
   parent_id            char(32) not null,
   update_date          datetime,
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
/* Table: permissions                                           */
/*==============================================================*/
create table permissions
(
   id                   char(32) not null,
   name                 varchar(100) not null,
   display_name         varchar(100) not null,
   path                 varchar(255),
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
   id                   char(32) not null,
   name                 varchar(50) not null,
   description          text not null,
   update_date          datetime,
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
/* Table: roles_permissions                                     */
/*==============================================================*/
create table roles_permissions
(
   role_id              char(32) not null,
   permission_id        char(32) not null,
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
   id                   char(32) not null,
   name                 varchar(100)  not null,
   group_id             char(32) not null,
   login_name           varchar(100) binary not null,
   password             varchar(255) not null,
   disabled             smallint not null default 0,
   expired              smallint not null default 0,
   locked               smallint not null default 0,
   update_date          datetime,
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
   user_id              char(32) not null,
   role_id              char(32) not null,
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

alter table roles_permissions add constraint FK_t_permissions_t_roles_permissions_1 foreign key (permission_id)
      references permissions (id);

alter table roles_permissions add constraint FK_t_roles_t_roles_permissions_1 foreign key (role_id)
      references roles (id);

alter table users add constraint FK_t_users_t_groups_1 foreign key (group_id)
      references groups (id);

alter table users_roles add constraint FK_t_roles_t_users_roles_1 foreign key (role_id)
      references roles (id);

alter table users_roles add constraint FK_t_users_t_users_roles_1 foreign key (user_id)
      references users (id);

