/**
 * Core
 */
DROP TABLE IF EXISTS TB_PROJECT_USER;

CREATE TABLE TB_PROJECT_USER (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`USERNAME` VARCHAR(100) NOT NULL ,
	`PASSWORD` VARCHAR(100) NOT NULL ,
	`EMAIL` VARCHAR(100) NOT NULL ,
	`PROJECT_ID` BIGINT ,
	PRIMARY KEY (`ID`) ,
    UNIQUE INDEX `USERNAME_UNIQUE` (`USERNAME`) ,
    UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL`)
);

DROP TABLE IF EXISTS TB_PROJECT_USER_ROLE;

CREATE TABLE TB_PROJECT_USER_ROLE (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `USER_ID` BIGINT NOT NULL ,
    `ROLE_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PROJECT_ROLE;

CREATE TABLE TB_PROJECT_ROLE (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `LABEL` VARCHAR(100) NOT NULL ,
    `LEVEL` INT NOT NULL ,
    `PROJECT_ID` BIGINT,
    `CATEGORY_ID` BIGINT NOT NULL,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PROJECT_ROLE_AUTHORITY;

CREATE TABLE TB_PROJECT_ROLE_AUTHORITY (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `ROLE_ID` BIGINT NOT NULL ,
    `AUTHORITY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PROJECT_AUTHORITY;

CREATE TABLE TB_PROJECT_AUTHORITY (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `CODE` VARCHAR(100) NOT NULL ,
    `DESCRIPTION` VARCHAR(255) NOT NULL ,
     UNIQUE INDEX `CODE_UNIQUE` (`CODE`) ,
     PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PROJECT;

CREATE TABLE TB_PROJECT (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`CODE` VARCHAR(100) NOT NULL ,
	`TITLE` VARCHAR(100) NOT NULL ,
	`DESCRIPTION` VARCHAR(255) NOT NULL ,
	`CREATE_AT` TIMESTAMP NOT NULL ,
	`MODIFY_AT` TIMESTAMP NOT NULL ,
	`CREATE_BY_ID` BIGINT NOT NULL ,
	`MODIFY_BY_ID` BIGINT NOT NULL ,
	`CATEGORY_ID` BIGINT NOT NULL ,
	`PRIVATE` BOOLEAN DEFAULT FALSE ,
	PRIMARY KEY (`ID`) , 
	UNIQUE INDEX `CODE_UNIQUE` (`CODE`)
);

DROP TABLE IF EXISTS TB_PROJECT_CATEGORY;

CREATE TABLE TB_PROJECT_CATEGORY (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`CODE` VARCHAR(100) NOT NULL ,
    `LABEL` VARCHAR(100) NOT NULL ,
    `ENABLED` BOOLEAN DEFAULT TRUE ,
    `PRIVATE` BOOLEAN DEFAULT FALSE ,
    `LEVEL` INT DEFAULT 0 ,
	PRIMARY KEY (`ID`) ,
	UNIQUE INDEX `CODE_UNIQUE` (`CODE`)
);

DROP TABLE IF EXISTS TB_PROJECT_FEATURE;

CREATE TABLE TB_PROJECT_FEATURE (
	`ID` INT NOT NULL AUTO_INCREMENT ,
	`CODE` VARCHAR(100) NOT NULL ,
	`LABEL` VARCHAR(100) NOT NULL ,
	`LEVEL` INT NOT NULL DEFAULT 0,
	`ENABLED` BOOLEAN NOT NULL ,
	`PROJECT_ID` BIGINT NOT NULL ,
	PRIMARY KEY (`ID`) ,
	UNIQUE INDEX `CODE_UNIQUE` (`CODE`)
);

DROP TABLE IF EXISTS TB_PROJECT_ATTRIBUTE;

CREATE TABLE TB_PROJECT_ATTRIBUTE (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`NAME` VARCHAR(50) NOT NULL ,
	`VALUE` VARCHAR(255) NOT NULL ,
	`TYPE` VARCHAR(50) NOT NULL DEFAULT "" ,
    `LEVEL` INT DEFAULT 0 ,
	`PROJECT_ID` BIGINT NOT NULL ,
	PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PROJECT_HISTROY;

CREATE TABLE TB_PROJECT_HISTROY (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`CONTENT` VARCHAR(255) NOT NULL ,
	`CREATE_AT` TIMESTAMP NOT NULL ,
	`PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    `TARGET_ID` BIGINT NOT NULL ,
    `TARGET_TYPE` VARCHAR(255) NOT NULL ,
	PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PROJECT_LINK;

CREATE TABLE TB_PROJECT_LINK (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`FROM_PROJECT_ID` BIGINT NOT NULL ,
    `TO_PROJECT_ID` BIGINT NOT NULL ,
    `MUTUAL` BOOLEAN DEFAULT FALSE ,
	PRIMARY KEY (`ID`)
);

-- TB_PROJECT_USER
ALTER TABLE TB_PROJECT_USER ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_USER
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_USER_ROLE
ALTER TABLE TB_PROJECT_USER_ROLE ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_USER_ROLE
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_USER_ROLE ADD CONSTRAINT FK_USER_ID_TB_PROJECT_USER_ROLE
    FOREIGN KEY(`USER_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_USER_ROLE ADD CONSTRAINT FK_ROLE_ID_TB_PROJECT_USER_ROLE
    FOREIGN KEY(`ROLE_ID`)
    REFERENCES TB_PROJECT_ROLE(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_ROLE
ALTER TABLE TB_PROJECT_ROLE ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_ROLE
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_ROLE ADD CONSTRAINT FK_CATEGORY_ID_TB_PROJECT_ROLE
    FOREIGN KEY(`CATEGORY_ID`)
    REFERENCES TB_PROJECT_CATEGORY(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_ROLE_AUTHORITY
ALTER TABLE TB_PROJECT_ROLE_AUTHORITY ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_ROLE_AUTHORITY
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_ROLE_AUTHORITY ADD CONSTRAINT FK_ROLE_ID_TB_PROJECT_ROLE_AUTHORITY
    FOREIGN KEY(`ROLE_ID`)
    REFERENCES TB_PROJECT_ROLE(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_ROLE_AUTHORITY ADD CONSTRAINT FK_AUTHORITY_ID_TB_PROJECT_ROLE_AUTHORITY
    FOREIGN KEY(`AUTHORITY_ID`)
    REFERENCES TB_PROJECT_AUTHORITY(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT
ALTER TABLE TB_PROJECT ADD CONSTRAINT FK_CREATE_BY_ID_TB_PROJECT
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT ADD CONSTRAINT FK_MODIFY_BY_ID_TB_PROJECT
    FOREIGN KEY(`MODIFY_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT ADD CONSTRAINT FK_CATEGORY_ID_TB_PROJECT
    FOREIGN KEY(`CATEGORY_ID`)
    REFERENCES TB_PROJECT_CATEGORY(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_FEATURE
ALTER TABLE TB_PROJECT_FEATURE ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_FEATURE
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_ATTRIBUTE
ALTER TABLE TB_PROJECT_ATTRIBUTE ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_ATTRIBUTE
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_HISTROY
ALTER TABLE TB_PROJECT_ATTRIBUTE ADD CONSTRAINT FK_PROJECT_ID_TB_PROJECT_HISTROY
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_HISTROY ADD CONSTRAINT FK_CREATE_BY_ID_TB_PROJECT_HISTROY
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_PROJECT_LINK
ALTER TABLE TB_PROJECT_LINK ADD CONSTRAINT FK_FROM_PROJECT_ID_TB_PROJECT_LINK
    FOREIGN KEY(`FROM_PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PROJECT_LINK ADD CONSTRAINT FK_TO_PROJECT_ID_TB_PROJECT_LINK
    FOREIGN KEY(`TO_PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
/**
 * Blog
 */
DROP TABLE IF EXISTS TB_BLOG_CATEGORY;

CREATE TABLE TB_BLOG_CATEGORY (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`LABEL` VARCHAR(100) NOT NULL ,
	`CREATE_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
	PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_BLOG_POST;

CREATE TABLE TB_BLOG_POST (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`TITLE` VARCHAR(100) NOT NULL ,
	`SUMMARY` TEXT NOT NULL ,
    `CONTENT` TEXT NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
	`MODIFY_AT` TIMESTAMP NOT NULL ,
    `CATEGORY_ID` BIGINT ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
	PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_BLOG_COMMENT;

CREATE TABLE TB_BLOG_COMMENT (
	`ID` BIGINT NOT NULL AUTO_INCREMENT ,
	`TITLE` VARCHAR(100) NOT NULL ,
    `CONTENT` TEXT NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
	`MODIFY_AT` TIMESTAMP NOT NULL ,
    `POST_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
	PRIMARY KEY (`ID`)
);

-- TB_BLOG_CATEGORY
ALTER TABLE TB_BLOG_CATEGORY ADD CONSTRAINT FK_PROJECT_ID_TB_BLOG_CATEGORY
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_BLOG_CATEGORY ADD CONSTRAINT FK_CREATE_BY_ID_TB_BLOG_CATEGORY
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_BLOG_POST
ALTER TABLE TB_BLOG_POST ADD CONSTRAINT FK_CATEGORY_ID_TB_BLOG_POST
    FOREIGN KEY(`CATEGORY_ID`)
    REFERENCES TB_BLOG_CATEGORY(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_BLOG_POST ADD CONSTRAINT FK_CREATE_BY_ID_TB_BLOG_POST
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_BLOG_COMMENT
ALTER TABLE TB_BLOG_COMMENT ADD CONSTRAINT FK_POST_ID_TB_BLOG_COMMENT
    FOREIGN KEY(`POST_ID`)
    REFERENCES TB_BLOG_POST(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_BLOG_COMMENT ADD CONSTRAINT FK_CREATE_BY_ID_TB_BLOG_COMMENT
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
/**
 * Forum
 */
DROP TABLE IF EXISTS TB_FORUM_CATEGORY;

CREATE TABLE TB_FORUM_CATEGORY(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `LABEL` VARCHAR(100) NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_FORUM_TOPIC;

CREATE TABLE TB_FORUM_TOPIC (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `TITLE` VARCHAR(250) NOT NULL ,
    `CONTENT` TEXT NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `MODIFY_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CATEGORY_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    `MODIFY_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_FORUM_POST;

CREATE TABLE TB_FORUM_POST (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `TITLE` VARCHAR(250) NOT NULL ,
    `CONTENT` TEXT NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `MODIFY_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `TOPIC_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    `MODIFY_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

-- TB_FORUM_CATEGORY
ALTER TABLE TB_FORUM_CATEGORY ADD CONSTRAINT FK_PROJECT_ID_TB_FORUM_CATEGORY
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_CATEGORY ADD CONSTRAINT FK_CREATE_BY_ID_TB_FORUM_CATEGORY
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_FORUM_TOPIC
ALTER TABLE TB_FORUM_TOPIC ADD CONSTRAINT FK_PROJECT_ID_TB_FORUM_TOPIC
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_TOPIC ADD CONSTRAINT FK_CATEGORY_ID_TB_FORUM_TOPIC
    FOREIGN KEY(`CATEGORY_ID`)
    REFERENCES TB_FORUM_CATEGORY(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_TOPIC ADD CONSTRAINT FK_CREATE_BY_ID_TB_FORUM_TOPIC
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_TOPIC ADD CONSTRAINT FK_MODIFY_BY_ID_TB_FORUM_TOPIC
    FOREIGN KEY(`MODIFY_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_FORUM_POST
ALTER TABLE TB_FORUM_POST ADD CONSTRAINT FK_PROJECT_ID_TB_FORUM_POST
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_POST ADD CONSTRAINT FK_TOPIC_ID_TB_FORUM_POST
    FOREIGN KEY(`TOPIC_ID`)
    REFERENCES TB_FORUM_TOPIC(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_POST ADD CONSTRAINT FK_CREATE_BY_ID_TB_FORUM_POST
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_FORUM_POST ADD CONSTRAINT FK_MODIFY_BY_ID_TB_FORUM_POST
    FOREIGN KEY(`MODIFY_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
/**
 * Event
 */
DROP TABLE IF EXISTS TB_EVENT_CATEGORY;

CREATE TABLE TB_EVENT_CATEGORY(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `LABEL` VARCHAR(100) NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_EVENT;

CREATE TABLE TB_EVENT(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `TITLE` VARCHAR(250) NOT NULL ,
    `CONTENT` TEXT NOT NULL ,
    `LINK` VARCHAR(250),
    `BEGIN` TIMESTAMP NOT NULL ,
    `END` TIMESTAMP NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `MODIFY_AT` TIMESTAMP NOT NULL ,
    `CATEGORY_ID` BIGINT NOT NULL,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    `MODIFY_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

-- TB_EVENT_CATEGORY
ALTER TABLE TB_EVENT_CATEGORY ADD CONSTRAINT FK_PROJECT_ID_TB_EVENT_CATEGORY
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_EVENT_CATEGORY ADD CONSTRAINT FK_CREATE_BY_ID_TB_EVENT_CATEGORY
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_EVENT
ALTER TABLE TB_EVENT ADD CONSTRAINT FK_CATEGORY_ID_TB_EVENT
    FOREIGN KEY(`CATEGORY_ID`)
    REFERENCES TB_EVENT_CATEGORY(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_EVENT ADD CONSTRAINT FK_PROJECT_ID_TB_EVENT
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_EVENT ADD CONSTRAINT FK_CREATE_BY_ID_TB_EVENT
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_EVENT ADD CONSTRAINT FK_MODIFY_BY_ID_TB_EVENT
    FOREIGN KEY(`MODIFY_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

/**
 * Photo
 */
DROP TABLE IF EXISTS TB_ALBUM;

CREATE TABLE TB_ALBUM(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `LABEL` VARCHAR(100) NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_PHOTO;

CREATE TABLE TB_PHOTO(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `ALBUM_ID` BIGINT NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

-- TB_PHOTO
ALTER TABLE TB_PHOTO ADD CONSTRAINT FK_ALBUM_ID_TB_PHOTO
    FOREIGN KEY(`ALBUM_ID`)
    REFERENCES TB_ALBUM(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PHOTO ADD CONSTRAINT FK_PROJECT_ID_TB_PHOTO
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_PHOTO ADD CONSTRAINT FK_CREATE_BY_ID_TB_PHOTO
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_ALBUM
ALTER TABLE TB_ALBUM ADD CONSTRAINT FK_PROJECT_ID_TB_ALBUM
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_ALBUM ADD CONSTRAINT FK_CREATE_BY_ID_TB_ALBUM
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

/**
 * Team
 */
DROP TABLE IF EXISTS TB_TEAM_MEMBER;

CREATE TABLE TB_TEAM_MEMBER (
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `MODIFY_AT` TIMESTAMP NOT NULL ,
    `USER_ID` BIGINT NOT NULL ,
    `ROLE_ID` BIGINT NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

ALTER TABLE TB_TEAM_MEMBER ADD CONSTRAINT FK_USER_ID_TB_TEAM_MEMBER
    FOREIGN KEY(`USER_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_TEAM_MEMBER ADD CONSTRAINT FK_ROLE_ID_TB_TEAM_MEMBER
    FOREIGN KEY(`ROLE_ID`)
    REFERENCES TB_PROJECT_ROLE(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_TEAM_MEMBER ADD CONSTRAINT FK_PROJECT_ID_TB_TEAM_MEMBER
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

/**
 * Mesage
 */
DROP TABLE IF EXISTS TB_MESSAGE;

CREATE TABLE TB_MESSAGE(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `TITLE` VARCHAR(250) NOT NULL ,
    `CONTENT` TEXT NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `BOX_ID` BIGINT NOT NULL,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS TB_MESSAGE_BOX;

CREATE TABLE TB_MESSAGE_BOX(
    `ID` BIGINT NOT NULL AUTO_INCREMENT ,
    `LABEL` VARCHAR(100) NOT NULL ,
    `TYPE` VARCHAR(100) NOT NULL ,
    `CREATE_AT` TIMESTAMP NOT NULL ,
    `PROJECT_ID` BIGINT NOT NULL ,
    `CREATE_BY_ID` BIGINT NOT NULL ,
    PRIMARY KEY (`ID`)
);

-- TB_MESSAGE
ALTER TABLE TB_MESSAGE ADD CONSTRAINT FK_BOX_ID_TB_MESSAGE
    FOREIGN KEY(`BOX_ID`)
    REFERENCES TB_MESSAGE_BOX(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_MESSAGE ADD CONSTRAINT FK_PROJECT_ID_TB_MESSAGE
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_MESSAGE ADD CONSTRAINT FK_CREATE_BY_ID_TB_MESSAGE
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- TB_MESSAGE_BOX
ALTER TABLE TB_MESSAGE_BOX ADD CONSTRAINT FK_PROJECT_ID_TB_MESSAGE_BOX
    FOREIGN KEY(`PROJECT_ID`)
    REFERENCES TB_PROJECT(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE TB_MESSAGE_BOX ADD CONSTRAINT FK_CREATE_BY_ID_TB_MESSAGE_BOX
    FOREIGN KEY(`CREATE_BY_ID`)
    REFERENCES TB_PROJECT_USER(`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

/**
 * Initial Data
 */
drop procedure if exists init_db;

delimiter //
create procedure init_db()
    begin
        # declare variables
        declare userId, categoryId, projectId bigint;
        #
        insert into tb_project_user(username, password, email)
            values ('admin', 'admin', 'admin@focusns.org');
        insert into tb_project_category(code, label, enabled, private, `level`)
            values ('people', '成员', true, false, 0);
        # select userId and categoryId
        select id into userId from tb_project_user where username = 'admin';
        select id into categoryId from tb_project_category where code = 'people';
        
        insert into tb_project (code, title, description, create_at, modify_at, 
                                create_by_id, modify_by_id, category_id, private)
            values ('admin', 'Admin', 'This is admin!', now(), now(), userId, 
                    userId, categoryId, true);
        # select projectId
        select id into projectId from tb_project where code = 'admin';
        # update user
        update tb_project_user set project_id = projectId where id = userId;

        insert into tb_project_feature (code, label, `level`, enabled, project_id)
            values('profile', '主页', 0, true, projectId);
        insert into tb_project_feature (code, label, `level`, enabled, project_id)
            values('blog', '博客', 5, true, projectId);
        insert into tb_project_feature (code, label, `level`, enabled, project_id)
            values('photo', '相册', 10, true, projectId);
        insert into tb_project_feature (code, label, `level`, enabled, project_id)
            values('team', '关系', 15, true, projectId);
        insert into tb_project_feature (code, label, `level`, enabled, project_id)
            values('message', '私信', 20, true, projectId);
        insert into tb_project_feature (code, label, `level`, enabled, project_id)
            values('admin', '管理', 25, true, projectId);
    end //
delimiter ;

call init_db();