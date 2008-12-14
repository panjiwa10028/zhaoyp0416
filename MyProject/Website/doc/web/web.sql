/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2008-12-14 23:13:29                          */
/*==============================================================*/


drop index Index_t_groups_2 on t_groups;

drop index Index_t_groups_1 on t_groups;

drop table if exists t_groups;

drop index Index_t_permissions_1 on t_permission;

drop table if exists t_permission;

drop index Index_t_roles_1 on t_roles;

drop table if exists t_roles;

drop index Index_t_roles_permissions_2 on t_roles_permissions;

drop index Index_t_roles_permissions_1 on t_roles_permissions;

drop table if exists t_roles_permissions;

drop index Index_t_users_3 on t_users;

drop index Index_t_users_2 on t_users;

drop index Index_t_users_1 on t_users;

drop table if exists t_users;

drop index Index_t_users_roles_2 on t_users_roles;

drop index Index_t_users_roles_1 on t_users_roles;

drop table if exists t_users_roles;

/*==============================================================*/
/* Table: t_groups                                              */
/*==============================================================*/
create table t_groups
(
   id                   bigint not null auto_increment,
   name                 varchar(100)  not null,
   parent_id            bigint not null,
   description          text not null,
   modify_time          timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (id),
   unique key AK_Key_t_groups_2 (name, parent_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_groups_1                                      */
/*==============================================================*/
create index Index_t_groups_1 on t_groups
(
   parent_id
);

/*==============================================================*/
/* Index: Index_t_groups_2                                      */
/*==============================================================*/
create index Index_t_groups_2 on t_groups
(
   name
);

/*==============================================================*/
/* Table: t_permission                                          */
/*==============================================================*/
create table t_permission
(
   id                   bigint not null auto_increment,
   name                 varchar(100) not null,
   display_name         varchar(100) not null,
   primary key (id),
   unique key AK_Key_t_permissions_2 (name),
   unique key AK_Key_t_permissions_3 (display_name)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_permissions_1                                 */
/*==============================================================*/
create index Index_t_permissions_1 on t_permission
(
   name
);

/*==============================================================*/
/* Table: t_roles                                               */
/*==============================================================*/
create table t_roles
(
   id                   bigint not null auto_increment,
   name                 varchar(50) not null,
   description          text not null,
   modify_time          timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (id),
   unique key AK_Key_t_roles_2 (name)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_roles_1                                       */
/*==============================================================*/
create index Index_t_roles_1 on t_roles
(
   name
);

/*==============================================================*/
/* Table: t_roles_permissions                                   */
/*==============================================================*/
create table t_roles_permissions
(
   role_id              bigint not null,
   permission_id        bigint not null,
   primary key (role_id, permission_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_roles_permissions_1                           */
/*==============================================================*/
create index Index_t_roles_permissions_1 on t_roles_permissions
(
   role_id
);

/*==============================================================*/
/* Index: Index_t_roles_permissions_2                           */
/*==============================================================*/
create index Index_t_roles_permissions_2 on t_roles_permissions
(
   permission_id
);

/*==============================================================*/
/* Table: t_users                                               */
/*==============================================================*/
create table t_users
(
   id                   bigint not null auto_increment,
   name                 varchar(100)  not null,
   group_id             bigint not null,
   login_name           varchar(100) binary not null,
   password             varchar(255) not null,
   enabled              smallint not null default 0,
   expired              smallint not null default 0,
   locked               smallint not null default 0,
   modify_time          timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (id),
   unique key AK_Key_t_users_2 (login_name)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_users_1                                       */
/*==============================================================*/
create index Index_t_users_1 on t_users
(
   name
);

/*==============================================================*/
/* Index: Index_t_users_2                                       */
/*==============================================================*/
create index Index_t_users_2 on t_users
(
   group_id
);

/*==============================================================*/
/* Index: Index_t_users_3                                       */
/*==============================================================*/
create index Index_t_users_3 on t_users
(
   login_name
);

/*==============================================================*/
/* Table: t_users_roles                                         */
/*==============================================================*/
create table t_users_roles
(
   user_id              bigint not null,
   role_id              bigint not null,
   primary key (user_id, role_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_users_roles_1                                 */
/*==============================================================*/
create index Index_t_users_roles_1 on t_users_roles
(
   user_id
);

/*==============================================================*/
/* Index: Index_t_users_roles_2                                 */
/*==============================================================*/
create index Index_t_users_roles_2 on t_users_roles
(
   role_id
);

alter table t_roles_permissions add constraint FK_t_permissions_t_roles_permissions_1 foreign key (permission_id)
      references t_permission (id);

alter table t_roles_permissions add constraint FK_t_roles_t_roles_permissions_1 foreign key (role_id)
      references t_roles (id);

alter table t_users add constraint FK_t_users_t_groups_1 foreign key (group_id)
      references t_groups (id);

alter table t_users_roles add constraint FK_t_roles_t_users_roles_1 foreign key (role_id)
      references t_roles (id);

alter table t_users_roles add constraint FK_t_users_t_users_roles_1 foreign key (user_id)
      references t_users (id);

