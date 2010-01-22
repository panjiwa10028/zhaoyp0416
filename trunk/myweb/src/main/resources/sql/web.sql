/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2010-1-22 11:46:43                           */
/*==============================================================*/
--drop database myweb;
--create database myweb character set =utf8;

drop index Index_t_groups_3 on groups;

drop index Index_t_groups_1 on groups;

drop index Index_t_groups_2 on groups;

drop table if exists groups;

drop index Index_t_menu_5 on menus;

drop index Index_t_menu_4 on menus;

drop index Index_t_menu_3 on menus;

drop index Index_t_menu_2 on menus;

drop index Index_t_menu_1 on menus;

drop table if exists menus;

drop index Index_1 on news;

drop table if exists news;

drop index Index_2 on news_category;

drop index Index_1 on news_category;

drop table if exists news_category;

drop index Index_1 on news_message;

drop table if exists news_message;

drop index Index_t_permissions_3 on permissions;

drop index Index_t_permissions_2 on permissions;

drop table if exists permissions;

drop index Index_2 on product;

drop index Index_1 on product;

drop table if exists product;

drop index Index_2 on product_category;

drop index Index_1 on product_category;

drop table if exists product_category;

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
   id                   bigint not null auto_increment,
   name                 varchar(100)  not null,
   parent_id            bigint,
   description          text,
   sort                 varchar(100),
   update_time          datetime,
   user_id              bigint,
   primary key (id),
   unique key AK_Key_t_groups_2 (name)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_groups_2                                      */
/*==============================================================*/
create index Index_t_groups_2 on groups
(
   name
);

/*==============================================================*/
/* Index: Index_t_groups_1                                      */
/*==============================================================*/
create index Index_t_groups_1 on groups
(
   parent_id
);

/*==============================================================*/
/* Index: Index_t_groups_3                                      */
/*==============================================================*/
create index Index_t_groups_3 on groups
(
   sort
);

/*==============================================================*/
/* Table: menus                                                 */
/*==============================================================*/
create table menus
(
   id                   bigint not null auto_increment,
   name                 varchar(50) not null,
   parent_id            bigint,
   display_name         varchar(100) not null,
   path                 varchar(500),
   sort                 varchar(100),
   is_disabled          int default 0,
   update_time          datetime,
   user_id              bigint,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_t_menu_1                                        */
/*==============================================================*/
create index Index_t_menu_1 on menus
(
   is_disabled
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
   id                   bigint not null auto_increment,
   category_id          bigint,
   title                varchar(100),
   auth                 varchar(50),
   content              text,
   date                 datetime,
   update_time          datetime,
   html_path            varchar(512),
   pic_path             varchar(512),
   html_name            varchar(255),
   pic_name             varchar(255),
   user_id              bigint,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create index Index_1 on news
(
   update_time
);

/*==============================================================*/
/* Table: news_category                                         */
/*==============================================================*/
create table news_category
(
   id                   bigint not null auto_increment,
   parent_id            bigint,
   name                 varchar(50) not null,
   description          text,
   sort                 varchar(100),
   update_time          datetime,
   user_id              bigint,
   primary key (id),
   key AK_Key_2 (name)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create index Index_1 on news_category
(
   sort
);

/*==============================================================*/
/* Index: Index_2                                               */
/*==============================================================*/
create index Index_2 on news_category
(
   parent_id
);

/*==============================================================*/
/* Table: news_message                                          */
/*==============================================================*/
create table news_message
(
   id                   bigint not null auto_increment,
   news_id              bigint,
   title                varchar(255),
   content              text,
   update_time          datetime,
   user_id              bigint,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create index Index_1 on news_message
(
   update_time
);

/*==============================================================*/
/* Table: permissions                                           */
/*==============================================================*/
create table permissions
(
   id                   bigint not null auto_increment,
   name                 varchar(100) not null,
   display_name         varchar(100) not null,
   path                 varchar(255),
   update_time          datetime,
   user_id              bigint,
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
/* Table: product                                               */
/*==============================================================*/
create table product
(
   id                   bigint not null auto_increment,
   category_id          bigint,
   name                 varchar(100),
   content              text,
   update_time          datetime,
   html_path            varchar(512),
   html_name            varchar(100),
   pic_path             varchar(512),
   pic_name             varchar(100),
   user_id              bigint,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create index Index_1 on product
(
   name
);

/*==============================================================*/
/* Index: Index_2                                               */
/*==============================================================*/
create index Index_2 on product
(
   update_time
);

/*==============================================================*/
/* Table: product_category                                      */
/*==============================================================*/
create table product_category
(
   id                   bigint not null auto_increment,
   parent_id            bigint,
   name                 varchar(100),
   description          text,
   sort                 varchar(100),
   update_time          datetime,
   user_id              bigint,
   primary key (id)
)
type = InnoDB;

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create index Index_1 on product_category
(
   name
);

/*==============================================================*/
/* Index: Index_2                                               */
/*==============================================================*/
create index Index_2 on product_category
(
   update_time
);

/*==============================================================*/
/* Table: roles                                                 */
/*==============================================================*/
create table roles
(
   id                   bigint not null auto_increment,
   name                 varchar(50) not null,
   description          text,
   update_time          datetime,
   user_id              bigint,
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
   role_id              bigint not null,
   menu_id              bigint not null,
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
   role_id              bigint not null,
   permission_id        bigint not null,
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
   id                   bigint not null auto_increment,
   name                 varchar(100)  not null,
   group_id             bigint not null,
   login_name           varchar(100) binary not null,
   password             varchar(255) not null,
   is_disabled          smallint not null default 0,
   is_expired           smallint not null default 0,
   is_locked            smallint not null default 0,
   update_time          datetime,
   user_id              bigint,
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
   user_id              bigint not null,
   role_id              bigint not null,
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

alter table news add constraint FK_FK_news_category_news foreign key (category_id)
      references news_category (id);

alter table news_message add constraint FK_news_news_message foreign key (news_id)
      references news (id);

alter table product add constraint FK_Reference_10 foreign key (category_id)
      references product_category (id);

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

