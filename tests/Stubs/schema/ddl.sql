--
-- Table structure for table `awf_assets`
--

CREATE TABLE `awf_assets` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `parent_id` INTEGER NOT NULL DEFAULT '0',
  `lft` INTEGER NOT NULL DEFAULT '0',
  `rgt` INTEGER NOT NULL DEFAULT '0',
  `level` INTEGER NOT NULL,
  `name` TEXT NOT NULL DEFAULT '',
  `title` TEXT NOT NULL DEFAULT '',
  `rules` TEXT NOT NULL DEFAULT '',
  CONSTRAINT `idx_assets_name` UNIQUE (`name`)
);

CREATE INDEX `idx_assets_left_right` ON `awf_assets` (`lft`,`rgt`);
CREATE INDEX `idx_assets_parent_id` ON `awf_assets` (`parent_id`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_categories`
--

CREATE TABLE `awf_categories` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `asset_id` INTEGER NOT NULL DEFAULT '0',
  `parent_id` INTEGER NOT NULL DEFAULT '0',
  `lft` INTEGER NOT NULL DEFAULT '0',
  `rgt` INTEGER NOT NULL DEFAULT '0',
  `level` INTEGER NOT NULL DEFAULT '0',
  `path` TEXT NOT NULL DEFAULT '',
  `extension` TEXT NOT NULL DEFAULT '',
  `title` TEXT NOT NULL DEFAULT '',
  `alias` TEXT NOT NULL DEFAULT '',
  `note` TEXT NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `published` INTEGER NOT NULL DEFAULT '0',
  `checked_out` INTEGER NOT NULL DEFAULT '0',
  `checked_out_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` INTEGER NOT NULL DEFAULT '0',
  `params` TEXT NOT NULL DEFAULT '',
  `metadesc` TEXT NOT NULL DEFAULT '',
  `metakey` TEXT NOT NULL DEFAULT '',
  `metadata` TEXT NOT NULL DEFAULT '',
  `created_user_id` INTEGER NOT NULL DEFAULT '0',
  `created_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` INTEGER NOT NULL DEFAULT '0',
  `modified_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` INTEGER NOT NULL DEFAULT '0',
  `language` TEXT NOT NULL DEFAULT ''
);

CREATE INDEX `idx_categories_lookup` ON `awf_categories` (`extension`,`published`,`access`);
CREATE INDEX `idx_categories_access` ON `awf_categories` (`access`);
CREATE INDEX `idx_categories_checkout` ON `awf_categories` (`checked_out`);
CREATE INDEX `idx_categories_path` ON `awf_categories` (`path`);
CREATE INDEX `idx_categories_left_right` ON `awf_categories` (`lft`,`rgt`);
CREATE INDEX `idx_categories_alias` ON `awf_categories` (`alias`);
CREATE INDEX `idx_categories_language` ON `awf_categories` (`language`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_content`
--

CREATE TABLE `awf_content` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `asset_id` INTEGER NOT NULL DEFAULT '0',
  `title` TEXT NOT NULL DEFAULT '',
  `alias` TEXT NOT NULL DEFAULT '',
  `title_alias` TEXT NOT NULL DEFAULT '',
  `introtext` TEXT NOT NULL DEFAULT '',
  `fulltext` TEXT NOT NULL DEFAULT '',
  `state` INTEGER NOT NULL DEFAULT '0',
  `sectionid` INTEGER NOT NULL DEFAULT '0',
  `mask` INTEGER NOT NULL DEFAULT '0',
  `catid` INTEGER NOT NULL DEFAULT '0',
  `created` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` INTEGER NOT NULL DEFAULT '0',
  `created_by_alias` TEXT NOT NULL DEFAULT '',
  `modified` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` INTEGER NOT NULL DEFAULT '0',
  `checked_out` INTEGER NOT NULL DEFAULT '0',
  `checked_out_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` TEXT NOT NULL DEFAULT '',
  `urls` TEXT NOT NULL DEFAULT '',
  `attribs` TEXT NOT NULL DEFAULT '',
  `version` INTEGER NOT NULL DEFAULT '1',
  `parentid` INTEGER NOT NULL DEFAULT '0',
  `ordering` INTEGER NOT NULL DEFAULT '0',
  `metakey` TEXT NOT NULL DEFAULT '',
  `metadesc` TEXT NOT NULL DEFAULT '',
  `access` INTEGER NOT NULL DEFAULT '0',
  `hits` INTEGER NOT NULL DEFAULT '0',
  `metadata` TEXT NOT NULL DEFAULT '',
  `featured` INTEGER NOT NULL DEFAULT '0',
  `language` TEXT NOT NULL DEFAULT '',
  `xreference` TEXT NOT NULL DEFAULT ''
);

CREATE INDEX `idx_content_access` ON `awf_content` (`access`);
CREATE INDEX `idx_content_checkout` ON `awf_content` (`checked_out`);
CREATE INDEX `idx_content_state` ON `awf_content` (`state`);
CREATE INDEX `idx_content_catid` ON `awf_content` (`catid`);
CREATE INDEX `idx_content_createdby` ON `awf_content` (`created_by`);
CREATE INDEX `idx_content_featured_catid` ON `awf_content` (`featured`,`catid`);
CREATE INDEX `idx_content_language` ON `awf_content` (`language`);
CREATE INDEX `idx_content_xreference` ON `awf_content` (`xreference`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_core_log_searches`
--

CREATE TABLE `awf_core_log_searches` (
  `search_term` TEXT NOT NULL DEFAULT '',
  `hits` INTEGER NOT NULL DEFAULT '0'
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_extensions`
--

CREATE TABLE `awf_extensions` (
  `extension_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL DEFAULT '',
  `type` TEXT NOT NULL DEFAULT '',
  `element` TEXT NOT NULL DEFAULT '',
  `folder` TEXT NOT NULL DEFAULT '',
  `client_id` INTEGER NOT NULL,
  `enabled` INTEGER NOT NULL DEFAULT '1',
  `access` INTEGER NOT NULL DEFAULT '1',
  `protected` INTEGER NOT NULL DEFAULT '0',
  `manifest_cache` TEXT NOT NULL DEFAULT '',
  `params` TEXT NOT NULL DEFAULT '',
  `custom_data` TEXT NOT NULL DEFAULT '',
  `system_data` TEXT NOT NULL DEFAULT '',
  `checked_out` INTEGER NOT NULL DEFAULT '0',
  `checked_out_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` INTEGER DEFAULT '0',
  `state` INTEGER DEFAULT '0'
);

CREATE INDEX `idx_extensions_client_id` ON `awf_extensions` (`element`,`client_id`);
CREATE INDEX `idx_extensions_folder_client_id` ON `awf_extensions` (`element`,`folder`,`client_id`);
CREATE INDEX `idx_extensions_lookup` ON `awf_extensions` (`type`,`element`,`folder`,`client_id`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_languages`
--

CREATE TABLE `awf_languages` (
  `lang_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `lang_code` TEXT NOT NULL DEFAULT '',
  `title` TEXT NOT NULL DEFAULT '',
  `title_native` TEXT NOT NULL DEFAULT '',
  `sef` TEXT NOT NULL DEFAULT '',
  `image` TEXT NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `metakey` TEXT NOT NULL DEFAULT '',
  `metadesc` TEXT NOT NULL DEFAULT '',
  `sitename` varchar(1024) NOT NULL default '',
  `published` INTEGER NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL default '0',
  CONSTRAINT `idx_languages_sef` UNIQUE (`sef`)
  CONSTRAINT `idx_languages_image` UNIQUE (`image`)
  CONSTRAINT `idx_languages_lang_code` UNIQUE (`lang_code`)
);

CREATE INDEX `idx_languages_ordering` ON `awf_languages` (`ordering`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_log_entries`
--

CREATE TABLE `awf_log_entries` (
  `priority` INTEGER DEFAULT NULL,
  `message` TEXT DEFAULT NULL,
  `date` TEXT DEFAULT NULL,
  `category` TEXT DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_menu`
--

CREATE TABLE `awf_menu` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `menutype` TEXT NOT NULL DEFAULT '',
  `title` TEXT NOT NULL DEFAULT '',
  `alias` TEXT NOT NULL DEFAULT '',
  `note` TEXT NOT NULL DEFAULT '',
  `path` TEXT NOT NULL DEFAULT '',
  `link` TEXT NOT NULL DEFAULT '',
  `type` TEXT NOT NULL DEFAULT '',
  `published` INTEGER NOT NULL DEFAULT '0',
  `parent_id` INTEGER NOT NULL DEFAULT '1',
  `level` INTEGER NOT NULL DEFAULT '0',
  `component_id` INTEGER NOT NULL DEFAULT '0',
  `ordering` INTEGER NOT NULL DEFAULT '0',
  `checked_out` INTEGER NOT NULL DEFAULT '0',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `browserNav` INTEGER NOT NULL DEFAULT '0',
  `access` INTEGER NOT NULL DEFAULT '0',
  `img` TEXT NOT NULL DEFAULT '',
  `template_style_id` INTEGER NOT NULL DEFAULT '0',
  `params` TEXT NOT NULL DEFAULT '',
  `lft` INTEGER NOT NULL DEFAULT '0',
  `rgt` INTEGER NOT NULL DEFAULT '0',
  `home` INTEGER NOT NULL DEFAULT '0',
  `language` TEXT NOT NULL DEFAULT '',
  `client_id` INTEGER NOT NULL DEFAULT '0',
  CONSTRAINT `idx_menu_lookup` UNIQUE (`client_id`,`parent_id`,`alias`)
);

CREATE INDEX `idx_menu_componentid` ON `awf_menu` (`component_id`,`menutype`,`published`,`access`);
CREATE INDEX `idx_menu_menutype` ON `awf_menu` (`menutype`);
CREATE INDEX `idx_menu_left_right` ON `awf_menu` (`lft`,`rgt`);
CREATE INDEX `idx_menu_alias` ON `awf_menu` (`alias`);
CREATE INDEX `idx_menu_path` ON `awf_menu` (`path`);
CREATE INDEX `idx_menu_language` ON `awf_menu` (`language`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_menu_types`
--

CREATE TABLE `awf_menu_types` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `menutype` TEXT NOT NULL DEFAULT '',
  `title` TEXT NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  CONSTRAINT `idx_menu_types_menutype` UNIQUE (`menutype`)
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_modules`
--

CREATE TABLE `awf_modules` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `title` TEXT NOT NULL DEFAULT '',
  `note` TEXT NOT NULL DEFAULT '',
  `content` TEXT NOT NULL DEFAULT '',
  `ordering` INTEGER NOT NULL DEFAULT '0',
  `position` TEXT DEFAULT NULL,
  `checked_out` INTEGER NOT NULL DEFAULT '0',
  `checked_out_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` INTEGER NOT NULL DEFAULT '0',
  `module` TEXT DEFAULT NULL,
  `access` INTEGER NOT NULL DEFAULT '0',
  `showtitle` INTEGER NOT NULL DEFAULT '1',
  `params` TEXT NOT NULL DEFAULT '',
  `client_id` INTEGER NOT NULL DEFAULT '0',
  `language` TEXT NOT NULL DEFAULT ''
);

CREATE INDEX `idx_modules_viewable` ON `awf_modules` (`published`,`access`);
CREATE INDEX `idx_modules_published` ON `awf_modules` (`module`,`published`);
CREATE INDEX `idx_modules_language` ON `awf_modules` (`language`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_modules_menu`
--

CREATE TABLE `awf_modules_menu` (
  `moduleid` INTEGER NOT NULL DEFAULT '0',
  `menuid` INTEGER NOT NULL DEFAULT '0',
  CONSTRAINT `idx_modules_menu` PRIMARY KEY (`moduleid`,`menuid`)
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_schemas`
--

CREATE TABLE `awf_schemas` (
  `extension_id` INTEGER NOT NULL,
  `version_id` TEXT NOT NULL DEFAULT '',
  CONSTRAINT `idx_schemas` PRIMARY KEY (`extension_id`,`version_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_session`
--

CREATE TABLE `awf_session` (
  `session_id` TEXT NOT NULL DEFAULT '',
  `client_id` INTEGER NOT NULL DEFAULT '0',
  `guest` INTEGER DEFAULT '1',
  `time` TEXT DEFAULT '',
  `data` TEXT DEFAULT NULL,
  `userid` INTEGER DEFAULT '0',
  `username` TEXT DEFAULT '',
  `usertype` TEXT DEFAULT '',
  CONSTRAINT `idx_session` PRIMARY KEY (`session_id`)
);

CREATE INDEX `idx_session_whosonline` ON `awf_session` (`guest`,`usertype`);
CREATE INDEX `idx_session_user` ON `awf_session` (`userid`);
CREATE INDEX `idx_session_time` ON `awf_session` (`time`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_updates`
--

CREATE TABLE `awf_updates` (
  `update_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `update_site_id` INTEGER DEFAULT '0',
  `extension_id` INTEGER DEFAULT '0',
  `categoryid` INTEGER DEFAULT '0',
  `name` TEXT DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `element` TEXT DEFAULT '',
  `type` TEXT DEFAULT '',
  `folder` TEXT DEFAULT '',
  `client_id` INTEGER DEFAULT '0',
  `version` TEXT DEFAULT '',
  `data` TEXT NOT NULL DEFAULT '',
  `detailsurl` TEXT NOT NULL DEFAULT ''
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_update_categories`
--

CREATE TABLE `awf_update_categories` (
  `categoryid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `parent` INTEGER DEFAULT '0',
  `updatesite` INTEGER DEFAULT '0'
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_update_sites`
--

CREATE TABLE `awf_update_sites` (
  `update_site_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT DEFAULT '',
  `type` TEXT DEFAULT '',
  `location` TEXT NOT NULL DEFAULT '',
  `enabled` INTEGER DEFAULT '0'
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_update_sites_extensions`
--

CREATE TABLE `awf_update_sites_extensions` (
  `update_site_id` INTEGER NOT NULL DEFAULT '0',
  `extension_id` INTEGER NOT NULL DEFAULT '0',
  CONSTRAINT  `idx_update_sites_extensions` PRIMARY KEY (`update_site_id`,`extension_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_usergroups`
--

CREATE TABLE `awf_usergroups` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `parent_id` INTEGER NOT NULL DEFAULT '0',
  `lft` INTEGER NOT NULL DEFAULT '0',
  `rgt` INTEGER NOT NULL DEFAULT '0',
  `title` TEXT NOT NULL DEFAULT '',
  CONSTRAINT `idx_usergroups_parent_title_lookup` UNIQUE (`parent_id`,`title`)
);

CREATE INDEX `idx_usergroups_title_lookup` ON `awf_usergroups` (`title`);
CREATE INDEX `idx_usergroups_adjacency_lookup` ON `awf_usergroups` (`parent_id`);
CREATE INDEX `idx_usergroups_nested_set_lookup` ON `awf_usergroups` (`lft`,`rgt`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_users`
--

CREATE TABLE `awf_users` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL DEFAULT '',
  `username` TEXT NOT NULL DEFAULT '',
  `email` TEXT NOT NULL DEFAULT '',
  `password` TEXT NOT NULL DEFAULT '',
  `usertype` TEXT NOT NULL DEFAULT '',
  `block` INTEGER NOT NULL DEFAULT '0',
  `sendEmail` INTEGER DEFAULT '0',
  `registerDate` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` TEXT NOT NULL DEFAULT '',
  `params` TEXT NOT NULL DEFAULT ''
);

CREATE INDEX `idx_users_usertype` ON `awf_users` (`usertype`);
CREATE INDEX `idx_users_name` ON `awf_users` (`name`);
CREATE INDEX `idx_users_block` ON `awf_users` (`block`);
CREATE INDEX `idx_users_username` ON `awf_users` (`username`);
CREATE INDEX `idx_users_email` ON `awf_users` (`email`);

-- --------------------------------------------------------

--
-- Table structure for table `awf_user_profiles`
--

CREATE TABLE `awf_user_profiles` (
  `user_id` INTEGER NOT NULL,
  `profile_key` TEXT NOT NULL DEFAULT '',
  `profile_value` TEXT NOT NULL DEFAULT '',
  `ordering` INTEGER NOT NULL DEFAULT '0',
  CONSTRAINT `idx_user_profiles_lookup` UNIQUE (`user_id`,`profile_key`)
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_user_usergroup_map`
--

CREATE TABLE `awf_user_usergroup_map` (
  `user_id` INTEGER NOT NULL DEFAULT '0',
  `group_id` INTEGER NOT NULL DEFAULT '0',
  CONSTRAINT `idx_user_usergroup_map` PRIMARY KEY (`user_id`,`group_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `awf_viewlevels`
--

CREATE TABLE `awf_viewlevels` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `title` TEXT NOT NULL DEFAULT '',
  `ordering` INTEGER NOT NULL DEFAULT '0',
  `rules` TEXT NOT NULL DEFAULT '',
  CONSTRAINT `idx_viewlevels_title` UNIQUE (`title`)
);



CREATE TABLE `awf_dbtest` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `title` TEXT NOT NULL DEFAULT '',
  `start_date` TEXT NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT ''
);


CREATE TABLE `awf_dbtest_composite` (
  `id1` INTEGER NOT NULL DEFAULT '0',
  `id2` INTEGER NOT NULL DEFAULT '0',
  `title` TEXT NOT NULL DEFAULT '',
  `asset_id` INTEGER NOT NULL DEFAULT '0',
  `hits` INTEGER NOT NULL DEFAULT '0',
  `checked_out` INTEGER NOT NULL DEFAULT '0',
  `checked_out_time` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` INTEGER NOT NULL DEFAULT '0',
  `publish_up` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` INTEGER NOT NULL DEFAULT '0',
  CONSTRAINT `idx_dbtest_composite` PRIMARY KEY (`id1`,`id2`)
);