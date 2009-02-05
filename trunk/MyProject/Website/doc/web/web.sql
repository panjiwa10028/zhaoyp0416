/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2008-12-29 21:26:02                          */
/*==============================================================*/


drop index Index_t_groups_2 on t_groups;

drop index Index_t_groups_1 on t_groups;

drop table if exists t_groups;

drop index Index_t_menu_5 on t_menus;

drop index Index_t_menu_4 on t_menus;

drop index Index_t_menu_3 on t_menus;

drop index Index_t_menu_2 on t_menus;

drop index Index_t_menu_1 on t_menus;

drop table if exists t_menus;

drop index Index_t_permissions_3 on t_permissions;

drop index Index_t_permissions_2 on t_permissions;

drop table if exists t_permissions;

drop index Index_t_roles_1 on t_roles;

drop table if exists t_roles;

drop index Index_t_roels_menus_2 on t_roles_menus;

drop index Index_t_roels_menus_1 on t_roles_menus;

drop table if exists t_roles_menus;

drop index Index_t_role_permissions_2 on t_roles_permissions;

drop index Index_t_role_permissions_1 on t_roles_permissions;

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
   id                   char(36) not null,
   name                 varchar(100)  not null,
   parent_id            char(36) not null,
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
/* Table: t_menus                                               */
/*==============================================================*/
create table t_menus
(
   id                   char(36) not null,
   name                 varchar(50) not null,
   parent_id            char(36) not null,
   display_name         varchar(100) not null,
   url                  varchar(500) not null,
   sort                 varchar(100) not null,
   disabled             int not null default 0,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_menu_1                                        */
/*==============================================================*/
create index Index_t_menu_1 on t_menus
(
   disabled
);

/*==============================================================*/
/* Index: Index_t_menu_2                                        */
/*==============================================================*/
create index Index_t_menu_2 on t_menus
(
   sort
);

/*==============================================================*/
/* Index: Index_t_menu_3                                        */
/*==============================================================*/
create unique index Index_t_menu_3 on t_menus
(
   name
);

/*==============================================================*/
/* Index: Index_t_menu_4                                        */
/*==============================================================*/
create unique index Index_t_menu_4 on t_menus
(
   display_name
);

/*==============================================================*/
/* Index: Index_t_menu_5                                        */
/*==============================================================*/
create index Index_t_menu_5 on t_menus
(
   parent_id
);

/*==============================================================*/
/* Table: t_permissions                                         */
/*==============================================================*/
create table t_permissions
(
   id                   char(36) not null,
   name                 varchar(100) not null,
   display_name         varchar(100) not null,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_permissions_2                                 */
/*==============================================================*/
create unique index Index_t_permissions_2 on t_permissions
(
   name
);

/*==============================================================*/
/* Index: Index_t_permissions_3                                 */
/*==============================================================*/
create unique index Index_t_permissions_3 on t_permissions
(
   display_name
);

/*==============================================================*/
/* Table: t_roles                                               */
/*==============================================================*/
create table t_roles
(
   id                   char(36) not null,
   name                 varchar(50) not null,
   description          text not null,
   modify_time          timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_roles_1                                       */
/*==============================================================*/
create unique index Index_t_roles_1 on t_roles
(
   name
);

/*==============================================================*/
/* Table: t_roles_menus                                         */
/*==============================================================*/
create table t_roles_menus
(
   role_id              char(36) not null,
   menu_id              char(36) not null,
   primary key (role_id, menu_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_roels_menus_1                                 */
/*==============================================================*/
create index Index_t_roels_menus_1 on t_roles_menus
(
   role_id
);

/*==============================================================*/
/* Index: Index_t_roels_menus_2                                 */
/*==============================================================*/
create index Index_t_roels_menus_2 on t_roles_menus
(
   menu_id
);

/*==============================================================*/
/* Table: t_roles_permissions                                   */
/*==============================================================*/
create table t_roles_permissions
(
   role_id              char(36) not null,
   permission_id        char(36) not null,
   primary key (role_id, permission_id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_role_permissions_1                            */
/*==============================================================*/
create index Index_t_role_permissions_1 on t_roles_permissions
(
   role_id
);

/*==============================================================*/
/* Index: Index_t_role_permissions_2                            */
/*==============================================================*/
create index Index_t_role_permissions_2 on t_roles_permissions
(
   permission_id
);

/*==============================================================*/
/* Table: t_users                                               */
/*==============================================================*/
create table t_users
(
   id                   char(36) not null,
   name                 varchar(100)  not null,
   group_id             char(36) not null,
   login_name           varchar(100) binary not null,
   password             varchar(255) not null,
   disabled             int not null default 0,
   expired              int not null default 0,
   locked               int not null default 0,
   modify_time          timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (id)
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
create unique index Index_t_users_3 on t_users
(
   login_name
);

/*==============================================================*/
/* Table: t_users_roles                                         */
/*==============================================================*/
create table t_users_roles
(
   user_id              char(36) not null,
   role_id              char(36) not null,
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

alter table t_roles_menus add constraint FK_t_menus_t_roles_menus foreign key (menu_id)
      references t_menus (id);

alter table t_roles_menus add constraint FK_t_roles_t_roles_menus foreign key (role_id)
      references t_roles (id);

alter table t_roles_permissions add constraint FK_t_permissions_t_roles_permissions_1 foreign key (permission_id)
      references t_permissions (id);

alter table t_roles_permissions add constraint FK_t_roles_t_roles_permissions_1 foreign key (role_id)
      references t_roles (id);

alter table t_users add constraint FK_t_users_t_groups_1 foreign key (group_id)
      references t_groups (id);

alter table t_users_roles add constraint FK_t_roles_t_users_roles_1 foreign key (role_id)
      references t_roles (id);

alter table t_users_roles add constraint FK_t_users_t_users_roles_1 foreign key (user_id)
      references t_users (id);

