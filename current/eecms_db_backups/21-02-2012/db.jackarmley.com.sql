-- phpMyAdmin SQL Dump
-- version 3.3.10.4
-- http://www.phpmyadmin.net
--
-- Host: db.jackarmley.com
-- Generation Time: Feb 21, 2012 at 01:02 PM
-- Server version: 5.1.53
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jackarmley_eesys`
--
CREATE DATABASE `jackarmley_eesys` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `jackarmley_eesys`;

-- --------------------------------------------------------

--
-- Table structure for table `exp_accessories`
--

CREATE TABLE IF NOT EXISTS `exp_accessories` (
  `accessory_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(75) NOT NULL DEFAULT '',
  `member_groups` varchar(50) NOT NULL DEFAULT 'all',
  `controllers` text,
  `accessory_version` varchar(12) NOT NULL,
  PRIMARY KEY (`accessory_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_accessories`
--

INSERT INTO `exp_accessories` (`accessory_id`, `class`, `member_groups`, `controllers`, `accessory_version`) VALUES
(1, 'Expressionengine_info_acc', '1|5', 'addons|addons_accessories|addons_extensions|addons_fieldtypes|addons_modules|addons_plugins|admin_content|admin_system|content|content_edit|content_files|content_publish|design|homepage|members|myaccount|tools|tools_communicate|tools_data|tools_logs|tools_utilities', '1.0');

-- --------------------------------------------------------

--
-- Table structure for table `exp_actions`
--

CREATE TABLE IF NOT EXISTS `exp_actions` (
  `action_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- Dumping data for table `exp_actions`
--

INSERT INTO `exp_actions` (`action_id`, `class`, `method`) VALUES
(1, 'Comment', 'insert_new_comment'),
(2, 'Comment_mcp', 'delete_comment_notification'),
(3, 'Comment', 'comment_subscribe'),
(4, 'Comment', 'edit_comment'),
(5, 'Email', 'send_email'),
(6, 'Search', 'do_search'),
(7, 'Channel', 'insert_new_entry'),
(8, 'Channel', 'filemanager_endpoint'),
(9, 'Channel', 'smiley_pop'),
(10, 'Member', 'registration_form'),
(11, 'Member', 'register_member'),
(12, 'Member', 'activate_member'),
(13, 'Member', 'member_login'),
(14, 'Member', 'member_logout'),
(15, 'Member', 'retrieve_password'),
(16, 'Member', 'reset_password'),
(17, 'Member', 'send_member_email'),
(18, 'Member', 'update_un_pw'),
(19, 'Member', 'member_search'),
(20, 'Member', 'member_delete'),
(21, 'Navee', 'add_navigation_handler'),
(22, 'Freeform', 'insert_new_entry'),
(23, 'Freeform', 'retrieve_entries'),
(24, 'Freeform', 'delete_freeform_notification'),
(25, 'Metaweblog_api', 'incoming'),
(26, 'Iexpression', 'incoming'),
(27, 'Playa_mcp', 'filter_entries'),
(28, 'Safecracker', 'submit_entry'),
(29, 'Safecracker', 'combo_loader');

-- --------------------------------------------------------

--
-- Table structure for table `exp_captcha`
--

CREATE TABLE IF NOT EXISTS `exp_captcha` (
  `captcha_id` bigint(13) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `word` varchar(20) NOT NULL,
  PRIMARY KEY (`captcha_id`),
  KEY `word` (`word`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_captcha`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_categories`
--

CREATE TABLE IF NOT EXISTS `exp_categories` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(6) unsigned NOT NULL,
  `parent_id` int(4) unsigned NOT NULL,
  `cat_name` varchar(100) NOT NULL,
  `cat_url_title` varchar(75) NOT NULL,
  `cat_description` text,
  `cat_image` varchar(120) DEFAULT NULL,
  `cat_order` int(4) unsigned NOT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `group_id` (`group_id`),
  KEY `cat_name` (`cat_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_categories`
--

INSERT INTO `exp_categories` (`cat_id`, `site_id`, `group_id`, `parent_id`, `cat_name`, `cat_url_title`, `cat_description`, `cat_image`, `cat_order`) VALUES
(1, 1, 1, 0, 'Article', 'article', '', '0', 1),
(2, 1, 1, 0, 'Note', 'note', '', '0', 2);

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_field_data`
--

CREATE TABLE IF NOT EXISTS `exp_category_field_data` (
  `cat_id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_category_field_data`
--

INSERT INTO `exp_category_field_data` (`cat_id`, `site_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_fields`
--

CREATE TABLE IF NOT EXISTS `exp_category_fields` (
  `field_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `field_label` varchar(50) NOT NULL DEFAULT '',
  `field_type` varchar(12) NOT NULL DEFAULT 'text',
  `field_list_items` text NOT NULL,
  `field_maxl` smallint(3) NOT NULL DEFAULT '128',
  `field_ta_rows` tinyint(2) NOT NULL DEFAULT '8',
  `field_default_fmt` varchar(40) NOT NULL DEFAULT 'none',
  `field_show_fmt` char(1) NOT NULL DEFAULT 'y',
  `field_text_direction` char(3) NOT NULL DEFAULT 'ltr',
  `field_required` char(1) NOT NULL DEFAULT 'n',
  `field_order` int(3) unsigned NOT NULL,
  PRIMARY KEY (`field_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_category_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_category_groups`
--

CREATE TABLE IF NOT EXISTS `exp_category_groups` (
  `group_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  `sort_order` char(1) NOT NULL DEFAULT 'a',
  `field_html_formatting` char(4) NOT NULL DEFAULT 'all',
  `can_edit_categories` text,
  `can_delete_categories` text,
  `exclude_group` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_category_groups`
--

INSERT INTO `exp_category_groups` (`group_id`, `site_id`, `group_name`, `sort_order`, `field_html_formatting`, `can_edit_categories`, `can_delete_categories`, `exclude_group`) VALUES
(1, 1, 'Blog', 'a', 'all', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_posts`
--

CREATE TABLE IF NOT EXISTS `exp_category_posts` (
  `entry_id` int(10) unsigned NOT NULL,
  `cat_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entry_id`,`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_category_posts`
--

INSERT INTO `exp_category_posts` (`entry_id`, `cat_id`) VALUES
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(28, 1),
(29, 1),
(32, 1),
(43, 1),
(44, 1),
(46, 1),
(47, 1),
(49, 1),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(56, 2),
(58, 1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_data`
--

CREATE TABLE IF NOT EXISTS `exp_channel_data` (
  `entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `field_id_1` text,
  `field_ft_1` tinytext,
  `field_id_2` text,
  `field_ft_2` tinytext,
  `field_id_3` text,
  `field_ft_3` tinytext,
  `field_id_4` text,
  `field_ft_4` tinytext,
  `field_id_5` text,
  `field_ft_5` tinytext,
  `field_id_6` text,
  `field_ft_6` tinytext,
  `field_id_7` text,
  `field_ft_7` tinytext,
  `field_id_8` text,
  `field_ft_8` tinytext,
  `field_id_9` text,
  `field_ft_9` tinytext,
  `field_id_10` text,
  `field_ft_10` tinytext,
  `field_id_11` text,
  `field_ft_11` tinytext,
  `field_id_12` text,
  `field_ft_12` tinytext,
  `field_id_13` text,
  `field_ft_13` tinytext,
  `field_id_14` text,
  `field_ft_14` tinytext,
  `field_id_15` text,
  `field_ft_15` tinytext,
  `field_id_16` text,
  `field_ft_16` tinytext,
  `field_id_17` text,
  `field_ft_17` tinytext,
  `field_id_21` text,
  `field_ft_21` tinytext,
  `field_id_22` text,
  `field_ft_22` tinytext,
  `field_id_23` text,
  `field_ft_23` tinytext,
  `field_id_24` text,
  `field_ft_24` tinytext,
  `field_id_25` text,
  `field_ft_25` tinytext,
  `field_id_26` text,
  `field_ft_26` tinytext,
  `field_id_27` text,
  `field_ft_27` tinytext,
  `field_id_28` text,
  `field_ft_28` tinytext,
  PRIMARY KEY (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_channel_data`
--

INSERT INTO `exp_channel_data` (`entry_id`, `site_id`, `channel_id`, `field_id_1`, `field_ft_1`, `field_id_2`, `field_ft_2`, `field_id_3`, `field_ft_3`, `field_id_4`, `field_ft_4`, `field_id_5`, `field_ft_5`, `field_id_6`, `field_ft_6`, `field_id_7`, `field_ft_7`, `field_id_8`, `field_ft_8`, `field_id_9`, `field_ft_9`, `field_id_10`, `field_ft_10`, `field_id_11`, `field_ft_11`, `field_id_12`, `field_ft_12`, `field_id_13`, `field_ft_13`, `field_id_14`, `field_ft_14`, `field_id_15`, `field_ft_15`, `field_id_16`, `field_ft_16`, `field_id_17`, `field_ft_17`, `field_id_21`, `field_ft_21`, `field_id_22`, `field_ft_22`, `field_id_23`, `field_ft_23`, `field_id_24`, `field_ft_24`, `field_id_25`, `field_ft_25`, `field_id_26`, `field_ft_26`, `field_id_27`, `field_ft_27`, `field_id_28`, `field_ft_28`) VALUES
(19, 1, 1, '<p>\n	A talk I gave at Cog Design about how fonts are rendered on your computer&#39;s operating system, and the knock-on effect this has on webfonts.</p>\n', 'none', '<p>\n	This is the transcript from a talk I gave at Cog, catchity titled "How text is rendered within the Mac OS/Windows environment, and how this affects the fonts we use on websites ". It was the result of many hours of webfont research (and boring those around me with "ooh, and what about this webfont fact" phrases)...</p>\n', 'none', '<p>\n	Every time you (the user) request a font at a specific size &ndash; either by loading a webpage in your browser, or selecting a typeface/size combination from InDesign &ndash; your computer has to retrieve that font file, and display it for you on the screen.</p>\n<p>\n	Modern font files store the information for each character as mathematically precise lines and&nbsp; curves. To display these on your computer screen (made of square pixels), your computer has to convert these lines and curves to a &ldquo;bitmap&rdquo;, so they can be mapped accurately to these pixels.</p>\n<p>\n	We&#39;ll be looking at what components are responsible for this process (on both the Mac OS and Windows platform), and how the different approaches each vendor has taken affect the finished product.</p>\n<h2>\n	1: It all starts with a font file</h2>\n<p>\n	All modern font formats store the building blocks for each character of the full set as mathematical instructions, which the computer can use to construct the font, using bezier curves. This means the font can be scaled to any size without losing any information (and thus decreasing in resolution). The two most common modern font formats are Truetype and Opentype, both of which derive from Adobe&#39;s Postscript format.</p>\n<h3>\n	Postscript Type 1</h3>\n<p>\n	Uses the Postscript storage algorhythm, developed by John Warnock and Charles Gurche (the founders of Adobe) in 1984.</p>\n<p>\n	Curves made from cubic Beziers.</p>\n<p>\n	Font file contains inbuilt hinting, as it was found some characters did not scale well at small sizes.</p>\n<h3>\n	TrueType (.TT)</h3>\n<p>\n	Developed by Apple in the late 80s, to compete with Adobe&#39;s monopolising &ldquo;Postscript Type 1&rdquo; format.</p>\n<p>\n	Curves made from quadratic Beziers.</p>\n<p>\n	Hinting information resides solely in the font file.</p>\n<h3>\n	Opentype/Compact Font Format (.ot/cff)</h3>\n<p>\n	Apple sold a licence for the Truetype technology to Microsoft (in exchange for TrueImage), which they (in partnership with Adobe) used to create the TrueType-Open format (later named &ldquo;Opentype&rdquo;).</p>\n<p>\n	Curves made from cubic Beziers (which are easier to manipulate and take up less memory).</p>\n<p>\n	They can store a larger amount of information (so are often used to store multiple language sets).</p>\n<p>\n	Opentype font files are &ldquo;20-50% smaller than comparable TrueType fonts&rdquo; (ref:56). This is largely In part to &ldquo;subroutinization&rdquo; (also present &ndash; but not as significant &ndash; in Truetype fonts) which is a process that looks at all the characters in a font file, looking for path segments that are identical. Once these are found, they can be replaced by a shared routine/command. So, it figures that the more common traits the characters share, the smaller the file will be.</p>\n<p>\n	Hinting nstructions for an OpenType font file are far more general than with a TrueType one; they are general outlines passed to the rasterizer, so it is better informed when performing hinting.</p>\n<h2>\n	2: from vector to bitmap</h2>\n<p>\n	To be viewed on a computer screen, a font file&#39;s vector-based outline has to be converted to a bitmap, which can then be mapped over the pixel grid of a computer monitor.</p>\n<p>\n	This process is known as &ldquo;rasterization&rdquo;.</p>\n<p>\n	Every time you request a font at a specific size, it has to be rasterized by your computer. As this process can be expensive (in terms of computer memory), your computer will cache the rasterized characters in its local memory, so the next time the same size/font combination is requested it won&#39;t have to be rasterized again.</p>\n<p>\n	The problem rasterization has to contend with, is that font outlines are made to be infinately scalable, and viewed at a high resolution (ie: printed) and when rasterized, these fine outlines have to conform to a rigid pixel grid.</p>\n<p>\n	Pixels have a finite size; you can&#39;t get any smaller than 1 pixel in width. So, if the edge of a font character&#39;s outline doesn&#39;t intersect a pixel cleanly, the rasterizer has to decide whether that pixel should be filled with the outline, or left blank.</p>\n<p>\n	This guesswork can produce artefacts like &ldquo;dropouts&rdquo; (where really thin parts of a character, such as strokes are lost entirely), or if too many pixels are turned on, can make characters look bolder than intended. Also, losing or gaining a pixel here and there per character adds up, so the spaces between characters can become irregular, meaning the complete line of text can reflow.</p>\n<p>\n	Fortunately, some clever ways have been developed, to hep alleviate this problem...</p>\n<h2>\n	3: Hinting</h2>\n<p>\n	Introduced with the Truetype font format, &ldquo;Truetype hinting&rdquo; (to give it its full name) is a set of instructions the type designer can include within the font file, that tell the rasterizer how to align the font&#39;s characters to the monitor&#39;s pixel grid.</p>\n<p>\n	So, instead of the rasterizer having to guess whether to turn on/off a pixel that&#39;s only half intersected by a character&#39;s outline, the type designer can make this decision beforehand.</p>\n<p>\n	Hinting instructions can be declared for specific sizes of a font-face (delta hinting), or can be set to scale each character in a smart way (with parts of a character being linked to other parts), regardless of its size (general hinting).</p>\n<p>\n	The previous paragraphs assume that a pixel is &ldquo;boolean&rdquo; (can either be on, or off), but as we all know, we&#39;re not using System 7 anymore; on modern output devices, pixels can be set to may colours and levels of intensity. &ldquo;Anti-aliasing&rdquo; exploits this.</p>\n<h2>\n	4: Anti-aliasing</h2>\n<p>\n	With anti-aliasing, a pixel can set to varying levels of intensity, rather than just on or off.</p>\n<p>\n	Greyscale anti-aliasing allows the pixel to be set through shades of grey. So, if the outline of a character only partially intersects a pixel, that pixel can be &ldquo;dimmed&rdquo;, rather than switched off or on. This means that the shape of a character can be more faithfully preserved. However, if this happens in the wrong places (such as a character&#39;s ascender/descender), than the text block&#39;s legibility can decrease (as it can vary in intensity, looking like parts of it have been partially erased).</p>\n<p>\n	This technique replicates each character as best it can, given the resolution it has to work with is finite (as small as a pixel). This finite resolution was true of CRT screens, whose pixels were derived from three beams of light (red, green and blue), which were fired from the back of the monitor, and then separated into pixels using either a metal plate perforated with thousands of tiny dots (a Shadow Mask) or thousands of tiny vertical wires (an Aperture Grille).</p>\n<p>\n	Modern LCD screens however, are comprised of thousands of tiny square, indivisible and precisely defined pixels, each one of which is split vertically into 3 &ldquo;subpixels&rdquo;, coloured red, green and blue. By varying the voltage applied to each subpixel, its intensity can range over 256 shades. Combining the subpixels produces a possible palette of 16.8 million colours per pixel (256 shades of red x 256 shades of green x 256 shades of blue). For example: All three subpixels turned to maximum intensity, give the user the impression they&#39;re looking at a white pixel.</p>\n<p>\n	&ldquo;Subpixel antialiasing&rdquo; takes advantage of the divided pixels of an LCD screen by applying antialiasing at the subpixel level, effectively tripling the horizontal resolution of each character. The disadvantage of this, is because some pixels are dialed down, the 3 individual colours within each pixel can become more noticable, resulting in &ldquo;colour fringing&rdquo; on the edge of characters (which some people notice more than others).</p>\n<p>\n	Another method employed at the subpixel level is &ldquo;subpixel positioning&rdquo;, which evens out the spaces between characters using subpixels, in order to recreate (as faithfully as possible) the intended spacing between each character.</p>\n<h2>\n	How does each operating system (MS Win/Mac) employ these tools to render text?</h2>\n<h3>\n	What does Microsoft use?</h3>\n<p>\n	Microsoft has always held clarity and readibility to be most important in on-screen text. So much so, that they commissioned the design of some of the most well-known pre-installed screen fonts in use today (eg: Arial, Verdana and Georgia).</p>\n<p>\n	Let&#39;s look at Windows XP and above, since it&#39;s unlikely people will have 3.0-2000 still installed. Windows XP uses GDI+ (Graphics Device Interface), a step on from GDI. It is responsible for handling graphic information on any output device attached to the PC, which includes the monitor. In regards to text rendering, GDI+ handles the whole process on Windows XP, right down to rasterizing and anti-aliasing the text. For users of Windows XP SP2, Vista, or XP users who have installed IE7 GDI+ works with Cleartype.</p>\n<p>\n	Cleartype is a specialist bit of software specifically designed to facilitate text rendering. As its current stage, it can handle sub-pixel antialiasing, sub-pixel positioning, greyscale antialiasing and advanced Opentype features. However, how many of these features can be used all depends on the text rasterizer it is working with.</p>\n<p>\n	GDI+ can use Cleartype, but cannot use its more advanced features, like sub-pixel antialiasing.</p>\n<p>\n	However, for Vista SP2 or Windows 7 users a new rasterizer is used (in replacement of GDI+). This rasterizer is called Directwrite. It can use all the features of Cleartype, such as sub-pixel antialiasing, and so on this set-up, large fonts look a lot smoother (being Windows however, hinting is still called into play for certain fonts, up to a certain size).</p>\n<h3>\n	What does Apple use?</h3>\n<p>\n	From OS4 onwards, Apple has used Quartz to render text (this system replaced QuickDraw).</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '\n<ol style="display:none;">\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Cathode_ray_tube">Wikipedia: Cathode ray tube</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Aperture_grille">Wikipedia: (CRT) Aperture grille</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Shadow_mask">Wikipedia: (CRT) Shadow mask</a></li>\n	<li>\n		<a href="http://electronics.howstuffworks.com/lcd5.htm">Getstuff: How LCDs work</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Font_rasterization">Wikipedia: Font rasterization</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/CoolType">Wikipedia: Adobe cooltype</a></li>\n	<li>\n		<a href="http://developer.apple.com/corefoundation/overview.html">Apple Developer: Core Foundation Overview</a></li>\n	<li>\n		<a href="http://www.typotheque.com/articles/hinting">Typotheque: Font hinting</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/ClearType">Wikipedia: ClearType</a></li>\n	<li>\n		<a href="https://freddie.witherden.org/pages/font-rasterisation/">A Treatise on Font Rasterisation With an Emphasis on Free Software/</a></li>\n	<li>\n		<a href="http://www.grc.com/ctwhat.htm">How it works: Splitting the Pixel: When is a pixel not a pixel?</a></li>\n	<li>\n		<a href="http://michelf.com/weblog/2006/subpixel-antialiasing-achilles-heel">Subpixel antialiasing Achilles heel</a></li>\n	<li>\n		<a href="http://www.kilobitspersecond.com/2009/04/17/ubuntu-font-hinting-you-a-cautionary-tale/">Ubuntu, Font Hinting, &amp; You: A Cautionary Tale</a></li>\n	<li>\n		<a href="http://www.basschouten.com/blog1.php/2010/09/07/firefox-4-beta-bringing-hardware-acceler">Firefox 4 Beta: Bringing Hardware Acceleration&lt;</a></li>\n	<li>\n		<a href="http://hacks.mozilla.org/2010/11/firefox-4-font-feature-support/">Firefox 4: OpenType font feature support</a></li>\n	<li>\n		<a href="http://labs.qt.nokia.com/2010/09/09/a-second-spring-of-text-rasterization/">A second spring of text rasterization</a></li>\n	<li>\n		<a href="http://support.apple.com/kb/TA21573?viewlocale=en_US">Fonts: Bitmap, PostScript, and TrueType Compared</a></li>\n	<li>\n		<a href="http://research.microsoft.com/en-us/projects/cleartype/">Mirrosoft Research: ClearType</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/TrueTypeHintingIntro.mspx">TrueType Hinting (1 of 5):Introduction</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/TrueTypeHintingWhat.mspx">TrueType Hinting (2 of 5):What is Hinting?</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/TrueTypeHintingWhy.mspx">TrueType Hinting (3 of 5): Why is Hinting Necessary?</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/TrueTypeHintingHow.mspx">TrueType Hinting (4 of 5):How Does Hinting Help</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/TrueTypeHistory.mspx">A brief history of TrueType</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/WhatIsTrueType.mspx">What is TrueType?</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/WhatIsOpenType.mspx">What is OpenType?</a></li>\n	<li>\n		<a href="http://blogs.adobe.com/typblography/2010/11/microsoft-directwrite-is-coming.html">Adobe blogs: Microsoft DirectWrite is Coming</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/PostScript">Wikipedia: Postscript</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Web_typography">Wikipedia: Web typography</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Embedded_OpenType">Wikipedia: Embedded OpenType</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/WOFF">Wikipedia: Web Open Font Format (WOFF)</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/OpenType"> Wikipedia: OpenType</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Truetype">Wikipedia: TrueType</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Quartz_%28graphics_layer%29">Wikipedia: Quartz (graphics layer)</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Raster_graphics">Wikipedia: Raster Graphics</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Font_rasterization">Wikipedia: Font rasterization</a></li>\n	<li>\n		<a href="http://developer.apple.com/library/ios/#referencelibrary/GettingStarted/URL_iPhone_OS_Overview/">iOs Reference Library: iOS Overview</a></li>\n	<li>\n		<a href="http://billhillsblog.blogspot.com/2008/02/cleartype-technology-with-limited-shelf.html">ClearType: A technology with a limited shelf life - but still longer than David Berlow&#39;s...</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Windows_Presentation_Foundation">Wikipedia: Windows Presentation Foundation (WPF)</a></li>\n	<li>\n		<a href="http://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/OSX_Technology_Overview/GraphicsTechnologies/GraphicsTechnologies.html#//apple_ref/doc/uid/TP40001067-CH273-SW1">Mac OSX Reference Library: Graphics and Multimedia Technologies</a></li>\n	<li>\n		<a href="http://msdn.microsoft.com/en-us/library/aa925824.aspx">Microsoft: Graphics Device Interface (GDI)</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Graphics_Device_Interface">Wikipedia: Graphics Device Interface (GDI)</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/DirectWrite">Wikipedia: DirectWrite</a></li>\n	<li>\n		<a href="http://msdn.microsoft.com/en-us/library/dd371554%28v=vs.85%29.aspx">Introducing DirectWrite</a></li>\n	<li>\n		<a href="http://www.microsoft.com/typography/WhatIsClearType.mspx">Microsoft: What is Cleartype?</a></li>\n	<li>\n		<a href="http://en.wikipedia.org/wiki/Subpixel_rendering">Wikipedia: Subpixel rendering</a></li>\n	<li>\n		<a href="http://chuckskoda.com/entry/warning_against_subpixel_hinting/">Technochocolate: warning against subpixel rendering</a></li>\n	<li>\n		<a href="http://www.basschouten.com/blog1.php/2009/10/27/font-rendering-gdi-versus-directwrite">Font Rendering: GDI versus DirectWrite</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/12/17/type-rendering-review-and-fonts-that-render-well/">Typekit: Type rendering: review, and fonts that render well</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/12/14/a-closer-look-at-truetype-hinting/">Typekit: A closer look at TrueType hinting</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/12/08/type-rendering-font-outlines-and-file-formats/">Typekit: Type rendering: font outlines and file format</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/11/09/type-rendering-the-design-of-fonts-for-the-web/">Typekit: Type rendering: the design of fonts for the web</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/10/21/type-rendering-web-browsers/">Typekit: Type rendering: web browsers</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/10/15/type-rendering-operating-systems/">Typekit: Type rendering: operating systems</a></li>\n	<li>\n		<a href="http://blog.typekit.com/2010/10/05/type-rendering-on-the-web/">Typekit: Type rendering on the web/</a></li>\n	<li>\n		<a href="http://www.ascendercorp.com/support/font-formats/">Ascender Corporation: Font Formats</a></li>\n	<li>\n		<a href="http://blogs.adobe.com/">Adobe: The benefits of OpenType/CFF over TreType Postscript</a></li>\n</ol>\n', 'xhtml', NULL, 'none', NULL, 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(20, 1, 1, '<p>\n	When picking webfonts and becoming frustrated with their looks on a PC, remember not everyone owns a Mac...</p>\n', 'none', '<p>\n	When picking a webfont, a designer should always remember to think outside the mac.</p>\n', 'none', '<p>\n	It&#39;s true, due to the Quartz rendering engine on the Mac OS, mac users will get more smoothly rendered fonts across all browsers, but this doesn&#39;t mean if a font you pick doesn&#39;t look as smooth on windows it should be discounted.</p>\n<p>\n	Rather, you should focus on how clear it is (how easy to read), because Windows users are used to seeing fonts rendered on Windows (yes, even Georgia looks different).</p>\n<p>\n	So always remember clarity, as well as smoothness is important.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '1', 'none', '1', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(5, 1, 2, '', NULL, '', NULL, '', NULL, 'blue', 'none', '<p>\n	Semantic Markup is the practice of ensuring your webpages are built correctly, using the most appropriate HTML tags. It helps to ensure the page will still be usable in the worst-case scenario (such as if the user has no Javascript or Flash installed).</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', NULL, 'none', NULL, 'none', NULL, 'xhtml', NULL, 'none', NULL, 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(6, 1, 2, '', NULL, '', NULL, '', NULL, 'green', 'none', '<p>\n	Being a commercial product, Expression Engine has steady, dependable release cycles and if something goes wrong, you know a member of the EllisLab team will be on hand to provide support. Also, its tags work around your markup (not the other way round).</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', NULL, 'none', NULL, 'none', NULL, 'xhtml', NULL, 'none', NULL, 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(7, 1, 2, '', NULL, '', NULL, '', NULL, 'red', 'none', '<p>\n	CSS provides a web page with style, and version 3 is the newest, most advanced specification. Although its full toolset is not yet fully supported, it provides even more tools to the web designer, making possible things like advanced type styling and rounded corners.</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', NULL, 'none', NULL, 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(8, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	To cope with the Thames Festival&#39;s suddenly huge audiance, this site needed to look great but perform even better.</p>\n', 'none', '<p>\n	"London&#39;s largest outdoor arts festival" pulled in 825,000+ visitors in 2010, with the website recieving 1.25m page views.</p>\n', 'none', '<p>\n	As part of Cog Design, I helped build the site in Expression Engine (with the design concept being provided by "Why Not"). During the build process, we focused on speed, taking as many steps as we could to ensure the site would be ready for the large traffic levels it recieves over the festival. One of these steps was to use webfonts to serve the site&#39;s headline font (Amasis).</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.thamesfestival.org/', 'none', 'website', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(9, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	A large site for a popular local theatre, which has to be intergated with the Corn Exchange&#39;s existing booking system.</p>\n', 'none', '<p>\n	Located in beautiful Newbury, the Corn Exchange (and New Greenham Arts) run a packed schedule of flms, performances and workshops.</p>\n', 'none', '<p>\n	The site is focused on making these events easy to browse through and book.</p>\n<p>\n	It is cleanly laid out, with text set in easy-to-read Verdana, and the headline font was originally added to the site using sIFR (a technique that uses Abobe Flash to apply the font file to selected text).</p>\n<p>\n	Just before I left the team at Cog Design however, I helped update the site, replacing the sIFR text with modern, quick-loading webfonts, which meant we could give the site the typographic look we had originally intended it to have. Also, some nice megamenus were added to the navigation, to help users find key content quickly and easily.</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.cornexchangenew.com', 'none', 'website', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(13, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	A site that literally switches sides, to help bring across this small but bold theatre company&#39;s unique character.</p>\n', 'none', '<p>\n	Founded in 1993, Told by an Idiot is a small theatre company with a big reputation.</p>\n', 'none', '<p>\n	To help convey their quirky, playful personality their website switches randomly between a left / right aligned layout when a new page is loaded.</p>\n<p>\n	Whilst each page is clean and easy to read, it is surrounded by playfully cut-out images from their back-catalouge of productions, and each page has a colourful, vibrant background.</p>\n<p>\n	I helped build the site in Expression Engine, as part of Cog Design</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.toldbyanidiot.org', 'none', 'website', 'none', '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(14, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	A dynamic and content-packed site, to help EEA sell themselves, and engage their loyal followers.</p>\n', 'none', '<p>\n	Emergency Exit Arts put on energenic, dazzling street performances for hire.</p>\n', 'none', '<p>\n	&nbsp;They came to Cog Design needing a personality-packed, bold site to showcase their offering, and help people see what they do. The site was given a clean layout, letting their numrous bold images sing, and each section can be previeved through the main navigaton bar through a "megamenu", so the visitor can get a sense of what is contained in each area of the site. To allow EEA to manage the content, the site was built in Expression Engine.</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.eea.org.uk', 'none', 'website', 'none', '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(15, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	My first Expression Engine site, built for an organisation that helps local communities to have a voice.</p>\n', 'none', '<p>\n	The Fair Share Trust (part of the Community Foundation Network) exists to help local communities to have a voice.</p>\n', 'none', '<p>\n	This was the first site I built at Cog Design, and the first site I built using Expression Engine.</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.fairsharetrust.org', 'none', 'website', 'none', '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(10, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	A dynamic and content rich site to showcase Immediate Theatre&#39;s great work with young people.</p>\n', 'none', '<p>\n	This site had to showcase all the fantastic work Immediate Theatre does with young people.</p>\n', 'none', '<p>\n	All the content within the site was clearly laid out, with the surrounding space dominated by a large randomly picked image. Their tagline "Inclusive. Interactive. Imaginative" is placd front-and-center on every page to ensure that whatever page a visitor comes to the site from they&#39;ll have some idea of Immediate Theatre&#39;s approach.</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.immediate-theatre.com/', 'none', 'website', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(11, 1, 2, '', NULL, '', NULL, '', NULL, 'yellow', 'none', '<p>\n	HTML5 (now referred to as just "HTML" - don&#39;t ask!) builds on top of the existing HTML tagset, providing tags which help make webpages even more accessable and extensible.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '', 'none', '', 'xhtml', '', 'none', NULL, 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(12, 1, 4, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	I relish the challenge of building beautiful, usable websites that people love to visit.</p>\n', 'none', '<p>\n	<img alt="A picture of Jack Armley" class="gu-float_rt" src="{filedir_1}graphicassets-biopic.png" style="width: 132px; height: 190px;" /></p>\n<p>\n	I&#39;ve been making stuff for the web in some form or another for longer than I can remember (my first website was for my mum - isn&#39;t that a mantle every web designer has to step to at some point), and have been building sites full-time for the last 5 years or so.</p>\n<p>\n	I cut my teeth as an in-house designer for Lewisham CLC, where I learnt (by trial and error) the fundamentals of building and maintaining live websites. The position allowed me to experiment with the best ways of building lean, beautiful CSS on top of semantic, accessable HTML.</p>\n<p>\n	Next I worked for ThruSites (now ThruDigital), where I was tasked with producing finished web graphics which would be passed onto their developers to be built. It was a great experience, where I got the chance to work directly with their clients, building the designs.</p>\n<p>\n	In early 2008 I started work at <a href="http://www.cogdesign.com">Cog Design</a>, helping to build beautiful websites for clients mainly in the creative sector. With every project the best solution was found to suit the client&#39;s needs. All the sites were built with usability and accessability in mind, utilising the most current web standards applicable.</p>\n<p>\n	On June 13th 2011, I started work at <a href="http://www.tangentsnowball.com/">Tangent Snowball</a> (in central London) as a front-end designer. Excitingly, we&#39;re currently working on creating our own open-source #webfont icon set, called Snowcone. Should be an interesting challenge!</p>\n', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(16, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	Being a young people&#39;s theatre company, YMT needed a site to reassure parents and engage their existing members.</p>\n', 'none', '<p>\n	YMT work with young people, putting on engaging, professionally directed musical theatre.</p>\n', 'none', '<p>\n	They came to Cog with an existing site, which included a forum used by their young members. Their new site had to include a forum too, as well as being a place for parents to get information on how to enrol their children, and for their children to see the performances they were a part of. Having a such a split focus, the site had to be fun and energetic on the one hand, and informative and reassuring on the other.</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.youthmusictheatre.org', 'none', 'website', 'none', '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(17, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	A new, clean and informative site for ancient Order of St John&#39;s museum in Clearkenwell</p>\n', 'none', '<p>\n	The Order of St John originated in 11th Century Jerusalem and the museum building is what&#39;s left of their London home, which used to take up most of Clearkenwell.</p>\n', 'none', '<p>\n	To help bring across their immense history, and serve their offering clearly and succinctly, the site utilizes a simple, easy-to-read layout which puts their wealth of images and history central stage.</p>\n<p>\n	I helped to build the site as part of Cog Design.</p>\n', 'none', '1', 'none', '1', 'none', 'http://museumstjohn.org.uk/', 'none', 'website', 'none', '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(18, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	Music company Done-and-Dusted needed new site, and I was asked to create the designs</p>\n', 'none', '<p>\n	As part of ThruSites (now ThruDigital), I created a set of visual designs for a potential Done-and-Dusted website.</p>\n', 'none', '<p>\n	As they&#39;re in the business of making music videos, their site had to be both showcase and marketing platform.</p>\n', 'none', '1', 'none', '1', 'none', '', 'none', 'visual_concept', 'none', '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(21, 1, 1, '<p>\n	When building a website, using good naming conventions can reap rewards, and save lots of stress.</p>\n', 'none', '<p>\n	Ever looked at your file list and seen "untitled_1.jpg", "image_green.jpg" and the rest? To avoid this situation, you gotta get a little geeky.</p>\n', 'none', '<p>\n	I think (especially when working as part of a team), that making rules for yourself is really important. One such rule I always stick to, is to use good naming conventions.</p>\n<p>\n	For me, this applies across the board, but I thought I&#39;d share the geeky way I name images. Previous to defining a rigid system for myself, I could devise no sensible way of naming an image. If, for example you have the image for a twitter icon, do you call it: twitter_icon, twitter_bird, twitter_image etc...? For some, maybe not important I can understand; for me, it kept me awake at night</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<p>\n	The system I came up with, was to start the image name with the area the image would be used, then state the function of the image (background image, replaced text, logo and so on), then give it a unique name. So, the image for a twitter icon, located in the site&#39;s footer would be:</p>\n<p>\n	<code>footer-icon_twitter.gif (location-function_uniqueName)</code></p>\n<p>\n	For me, this saves time during a build, as I don&#39;t have to constantly think about what to call something. Also, when I have a list of images (which can happen even if you&#39;re using a sprite image),. it&#39;s easier to scan what goes where.</p>\n<p>\n	Drop a comment, and let me know your naming conventions (or if I&#39;m totally geeky and need to get out more).</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(22, 1, 1, '<p>\n	Think of your CSS styles like "legos" (aka Nicole Sullivan) - go modular snippets with our CSS; It will save bytes, and lots of agro</p>\n', 'none', '<p>\n	When working on large builds, and especially when rolling a site out based on a CMS like Expression Engine, I think unlocking your styles from a specific location and making them modular, is really important.</p>\n', 'none', '<p>\n	We (as web designers) alll know how to construct a descendent selector, right? It&#39;s a way of targeting an element, based on its poition within the DOM tree. So, this is a good example:</p>\n<p>\n	<code>section#main_content article h1&#123;<br />\n	color:red;<br />\n	&#125;</code>\n<p>\n	Here, you&#39;d apply a red color to an h1 located within a article, which in turn sat inside a section called "content". This is all very well, but what if that article were to be dropped elsewhere? Like in a section called #secondary_content? In this case, you&#39;d have to re-declare your rule, which bloats your stylesheet and means you&#39;ve got to keep tabs on two rules.</p>\n<p>\n	With the object-oriented approach championed by Nicole Sulliva (at <a href="http://oocss.org/">oocss.org</a>), you&#39;d create that style once for the article, then you could move it wherever you please. So, to make the article location-independant you&#39;d have to give it a unique identifier (in the form of a class). With this rule done, your CSS would look like this:</p>\n<p>\n	<code>article.listing h1&#123;<br />\n	color:red;<br />\n	&#125;</code>\n<p>\n	Now, you can drop it wherever you please, and your CSS is smaller and thus quicker to download. Neat eh? You can take this much further, by constructing extensble classes that stack on top of one another to change the appearanbce of your modular element, but that&#39;s for a later post I guess.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '', 'none', '', 'none', '1', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(23, 1, 1, '<p>\n	When picking out webfonts, learn to know your enemy (or, stop worrying and learn to love the rasterizer)</p>\n', 'none', '<p>\n	Know your enemy (or, stop worrying and learn to love the rasterizer).</p>\n', 'none', '<p>\n	After using techniques like Cufon,&nbsp; <abbr title="Shaun Inman Flash Replacement">sIFR</abbr> or even image replacement to bring custom fonts into websites, we expect (when switching to webfonts) for our font to look smooth and consistent across all browsers. When using webfonts, we need to adjust our expectations, as given a font needs to be rendered by the user&#39;s computer, the quirks of each system come into play and this consistency just isn&#39;t possible. Instead, we need to understand how fonts are rendered on each system (by which I mean MacOS, <abbr title="i Operating System">iOS</abbr> and Windows), so we know what users expect to see. With this knowledge, we can safely hunt for a "bulletproof" webfont (by which I mean one that is clear and readable at small sizes, and (ideally) smooth at large sizes, with each letter spaced equally and aligning to the baseline).</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<p>\n	In a future post (which I guess will be part 2), I&#39;d like to share how I test for a bulletproof webfont but first, It&#39;s important to understand the landscape we&#39;re operating in here so, introducing the "rasterizer":</p>\n<h2>\n	Ok, so what&#39;s a rasterizer?</h2>\n<p>\n	Before your webfont even makes it to the browser, it needs to be transformed from it&#39;s raw form (a set of mathematical instructions consisting of points and curves) to a bitmap, which is then laid out across the pixels of your monitor. This is what the rasterizer does.</p>\n<p>\n	For a webfont to come out of this process unscathed is a small miricle. All the fine details of each character have to be represented by pixels, which have a finite size. So, if the upstroke of a "d" for example, falls between two pixels it may not be rendered at all. Through the relatively short time screen fonts have been available, a number of technologies have been created to try and circumvent this issue:</p>\n<h3>\n	Hinting</h3>\n<p>\n	"Hinting" is a set of instructions embedded into each character of a font set that tell the rasteriser where the pixels of each character should fall, when they&#39;re laid out on the pixel grid of your monitor. This often means that the space of a character in a hinted font can change at different sizes, as it&#39;s outline has been manually adjusted to ensure it falls perfectly onto the pixel grid.&nbsp; These instructions remove the guesswork from the rasteriser; the font creator can control exactly how each character will look on screen. Hinting instructions are often applied anew at specific sizes (delta hinting) but auto hinting can also be used (which is not as precise). I could go on forever, but for more detail typotheque have a <a href="http://www.typotheque.com/articles/hinting" title="Read this article on hinting by Peter Biľak; it''s a gas I assure you!">great article on hinting.</a></p>\n<h3>\n	Anti-aliasing</h3>\n<p>\n	Anti-aliasing gives the rasterizer a little more choice, when it has to convert a character&#39;s outline to pixels. With no anti-aliasing, a rasterizer has the choice between turning a pixel on, or off (think black or white) so, if it makes an incorrect decision about where the outline should fall that outline will either not be represtned at all, or will be bloated with additional pixels being filled in. With anti-aliasing switched on, a rasterizer can choose to vary a pixel&#39;s intensity through shades of grey, as well as just black and white. As a result, when confronted with an outline that may not fall perfectly in line with the pixel grid, it can choose to render those pixels in a shade of grey. This most basic type of anti-aliasing is called "Greyscale" .</p>\n<h3>\n	Sub-pixel anti-aliasing / positioning</h3>\n<p>\n	Greyscale anti-aliasing is definately an improvement on no anti-aliasing at all, but it still means that without the correct instructions (hinting), a rasterizer has the potential to turn part of a character&#39;s outline grey, when it should be black (this can result in parts of some chacacters looking like they&#39;ve been partially erased). Sub-pixel antialiasing attempts to lessen this effect, by exploiting the pixel composition of LCD monitors.</p>\n<p>\n	Whereas a <abbr title="Cathode Ray Tube">CRT</abbr> monitor&#39;s pixels are created by physically splitting up the light projected from the rear of the monitor into fragments (using a metal screen punched with tiny holes, or hundreds of tiny wires spaced vertically behind the glass screen of the monitor), the pixels of an LCD screen are far more precise. Each pixel is a perfect square, split vertically into 3 tiny strips (most commonly ordered: red, green and blue) that can be individually varied in intensity, to control the colour of the pixel. With sub-pixel anti-aliasing, when the outline of a character falls across a pixel, not only can the pixel by&nbsp; varied in intensity through black, grey and then white, but each of its 3 "sub-pixels" can too. This means rendering can be far more precise, and some rasterizers can even shift each character&#39;s position by the sub-pixel to more faithfully repicate the letter-spacing intended by the type designer. The only shortfall of this method, is that given a pixel is split horizontally into thirds, the same precision cannot be achieved vertically. So, rasterizers often sub-pixel render horizontally, and fall-back to greyscale rendering in the vertical direction (known as <em>y-direction anti-aliasing</em>).</p>\n<p>\n	How many of these methods are used all depends on the operating system, and the different ways each operating system render text means a font may look completely different on a Mac or windows PC, or even on two different windows installs.</p>\n<h2>\n	So, how does Mac do it?</h2>\n<p>\n	Mac <abbr title="Operating System">OS</abbr> (since 10.4) uses "Quartz" to rasterize text. Quartz is a powerful rasterizer, able to handle sub-pixel anti-aliasing, sub-pixel positioning and y-direction anti-aliasing. As such, Quartz chooses to ignore a font&#39;s inbuilt hinting instructions (which makes it a "smart rasterizer"), and instead tries it&#39;s best to stay true to the original shape of each character, and the spacing of each letter from one another. This results in letters looking smooth and consistent (Windows fans say "blurry" and with some fonts, I tend to agree).</p>\n<p>\n	With <abbr title="i Operating System">iOS</abbr>, sub-pixel anti-aliasing is not used, because iOS devices are made to be turned round (from portrait to landscape orientation, and vice-versa) and as a result, the vertical strips a pixel is split into become horizontal. Fortunately, particularly with a Retina display this really isn&#39;t noticable. Fonts actually look sharper, given the pixels on those displays are half the size of their desktop cousins.</p>\n<h2>\n	What about Windows?</h2>\n<p>\n	GDI+ (Graphics Device Interface +) is a core Windows component responsible for outputting all graphics (including text) to all output devices, including the monitor; It has shipped with Windows since XP (which is as far back as I&#39;m going). Unlike Apple, Microsoft don&#39;t place all the emphasis on staying faithful to a font&#39;s original form, when rasterizing each character. Of higher importance, is that each font is readable and sharp, with a consistent grey value across a block of text. In accordance with this philosophy, <abbr title="Graphics Device Interface +">GDI+</abbr> will attempt to snap the outlines of each character to the nearest pixel, when&nbsp; laying it out over the monitor&#39;s grid. As such, it relies almost entirely on a font&#39;s inbuilt instructions (making it a "dumb" rasterizer). If these hints aren&#39;t present, the rasterizer will have to guess and with it&#39;s abilities stretching only as far as greyscale anti-aliasing, this guesswork often results in poorly rendered fonts. Of course, well-hinted screen fonts (like Georgia, Verdana and Arial) look beautiful, crisp and black in GDI+, as each outline is perfectly placed over the pixel grid.</p>\n<p>\n	With the advent of the <abbr title="Liquid Crystal Display">LCD</abbr> screen (and sub-pixels) however, Microsoft saw a chance to improve font rendering, possibly even on poorly-hinted fonts...</p>\n<h3>\n	Bring on cleartype</h3>\n<p>\n	Cleartype is a powerful program whose only function is to provide sub-pixel rendering abilities to the rasterizer. It can do everything on a sub-pixel level, that Quartz can (repeat after me: sub-pixel anti-aliasing and sub-pixel positioning) however, how many of these abilities can be exploited all depends on the rasterizer using Cleartype.</p>\n<p>\n	<abbr title="Graphics Device Interface +">GDI+</abbr> can only use Cleartype&#39;s sub-pixel rendering function and, when this is turned on GDI+ can no longer do greyscale anti-aliasing. This means that, with the combination of GDI+ and Cleartype, no y-direction anti-aliasing is being done, which becomes really noticable when a font is set at a large size (you&#39;ll see it&#39;s curved parts can look a little jaggy).</p>\n<p>\n	To smooth out these final niggle, Windows brought out Directwrite...</p>\n<h3>\n	So step in Directwrite</h3>\n<p>\n	Directwrite (shipped with Windows 7) has much more advanced text-rendering capabilities than GDI+ and (although GDI+ is still responsible for outputting all graphics) If an application chooses, it can tell GDI+ to hand over responsibility of rendering text (within that application only) to Directwrite. When Directwrite asks Cleartype to handle it&#39;s sub-pixel rendering, it can access its full feature set. As a result (and because Directwrite doesn&#39;t snap to pixel so much) the rasterization produced by Directwrite and Cleartype is much closer to Quartz on MacOS.</p>\n<p>\n	As an aside, Microsoft also came out with WPF (Windows Presentation Foundation), a rasterizer which has much the same abilities as Directwrite. However, it was eclipsed by Directwrite, and the only place I ever see it in in the plugins list for Firefox 4 (it uses WPF to improve text rendering within the browser).</p>\n<h2>\n	How does this all come together in my browser?</h2>\n<h3>\n	Mac OS/iOS</h3>\n<p>\n	As Quartz is a core component of the Operatng System, all browsers will use it for text rendering as as such, text will render the same in every browser on a Mac.</p>\n<h3>\n	Windows XP</h3>\n<p>\n	<abbr title="Graphics Device Interface +">GDI+</abbr> with Cleartype switched off is the default mode in Windws XP. As GDI+ is a core component of the Operating System, all browsers will honour this setting (except Firefox 4, which&nbsp; uses the Windows Presentation Foundation plugin). However, if IE7 is installed, Cleartype will be switched on for <abbr title="Internet Explorer 7">IE7</abbr> only. If <abbr title="Internet Explorer 8">IE8</abbr> is installed, Cleartype will be switched on system-wide, meaning all browsers will honour this setting.</p>\n<h3>\n	Windows Vista / Windows 7</h3>\n<p>\n	<abbr title="Graphics Device Interface +">GDI+</abbr> with Cleartype is switched on is the default within Vista/7 (so, all browsers will use this setting). However, Firefox 4 will use WPF to render it&#39;s text and, if <abbr title="Internet Explorer 9">IE9</abbr> is installed it will use Directwrite.</p>\n<h2>\n	To conclude</h2>\n<p>\n	If you&#39;re still awake down here, you&#39;ll hopefully be somewhat enlightened on the complex dance between the OS, browser, font and rasterizer. Do join me in part 2, where I&#39;ll go through how to put a webnfont throughall these different environments, to see if it comes out unscathed.</p>\n<p>\n	&nbsp;</p>\n', 'none', '', 'none', '1', 'none', '1', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(24, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	A site built all in Flash, to showcase student work from a secondary level web-design course.</p>\n', 'none', '<p>\n	I created the iluv2 site for Lewisham CLC; it stemmed from a web design course they were running with their students.</p>\n', 'none', '<p>\n	The end goal of the course was to get their website published, and this site was a tool to publish and host each site. Although I designed this way back in 2006, I still love it; I really got to flex my illustrating muscle, designing all the graphics and logo from scratch. Also, given the entire site is built in Flash, I got to create some beautiful animations and play with in-depth Actionscript.</p>\n', 'none', '1', 'none', '1', 'none', '', 'none', 'website', 'none', '', NULL, '', NULL, '', 'xhtml', '', NULL, '<iframe width="640" height="480" src="http://www.youtube.com/embed/A6Udz5XQ9SU" frameborder="0" allowfullscreen></iframe>', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none');
INSERT INTO `exp_channel_data` (`entry_id`, `site_id`, `channel_id`, `field_id_1`, `field_ft_1`, `field_id_2`, `field_ft_2`, `field_id_3`, `field_ft_3`, `field_id_4`, `field_ft_4`, `field_id_5`, `field_ft_5`, `field_id_6`, `field_ft_6`, `field_id_7`, `field_ft_7`, `field_id_8`, `field_ft_8`, `field_id_9`, `field_ft_9`, `field_id_10`, `field_ft_10`, `field_id_11`, `field_ft_11`, `field_id_12`, `field_ft_12`, `field_id_13`, `field_ft_13`, `field_id_14`, `field_ft_14`, `field_id_15`, `field_ft_15`, `field_id_16`, `field_ft_16`, `field_id_17`, `field_ft_17`, `field_id_21`, `field_ft_21`, `field_id_22`, `field_ft_22`, `field_id_23`, `field_ft_23`, `field_id_24`, `field_ft_24`, `field_id_25`, `field_ft_25`, `field_id_26`, `field_ft_26`, `field_id_27`, `field_ft_27`, `field_id_28`, `field_ft_28`) VALUES
(25, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	The Norfolk and Norwich festival is well-estalished with a large audiance, but they needed a punchy online prescence.</p>\n', 'none', '<p>\n	The Norfolk and Nowich Festival is long-established, with a varied programme and audiance.</p>\n', 'none', '<p>\n	The 2011 site is well-laid out, making it easy for festival-goers to buy tickets, and also has an engaging interactive element (NNF Live) where, during the festival, photos can be submitted to a Flickr group which are then fed into the site.</p>\n<p>\n	Cog Design had created their site for 2010, so this site built on that structure, with changes made based on user and client feedback. A significant change was to bring in their headline font as a webfont.</p>\n', 'none', '1', 'none', '1', 'none', '', 'none', 'website', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(26, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	Part of a series of Flash micro-sites to promote musical tours from the Contemprary Music Network</p>\n', 'none', '<p>\n	As part of Cog Design, I helped to produce this Flash microsite for the Approximately Infinite Universe tour (2008).</p>\n', 'none', '<p>\n	Using Flash enabled a rich animation to be the main feature of the site, to engage the visitor and tie in with the campaign material for the tour. Also, whilst viewing informtaion for the tour, the visitor could play music tracks.</p>\n', 'none', '1', 'none', '1', 'none', '', 'none', 'website', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '<iframe width="640" height="480" src="http://www.youtube.com/embed/Uxp_va7GrcE" frameborder="0" allowfullscreen></iframe>', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(27, 1, 4, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	You appear to have taken a wrong turn; I can&#39;t find the page you&#39;re looking for, so maybe you&#39;d like to start from the <a href="http://www.jackarmley.co.uk">home page?</a></p>\n<p>\n	<img alt="A little mouse sniffing the ground" class="float_right" src="{filedir_1}generalimg-404_page.png" /></p>\n', 'none', '<p>\n	&nbsp;</p>\n<p>\n	&nbsp;</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(28, 1, 1, '<p>\n	How to know what webfont you need, and how to find it.</p>\n', 'none', '<p>\n	How to know what webfont you need, and how to find it.</p>\n', 'none', '<h2>\n	Get a "virtual clipboard"</h2>\n<p>\n	To ensure we&#39;ve not just blindly stumbling around when searching for our webfont, it&#39;s useful to have a "virtual clipboard" of questions and requirements to keep with us. This way, our search will be more efficiant and more focused.</p>\n<h3>\n	Questions need to ask ourselves</h3>\n<ol>\n	<li>\n		What size/sizes will the webfont be used for?</li>\n	<li>\n		What character set does the webfont need; latin, or more extensive?</li>\n	<li>\n		Will a bold weight be required for the font (in case the author makes use of the &lt;Strong&gt; tag).</li>\n	<li>\n		Will an italisized version be required for the font (in case the author makes use of the &lt;em&gt; tag).</li>\n	<li>\n		How much traffic does the site using the webfont recieve per month?</li>\n	<li>\n		How many domains will the webfont be used on?</li>\n</ol>\n<h3>\n	Basic requirements of any webfont</h3>\n<ol>\n	<li>\n		The webfont should be bundled with all the file formats neccesary for it to work successfully across all supported browsers/devices:\n		<ul>\n			<li>\n				Opentype (TT/OTF)</li>\n			<li>\n				Web Open Font Format (WOFF)</li>\n			<li>\n				Embedded OpenType (EOT)</li>\n			<li>\n				Scalable Vector Graphics (SVG)</li>\n		</ul>\n	</li>\n	<li>\n		If the webfont is being paid for it&#39;s file formats should be protected from being stolen or used on unsanctioned sites.</li>\n	<li>\n		If the webfont is free there should be a way of crediting it&#39;s designers.</li>\n</ol>\n<h2>\n	Finding the right service</h2>\n<p>\n	There are two ways of bringing a webfont onto your site: firstly, the font-files can be uploaded to your website&#39;s server and secondly, can be hosted on a dedicated third-party service (of which Typekit is the most well known). Let&#39;s look at the options:</p>\n<h3>\n	The free, self-hosted solution</h3>\n<p>\n	Fontsquirrel is the go-to place for free webfonts. Some well-known foundries (Exjilbris and the League of Movable Type) provide downloads of their fonts on their own sites too. The advantage of these sites is - obviously - the fonts are free. Howver, the caveat of this is that free fonts, however well built can sometimes lack the full character set of commercial fonts (Exlibris provides cut-down versions of their commercial fonts for free, for example), and also on occasion may not be as well built as their commercial counterparts.</p>\n<p>\n	The way to serve free fonts is always by uploading the font files to your own server (or that of the website you&#39;re working on). However, if a faster dedicated webfont server is needed, <a href="http://typefront.com/">Typefront </a>is a good option.</p>\n<h3>\n	The paid-for, third-party hosted option</h3>\n<p>\n	There are quite a few services now, offering a plethora of fonts on a monthly or yearly subscription basis.</p>\n<p>\n	&nbsp;</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '', 'none', '', NULL, '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(30, 1, 4, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '<p>\n	If you&rsquo;ve an aversion to the multiple places I post on the web,<br />\n	feel free to get in touch here!</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(31, 1, 2, '', NULL, '', NULL, '', NULL, 'blue', 'none', '<p>\n	It&#39;s all very well working on projects each day, but attending nightly meetups about web-design (or any other topic) is a great way to challenge your perceptions and bring new ideas into your daily work.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(32, 1, 1, '<p>\n	An often overlooked step in the process of optimising a website is to clean up the style sheet</p>\n', 'none', '<p>\n	A stylesheet may seem small, but the kilobytes can add up. Sticking to a few simple rules can help keep the weight off.</p>\n', 'none', '<h2>\n	Don&#39;t create empty rules, or comment out un-needed ones</h2>\n<p>\n	It&#39;s very tempting when creating styles to open empty rules for HTML elements you&#39;ve created, like the below, which can be filled in later:</p>\n<pre>\n.video_container{}</pre>\n<p>\n	I find that, often these empty rules get forgotton about ad end up lingering in the stylesheet. Although they contain no actual rules, they still need to be processed by the browser so I&#39;d always recommend:</p>\n<p>\n	only creating new rules if you&#39;re going to use them,</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '<p>\n	In the same way, commented-out rules like:</p>\n<pre>\n/*video_container{padding:10px;}*/</pre>\n<p>\n	can be forgotton about. If these types of rules may be needed later, I&#39;d recommend putting them in a fresh text document as a backup, so you&#39;ll have them if needed.</p>\n<h2>\n	Avoid unneccesary selectors</h2>\n<p>\n	When the rules stack up, it can be difficult to navigate the stylesheet, and one way to keep tabs on what rules refers to where on the site, is to prefix the rule with the name of the element, or use descendant selectors to indicate where a rule belongs; like so:</p>\n<pre>\nbody div#content-wrapper div#content-main div.panel h2{&#10;font-size:16px;&#10;line-height:18px;&#10;}</pre>\n<p>\n	This rule will work fine, but the browser has a lot of work to do to process it. Also, due to the amount of selectors used the rule has a really high specicifity (a value of 215 to be precise), which means that, if it needs to be overridden elsewhere in the stylesheet even more selectors will have to be used, in turn adding more weight and complexity to the stylesheet.<span style="font-weight: bold;"> </span></p>\n<p>\n	To avoid this, I use the minimal amout of selectors neccesary to give the element I&#39;m targeting a unique set of styles, which using the above example would be:</p>\n<pre>\n.panel h2{&#10;font-size:16px;&#10;line-height:18px;&#10;}&#10;</pre>\n<p>\n	If you&#39;ve quite a few rules and you want to keep track of what beongs to what, rather than using lots of elements and descendent selection, I find it better to indent them:</p>\n<h3>\n	Before</h3>\n<pre>\nbody{&#10;height:100%;&#10;background-color:#fff;&#10;}</pre>\n<br />\n<pre>\nbody #content-wrapper{&#10;width:960px;&#10;margin:0 auto;&#10;}</pre>\n<br />\n<pre>\nbody #content-wrapper #content-main{&#10;width:600px;&#10;float:left;&#10;}&#10;&#10;body #content-wrapper #content-main .panel{&#10;padding:20px;&#10;background-color:#ccc;&#10;}&#10;&#10;body #content-wrapper #content-main .panel h2{&#10;font-size:1.2em;&#10;margin:0 0 .5em 0;&#10;color:#000;&#10;}&#10;&#10;body #content-wrapper #content-main .panel p{&#10;font-size:1em;&#10;margin:0 1em 0;&#10;color:#333;&#10;} </pre>\n<h3>\n	After</h3>\n<pre>\nbody{&#10;height:100%;&#10;background-color:#fff;&#10;}&#10;&#10;#content-wrapper{&#10;width:960px;&#10;margin:0 auto;&#10;}&#10;&#10;#content-main{&#10;width:600px;&#10;float:left;&#10;}&#10;&#10;.panel{&#10;padding:20px;&#10;background-color:#ccc;&#10;}&#10;&#10;.panel h2{&#10;font-size:1.2em;&#10;margin:0 0 .5em 0;&#10;color:#000;&#10;}&#10;&#10;.panel p{&#10;font-size:1em;&#10;margin:0 1em 0;&#10;color:#333;&#10;} </pre>\n<p>\n	You&#39;ll notice that all the CSS rules I&#39;ve written are on one line; this helps to keep the stylesheet smaller and makes it easier to scan throught. Of course this is purely preference; I find it easier to work with but of course, others may prefer to put each rule on a new line.</p>\n<h2>\n	Group shared properties together</h2>\n<p>\n	Another thing I tend to do, is to group together rules I know will be needed time and again throughout the stylesheet; what&#39;s the point of re-declaring something over and over again? To group multiple selecters behind one rule again, makes the stylesheet lighter and easier to manage.</p>\n<p>\n	So for example this...</p>\n<pre>\nh1{&#10;font-family:Arial,helvetica,sans-serif;&#10;font-weight:bold;&#10;color:#333;&#10;font-size:2em;&#10;}&#10;&#10;h2{&#10;font-family:Arial,helvetica,sans-serif;&#10;font-weight:bold;&#10;color:#333;&#10;font-size:2em;&#10;}&#10;&#10;h3{&#10;font-family:Arial,helvetica,sans-serif;&#10;font-weight:bold;&#10;color:#333;&#10;font-size:2em;&#10;}</pre>\n<p>\n	Becomes this:</p>\n<pre>\nh1,h2,h3{&#10;font-family:Arial,helvetica,sans-serif;&#10;font-weight:bold;&#10;color:#333;&#10;font-size:2em;&#10;}</pre>\n<p>\n	Additionally, if I want to declare a new size for each font, I could re-declare this new rule underneath, along with other unique properties, like so:</p>\n<pre>\nh1,h2,h3{&#10;font-family:Arial,helvetica,sans-serif;&#10;font-weight:bold;&#10;color:#333;&#10;}&#10;&#10;h1{&#10;font-size:2em;&#10;margin:0 0 0.25em 0;&#10;}&#10;&#10;h2{&#10;font-size:1.5em;&#10;margin:1em 0 0.5em 0;&#10;}&#10;&#10;h3{&#10;font-size:1.2em;&#10;margin:0.75em 0 0.5em 0;&#10;}</pre>\n<h2>\n	Extending this thinking</h2>\n<p>\n	Of course, here I&#39;ve started to foray a little into Modular (or object-oriented) CSS; the idea of using reusable chunks of pre throughout a site in a really planned and systematic way. I&#39;ve writtenbriefly about this on the site, but I&#39;d recommend going to <a href="https://github.com/stubbornella/oocss/wiki" title="Find out more about OOCSS">Nicole Suillivan&#39;s github repo</a> for more info (she&#39;s a champion of modular CSS; she even managed to cut Facebook&#39;s mass of stylesheets down to size). I think, with an appropriate balance of modular and decendant-selection style CSS a site&#39;s styles can become much more lightweight and easy to manage. I&#39;ve only scratched the surface here so, like on any good topical news programme, I&#39;d love to hear your thoughts (and how many people hate CSS indenting; I hear quite a few).</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(29, 1, 1, '<p>\n	rthrt</p>\n', 'none', '<p>\n	Learn how to ensure your chosen webfont will stand up against anything that&#39;s thrown at it</p>\n', 'none', '<p>\n	<img alt="Some letter a''s on a conveyor belt" src="{filedir_1}blogimg-bltproof_webfonts2.png" /></p>\n<h2>\n	3. Prepare a sandbox</h2>\n<p>\n	Once you&#39;ve found the webfont you&#39;d like to test it&#39;s important to set-up some live samples in the correct size (I&#39;d always caution against relying on rendered screenshots of the webfont shown in different browser/OS combinations). Most online services will have sample pages for each webfont, where it will be rendered in the most common sizes. Some services even allow you to add your own sample text.</p>\n<h2>\n	4. Get testing</h2>\n<p>\n	To accurately test a webfont you need to start with the worst-case scenario and work up from there. This way, you can quickly ascertain whether the webfont you&#39;ve chosen is worth sticking with. Below are the conditions that should be tested:</p>\n<ol>\n	<li>\n		GDI+</li>\n	<li>\n		GDI+ with Cleartype</li>\n	<li>\n		WPF with Cleartype</li>\n	<li>\n		Directwrite with Cleartype</li>\n	<li>\n		Quartz 2D</li>\n</ol>\n<h3>\n	1. GDI+</h3>\n<p>\n	For this test, you&#39;ll need a PC running Windows XP/Vista (as I can&#39;t personally see much difference in GDI+ rendering in either system).</p>\n<p>\n	To turn Cleartype off in Windows XP:</p>\n<ol>\n	<li>\n		Right-click on the desktop background</li>\n	<li>\n		Select Properties from the fly-out menu</li>\n	<li>\n		Click the Appearance tab</li>\n	<li>\n		Click on Effects</li>\n	<li>\n		Ensure the Use the following method to smooth the edges of screen fonts checkbox is checked</li>\n	<li>\n		From the dropdown menu beneath this checkbox select Standard</li>\n	<li>\n		Click OK, then OK again.</li>\n</ol>\n<p>\n	To turn Cleartype off in Windows Vista:</p>\n<ol>\n	<li>\n		Right-click on the desktop background</li>\n	<li>\n		Click on Personalization</li>\n	<li>\n		Click on Window Color and Appearance</li>\n	<li>\n		Click Open classic appearance properties for more color options</li>\n	<li>\n		From the Appearance Settings window click Effects</li>\n	<li>\n		Ensure the Use the following method to smooth the edges of screen fonts checkbox is checked</li>\n	<li>\n		From the dropdown menu beneath this checkbox select Standard</li>\n	<li>\n		Click OK, then OK again.</li>\n</ol>\n<p>\n	Once you&#39;ve switched Cleartype off, check your webfont in any browser except Safari for PC, or FIrefox</p>\n<h3>\n	2. GDI+ with Cleartype</h3>\n<p>\n	Again, for this test you&#39;ll need a PC running Windows XP/Vista. Tn enable Cleartype, go back to the</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '', 'none', '', NULL, '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(40, 1, 2, '', 'none', '', 'none', '', 'none', 'red', 'none', '<p>\n	HTML5 is still very new, so HTML5 Doctor is a great resource to explore the semantic meaning of each new tag</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(41, 1, 2, '', 'none', '', 'none', '', 'none', 'green', 'none', '<p>These days all manner of devices are used to acces the Internet. Using media queries (now referred to as "responsive design") means a website can take full advantage of this rich collection of screen sizes</p>', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(46, 1, 1, '<p>\n	Understanding how the "cascade" works in CSS can really help speed up a site&#39;s performance.</p>\n', 'none', '<p>\n	Principles like descendent selection and inheritance are what makes CSS so powerful, but used a little more wisely your stylesheet can be that little bit more efficient</p>\n', 'none', '<p>\n	When considering performance, CSS is often the last thing to be combed through; it&#39;s so tiny, what impact can it make on the speed of the site?</p>\n<p>\n	True, a stylesheet (in comparison to the countless images, webfonts and video you&#39;re asking a user to download) is pretty small, but it&#39;s surprising what a difference can be made from understanding how a browser reads it. The browser reads your stylesheet from the bottom up, and each rule from right to left. It only does what it&#39;s told, and wants to make sure it&#39;s got each rule right, so for every rule it goes through a qualification process.</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '<h2>Further reading</h2>\n<dl>\n<dt>Chris Coyer (for CSS Tricks) on CSS rendering</dt>\n<dd><a href="http://css-tricks.com/6386-efficiently-rendering-css/">visit the page</a></dd>\n</dd>\n</dl>', 'xhtml', '<h2>\n	An example</h2>\n<pre>\nhtml body div#wrapper article p{&#10;font-family:arial,sans-serif;&#10;margin:0 0 1em 0;&#10;}</pre>\n<p>\n	In this example, in applying a style to the paragraph, the browser will (in reading from right to left) look inside the curly braces to find what rules are to be applied, then it will move on to the element(s) after the braces to figure out what to apply them too. It sees the first "p" in the stack (which looks like the last item to human eyes) and knows to apply the rule to that "p". However, before settling on this decision it checks if the rule for this "p" tag has been made any more specific. It goes up the chain of selectors, and for each one checks if the rule is still valid until it gets to the end if the stack.</p>\n<p>\n	It will then read upwards in the stylesheet, to check if any additional rules add properties to this "p" element, or override them.</p>\n<p>\n	Of course, this all happens pretty quick so the idea would never be to have one rule per element, with no descendence or inheritance. It does however, bring home the importance of thinking through each rule, and what selectors are necessary to make it work. For example, this would be deemed an "over-qualified" rule:</p>\n<p>\n	<code>div#main-content&#123;...&#125;</code></p>\n<p>\n	Why make the browser work harder to ensure the ID selector is applied to a DIV element. Also, why give the rule 1 more <a href="http://www.quora.com/Whats-the-difference-between-a-CSS-Class-and-ID/answer/Jack-Armley">point of specifity?</a> You&#39;re just adding more complexity to the cascade.</p>\n<p>\n	This same concept potentially knocks some of the shine off CSS resets. Whilst they are useful to ensure you always start with a clean, consistent base they do add more rules that get constantly overridden, and that subsequently mean the browser has to check them against any rules it&#39;s applying to the same element, further down the stylesheet.</p>\n<p>\n	Of course, as stylesheets are tiny I&#39;m in no way suggesting that resets should be dropped, and the descendence shouldn&#39;t be used. I think however, it&#39;s always good to be aware of these things so our websites can be made even better-er!</p>\n', 'none', '', 'none', '1', 'none', '1', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(43, 1, 1, 'I''ve been fortunate enough to help out on the new agency site for the (freshly renamed) Tangent Snowball', 'none', 'This site, although small was an opportunity for us (Tangent Snowball) to show off our collective skills. With this in mind, we set out to produce a stunning responsive design, and a re-worked mobile site.', 'none', 'On the team, we had Pete (TS''s creative director), Darius (a Designer who can spot an out-of-place pixel from 30 yards out), Ian (one of our resident UX specialists), Renee (project lead) ', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(44, 1, 1, '<p>\n	In some instances, changing the way a team works together can bring huge advantages</p>\n', 'none', '<p>\n	I recenty headed up for a daytrip to the Tangent Labs developer weekend: 3 days set aside for Tangent Snowball&#39;s in-house team of gifted developers to create something new and innovative.</p>\n', 'none', '<p>Instead of sitting at desks - headphones in - the members of each team were crowded round a table (sans headphones) with laptops and, due to time pressures had to make quick decisions, draw things up on whiteboards and have quick huddles to figure things out.</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '<p>\n	As a front-end designer I was building flat pages in HTML and CSS, all the while running things past my team-mates and quickly implementing their feedback.</p>\n<p>\n	Once these pages were at a good stage they were passed to the team to be turned into dynamic, Django-driven pages.</p>\n<p>\n	In this situation, the (somewhat over-egged) barrier between back-end and front-end developers was a little less high and forboding; we managed to build, in an afternoon, what could (in regular circumstanses) take significantly longer.</p>\n<p>\n	I&#39;m not in any way suggesting this practice should be the norm: for long-term projects protocol and process need to be involved, to ensure things stay on track. However, for quick turnaround projects having a room, a table and a group of passionate developers all working together (and without distraction) is a great way to work.</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(47, 1, 1, '<p>\n	Over the past few weeks I&#39;ve felt compelled to collect images of all the Christmas trees I&#39;ve encounters whilst out and about, on Instagram.</p>\n', 'none', '<p>\n	Over the festive period I turned into a bit of a virtual horder...</p>\n<p>\n	<img alt="" class="float_right" height="400" src="{filedir_1}blogimg-xmastreesinthewild.png" width="223" /></p>\n', 'none', '<p>I love Instagram; It doesn''t feel as formalized as Flickr but feels more like a book to keep quick snaps of what you find whilst out and about.  I took advantage of this instantanious-ness - and the fact that you can tag images to make collections - to amass a collection of Christmas tree pictures.</p>\n<p>I collected ones whilst going around London: from department stores, street corners or ones I spied in Windows. These trees I shared on Twitter (which I''m fairly sure annoyed the hell out of my huge collection of devoted twitter fans - ahem). Sometimes, I even noted that others had dropped their trees into the collection using the hash-tag (well, three times).</p>\n<p>I''ve collected them via an RSS feed and you can see the latest few <a href="http://www.jackarmley.com/index.php/xmastrees">here.</a> Alternatively, <a href="http://followgram.me/tag/xmastreesinthewild">see the whole collection.</a></p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '', 'none', '', NULL, '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(50, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	The much-loved, London-based nail bar chain got a well-considered online refresh</p>\n', 'none', '<p>\n	As part of a great team at Tangent Snowball, I helped to bring the "Couture" and "Try It On" sections of the site to fruition.</p>\n', 'none', '<p>\n	I worked with an amazing team of account handlers, <abbr title="User Experience">UX</abbr> architects and designers to help nails inc bring the experience of trying on their products into the virtual realm.</p>\n<p>\n	"Try It On" is a pluggable module that appears in multiple places on the site, but has its <a href="http://nailsinc.com/try-it-on/">own dedicated page.</a> We spent a worrying amount of time trying on nail varnish in order to represent their product correctly on screen, as we wanted to ensure we could build each colour with a modular system of layers and CSS classes.</p>\n', 'none', '1', 'none', '1', 'none', 'http://nailsinc.com/', 'none', 'website', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '', NULL, '', NULL, '<p>\n	The Couture section allows the visitor to build their own bespoke nail varnish. The section had to be available both on touch-based smartphones, and desktops, do to accomodate this need we re-thought the user experience for each platform (for example, on iPad/iPhone, if the device is rotated you get a preview of your assembled nail varnish). Including interactions like drag-and-drop, and animated transitions was great fun, and an interesting challenge.</p>\n<p>\n	I really enjoyed working on these two features - at Tangent we took a really agile approach to ensure we really understood how the user would interact with each feature and as a result I think it works really well (the site got recieved with buckets of delight from nails inc&#39;s expansive Facebook following).</p>\n', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(56, 1, 1, '<p>\n	A great talk on how to fine-tune your nice shiny new HTML5 site to be even faster-er</p>\n', 'none', '<p>\n	Although 45 mins late (due to the inaccuracy of my maps app) I managed to glean a few great insights from Peter Lubbock&#39;s talk about making sites faster</p>\n', 'none', '<p>\n	His talk centered around exploiting some new (and some well-known) HTML5/CSS3 techniques and general best practices.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<h2>\n	A desktop-based image optimiser</h2>\n<p>\n	Being a big fan of Yahoo Smush.it, I was delighted that a desktop version - imageoptim - is available (for mac only). Now, you can drag a whole folder of images to be optimised, as a part of the build process.</p>\n<h2>\n	Data URIs</h2>\n<p>\n	Data URIs make it possible to store a set amount of image data using a string of text. As the smallest allocation (for IE8) is 32kb (IE7 and below don&#39;t support data URIs) data URIs are best used for small, static images like global page elements or icons. The allocation size gets larger for (in order) Firefox, Safari, Opera then to Chrome which has an allocation of 2mb.</p>\n<p>\n	I&#39;m told URI Kitchen is a good resource to learn more.</p>\n<h2>\n	HTML5 Boilerplate</h2>\n<p>\n	Although this great resource is well-known, I had no idea it had a built-in compiler that minifies all the HTML, CSS and JavaScript. Well worth a look I think.</p>\n<h2>\n	HTML 5 webworkers</h2>\n<p>\n	I didn&#39;t fully understand these, but I gathered they allow JavaScript to be run in the background, instead of every process being another header call.</p>\n<p>\n	@edidel has written a more expansive article on inline web-workers at HTML5 Rocks http://googl/KpQpS</p>\n<h2>\n	Application cache</h2>\n<p>\n	With this, you can store specific pages and assets on a user&#39;s computer so the next time this user visits the site, it will prefetch the dynamic content whilst the stored content is being viewed. Creating app cache is a 3-stage process:</p>\n<ol>\n	<li>\n		Firstly, you need a .appcache file sitting on the root of the website</li>\n	<li>\n		Then you need to add a parameter to the HTML tag.</li>\n	<li>\n		Lastly, you need to tell your server about the new appcache mime-type.</li>\n</ol>\n<h2>\n	Better practice for CSS3/Canvas animation</h2>\n<p>\n	Apparently, using "Request Animation Frame" instead of setTimeOut makes for a smoother animation, when using CSS3 or HTML5 canvas animations.</p>\n<h2>\n	About the speaker</h2>\n<p>\n	Peter Lubbock is part of Kazzing, in California. He has a new book out, called "Pro HTML5 Programming" and can be found on Twitter as <a href="http://twitter.com/#!/peterlubbers">@peterlubbers</a></p>\n<p>\n	Drop him an email at <a href="mailto:peter.lubbers@kazzing.com">peter.lubbers@kazzing.com</a> (he says that would be fine).</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(55, 1, 1, '<p>\n	3 talks explaining why it&#39;s important to get your hands dirty if you want to build good Javascript</p>\n', 'none', '<p>\n	After braving driving rain with the help of my stylish PVC man-mac, I attended a great London Web Standards talk called "Javascript Nuts &#39;n&#39; Bolts" (<a href="http://twitter.com/#!/JeffVanCampen/statuses/93092234035077120">best twitter tag ever</a>: #lwsnuts</p>\n<p>\n	&nbsp;</p>\n', 'none', '<p>\n	As the name suggests, it focused on really understanding what makes Javascript tick, and in doing so how to build it better (as always, the great lws folks kept a <a href="http://www.londonwebstandards.org/2011/07/london-web-standards-nuts-n-bolts-liveblog-lwsnuts/">live blog</a> going throughout).</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<h2>\n	My highlight: Addi Osmani on jQuery performance</h2>\n<p>\n	Addi Osmani&#39;s (<a href="http://twitter.com/addyosmani">@addyosmani</a>) is part of the core jQuery team, and works at AOL, so his advice is pretty sound. He gave a very slick talk (Monopoly themed, naturally) that went through 10 ways to build your jQuery smarter, so it will run faster. For each example, he provided a URL to jsperf.com so attendees can see if his examples can walk the walk. He highlighted jsperf as a great way of seeing how the jQuery rules we write actually perform; they get a percentage score, a little like YSlow.</p>\n<h3>\n	Mind those fancy classes</h3>\n<p>\n	Don&#39;t take the fact that jQuery can use all kinds of fancy pseudo and attribute selectors for granted. Even something as simple as targeting an element by it&#39;s class has an overhead as, given there isn&#39;t a fully supported native JavaScript selector for class (like getElementById for example) jQuery needs to make a more far-reaching call to understand what you need to do. In this vein, he recommend if you can, to use native JavaScript methods within your jQuery as jQuery doesn&#39;t need to do all sorts of work to understand it.</p>\n<h3>\n	Get your chains out</h3>\n<p>\n	He promoted chaining as a better way of attaching a load of stuff to an element, as calling that element anew for each action just means more overhead. For example:</p>\n<pre>\n$(&#39;p&#39;)&#10;.dothis()&#10;.andthis()&#10;.andthis();</pre>\n<p>\n	Is much better then:</p>\n<pre>\n$(&#39;p&#39;).dothis();&#10;$(&#39;p&#39;).andthis();&#10;$(&#39;p&#39;).andthis();</pre>\n<h3>\n	Be nice to the DOM</h3>\n<p>\n	Another great tip was that the DOM isn&#39;t a database to just load stuff onto willy-nilly. In other words, use methods like <code>append()</code> and <code>wrapInner()</code> sparingly. Injecting stuff into the DOM in this way has a significant performance overhead.</p>\n<h3>\n	Write D.R.Y style</h3>\n<p>\n	He also recommended writing D.R.Y (Don&#39;t Repeat Yourself) style code, trying to rewrite a bit of code you&#39;ve made in a smarter way, that makes less calls.</p>\n<p>\n	It was a great talk and <a href="http://addyosmani.com/jqprovenperformance/">he&#39;s released his slides</a>. Also, I&#39;ve no doubt there&#39;s more wisdom on <a href="http://addyosmani.com/blog/">his blog.</a></p>\n<h2>\n	Crystal Hirschorn on debugging your Javascript with QUnit</h2>\n<p>\n	Also speaking was Crystal Hirschorn (<a href="http://twitter.com/pand0ra83">@pand0ra83</a> ) from the BBC. She did a great talk about unit testing for JavaScript, focused on a tool called Qunit which was developed by the folks a jQuery (they&#39;ve been using it at the BBC for the last 2 years). Although known for being a great jQuery tool; it can be used to test any JavaScript code. I imagine in a large ecosystem like the BBC, consistency and a good, rapid&nbsp; way to debug is an absolute must.</p>\n<p>\n	One of the most interesting things she mentioned was how teams of developers at the BBC write code our on whiteboards, and sketch things out to solve a complex problem. It just proves the paperless offlice is still a pipe dream!</p>\n<p>\n	She&#39;s linked to her slides, <a href="https://docs.google.com/present/view?id=dhncpgx7_7fm6725gt&amp;interval=10">here.</a></p>\n<h2>\n	Tim Ruffles on backbone.js</h2>\n<p>\n	Tim Ruffles (<a href="http://twitter.com/#!/timruffles">@timruffles</a>) who works for <a href="https://picklive.com/">Picklive </a>(they make the fantasy football app) spoke about backbone.js; a Javascript framework. It was a really well-structured and informative talk but was a little too high-level for my front-end brain.</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(54, 1, 1, '<p>\n	We should always question and understand established web-design conventions</p>\n', 'none', '<p>\n	In the dusty, wild-west border town that the web world still is, we&#39;ve created systems and conventions to carve out best practice and help us work smarter.</p>\n', 'none', '<p>\n	A convention can only become such if it is backed by sound reasoning and works in the real world. However, if they aren&#39;t questioned and understood they can potentially (as things move so quickly) become the wrong way of doing things.</p>\n<p>\n	A great example is the 960px recommended maximum width for a website. This width is perfect for ensuring a site fits comfortably within a 1024x768px screen, but now this size is becoming superseded by larger, more high-resolution screens. Of course, in some cases this size may be the most common, but that&#39;s what analytics are for</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<p>\n	Another great example is using things like CSS resets or boilerplates (like YUI reset or HTML5 boilerplate).</p>\n<p>\n	Up to a few weeks ago I used the YUI reset (with a few tweaks) but recently, in looking at it afresh realised it has no reset for HTML5 elements so, time to find a more suitable one. In fact, in creating a new base CSS sheet I realised how many base CSS rules I was using needed improvement, and how much more I needed to learn about the appropriate use of some of the new or redefined HTML5 elements.</p>\n<p>\n	Essentially, the lesson here (certainly the one I learnt) is that conventions are great, we need them to make our lives easier but I think they should be evaluated for every new project, so we don&#39;t forget why we&#39;re using them or why they were made in the first place.</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(53, 1, 1, '<p>\n	My highlights from Insites London 2011, a special webby event run by<br />\n	Elliot Jay Stocks</p>\n', 'none', '<p>\n	The <a href="http://insitestour.com/">Insites tour</a> is (soon to be was) a series of 4 talks taking place around the country over 4 days, organised by Keir Whitaker &amp; Elliot Jay Stocks&hellip;</p>\n', 'none', '<p>\n	I was lucky enough to attend the London talk at Jam HQ (housed just down the road from Tangent One towers at <a href="http://gowalla.com/checkins/41054828">Engine</a>) with my fellow Tangent One team members; 3 of us even won goodies.</p>\n<p>\n	Rather than dishing out technical hints and tips, the talks centered around each speaker&#39;s experiences, with the host asking questions about their working practices and career so far</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<p>\n	There were 3 talks, but for sure my highlight was Denise Wilton&#39;s talk (<a href="http://twitter.com/#!/denisewilton">@denisewilton</a>).</p>\n<p>\n	Having missed the boat to use a computer in university, she came out into the world without prior knowledge of software and started working for a small company designing stuff for them in Quark which she explained was actually relatively easy to pick up due to it&#39;s logical nature. From there, she learnt HTML/CSS on train rides acoss town (to and from work) and with these dual skillsets worked both in digital and print. She is currently <a href="http://berglondon.com/studio/denise-wilton/">creative director at Berg.</a></p>\n<p>\n	I liked hearing a story from somebody who has worked both sides of the coin as it were. I think, although print and web are perceived as worlds apart, they are getting closer thanks t the more tangable experience of accessing intangible, digital content devices like the iPad and the Kindle can offer us.</p>\n<p>\n	Most interesting was a comment she made on the use of metaphors. She cited a company that manufactures objects that amplify or pander to certain roles an iPhone can fulfill, like playing videos or being an alarm clock. This company makes beautiful (and no doubt expensive) objects that house the iPhone and make it look like the device from which a function originates. So, a traditional CRT television or a 70s era clock-radio.</p>\n<p>\n	She explained that, whilst beautiful these objects only make sense to those of us who have grown up with them; somebody born now for example, may only ever see a CRT TV in a book.</p>\n<p>\n	From this she cited further examples, like flippable PDFs and eBooks that look like paper books and this got me thinking, is it right to create these metaphors? Are we doing so because the book or CRT television have now become nostalgic objects, or to ease the non-converted into reading a book on an iPad?</p>\n<p>\n	I can&#39;t help thinking it&#39;s better to think of each device and play to it&#39;s strengths. For example, the Kindle makes no attempt to keep afloat the book metaphor, but simply is the best way currently, of reading text on something other than paper. They&#39;ve concentrated on ensuring it can be read in bright sunlight, and that text size and line-height can be adjusted to suit the user, rather than keeping this tired flip page metaphor (which I&#39;m sure would get tiresome after 500 pages). The web has developed it&#39;s own conventions, and to forsake these to try and emulate a physical thing (like a book) is the wrong way of thinking.</p>\n<h2>\n	Other talks</h2>\n<p>\n	In addition, Natalie Downe &amp; Simon Willison talked about their experiences of building <a href="http://lanyrd.com/">Lanyrd</a>, a task that looked daunting to me as they did it whilst travelling, on shaky WiFi connections and in tents on top of 4x4s. They also spoke of the joys and pitfalls of building a startup stateside, and how they&#39;ve worked to build Lanyrd from a pet project into a business (they have an employee now, and offices in Old Street: the silicon valley of Anglia).</p>\n<p>\n	Sandwiched between these two talks was John Gruber, a designer/comic artist who loves the little details and now works for such allustrious names as Marvel and DC. It was great to hear of his experiences working together with his wife (a creative director in a high-end magazine); she likes pure, stripped-down design, white space and clean typograhy, and he like adding little details here, bits there and seeing what happens if you offset blocks of text so slightly!</p>\n<p>\n	All in all, it was a very <em>insight-ful</em> night (see what I did there?), and I thought the conversational format (with questions after each talk) was managed really well. Also, Engine have an awesome foozball table and believe me, at Tangent One we don&#39;t mess around when it comes to foozball; we owned that table.</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(51, 1, 3, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<p>\n	To my delight, one of the first jobs I got tasked with when starting at Tangent, was to build the new agency site.</p>\n', 'none', '<p>\n	Before the launch of their present site, Tangent Snowball were known by a different name, so the site had to both reassure current clients that change was for the better, and propel the new brand into public conciousness.</p>\n', 'none', '<p>\n	The initial site, although small was an opportunity for us (Tangent Snowball) to show off our collective skills. With this in mind, we set out to produce a stunning responsive design, and a re-worked mobile site. We decided, rather than the design packing down to mobile it would stop at iPad portrait width (768 pixels), and from that point on a seperate mobile site would take over.</p>\n<p>\n	The desktop site works beautifully on any platform, but it particularly good on iPad, as it utilizes all space on the device. The whole site uses large, sumptuous images and snappy text to bring the work to life.</p>\n<p>\n	As we created a seperate mobile site, we could re-format all the images for mobile, use application caching to ensure the site was super-quick, and re-design the page structure to make full sue of the small screen real-estate. Also, we ensured all graphics were optimised for iPhone 4&#39;s Retina display.</p>\n', 'none', '1', 'none', '1', 'none', 'http://www.tangentsnowball.com', 'none', 'website', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '', NULL, '', NULL, '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(49, 1, 1, '<p>\n	With the amount of new stuff I have learnt, and the radical changes happening in web design, I needed a fresh site.</p>\n', 'none', '<p>\n	The many millions of visitors that come to my site (ahem!) may have noticed it has changed somewhat.</p>\n', 'none', '<p>\n	I felt, with the amount of new stuff I have learnt over the last few months, and the radical shifts that have happened in web design, it was time to start afresh.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<h2>\n	Why change?</h2>\n<p>\n	I wanted to ensure my site was mobile friendly (as I now view more sites on my iPhone more than I do my desktop), fully responsive and able to house much more varied content than the old one did. I wanted it to be more about the content, and wanted to make looking at work and reading a blog post as distraction-free and as easy on the eyes as possible.</p>\n<h2>\n	So, what&#39;s different now?</h2>\n<h3>\n	The site is responsive</h3>\n<p>\n	Using the principles Elliot Jay Stocks outlined in <a href="http://elliotjaystocks.com/blog/a-better-photoshop-grid-for-responsive-web-design/">his blog-post</a> about a 1000px flexible grid, I&#39;ve gone for a six-column layout that collapses right down to mobile. This layout means the site has a more solid frame for me to work within; content doesn&#39;t "float" and as such, I can make better decisions on where to place stuff. Also, I&#39;ve ensured things like the tweetbox on the blog page is responsive, by using a little Javascript trickery (check it out on <a href="https://github.com/jackarmley/mysite/blob/gh-pages/current/v2/scripts/mysite.js">github</a>).</p>\n<h3>\n	My code is (even) more organized</h3>\n<p>\n	I&#39;ve also streamlined my naming conventions, taking some of the Wisdom from <a href="http://smacss.com/">SMACSS</a>. In addition, I&#39;ve used a whole lot more CSS3 and have structured my Javascript in a far more object-oriented way, so I can just call functions as needed.</p>\n<h3>\n	I&#39;ve gone hardboiled</h3>\n<p>\n	As I wanted the freedom to experiment with CSS3, and not have to dumb stuff down or comprimise for IE, I&#39;ve gone "hardboiled" (in the words of Andy Clarke) and have served up a varient on my mobile styles for IE. At Tangent Snowball (where I get to do web stuff all day), we&#39;ve taken a similar (if more realistic approach) to IE support, and have published a <a href="https://github.com/tangentsnowball/Panflets-and-publications/blob/master/understanding_browsers_TS.pdf">great little booklet </a>for our team and clients, about understanding the browser.</p>\n<h3>\n	It allows for more varied content</h3>\n<p>\n	Previously, each part of my site had a very specific way of displaying content; so specific in fact, that I found myself bolting on a "notes" section to post links and pictures from all the meetups I attend. With this site, I can just roll that stuff in. Also, creating a post was a lot of hassle - I needed to produce an illustration for each one. Now however, I can post a quick thought, or a link to a Github gist in the same space as a long-form article.</p>\n<h3>\n	It&#39;s more future-proof</h3>\n<p>\n	The site has a flexible layout, uses very little images for the UI (icons are served via <a href="http://tangentsnowball.github.com/Snowcone/index.html">Snowcone</a>), and uses a HTML5 doctype. As such, I can continue to build upon it as new tablets, mobiles and other devices see more use. Also, as the icons and Headings use @font-face, they are infinately scalable.</p>\n<h2>\n	Where now?</h2>\n<p>\n	As I&#39;ve now got the platform I want, I can really put it to use, and share code snippets from github, info about the lastest app I&#39;m using that nobody else is on, or write long-form articles. I hope you&#39;ll come back and visit!</p>\n<p>\n	If you&#39;re the curious type, you can see all the code on <a href="https://github.com/jackarmley/mysite/tree/gh-pages">Github.</a></p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none');
INSERT INTO `exp_channel_data` (`entry_id`, `site_id`, `channel_id`, `field_id_1`, `field_ft_1`, `field_id_2`, `field_ft_2`, `field_id_3`, `field_ft_3`, `field_id_4`, `field_ft_4`, `field_id_5`, `field_ft_5`, `field_id_6`, `field_ft_6`, `field_id_7`, `field_ft_7`, `field_id_8`, `field_ft_8`, `field_id_9`, `field_ft_9`, `field_id_10`, `field_ft_10`, `field_id_11`, `field_ft_11`, `field_id_12`, `field_ft_12`, `field_id_13`, `field_ft_13`, `field_id_14`, `field_ft_14`, `field_id_15`, `field_ft_15`, `field_id_16`, `field_ft_16`, `field_id_17`, `field_ft_17`, `field_id_21`, `field_ft_21`, `field_id_22`, `field_ft_22`, `field_id_23`, `field_ft_23`, `field_id_24`, `field_ft_24`, `field_id_25`, `field_ft_25`, `field_id_26`, `field_ft_26`, `field_id_27`, `field_ft_27`, `field_id_28`, `field_ft_28`) VALUES
(52, 1, 1, '<p>\n	Avoid constant overrides for different widths, by writing your media queries as bounds between two widths.</p>\n', 'none', '<p>\n	The two traditional ways of building a web-page: either fixed-width or fluid (with max/min width stops) have - with the increased usage of smartphones, tablets and a multitude of screen sizes - been joined by a third: responsive design.</p>\n', 'none', '<p>\n	The term - coined by Ethan marcotte in an alistapart article - refers to a design that can change form dependant on screen size, by utilising CSS media queries.</p>\n<p>\n	I think I (like many) came to the realisation that this third way of building a page is now the most relevant, as the ways a user can access that page is impossible to predict.</p>\n<p>\n	I&#39;ve put them into action on a few projects, using 320 and up to help give me an idea as to what screen widths to cater for.<br />\n	Media queries for different screen widths, as I have understood them thus far work by creating a rule set for a minimum screen width, starting smallest first. For this reason, you need to re-declare the style you&#39;re overriding for each subsequent size, or the first declared query will override the next. However, I found a way to avoid this.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '<h2>\n	Instead of this</h2>\n<pre>\n/*--[=6a:Mobile]--*/&#10;@media only screen and (min-width:300px){}&#10;&#10;/*--[=6b:768px screen / iPad portrait]--*/&#10;@media only screen and (min-width:768px){}&#10;&#10;/*--[=6c:1024px screen]--*/&#10;@media only screen and (min-width:992px{}&#10;&#10;/*--[=6d:Large screen]--*/&#10;@media only screen and (min-width:1280px){}&#10;&#10;/*--[=6d:Super large screen]--*/&#10;@media only screen and (min-width:2000px){}</pre>\n<h2>\n	Do this</h2>\n<pre>\n/*--[=6a:Mobile]--*/&#10;@media only screen and (min-width:300px) and (max-width:767px) {}&#10;&#10;/*--[=6b:768px screen / iPad portrait]--*/&#10;@media only screen and (min-width:768px) and (max-width:991px){}&#10;&#10;/*--[=6c:1024px screen]--*/&#10;@media only screen and (min-width:992px) and (max-width:1279px){}&#10;&#10;/*--[=6d:Large screen]--*/&#10;@media only screen and (min-width:1280px) and (max-width:1999px){}&#10;&#10;/*--[=6d:Super large screen]--*/&#10;&#10;@media only screen and (min-width:2000px){}</pre>\n<p>\n	This way - using bounds instead of min-widths that overlap - means that styles from the smallest screen width won&#39;t be true for the widest width. This will mean rules don&#39;t have to be redeclared each time (to prevent those true from a small width affecting a larger width).</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(57, 1, 1, '<p>\n	A nice little script to make <strong>abbr</strong> tags a little more helpful for the user.</p>\n', 'none', '<p>\n	I&#39;ve never been happy with the way the <code>&lt;abbr&gt;</code> tag works, so I decided to write a small script for my site, that would make it more helpful for the user.</p>\n', 'none', '<p>\n	I always feel a little uneasy about modifying elements like <code>title=""</code> tags and other browser-ui specific elements, as I&#39;m aware that such things are so familiar, that modifying them may negatively alter that user&#39;s experience of the site.</p>\n<p>\n	I&#39;ve always styled tags with a dotted border underneath (as that&#39;s what I assume a user expects). However, I&#39;ve always felt that adding such tags to the markup of an article was a pragmatic web-designer-y thing to do, and they would go unused by the reader.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, ' ', 'xhtml', '<p>\n	For my new site, I aimed to re-assess all my assumptions and when it came to the <code>&lt;abbr&gt;</code> tag, I wanted to make it a more helpful addition to an article. To do this, I wanted to show the <code>title=""</code> attribute of the tag in a little tooltip, in replacement of the standard yellow one.</p>\n<p>\n	As this couldn&#39;t be done purely with CSS, I needed a small bit of jQuery to extract the title and append it to a tag, that was injected (via the jQuery) into the abbreviation. Once that little operation was performed, I could then prettify the injected markup with a little CSS.</p>\n<h2>\n	A quick demo</h2>\n<blockquote>\n	<p>\n		You just overwrote some of my <abbr title="Cascading Style Sheets">CSS</abbr> on the <abbr title="Apache Subversion">SVN</abbr> repo. <abbr title="Oh My God">OMG,</abbr> you are such a <abbr title="newbie">noob</abbr></p>\n	<footer>\n		<p>\n			The words of many web designers, I&#39;m sure</p>\n	</footer>\n</blockquote>\n<h2>\n	The jQuery</h2>\n<pre>\nfunction fancyabbr(){&#10;&#10; $("abbr").each(function(){&#10;&#10;  //Grab the title, from each &lt;abbr&gt; tag on the page&#10;  var abbrcontent = $(this).attr("title");&#10;&#10;  //Append the title to each &lt;abbr&gt; tag&#10;  $(this).append("<span class="''fancyabbr''">Short for: <strong>""+abbrcontent+""</strong></span>");&#10;&#10;  //If this has been successful, remove the title attribute from each &lt;abbr&gt; tagt&#10;  if (abbrcontent!=""){&#10;   $(this).attr("title","");&#10;  } &#10;&#10;  //Call the appended <span> tag in, on :hover&#10;   $(this).hover( &#10;    function(){&#10;     $("span",this).fadeIn(400);&#10;    },&#10;    function(){&#10;     $("span",this).fadeOut(200);&#10;    });&#10;&#10; });&#10;&#10;}</span></abbr></abbr></abbr></pre>\n<h2>\n	The CSS</h2>\n<pre>\nabbr{&#10;position:relative;&#10;}&#10;.fancyabbr{&#10;font:italic normal 14px/30px georgia,times,serif;&#10;color:#666;&#10;text-transform:none;&#10;position:absolute;&#10;top:-40px;&#10;left:0;&#10;display:block;&#10;float:left;&#10;white-space:pre;&#10;z-index:2;&#10;background:#fff;&#10;padding:0 0.5em;&#10;border-radius:0.25em;&#10;box-shadow:0 0 4px rgba(1,1,1,.5);&#10;border:1px solid #999;&#10;display:none;&#10;}&#10;.fancyabbr:after{&#10;content:" ";&#10;width:10px;&#10;height:10px;&#10;display:block;&#10;background:#fff;&#10;position:absolute;&#10;bottom:-6px;&#10;left:10px;&#10;transform:rotate(45deg);&#10;border:1px solid #999;&#10;border-top:none;&#10;border-left:none;&#10;box-shadow:2px 2px 2px rgba(1,1,1,.3);&#10;}</pre>\n<h2>\n	That&#39;s it</h2>\n<p>\n	I&#39;ll fling this on github soon but I&#39;ve no doubt - being such a small script - it&#39;s easily copied and pasted from this page. Enjoy, and do let me know of any improvements!</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(58, 1, 1, '<p>\n	Nice "chevron" style breadcrumb nav, using just CSS3 (no images)</p>\n', 'none', '<p>\n	reg</p>\n', 'none', '<p>\n	reg</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'xhtml', '', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, 'blog-type_plaintext', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(59, 1, 1, 'My foray to the Southbank to see the "show name" show', 'none', 'Last weekend I went into London hoping to soak up a little culture (maybe it would cancel out the fact that I''ve seen all 3 starship troopers films).', 'none', 'My first stop - after hopping off at Holborn - was Somerset House, to see "show name".\n\nThe show charted the media coverage (both official and user-generated) created around the death of a famous Libyan dictator, and the subsequent riots that followed.\n\nThe content, whilst a little disturbing was interesting and well-curated but what interested me, was the inclusion  of Augmented Reality into the mix, via the Aurasma App.\n\nFor those unfamiliar with Aurasma, it''s an easy to use AR app where you make "glimpses" out of a', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none'),
(60, 1, 6, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '<link rel="stylesheet"  href=''http://fonts.googleapis.com/css?family=Lilita+One'' />\n<link rel="stylesheet" href="{site_url}v2/css/bespoke_posts/lebowski_quotes.css" media="screen" />', 'none', '<article id="gl-content_wrapper" class="clearfix">\n				<blockquote id="maude_quote">	\n					<footer>\n						<p>Maude</p>\n					</footer>\n					<p>\n						<span class="line_1">What do you</span>\n						<span class="line_2">do for</span>\n						<span class="line_3">recreation?</span>\n					</p>\n				</blockquote>	\n				<blockquote id="jeff_quote">\n					<footer>\n						<p>Jeff</p>\n					</footer>\n					<p>\n						<span class="line_1">Oh, the usual</span>\n						<span class="line_2">I bowl.</span>\n						<span class="line_3">Drive around.</span>\n						<span class="line_4">The occasional</span>\n						<span class="line_5">acid</span>\n						<span class="line_6">flashback</span>\n					</p>\n				</blockquote>	\n			</article>', 'none', '<p>\n	This is a little experiment for me to try out <a href="http://fittextjs.com/" title="Visit rhe fittext website">fittext,</a> by the folks at <a href="http://paravelinc.com" title="Visit the Paravel website">Paravel.</a> I&#39;ve used <a href="http://www.theleagueofmoveabletype.com/chunk" title="Check out Chunk">Chunk</a> by the <abbr title="League of Movable Type">LOMT.</abbr> The background pattern is a pure CSS3 gradient, from Lea Verou&#39;s <a href="http://lea.verou.me/css3patterns/" title="Visit the patterns gallery">CSS3 Patterns Gallery.</a></p>\n<p>\n	Check out the <a href="http://www.jackarmley.com/articles/post/lebowski_loves_fittext" title="Read the article">article,</a> here.</p>\n', 'none', 'leboswkiquotes', 'none'),
(61, 1, 1, '<p>\n	What better content to try fittext on, than a quote from "that" film about bowling.</p>\n', 'none', '<p>\n	I thought I&#39;d give Paravel&#39;s <a href="http://fittextjs.com/">responsive text plugin, fittext</a> a try, and what better content to try it with than a quote from the Big Lebowski.</p>\n', 'none', '<p>\n	Fittext, by Paravel is a lightweight jQuery plugin to make fully responsive headlines that always take up the same space on the page. I&#39;ve been wanting to try it for a while, and thought another great use for the plugin would be on short quotes. Trent Walton has a <a href="http://trentwalton.com/2012/01/27/new-adventures-2012/">great post</a> from naconf 2012 which examples of fittext in action, used to make movie stills.</p>\n', 'none', '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', NULL, '', 'none', '<h2>\n	Demo page</h2>\n<p>\n	<a href="http://www.jackarmley.com/sandbox/lebowski_quote/">Check out my demo</a> (and try rezising your browser while you do).</p>\n<h2>\n	Setting up</h2>\n<p>\n	I found fittext is made to work on one line a time, and each instance requires a little tweaking to ensure the text stretches across the whole line. To ensure I could do this, I split each line of both quotes, using spans then gave each span an individual a class so I could tweak each line with a different fittext call.</p>\n<h2>\n	The HTML</h2>\n<pre>\n&lt;blockquote id="jeff_quote"&gt;&#10; &lt;footer&gt;&#10;  &lt;p&gt;Jeff&lt;/p&gt;&#10; &lt;/footer&gt;&#10; &lt;p&gt;&#10;  &lt;span class="line_1"&gt;Oh, the usual&lt;/span&gt;&#10;  &lt;span class="line_2"&gt;I bowl.&lt;/span&gt;&#10;  &lt;span class="line_3"&gt;Drive around.&lt;/span&gt;&#10;  &lt;span class="line_4"&gt;The occasional&lt;/span&gt;&#10;  &lt;span class="line_5"&gt;acid&lt;/span&gt;&#10;  &lt;span class="line_6"&gt;flashback&lt;/span&gt;&#10; &lt;/p&gt;&#10;&lt;/blockquote&gt;&#10;</pre>\n<h2>\n	The CSS</h2>\n<p>\n	The CSS for text sizes is overridden by fittext, so I just gave an arbitary text size for the whole quote. I used Chunk (by League of Movable Type) for the text and smoothed out the edges for Windows PC&#39;s with a small text shadow. Also, I used a CSS3 gradient pattern for the background (check out Lea Verou&#39;s <a href="http://lea.verou.me/css3patterns/">gallery</a>, here). All the responsive awesomeness for mobile was handled by FitText, so I didn&#39;t need to do any CSS wrangling for text sizes.</p>\n<h2>\n	The script</h2>\n<pre>\n$("#jeff_quote .line_1").fitText(0.9);&#10;$("#jeff_quote .line_2").fitText(0.5);&#10;$("#jeff_quote .line_3").fitText(0.9);&#10;</pre>\n<h2>\n	How the tweaking works</h2>\n<p>\n	The value in the brackets of each fitText call can be adjusted to change how aggressively the text is resized. The lower the number, the more the text balloons out. If you don&#39;t state a number it will fallback to the default, which is 1. On <a href="https://github.com/davatron5000/FitText.js">FitText github repo</a> is the full list of tweaks (min and max font-size can also be set).</p>\n<h2>\n	Wrap up</h2>\n<p>\n	It&#39;s a really well-made plugin, really lightweight and dead simple to implement. Give it a try, you&#39;ll be quoting classics like <a href="http://www.imdb.com/title/tt0088944/quotes">Commando</a> in no time!</p>\n', 'none', '', NULL, '1', 'none', '1', 'none', '', NULL, 'blog-type_image', 'xhtml', '', NULL, '', NULL, '', NULL, '', NULL),
(62, 1, 1, '<p>\n	My reaction to a recent guardian article entitled "Graphic designers are ruining the web"</p>\n', 'none', '<p>\n	John Naughton, a writer at the observer recently wrote an article entitled <a href="http://www.guardian.co.uk/technology/2012/feb/19/john-naughton-webpage-obesity">"Graphic designers are ruining the web"</a>. Hang on John, surely that&#39;s a bit unfair. Nothing can be that black and white.</p>\n', 'none', '<p>\n	The crux of his article was that, due to the demands a rich graphic design places on the web designer (such as custom fonts, gradients, drop shadows etc...) web pages have mutated from simple, clear sources of information to hefty, kikobyte-heavy broadband bill eaters.</p>\n<p>\n	He feels design elements add bloat, and web-pages should remain true to the founding idea of what a website should be - an accessable, clear source of information.</p>\n<p>\n	This is true: if a website is supposed to convey textural information than it should be engineered for that purpose. However, websites have moved from being linked documents to becoming music players, televisions, text editors, image editors, mobile hard-drives and even conference call software. The same expectations and ideals may be hard to apply if a website is geared towards this kind of use case.</p>\n<p>\n	That&#39;s not to say however, that websites bringing rich content or facilitating heavy interaction can&#39;t still be light, relative to their size. The tools we use to create websites have improved dramatically over the last few years.</p>\n<p>\n	John is probably right in saying that:</p>\n<blockquote>\n	<p>\n		From 2003 to 2011, the average web page grew from 93.7kB to over 679kB</p>\n</blockquote>\n<p>\n	Certainly the sites I&#39;ve built have gone the way of a yo-yo diet; a few years ago, in order to replicate a simple rounded box a bucketload of unsemantic markup and additional resources needed to be stuffed into the site. That said, the web community is agile and flexible, and CSS - our language for enhancing HTML with visual flair - has evolved to address a multitude of commonly-sought visual flourishes. For example:</p>\n<h2>\n	A rounded box, c.2008</h2>\n<p>\n	To make a rounded box, back before Avatar came out and when the iPhone4 was just a pipe dream, you needed 4 HTML elements on your page. This was to ensure you had a place to hang each rounded corner image that was used to make the box.</p>\n<pre>\n&lt;div class="rounded"&gt;&#10;&lt;div class="outer"&gt;&#10;&nbsp; &lt;div class="inner"&gt;&#10;&nbsp;&nbsp; &lt;div class="content"&gt;&#10;&nbsp;&nbsp;&nbsp; &lt;p&gt;&#10;&nbsp;&nbsp;&nbsp;&nbsp; Hey y&#39;all, check out these curves&lt;/p&gt;&#10;&nbsp;&nbsp; &lt;/div&gt;&#10;&nbsp; &lt;/div&gt;&#10;&lt;/div&gt;&#10;&lt;/div&gt;&#10;</pre>\n<p>\n	Then, we had to make four images (in the worst case) and attach one to each of the div elements to give the box it&#39;s curvy appearance:</p>\n<pre>\n.rounded{background:blue url(&#39;topleft.gif&#39;) no-repeat top left;}&#10;.outer{background:transparent url(&#39;topright.gif&#39;) no-repeat top right;}&#10;.inner{background:blue url(&#39;bottomleft.gif&#39;) no-repeat bottom left;}&#10;.content{background:blue url(&#39;bottomright.gif&#39;) no-repeat bottom right;}&#10;</pre>\n<p>\n	Then, what of you want to put the box on a textured background? Can&#39;t be done. How about different colours? That needs new graphics, hence more bloat.</p>\n<h2>\n	A rounded box, c.2012</h2>\n<p>\n	Fast forward to now (wear your two ties, and your pockets inside out), and the tiny elves that evolve CSS have "towed the cowpaths" so to speak, and have ensured the language has tools for most of these scenarios. Want a rounded box? No problem:</p>\n<pre>\n&lt;div class="rounded"&gt;&#10; &lt;p&gt;Ah yeah, check these curves out!&lt;/p&gt;&#10;&lt;/div&gt;&#10;</pre>\n<pre>\n.rounded{border-radius:10px;}</pre>\n<p>\n	Ah, that&#39;s better: no additional graphics to sip away at your user&#39;s bandwidth, and if you want a new colour, that can be done with one additional line of CSS.</p>\n<p>\n	Granted, for some newer properties, you may have to write that line a few times, including vendor prefixes at the beginning. However, as soon as a rule is comfortably adopted, you can safely remove them.</p>\n<h2>\n	Ok, but why are some modern sites still heavy?</h2>\n<p>\n	The only excuse to have an overweight site these days, is if legacy browser support has not been thought through properly.</p>\n<p>\n	By this, I mean that our friend Internet Explorer is still the most used browser, and many IE users are still surfing the information superhighway on version 6-8; these versions will not understand most new tools (like rounded corners and text shadow) that we have at our disposal.</p>\n<p>\n	Here I think, is where sites can unwittingly go to maccas instead of pret. When a client is presented with a visually rich design, if their expectation remains that all those elements will be faithfully recreated in any browser - whatever the cost - then the web designer responsible for that build will have to hop in his/her delorean and dig up all the dirty tricks they used a few years ago.</p>\n<p>\n	If however, a client understands the impact of replicating a visually complex design on older browsers, then the web designer is free to use these modern tools, and re-think how to ensure the key parts of that site are bought across on legacy browsers.</p>\n', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '', 'none', '1', 'none', '1', 'none', '', 'none', '', 'xhtml', '', 'none', '', 'none', '', 'none', '', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_entries_autosave`
--

CREATE TABLE IF NOT EXISTS `exp_channel_entries_autosave` (
  `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `original_entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `pentry_id` int(10) NOT NULL DEFAULT '0',
  `forum_topic_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(16) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL DEFAULT 'n',
  `view_count_one` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_two` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_three` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_four` int(10) unsigned NOT NULL DEFAULT '0',
  `allow_comments` varchar(1) NOT NULL DEFAULT 'y',
  `sticky` varchar(1) NOT NULL DEFAULT 'n',
  `entry_date` int(10) NOT NULL,
  `dst_enabled` varchar(1) NOT NULL DEFAULT 'n',
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL DEFAULT '0',
  `comment_expiration_date` int(10) NOT NULL DEFAULT '0',
  `edit_date` bigint(14) DEFAULT NULL,
  `recent_comment_date` int(10) DEFAULT NULL,
  `comment_total` int(4) unsigned NOT NULL DEFAULT '0',
  `entry_data` text,
  PRIMARY KEY (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `url_title` (`url_title`),
  KEY `status` (`status`),
  KEY `entry_date` (`entry_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `exp_channel_entries_autosave`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_fields`
--

CREATE TABLE IF NOT EXISTS `exp_channel_fields` (
  `field_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `field_label` varchar(50) NOT NULL,
  `field_instructions` text,
  `field_type` varchar(50) NOT NULL DEFAULT 'text',
  `field_list_items` text NOT NULL,
  `field_pre_populate` char(1) NOT NULL DEFAULT 'n',
  `field_pre_channel_id` int(6) unsigned DEFAULT NULL,
  `field_pre_field_id` int(6) unsigned DEFAULT NULL,
  `field_related_to` varchar(12) NOT NULL DEFAULT 'channel',
  `field_related_id` int(6) unsigned NOT NULL DEFAULT '0',
  `field_related_orderby` varchar(12) NOT NULL DEFAULT 'date',
  `field_related_sort` varchar(4) NOT NULL DEFAULT 'desc',
  `field_related_max` smallint(4) NOT NULL DEFAULT '0',
  `field_ta_rows` tinyint(2) DEFAULT '8',
  `field_maxl` smallint(3) DEFAULT NULL,
  `field_required` char(1) NOT NULL DEFAULT 'n',
  `field_text_direction` char(3) NOT NULL DEFAULT 'ltr',
  `field_search` char(1) NOT NULL DEFAULT 'n',
  `field_is_hidden` char(1) NOT NULL DEFAULT 'n',
  `field_fmt` varchar(40) NOT NULL DEFAULT 'xhtml',
  `field_show_fmt` char(1) NOT NULL DEFAULT 'y',
  `field_order` int(3) unsigned NOT NULL,
  `field_content_type` varchar(20) NOT NULL DEFAULT 'any',
  `field_settings` text,
  PRIMARY KEY (`field_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`),
  KEY `field_type` (`field_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `exp_channel_fields`
--

INSERT INTO `exp_channel_fields` (`field_id`, `site_id`, `group_id`, `field_name`, `field_label`, `field_instructions`, `field_type`, `field_list_items`, `field_pre_populate`, `field_pre_channel_id`, `field_pre_field_id`, `field_related_to`, `field_related_id`, `field_related_orderby`, `field_related_sort`, `field_related_max`, `field_ta_rows`, `field_maxl`, `field_required`, `field_text_direction`, `field_search`, `field_is_hidden`, `field_fmt`, `field_show_fmt`, `field_order`, `field_content_type`, `field_settings`) VALUES
(1, 1, 1, 'blog-summary', 'Summary', '', 'wygwam', '', '0', 0, 0, 'channel', 1, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'y', 'n', 'none', 'n', 1, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(2, 1, 1, 'blog-standfirst', 'Standfirst', '', 'wygwam', '', '0', 0, 0, 'channel', 1, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'y', 'n', 'none', 'n', 2, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(3, 1, 1, 'blog-body', 'Body', '', 'wygwam', '', '0', 0, 0, 'channel', 1, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'y', 'n', 'none', 'n', 3, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIyIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(4, 1, 2, 'whyilove-colour', 'Colour', 'Pick a colour background', 'select', 'blue\nyellow\ngreen\nred', 'n', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'n', 'n', 'none', 'n', 1, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(5, 1, 2, 'whyilove-text', 'Text', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 3, 128, 'y', 'ltr', 'n', 'n', 'none', 'n', 2, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(6, 1, 3, 'work-summary', 'Summary', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'y', 'n', 'none', 'n', 1, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(7, 1, 3, 'work-standfirst', 'Standfirst', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'y', 'n', 'none', 'n', 2, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(8, 1, 3, 'work-body', 'Body', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'y', 'n', 'none', 'n', 3, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIyIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(9, 1, 3, 'work-thumb', 'Thumbnail image', '', 'matrix', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'n', 'n', 'none', 'n', 4, 'any', 'YTozOntzOjg6Im1pbl9yb3dzIjtzOjE6IjAiO3M6ODoibWF4X3Jvd3MiO3M6MToiMSI7czo3OiJjb2xfaWRzIjthOjI6e2k6MDtzOjE6IjEiO2k6MTtzOjE6IjIiO319'),
(10, 1, 3, 'work-slides', 'Slideshow', 'Min: 2\nMax: 10', 'matrix', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'n', 'n', 'none', 'n', 5, 'any', 'YTozOntzOjg6Im1pbl9yb3dzIjtzOjE6IjIiO3M6ODoibWF4X3Jvd3MiO3M6MjoiMTAiO3M6NzoiY29sX2lkcyI7YTo0OntpOjA7czoxOiIzIjtpOjE7czoxOiI0IjtpOjI7czoxOiI1IjtpOjM7aToxNzt9fQ=='),
(11, 1, 3, 'work-url', 'Website URL', '', 'text', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 300, 'n', 'ltr', 'n', 'n', 'none', 'n', 6, 'any', 'YTo4OntzOjE4OiJmaWVsZF9jb250ZW50X3RleHQiO2I6MDtzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO3M6MTg6ImZpZWxkX2NvbnRlbnRfdHlwZSI7czozOiJhbnkiO30='),
(12, 1, 3, 'work-type', 'Type of work', '', 'select', 'website\nemail_template\nbanner\nvisual_concept', 'n', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'n', 'n', 'none', 'n', 7, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(13, 1, 4, 'page-standfirst', 'Standfirst', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'y', 'n', 'none', 'n', 1, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(14, 1, 4, 'page-body', 'Body', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'y', 'ltr', 'y', 'n', 'none', 'n', 2, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIyIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(15, 1, 1, 'blog-addinfo', 'Additional information', '', 'textarea', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'y', 'n', 'xhtml', 'n', 4, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(16, 1, 1, 'blog-extended', 'Extended', 'If it''s a particularly long post, add the full extent of the post here.', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'y', 'n', 'none', 'n', 5, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIyIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(17, 1, 3, 'work-screencast', 'Screencast', 'Add embed code below', 'textarea', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 8, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(26, 1, 6, 'bespoke-content', 'Content', '', 'textarea', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 40, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 2, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(25, 1, 6, 'bespoke-headercalls', 'Additional header calls', '', 'textarea', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 1, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(24, 1, 1, 'blog-type', 'Post type', '', 'pt_radio_buttons', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'xhtml', 'n', 8, 'any', 'YTo3OntzOjc6Im9wdGlvbnMiO2E6Mjp7czoxNToiYmxvZy10eXBlX2ltYWdlIjtzOjEwOiJXaXRoIGltYWdlIjtzOjE5OiJibG9nLXR5cGVfcGxhaW50ZXh0IjtzOjEwOiJQbGFpbiB0ZXh0Ijt9czoxODoiZmllbGRfc2hvd19zbWlsZXlzIjtzOjE6Im4iO3M6MTk6ImZpZWxkX3Nob3dfZ2xvc3NhcnkiO3M6MToibiI7czoyMToiZmllbGRfc2hvd19zcGVsbGNoZWNrIjtzOjE6Im4iO3M6MjY6ImZpZWxkX3Nob3dfZm9ybWF0dGluZ19idG5zIjtzOjE6Im4iO3M6MjQ6ImZpZWxkX3Nob3dfZmlsZV9zZWxlY3RvciI7czoxOiJuIjtzOjIwOiJmaWVsZF9zaG93X3dyaXRlbW9kZSI7czoxOiJuIjt9'),
(21, 1, 1, 'blog-image', 'Image', '', 'matrix', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 6, 'any', 'YTozOntzOjg6Im1pbl9yb3dzIjtzOjE6IjEiO3M6ODoibWF4X3Jvd3MiO3M6MToiMSI7czo3OiJjb2xfaWRzIjthOjQ6e2k6MDtzOjE6IjkiO2k6MTtzOjI6IjEwIjtpOjI7czoyOiIxMSI7aTozO2k6MTU7fX0='),
(22, 1, 1, 'blog-thumb', 'Thumb', '', 'matrix', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 7, 'any', 'YTozOntzOjg6Im1pbl9yb3dzIjtzOjE6IjEiO3M6ODoibWF4X3Jvd3MiO3M6MToiMSI7czo3OiJjb2xfaWRzIjthOjQ6e2k6MDtzOjI6IjEyIjtpOjE7czoyOiIxMyI7aToyO3M6MjoiMTQiO2k6MztpOjE2O319'),
(23, 1, 3, 'work-extended', 'Extended', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 9, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIyIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(27, 1, 6, 'bespoke-footer', 'Footer', '', 'wygwam', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 3, 'any', 'YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(28, 1, 6, 'bespoke-cssclass', 'CSS class', '', 'text', '', '0', 0, 0, 'channel', 2, 'title', 'desc', 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 4, 'any', 'YTo3OntzOjE4OiJmaWVsZF9jb250ZW50X3R5cGUiO3M6MzoiYWxsIjtzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30=');

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_channel_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `channel_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_channel_member_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_titles`
--

CREATE TABLE IF NOT EXISTS `exp_channel_titles` (
  `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `pentry_id` int(10) NOT NULL DEFAULT '0',
  `forum_topic_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(16) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL DEFAULT 'n',
  `view_count_one` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_two` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_three` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_four` int(10) unsigned NOT NULL DEFAULT '0',
  `allow_comments` varchar(1) NOT NULL DEFAULT 'y',
  `sticky` varchar(1) NOT NULL DEFAULT 'n',
  `entry_date` int(10) NOT NULL,
  `dst_enabled` varchar(1) NOT NULL DEFAULT 'n',
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL DEFAULT '0',
  `comment_expiration_date` int(10) NOT NULL DEFAULT '0',
  `edit_date` bigint(14) DEFAULT NULL,
  `recent_comment_date` int(10) DEFAULT NULL,
  `comment_total` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `url_title` (`url_title`),
  KEY `status` (`status`),
  KEY `entry_date` (`entry_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

--
-- Dumping data for table `exp_channel_titles`
--

INSERT INTO `exp_channel_titles` (`entry_id`, `site_id`, `channel_id`, `author_id`, `pentry_id`, `forum_topic_id`, `ip_address`, `title`, `url_title`, `status`, `versioning_enabled`, `view_count_one`, `view_count_two`, `view_count_three`, `view_count_four`, `allow_comments`, `sticky`, `entry_date`, `dst_enabled`, `year`, `month`, `day`, `expiration_date`, `comment_expiration_date`, `edit_date`, `recent_comment_date`, `comment_total`) VALUES
(20, 1, 1, 1, 0, NULL, '94.194.134.131', 'Clarity vs smoothness', 'clarity_vs_smoothness', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1303256973, 'n', '2011', '04', '19', 0, 0, 20120201014534, 0, 0),
(19, 1, 1, 1, 0, NULL, '94.194.134.131', 'Webfonts; how are they rendered?', 'webfonts_how_are_they_rendered', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1303181229, 'n', '2011', '04', '18', 0, 0, 20110420124551, 0, 0),
(5, 1, 2, 1, 0, NULL, '127.0.0.1', 'Semantic markup', 'semantic_markup', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1303051213, 'n', '2011', '04', '17', 0, 0, 20110418080715, 0, 0),
(6, 1, 2, 1, 0, NULL, '127.0.0.1', 'Expression engine', 'expression_engine', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1303052430, 'n', '2011', '04', '17', 0, 0, 20110418080532, 0, 0),
(7, 1, 2, 1, 0, NULL, '94.194.134.131', 'css3', 'css3', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1303052885, 'n', '2011', '04', '17', 0, 0, 20110419160107, 0, 0),
(8, 1, 3, 1, 0, NULL, '94.194.134.131', 'Thames Festival', 'thames_festival', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304975054, 'n', '2011', '05', '09', 0, 0, 20120130021515, 0, 0),
(9, 1, 3, 1, 0, NULL, '94.194.134.131', 'Corn Exchange Newbury', 'corn_exchange_newbury', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304975119, 'n', '2011', '05', '09', 0, 0, 20120129182021, 0, 0),
(10, 1, 3, 1, 0, NULL, '94.194.134.131', 'Immediate Theatre', 'immediate_theatre', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304974994, 'n', '2011', '05', '09', 0, 0, 20120130021515, 0, 0),
(11, 1, 2, 1, 0, NULL, '94.194.134.131', 'HTML5', 'html5', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1303110706, 'n', '2011', '04', '18', 0, 0, 20110422060148, 0, 0),
(12, 1, 4, 1, 0, NULL, '94.194.134.131', 'What makes me tick?', 'what_makes_me_tick', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1303150448, 'n', '2011', '04', '18', 0, 0, 20120201002410, 0, 0),
(13, 1, 3, 1, 0, NULL, '94.194.134.131', 'Told by an Idiot', 'told_by_an_idiot', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304974874, 'n', '2011', '05', '09', 0, 0, 20120130021515, 0, 0),
(14, 1, 3, 1, 0, NULL, '94.194.134.131', 'Emergency Exit Arts', 'emergency_exit_arts', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304974814, 'n', '2011', '05', '09', 0, 0, 20120130021515, 0, 0),
(15, 1, 3, 1, 0, NULL, '94.194.134.131', 'Fair Share Trust', 'fair_share_trust', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1303175294, 'n', '2011', '04', '18', 0, 0, 20120130021515, 0, 0),
(16, 1, 3, 1, 0, NULL, '94.194.134.131', 'Youth Music Theatre', 'youth_music_theatre', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1304974934, 'n', '2011', '05', '09', 0, 0, 20120130021515, 0, 0),
(17, 1, 3, 1, 0, NULL, '94.194.134.131', 'Museum of the Order of St John', 'museum_of_the_order_of_st_john', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304975174, 'n', '2011', '05', '09', 0, 0, 20120130021515, 0, 0),
(18, 1, 3, 1, 0, NULL, '94.194.134.131', 'Done and Dusted', 'done_and_dusted', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1303173974, 'n', '2011', '04', '18', 0, 0, 20120130021515, 0, 0),
(21, 1, 1, 1, 0, NULL, '94.194.134.131', 'Convention can be fun', 'convention_can_be_fun', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1299135223, 'n', '2011', '03', '02', 0, 0, 20110510132144, 0, 0),
(22, 1, 1, 1, 0, NULL, '94.194.134.131', 'Objectify your CSS', 'objectify_your_css', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1296546881, 'n', '2011', '01', '31', 0, 0, 20120129093842, 0, 0),
(23, 1, 1, 1, 0, NULL, '217.205.197.194', 'Bulletproof webfonts: part 1', 'bulletproof_webfonts_pt1', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1305064753, 'n', '2011', '05', '10', 0, 0, 20120131060615, 0, 0),
(24, 1, 3, 1, 0, NULL, '94.194.134.131', 'iluv2', 'iluv2', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304538905, 'n', '2011', '05', '04', 0, 0, 20120131161606, 0, 0),
(25, 1, 3, 1, 0, NULL, '94.194.134.131', '2011 Norfolk and Norwich festival', 'nnf11', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304975258, 'n', '2011', '05', '09', 0, 0, 20120201001940, 0, 0),
(26, 1, 3, 1, 0, NULL, '94.194.134.131', 'CMN Tours', 'cmn_tours_microsite_approximately_infinate_universe', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1304235514, 'n', '2011', '05', '01', 0, 0, 20120131161735, 0, 0),
(27, 1, 4, 1, 0, NULL, '94.194.134.131', 'Oops!', 'oops', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1305227538, 'n', '2011', '05', '12', 0, 0, 20110512122119, 0, 0),
(28, 1, 1, 1, 0, NULL, '94.194.134.131', 'Bulletproof webfonts: part 2', 'bulletproof_webfonts_part_2', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1305233072, 'n', '2011', '05', '12', 0, 0, 20110606124033, 0, 0),
(29, 1, 1, 1, 0, NULL, '94.194.134.131', 'Bulletproof webfonts: part 3', 'bulletproof_webfonts_part_3', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1307292844, 'n', '2011', '06', '05', 0, 0, 20110605095606, 0, 0),
(30, 1, 4, 1, 0, NULL, '94.194.134.131', 'A word in my ear?', 'a_word_in_my_ear', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1308494631, 'n', '2011', '06', '19', 0, 0, 20120129075652, 0, 0),
(31, 1, 2, 1, 0, NULL, '94.194.134.131', 'Geek meets', 'geek_meets', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1308596219, 'n', '2011', '06', '20', 0, 0, 20110620120203, 0, 0),
(32, 1, 1, 1, 0, NULL, '94.194.134.131', 'Keeping a clean (style) sheet', 'keeping_a_clean_stylesheet', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1308597093, 'n', '2011', '06', '20', 0, 0, 20120131165635, 0, 0),
(59, 1, 1, 2, 0, NULL, '213.205.225.139', 'When the real and virtual just don''t mix', 'when_the_real_and_virtual_just_dont_mix', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1329019092, 'n', '2012', '02', '11', 0, 0, 20120211120238, 0, 0),
(58, 1, 1, 1, 0, NULL, '94.194.134.131', 'No-image breadcrumb nav', 'no_image_breadcrumb_nav', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1328450602, 'n', '2012', '02', '05', 0, 0, 20120205085823, 0, 0),
(55, 1, 1, 1, 0, NULL, '94.194.134.131', 'Love your JS', 'heart_your_js', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1311040844, 'n', '2011', '07', '18', 0, 0, 20120131171145, 0, 0),
(54, 1, 1, 1, 0, NULL, '94.194.134.131', 'Shifting conventions', 'shifting_conventions', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1311058753, 'n', '2011', '07', '18', 0, 0, 20120131143115, 0, 0),
(40, 1, 2, 2, 0, NULL, '94.194.134.131', 'HTML Doctor', 'html_doctor', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1311344965, 'n', '2011', '07', '22', 0, 0, 20110722132927, 0, 0),
(41, 1, 2, 2, 0, NULL, '193.35.132.13', 'Responsive design', 'responsive_design', 'open', 'y', 0, 0, 0, 0, 'n', 'n', 1311345149, 'n', '2011', '07', '22', 0, 0, 20111027115531, 0, 0),
(46, 1, 1, 2, 0, NULL, '94.194.134.131', 'Know your descendence', 'know_your_descendence', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1319602352, 'n', '2011', '10', '25', 0, 0, 20120201002233, 0, 0),
(43, 1, 1, 2, 0, NULL, '193.35.132.14', 'Building tangentsnowball.com', 'building_tangentsnowball.com', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1313504545, 'n', '2011', '08', '16', 0, 0, 20110820140708, 0, 0),
(44, 1, 1, 2, 0, NULL, '94.194.134.131', 'Are you sitting comfortably?', 'are_you_sitting_comfortably', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1313924446, 'n', '2011', '08', '21', 0, 0, 20120102085247, 0, 0),
(53, 1, 1, 1, 0, NULL, '94.194.134.131', 'Insites highlights', 'insites_london_2011_highlights', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1311119637, 'n', '2011', '07', '19', 0, 0, 20120131142759, 0, 0),
(47, 1, 1, 1, 0, NULL, '94.194.134.131', 'Oh Christmas tree...', 'xmastreesinthewild', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1323981794, 'n', '2011', '12', '15', 0, 0, 20120129160815, 0, 0),
(62, 1, 1, 2, 0, NULL, '217.205.197.194', 'Designers aren''t ruining the web', 'designers_arent_ruining_the_web', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1329717158, 'n', '2012', '02', '19', 0, 0, 20120221005539, 0, 0),
(49, 1, 1, 1, 0, NULL, '94.194.134.131', 'A new site, from the ground up', 'a_new_site_from_the_ground_up', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1327863898, 'n', '2012', '01', '29', 0, 0, 20120129134159, 0, 0),
(57, 1, 1, 1, 0, NULL, '94.194.134.131', 'Fancy  abbr tags', 'fancy_abbr_tags', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1328060942, 'n', '2012', '01', '31', 0, 0, 20120201151104, 0, 0),
(50, 1, 3, 1, 0, NULL, '94.194.134.131', 'A little polish for nails inc', 'nails_inc', 'Featured', 'y', 0, 0, 0, 0, 'y', 'n', 1327875610, 'n', '2012', '01', '29', 0, 0, 20120131134812, 0, 0),
(51, 1, 3, 1, 0, NULL, '94.194.134.131', 'Tangent Snowball', 'tangent_snowball', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1327541834, 'n', '2012', '01', '25', 0, 0, 20120130021515, 0, 0),
(52, 1, 1, 1, 0, NULL, '94.194.134.131', 'Avoid repition with media queries', 'avoid_repition_with_media_queries', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1314913341, 'n', '2011', '09', '01', 0, 0, 20120131171422, 0, 0),
(56, 1, 1, 1, 0, NULL, '94.194.134.131', 'Hi-speed HTML5', 'hi_speed_html5', 'closed', 'y', 0, 0, 0, 0, 'y', 'n', 1310228504, 'n', '2011', '07', '09', 0, 0, 20120131144745, 0, 0),
(60, 1, 6, 1, 0, NULL, '94.194.134.131', 'A Lebowski quote', 'lebowski_quote', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1329065414, 'n', '2012', '02', '12', 0, 0, 20120212095715, 0, 0),
(61, 1, 1, 1, 0, NULL, '94.194.134.131', 'Lebowski loves fittext', 'lebowski_loves_fittext', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1329066773, 'n', '2012', '02', '12', 0, 0, 20120212183254, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_channels`
--

CREATE TABLE IF NOT EXISTS `exp_channels` (
  `channel_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_name` varchar(40) NOT NULL,
  `channel_title` varchar(100) NOT NULL,
  `channel_url` varchar(100) NOT NULL,
  `channel_description` varchar(225) DEFAULT NULL,
  `channel_lang` varchar(12) NOT NULL,
  `total_entries` mediumint(8) NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `cat_group` varchar(255) DEFAULT NULL,
  `status_group` int(4) unsigned DEFAULT NULL,
  `deft_status` varchar(50) NOT NULL DEFAULT 'open',
  `field_group` int(4) unsigned DEFAULT NULL,
  `search_excerpt` int(4) unsigned DEFAULT NULL,
  `deft_category` varchar(60) DEFAULT NULL,
  `deft_comments` char(1) NOT NULL DEFAULT 'y',
  `channel_require_membership` char(1) NOT NULL DEFAULT 'y',
  `channel_max_chars` int(5) unsigned DEFAULT NULL,
  `channel_html_formatting` char(4) NOT NULL DEFAULT 'all',
  `channel_allow_img_urls` char(1) NOT NULL DEFAULT 'y',
  `channel_auto_link_urls` char(1) NOT NULL DEFAULT 'y',
  `channel_notify` char(1) NOT NULL DEFAULT 'n',
  `channel_notify_emails` varchar(255) DEFAULT NULL,
  `comment_url` varchar(80) DEFAULT NULL,
  `comment_system_enabled` char(1) NOT NULL DEFAULT 'y',
  `comment_require_membership` char(1) NOT NULL DEFAULT 'n',
  `comment_use_captcha` char(1) NOT NULL DEFAULT 'n',
  `comment_moderate` char(1) NOT NULL DEFAULT 'n',
  `comment_max_chars` int(5) unsigned DEFAULT '5000',
  `comment_timelock` int(5) unsigned NOT NULL DEFAULT '0',
  `comment_require_email` char(1) NOT NULL DEFAULT 'y',
  `comment_text_formatting` char(5) NOT NULL DEFAULT 'xhtml',
  `comment_html_formatting` char(4) NOT NULL DEFAULT 'safe',
  `comment_allow_img_urls` char(1) NOT NULL DEFAULT 'n',
  `comment_auto_link_urls` char(1) NOT NULL DEFAULT 'y',
  `comment_notify` char(1) NOT NULL DEFAULT 'n',
  `comment_notify_authors` char(1) NOT NULL DEFAULT 'n',
  `comment_notify_emails` varchar(255) DEFAULT NULL,
  `comment_expiration` int(4) unsigned NOT NULL DEFAULT '0',
  `search_results_url` varchar(80) DEFAULT NULL,
  `ping_return_url` varchar(80) DEFAULT NULL,
  `show_button_cluster` char(1) NOT NULL DEFAULT 'y',
  `rss_url` varchar(80) DEFAULT NULL,
  `enable_versioning` char(1) NOT NULL DEFAULT 'n',
  `max_revisions` smallint(4) unsigned NOT NULL DEFAULT '10',
  `default_entry_title` varchar(100) DEFAULT NULL,
  `url_title_prefix` varchar(80) DEFAULT NULL,
  `live_look_template` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`channel_id`),
  KEY `cat_group` (`cat_group`),
  KEY `status_group` (`status_group`),
  KEY `field_group` (`field_group`),
  KEY `site_id` (`site_id`),
  KEY `channel_name` (`channel_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `exp_channels`
--

INSERT INTO `exp_channels` (`channel_id`, `site_id`, `channel_name`, `channel_title`, `channel_url`, `channel_description`, `channel_lang`, `total_entries`, `total_comments`, `last_entry_date`, `last_comment_date`, `cat_group`, `status_group`, `deft_status`, `field_group`, `search_excerpt`, `deft_category`, `deft_comments`, `channel_require_membership`, `channel_max_chars`, `channel_html_formatting`, `channel_allow_img_urls`, `channel_auto_link_urls`, `channel_notify`, `channel_notify_emails`, `comment_url`, `comment_system_enabled`, `comment_require_membership`, `comment_use_captcha`, `comment_moderate`, `comment_max_chars`, `comment_timelock`, `comment_require_email`, `comment_text_formatting`, `comment_html_formatting`, `comment_allow_img_urls`, `comment_auto_link_urls`, `comment_notify`, `comment_notify_authors`, `comment_notify_emails`, `comment_expiration`, `search_results_url`, `ping_return_url`, `show_button_cluster`, `rss_url`, `enable_versioning`, `max_revisions`, `default_entry_title`, `url_title_prefix`, `live_look_template`) VALUES
(1, 1, 'blog', 'Blog', 'http://www. jackarmley.co.uk/blog/article', '', 'en', 14, 0, 1329066773, 0, '1', 1, 'closed', 1, 1, '', 'y', 'y', NULL, 'all', 'y', 'n', 'n', '', '', 'y', 'n', 'y', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '', '', 'y', '', 'n', 10, '', '', 51),
(2, 1, 'whyilove', '"Why I love" easter egg', 'http://localhost/jackarmley/index.php', '', 'en', 7, 0, 1311345149, 0, NULL, 1, 'closed', 2, NULL, '', 'y', 'y', NULL, 'all', 'y', 'n', 'n', '', '', 'n', 'n', 'y', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '', '', 'n', '', 'n', 10, '', '', 0),
(3, 1, 'work', 'Work', 'http://localhost/jackarmley/index.php', '', 'en', 13, 0, 1327875610, 0, NULL, 2, 'closed', 3, 6, '', 'y', 'y', NULL, 'all', 'y', 'n', 'n', '', '', 'y', 'n', 'y', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '', '', 'n', '', 'n', 10, '', '', 50),
(4, 1, 'page', 'Page', 'http://localhost/jackarmley/index.php', '', 'en', 3, 0, 1308494631, 0, NULL, 1, 'closed', 4, NULL, '', 'y', 'y', NULL, 'all', 'y', 'n', 'n', '', '', 'y', 'n', 'y', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '', '', 'n', '', 'n', 10, '', '', 0),
(6, 1, 'bespoke_post', 'Bespoke post', 'http://www. jackarmley.co.uk/blog/article', '', 'en', 1, 0, 1329065414, 0, NULL, 1, 'closed', 6, 1, '', 'y', 'y', NULL, 'all', 'y', 'n', 'n', '', '', 'y', 'n', 'y', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '', '', 'y', '', 'n', 10, '', '', 51);

-- --------------------------------------------------------

--
-- Table structure for table `exp_comment_subscriptions`
--

CREATE TABLE IF NOT EXISTS `exp_comment_subscriptions` (
  `subscription_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned DEFAULT NULL,
  `member_id` int(10) DEFAULT '0',
  `email` varchar(50) DEFAULT NULL,
  `subscription_date` varchar(10) DEFAULT NULL,
  `notification_sent` char(1) DEFAULT 'n',
  `hash` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  KEY `entry_id` (`entry_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_comment_subscriptions`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_comments`
--

CREATE TABLE IF NOT EXISTS `exp_comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) DEFAULT '1',
  `entry_id` int(10) unsigned DEFAULT '0',
  `channel_id` int(4) unsigned DEFAULT '1',
  `author_id` int(10) unsigned DEFAULT '0',
  `status` char(1) DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `url` varchar(75) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `comment_date` int(10) DEFAULT NULL,
  `edit_date` int(10) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`comment_id`),
  KEY `entry_id` (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `status` (`status`),
  KEY `site_id` (`site_id`),
  KEY `comment_date_idx` (`comment_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_cp_log`
--

CREATE TABLE IF NOT EXISTS `exp_cp_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) unsigned NOT NULL,
  `username` varchar(32) NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `act_date` int(10) NOT NULL,
  `action` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=187 ;

--
-- Dumping data for table `exp_cp_log`
--

INSERT INTO `exp_cp_log` (`id`, `site_id`, `member_id`, `username`, `ip_address`, `act_date`, `action`) VALUES
(1, 1, 1, 'jack_armley', '127.0.0.1', 1303041054, 'Logged in'),
(2, 1, 1, 'jack_armley', '127.0.0.1', 1303049172, 'Channel Created:&nbsp;&nbsp;Blog'),
(3, 1, 1, 'jack_armley', '127.0.0.1', 1303049287, 'Field Group Created:&nbsp;Blog'),
(4, 1, 1, 'jack_armley', '127.0.0.1', 1303050903, 'Channel Created:&nbsp;&nbsp;"Why I love" easter egg'),
(5, 1, 1, 'jack_armley', '127.0.0.1', 1303050968, 'Field Group Created:&nbsp;Why i love easter egg'),
(6, 1, 1, 'jack_armley', '127.0.0.1', 1303054862, 'Channel Created:&nbsp;&nbsp;Work'),
(7, 1, 1, 'jack_armley', '127.0.0.1', 1303054915, 'Field Group Created:&nbsp;Work'),
(8, 1, 1, 'jack_armley', '127.0.0.1', 1303060512, 'Logged in'),
(9, 1, 1, 'jack_armley', '127.0.0.1', 1303109766, 'Logged in'),
(10, 1, 1, 'jack_armley', '127.0.0.1', 1303150331, 'Channel Created:&nbsp;&nbsp;Page'),
(11, 1, 1, 'jack_armley', '127.0.0.1', 1303150350, 'Field Group Created:&nbsp;Page'),
(12, 1, 1, 'jack_armley', '94.194.134.131', 1303155151, 'Logged in'),
(13, 1, 1, 'jack_armley', '94.194.134.131', 1303159374, 'Logged in'),
(14, 1, 1, 'jack_armley', '94.194.134.131', 1303160372, 'Logged in'),
(15, 1, 1, 'jack_armley', '94.194.134.131', 1303160463, 'Logged in'),
(16, 1, 1, 'jack_armley', '94.194.134.131', 1303160603, 'Logged in'),
(17, 1, 1, 'jack_armley', '94.194.134.131', 1303161973, 'Logged in'),
(18, 1, 1, 'jack_armley', '94.194.134.131', 1303162448, 'Logged in'),
(19, 1, 1, 'jack_armley', '94.194.134.131', 1303166394, 'Logged in'),
(20, 1, 1, 'jack_armley', '94.194.134.131', 1303166490, 'Logged in'),
(21, 1, 1, 'jack_armley', '94.194.134.131', 1303179450, 'Logged out'),
(22, 1, 1, 'jack_armley', '94.194.134.131', 1303179847, 'Logged in'),
(23, 1, 1, 'jack_armley', '94.194.134.131', 1303180003, 'Logged in'),
(24, 1, 1, 'jack_armley', '94.194.134.131', 1303196353, 'Logged in'),
(25, 1, 1, 'jack_armley', '83.104.28.50', 1303201880, 'Logged in'),
(26, 1, 1, 'jack_armley', '83.104.28.50', 1303232485, 'Logged in'),
(27, 1, 1, 'jack_armley', '94.194.134.131', 1303240160, 'Logged in'),
(28, 1, 1, 'jack_armley', '94.194.134.131', 1303247595, 'Logged in'),
(29, 1, 1, 'jack_armley', '94.194.134.131', 1303262992, 'Logged out'),
(30, 1, 1, 'jack_armley', '94.194.134.131', 1303263068, 'Logged in'),
(31, 1, 1, 'jack_armley', '94.194.134.131', 1303328206, 'Logged in'),
(32, 1, 1, 'jack_armley', '83.104.28.50', 1303374565, 'Logged in'),
(33, 1, 1, 'jack_armley', '83.104.28.50', 1303374580, 'Logged out'),
(34, 1, 1, 'jack_armley', '83.104.28.50', 1303404849, 'Logged in'),
(35, 1, 1, 'jack_armley', '94.194.134.131', 1303462780, 'Logged in'),
(36, 1, 1, 'jack_armley', '94.194.134.131', 1303470469, 'Logged in'),
(37, 1, 1, 'jack_armley', '94.194.134.131', 1303471170, 'Logged in'),
(38, 1, 1, 'jack_armley', '94.194.134.131', 1303476467, 'Status Group Created:&nbsp;Work'),
(39, 1, 1, 'jack_armley', '94.194.134.131', 1304240851, 'Logged in'),
(40, 1, 1, 'jack_armley', '94.194.134.131', 1304460866, 'Logged in'),
(41, 1, 1, 'jack_armley', '94.194.134.131', 1304463372, 'Logged in'),
(42, 1, 1, 'jack_armley', '94.194.134.131', 1304491410, 'Logged in'),
(43, 1, 1, 'jack_armley', '94.194.134.131', 1304491714, 'Logged out'),
(44, 1, 1, 'jack_armley', '83.104.28.50', 1304497222, 'Logged in'),
(45, 1, 1, 'jack_armley', '83.104.28.50', 1304512166, 'Logged in'),
(46, 1, 1, 'jack_armley', '83.104.28.50', 1304512496, 'Logged out'),
(47, 1, 1, 'jack_armley', '94.194.134.131', 1304536450, 'Logged in'),
(48, 1, 1, 'jack_armley', '94.194.134.131', 1304547677, 'Logged out'),
(49, 1, 1, 'jack_armley', '94.194.134.131', 1304577882, 'Logged in'),
(50, 1, 1, 'jack_armley', '94.194.134.131', 1304745650, 'Logged in'),
(51, 1, 1, 'jack_armley', '94.194.134.131', 1304839572, 'Logged in'),
(52, 1, 1, 'jack_armley', '94.194.134.131', 1304846775, 'Logged in'),
(53, 1, 1, 'jack_armley', '94.194.134.131', 1304862627, 'Logged in'),
(54, 1, 1, 'jack_armley', '94.194.134.131', 1304913779, 'Logged in'),
(55, 1, 1, 'jack_armley', '94.194.134.131', 1304920350, 'Logged in'),
(56, 1, 1, 'jack_armley', '83.104.28.50', 1304941888, 'Logged in'),
(57, 1, 1, 'jack_armley', '83.104.28.50', 1304943779, 'Logged out'),
(58, 1, 1, 'jack_armley', '83.104.28.50', 1304960592, 'Logged in'),
(59, 1, 1, 'jack_armley', '94.194.134.131', 1304968450, 'Logged in'),
(60, 1, 1, 'jack_armley', '94.194.134.131', 1304975197, 'Logged in'),
(61, 1, 1, 'jack_armley', '94.194.134.131', 1305007580, 'Logged in'),
(62, 1, 1, 'jack_armley', '94.194.134.131', 1305058718, 'Logged in'),
(63, 1, 1, 'jack_armley', '94.194.134.131', 1305065543, 'Logged in'),
(64, 1, 1, 'jack_armley', '83.104.28.50', 1305115026, 'Logged in'),
(65, 1, 1, 'jack_armley', '83.104.28.50', 1305115595, 'Logged out'),
(66, 1, 1, 'jack_armley', '83.104.28.50', 1305135750, 'Logged in'),
(67, 1, 1, 'jack_armley', '83.104.28.50', 1305186738, 'Logged in'),
(68, 1, 1, 'jack_armley', '94.194.134.131', 1305232822, 'Logged in'),
(69, 1, 1, 'jack_armley', '94.194.134.131', 1305268758, 'Logged in'),
(70, 1, 1, 'jack_armley', '94.194.134.131', 1305268888, 'Logged out'),
(71, 1, 1, 'jack_armley', '83.104.28.50', 1305727157, 'Logged in'),
(72, 1, 1, 'jack_armley', '83.104.28.50', 1305727500, 'Logged out'),
(73, 1, 1, 'jack_armley', '83.104.28.50', 1305734317, 'Logged in'),
(74, 1, 1, 'jack_armley', '83.104.28.50', 1305734387, 'Logged out'),
(75, 1, 1, 'jack_armley', '94.194.134.131', 1306018293, 'Logged in'),
(76, 1, 1, 'jack_armley', '94.194.134.131', 1306089324, 'Logged in'),
(77, 1, 1, 'jack_armley', '94.194.134.131', 1306178580, 'Logged in'),
(78, 1, 1, 'jack_armley', '94.194.134.131', 1306351163, 'Logged in'),
(79, 1, 1, 'jack_armley', '94.194.134.131', 1306868580, 'Logged in'),
(80, 1, 1, 'jack_armley', '94.194.134.131', 1307269185, 'Logged in'),
(81, 1, 1, 'jack_armley', '82.28.89.161', 1307283780, 'Logged in'),
(82, 1, 1, 'jack_armley', '94.194.134.131', 1307288797, 'Logged in'),
(83, 1, 1, 'jack_armley', '94.194.134.131', 1307387961, 'Logged in'),
(84, 1, 1, 'jack_armley', '94.194.134.131', 1307791789, 'Logged in'),
(85, 1, 1, 'jack_armley', '94.194.134.131', 1307797383, 'Logged in'),
(86, 1, 1, 'jack_armley', '94.194.134.131', 1308491686, 'Logged in'),
(87, 1, 1, 'jack_armley', '94.194.134.131', 1308595119, 'Logged in'),
(88, 1, 1, 'jack_armley', '94.194.134.131', 1308605366, 'Logged in'),
(89, 1, 1, 'jack_armley', '94.194.134.131', 1308684931, 'Logged in'),
(90, 1, 1, 'jack_armley', '94.194.134.131', 1308685414, 'Logged in'),
(91, 1, 1, 'jack_armley', '94.194.134.131', 1308724471, 'Logged in'),
(92, 1, 1, 'jack_armley', '94.194.134.131', 1309696664, 'Logged in'),
(93, 1, 1, 'jack_armley', '94.194.134.131', 1309696693, 'Logged out'),
(94, 1, 1, 'jack_armley', '94.194.134.131', 1309699095, 'Logged in'),
(95, 1, 1, 'jack_armley', '94.194.134.131', 1309728315, 'Logged in'),
(96, 1, 1, 'jack_armley', '94.194.134.131', 1309990199, 'Logged in'),
(97, 1, 1, 'jack_armley', '94.194.134.131', 1310197727, 'Logged in'),
(98, 1, 1, 'jack_armley', '94.194.134.131', 1310199890, 'Channel Created:&nbsp;&nbsp;Note'),
(99, 1, 1, 'jack_armley', '94.194.134.131', 1310199914, 'Field Group Created:&nbsp;Note'),
(100, 1, 1, 'jack_armley', '94.194.134.131', 1310201305, 'Logged in'),
(101, 1, 1, 'jack_armley', '94.194.134.131', 1310202029, 'Logged in'),
(102, 1, 1, 'jack_armley', '94.194.134.131', 1310202429, 'Logged in'),
(103, 1, 1, 'jack_armley', '94.194.134.131', 1310202537, 'Logged out'),
(104, 1, 1, 'jack_armley', '94.194.134.131', 1310202548, 'Logged in'),
(105, 1, 1, 'jack_armley', '94.194.134.131', 1310203106, 'Member profile created:&nbsp;&nbsp;iphoneuser'),
(106, 1, 1, 'jack_armley', '94.194.134.131', 1310304152, 'Logged in'),
(107, 1, 1, 'jack_armley', '217.205.197.194', 1310490514, 'Logged in'),
(108, 1, 1, 'jack_armley', '217.205.197.194', 1310490575, 'Logged out'),
(109, 1, 1, 'jack_armley', '217.205.197.194', 1310724480, 'Logged in'),
(110, 1, 1, 'jack_armley', '217.205.197.194', 1310724521, 'Logged out'),
(111, 1, 1, 'jack_armley', '217.205.197.194', 1311007290, 'Logged in'),
(112, 1, 1, 'jack_armley', '94.194.134.131', 1311022478, 'Logged in'),
(113, 1, 1, 'jack_armley', '217.205.197.194', 1311061057, 'Logged in'),
(114, 1, 1, 'jack_armley', '94.194.134.131', 1311113859, 'Logged in'),
(115, 1, 1, 'jack_armley', '94.194.134.131', 1311144071, 'Logged in'),
(116, 1, 1, 'jack_armley', '217.205.197.194', 1311266671, 'Logged in'),
(117, 1, 1, 'jack_armley', '94.194.134.131', 1311366541, 'Logged in'),
(118, 1, 1, 'jack_armley', '82.28.89.161', 1313192976, 'Logged in'),
(119, 1, 1, 'jack_armley', '217.205.197.194', 1313415908, 'Logged in'),
(120, 1, 1, 'jack_armley', '217.205.197.194', 1313416001, 'Logged out'),
(121, 1, 1, 'jack_armley', '94.194.134.131', 1313930559, 'Logged in'),
(122, 1, 1, 'jack_armley', '217.205.197.194', 1314000639, 'Logged in'),
(123, 1, 1, 'jack_armley', '217.205.197.194', 1314000893, 'Logged out'),
(124, 1, 1, 'jack_armley', '217.205.197.194', 1314171759, 'Logged in'),
(125, 1, 1, 'jack_armley', '217.205.197.194', 1314174554, 'Logged out'),
(126, 1, 1, 'jack_armley', '94.194.134.131', 1314913345, 'Logged in'),
(127, 1, 1, 'jack_armley', '217.205.197.194', 1315833369, 'Logged in'),
(128, 1, 1, 'jack_armley', '217.205.197.194', 1315833620, 'Logged out'),
(129, 1, 1, 'jack_armley', '217.205.197.194', 1315833806, 'Logged in'),
(130, 1, 1, 'jack_armley', '217.205.197.194', 1317289098, 'Logged in'),
(131, 1, 1, 'jack_armley', '217.205.197.194', 1317289166, 'Logged out'),
(132, 1, 1, 'jack_armley', '82.28.89.161', 1319657277, 'Logged in'),
(133, 1, 1, 'jack_armley', '217.205.197.194', 1319812958, 'Logged in'),
(134, 1, 1, 'jack_armley', '217.205.197.194', 1320137525, 'Logged in'),
(135, 1, 1, 'jack_armley', '217.205.197.194', 1320652626, 'Logged in'),
(136, 1, 1, 'jack_armley', '217.205.197.194', 1320653136, 'Logged out'),
(137, 1, 1, 'jack_armley', '217.205.197.194', 1320834844, 'Logged in'),
(138, 1, 1, 'jack_armley', '217.205.197.194', 1320834962, 'Logged out'),
(139, 1, 1, 'jack_armley', '94.194.134.131', 1320968121, 'Logged in'),
(140, 1, 1, 'jack_armley', '94.194.134.131', 1321112934, 'Logged in'),
(141, 1, 1, 'jack_armley', '94.194.134.131', 1323907596, 'Logged in'),
(142, 1, 1, 'jack_armley', '31.76.13.75', 1323981894, 'Logged in'),
(143, 1, 1, 'jack_armley', '217.205.197.194', 1324026082, 'Logged in'),
(144, 1, 1, 'jack_armley', '94.194.134.131', 1325518498, 'Logged in'),
(145, 1, 1, 'jack_armley', '94.194.134.131', 1325523792, 'Logged out'),
(146, 1, 1, 'jack_armley', '94.194.134.131', 1327282933, 'Logged in'),
(147, 1, 1, 'jack_armley', '94.194.134.131', 1327347590, 'Logged in'),
(148, 1, 1, 'jack_armley', '94.194.134.131', 1327842279, 'Logged in'),
(149, 1, 1, 'jack_armley', '94.194.134.131', 1327852293, 'Logged in'),
(150, 1, 1, 'jack_armley', '94.194.134.131', 1327862973, 'Logged in'),
(151, 1, 1, 'jack_armley', '94.194.134.131', 1327893822, 'Logged in'),
(152, 1, 1, 'jack_armley', '94.194.134.131', 1327897135, 'Logged out'),
(153, 1, 1, 'jack_armley', '217.205.197.194', 1328017905, 'Logged in'),
(154, 1, 1, 'jack_armley', '94.194.134.131', 1328045634, 'Logged in'),
(155, 1, 1, 'jack_armley', '94.194.134.131', 1328046713, 'Category Group Created:&nbsp;&nbsp;Blog'),
(156, 1, 1, 'jack_armley', '94.194.134.131', 1328050330, 'Channel Deleted:&nbsp;&nbsp;Note'),
(157, 1, 1, 'jack_armley', '94.194.134.131', 1328050341, 'Field group Deleted:&nbsp;&nbsp;Note'),
(158, 1, 1, 'jack_armley', '94.194.134.131', 1328084296, 'Logged in'),
(159, 1, 1, 'jack_armley', '94.194.134.131', 1328137366, 'Logged in'),
(160, 1, 1, 'jack_armley', '217.205.197.194', 1328207102, 'Logged in'),
(161, 1, 1, 'jack_armley', '94.194.134.131', 1328213682, 'Logged in'),
(162, 1, 1, 'jack_armley', '94.194.134.131', 1328362167, 'Logged in'),
(163, 1, 1, 'jack_armley', '94.194.134.131', 1328450256, 'Logged in'),
(164, 1, 1, 'jack_armley', '94.194.134.131', 1328459811, 'Logged in'),
(165, 1, 1, 'jack_armley', '94.194.134.131', 1328562499, 'Logged in'),
(166, 1, 1, 'jack_armley', '94.194.134.131', 1328567625, 'Logged in'),
(167, 1, 1, 'jack_armley', '94.194.134.131', 1328569616, 'Logged out'),
(168, 1, 1, 'jack_armley', '217.205.197.194', 1328810984, 'Logged in'),
(169, 1, 1, 'jack_armley', '94.194.134.131', 1329064867, 'Logged in'),
(170, 1, 1, 'jack_armley', '94.194.134.131', 1329064898, 'Channel Created:&nbsp;&nbsp;Bespoke post'),
(171, 1, 1, 'jack_armley', '94.194.134.131', 1329064956, 'Field Group Created:&nbsp;Bespoke post'),
(172, 1, 1, 'jack_armley', '94.194.134.131', 1329085483, 'Logged in'),
(173, 1, 1, 'jack_armley', '94.194.134.131', 1329092603, 'Logged out'),
(174, 1, 1, 'jack_armley', '94.194.134.131', 1329100106, 'Logged in'),
(175, 1, 1, 'jack_armley', '94.194.134.131', 1329585747, 'Logged in'),
(176, 1, 1, 'jack_armley', '94.194.134.131', 1329592720, 'Logged in'),
(177, 1, 1, 'jack_armley', '94.194.134.131', 1329773316, 'Logged in'),
(178, 1, 1, 'jack_armley', '217.205.197.194', 1329812561, 'Logged in'),
(179, 1, 1, 'jack_armley', '217.205.197.194', 1329850430, 'Logged in'),
(180, 1, 1, 'jack_armley', '217.205.197.194', 1329854191, 'Logged in'),
(181, 1, 1, 'jack_armley', '94.194.134.131', 1329857717, 'Logged in'),
(182, 1, 1, 'jack_armley', '94.194.134.131', 1329857754, 'Logged out'),
(183, 1, 1, 'jack_armley', '94.194.134.131', 1329857758, 'Logged in'),
(184, 1, 1, 'jack_armley', '94.194.134.131', 1329857776, 'Logged out'),
(185, 1, 1, 'jack_armley', '94.194.134.131', 1329857801, 'Logged in'),
(186, 1, 1, 'jack_armley', '94.194.134.131', 1329857832, 'Logged out');

-- --------------------------------------------------------

--
-- Table structure for table `exp_cp_search_index`
--

CREATE TABLE IF NOT EXISTS `exp_cp_search_index` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `controller` varchar(20) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `access` varchar(50) DEFAULT NULL,
  `keywords` text,
  PRIMARY KEY (`search_id`),
  FULLTEXT KEY `keywords` (`keywords`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52 ;

--
-- Dumping data for table `exp_cp_search_index`
--

INSERT INTO `exp_cp_search_index` (`search_id`, `controller`, `method`, `language`, `access`, `keywords`) VALUES
(1, 'admin_system', 'general_configuration', 'english', 'can_access_sys_prefs', 'Is system on? License Number Name of your site Name of your site''s index page URL to the root directory of your site URL to your Control Panel index page URL to your "themes" folder Theme Folder Path Default Control Panel Theme Default Language Default XML Language Maximum Number of Cachable URIs New Version Auto Check URL to Documentation Directory'),
(2, 'admin_system', 'output_debugging_preferences', 'english', 'can_access_sys_prefs', 'Generate HTTP Page Headers? Enable GZIP Output? Force URL query strings Redirection Method Debug Preference Display Output Profiler? Display Template Debugging?'),
(3, 'admin_system', 'database_settings', 'english', 'can_access_sys_prefs', 'Enable Database Debugging Persistent Database Connection Enable SQL Query Caching'),
(4, 'admin_system', 'security_session_preferences', 'english', 'can_access_sys_prefs', 'cookie cookies Control Panel Session Type User Session Type Process form data in Secure Mode? Deny Duplicate Data? Apply Rank Denial to User-submitted Links? Allow members to change their username? Allow multiple log-ins from a single account? Require IP Address and User Agent for Login? Require IP Address and User Agent when receiving comments? Apply XSS Filtering to uploaded files? Enable Password Lockout? Time Interval for Lockout Require Secure Passwords? Allow Dictionary Words as Passwords? Name of Dictionary File Minimum Username Length Minimum Password Length'),
(5, 'admin_system', 'throttling_configuration', 'english', 'can_access_sys_prefs', 'Enable Throttling Deny Access if No IP Address is Present Maximum Number of Page Loads Time Interval (in seconds) Lockout Time (in seconds) Action to Take URL for Redirect Custom Message'),
(6, 'admin_system', 'localization_settings', 'english', 'can_access_sys_prefs', 'Server Time Zone Server Offset (in minutes) Default Time Formatting Daylight Saving Time'),
(7, 'admin_system', 'email_configuration', 'english', 'can_access_sys_prefs', 'Return email address for auto-generated emails Webmaster or site name for auto-generated emails Email Character Encoding Enable Email Debugging? Email Protocol SMTP Server Address SMTP Username SMTP Password Use Batch Mode? Number of Emails Per Batch Default Mail Format Enable Word-wrapping by Default? Email Console Timelock Log Email Console Messages Enable CAPTCHAs for Tell-a-Friend and Contact emails'),
(8, 'admin_system', 'cookie_settings', 'english', 'can_access_sys_prefs', 'cookies Cookie Domain Cookie Path Cookie Prefix'),
(9, 'admin_system', 'image_resizing_preferences', 'english', 'can_access_sys_prefs', 'Image Resizing Protocol Image Converter Path Image Thumbnail Suffix'),
(10, 'admin_system', 'captcha_preferences', 'english', 'can_access_sys_prefs', 'Server Path to CAPTCHA Folder Full URL to CAPTCHA Folder Use TrueType Font for CAPTCHA? Add Random Number to CAPTCHA Word Require CAPTCHA with logged-in members?'),
(11, 'admin_system', 'word_censoring', 'english', 'can_access_sys_prefs', 'Enable Word Censoring? Censoring Replacement Word Censored Words'),
(12, 'admin_system', 'mailing_list_preferences', 'english', 'can_access_sys_prefs', 'Mailing List is Enabled Enable recipient list for notification of new mailing list sign-ups Email Address of Notification Recipient(s) '),
(13, 'admin_system', 'emoticon_preferences', 'english', 'can_access_sys_prefs', 'Display Smileys? URL to the directory containing your smileys '),
(14, 'admin_system', 'tracking_preferences', 'english', 'can_access_sys_prefs', 'Enable Online User Tracking? Enable Template Hit Tracking? Enable Channel Entry View Tracking? Enable Referrer Tracking? Maximum number of recent referrers to save Suspend ALL tracking when number of online visitors exceeds:'),
(15, 'admin_system', 'search_log_configuration', 'english', 'can_access_sys_prefs', 'Enable Search Term Logging Maximum number of recent search terms to save'),
(16, 'admin_content', 'global_channel_preferences', 'english', 'can_admin_channels', 'Use Category URL Titles In Links? Category URL Indicator Auto-Assign Category Parents Clear all caches when new entries are posted? Cache Dynamic Channel Queries? Word Separator for URL Titles'),
(17, 'admin_content', 'field_group_management', 'english', 'can_admin_channels', 'Custom Channel Fields Field Group Add/Edit Custom Fields Edit Field Group Delete Field Group There are currently no custom channel fields Field Group Management'),
(18, 'admin_content', 'category_management', 'english', 'can_admin_categories', 'Category Management Administration Category Group Add/Edit Categories Edit Category Group Manage Custom Fields Delete Group There are currently no categories Category Management'),
(19, 'addons_accessories', 'index', 'english', 'can_access_accessories', 'Accessories Accessory Name Available to Member Groups Specific Page? Status Add-ons Accessories'),
(20, 'addons_extensions', 'index', 'english', 'can_access_extensions', 'Extensions Version Status Add-ons Extension Name Settings Documentation Status No Extensions Exist Class %c does not exist in (%f) Extensions'),
(21, 'addons_modules', 'index', 'english', 'can_access_modules', 'Modules Add-ons You are not allowed to access any modules Module Name Description Version Status Action Remove updated to version Updated All modules are up to date. Modules'),
(22, 'addons_plugins', 'index', 'english', 'can_access_plugins', 'Plugins Add-ons Plugins Plugin(s) Installed Version There are no plugins currently installed Remove Plugins'),
(23, 'content_publish', 'index', 'english', 'all', 'publish new entry There are currently no channels You are not authorized to post channel entries publ_index'),
(24, 'content_files', 'index', 'english', 'can_access_files', 'File Upload Choose an upload directory Upload File Upload hide toolbar Hide Show Date show toolbar File Manager File Information File Upload Choose an upload directory Upload File Upload File Tools Download Selected Files Delete Selected Files Create New Upload Destination File Upload Preferences You have no upload directories defined File Name File Size Kind You have no files uploaded to this directory Uploading File File Manager'),
(25, 'design', 'user_message', 'english', 'can_admin_design', 'User Message Template Has Been Updated The purpose of this template is to show error and other messages to users after they perform certain actions, like logging in, submitting a form, etc. Do not delete any of the five required variables: User Message Template'),
(26, 'design', 'global_template_preferences', 'english', 'can_admin_design', 'strict_urls 404 Page save_tmpl_revisions max_tmpl_revisions save_tmpl_files tmpl_file_basepath'),
(27, 'design', 'system_offline', 'english', 'can_admin_design', 'System Offline Template This template contains the page that is shown when your site is offline. Template Has Been Updated System Offline Template'),
(28, 'design', 'email_notification', 'english', 'can_admin_templates', 'Unable to locate the member profile templates. Email Notification Templates Email Notification Template'),
(29, 'design', 'member_profile_templates', 'english', 'can_admin_mbr_templates', 'Unable to locate the member profile templates. Member Profile Templates Member Profile Template'),
(30, 'members', 'register_member', 'english', 'can_admin_members', 'members_register_member'),
(31, 'members', 'member_validation', 'english', 'can_admin_members', 'Activate Pending Members Screen Name Email Address Join Date Activate Selected Members Delete Selected Members Send email notification to each person There are no member accounts awaiting activation Username Screen Name Join Date Screen Name members_member_validation'),
(32, 'members', 'view_members', 'english', 'can_access_members', 'members_view_members'),
(33, 'members', 'ip_search', 'english', 'can_admin_members', 'ip IP IP Address Search You can submit a partial or full IP address Your search did not return any results The IP address you submitted is too short.  It must be at least 3 characters long. members_ip_search'),
(34, 'members', 'custom_profile_fields', 'english', 'can_admin_members', 'Custom Member Fields Field Label Field Name There are currently no custom member fields Field ID Order Field Order Custom Member Profile Fields'),
(35, 'members', 'member_group_manager', 'english', 'can_admin_mbr_groups', 'Member Groups Group Title Edit Group Security Lock Group ID can access the control panel Create a new group based on an existing one Locked Unlocked Member Groups Member Group Management'),
(36, 'members', 'member_config', 'english', 'can_admin_members', 'Membership Preferences Preference Setting General Configuration Preference Setting members_member_config'),
(37, 'members', 'member_banning', 'english', 'can_ban_users', 'User Banning Preference Setting Banned IP Address Place each IP address on a separate line Use wildcards for partial IP addresses. Example:  123.345.* Banned Email Address Place each email address on a separate line Use wildcards for partial email addresses. Example:  *@domain.com Restricted Usernames Place each username on a separate line Restricted Screen Names Place each screen name on a separate line Restrict them to viewing only Show this message Send them to this site When a banned IP tries to access the site Preference Setting members_member_banning'),
(38, 'members', 'member_search', 'english', 'all', 'members_member_search'),
(39, 'tools_data', 'sql_manager', 'english', 'can_access_data', 'SQL Manager Tools Data SQL Info Sql Manager'),
(40, 'tools_data', 'search_and_replace', 'english', 'can_access_data', 'Search and Replace These forms enable you to search for specific text and replace it with different text Advanced Users Only Search for this text And replace it with this text In what database field do you want the replacement to occur? Depending on the syntax used, this function can produce undesired results.  Consult the manual and backup your database. Tools Data (Choose from the following) If you are replacing within templates, <a href="%x">synchronize with the database</a> first, or permanent data loss can occur! Number of database records in which a replacement occurred: Search and Replace'),
(41, 'tools_data', 'recount_stats', 'english', 'can_access_data', 'Recount Statistics Tools Data Source Database Records Perform Recount The links below allow you to update various statistics, like how many entries each member has submitted. Recount Preferences Recount Completed Recount Stats'),
(42, 'tools_data', 'php_info', 'english', 'can_access_data', 'PHP Info'),
(43, 'tools_data', 'clear_caching', 'english', 'can_access_data', 'Clear Cached Data Page (template) cache files Tag cache files Database cache files Cached Relationship Entries All caches Tools Data Cache files have been deleted Clear Caching'),
(44, 'tools_logs', 'view_cp_log', 'english', 'can_access_logs', 'View Control Panel Log Site No Results Found Tools Logs Your search resulted in no matches View Control Panel Log'),
(45, 'tools_logs', 'view_throttle_log', 'english', 'can_access_logs', 'Hits Last Activity Throttling Disabled Blacklist All IPs No IPs are currently being throttled by the system. View Throttle Log Tools Logs View Throttle Log'),
(46, 'tools_logs', 'view_search_log', 'english', 'can_access_logs', 'Screen Name Searched In Search Terms No Results Found View Search Log Tools Logs Screen Name Your search resulted in no matches View Search Log'),
(47, 'tools_logs', 'view_email_log', 'english', 'can_access_logs', 'View Email Console Log Tools Logs Email Title From To There are no cached email messages. View Email Log'),
(48, 'tools_utilities', 'member_import', 'english', 'can_access_utilities', 'Member Import Utility This utility allows you to import members from other systems into ExpressionEngine Import from XML File Allows you to import members from an XML file in ExpressionEngine''s Member XML format Convert delimited text to XML Allows you to create an ExpressionEngine Member XML file from another application''s delimited text file Member Import'),
(49, 'tools_utilities', 'import_from_mt', 'english', 'can_access_utilities', 'Import From MT'),
(50, 'tools_utilities', 'import_from_xml', 'english', 'can_access_utilities', 'Import From XML'),
(51, 'tools_utilities', 'translation_tool', 'english', 'can_access_utilities', 'Translation Utility Choose a file to translate Translation Utility');

-- --------------------------------------------------------

--
-- Table structure for table `exp_developer_log`
--

CREATE TABLE IF NOT EXISTS `exp_developer_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` int(10) unsigned DEFAULT NULL,
  `viewed` char(1) DEFAULT 'n',
  `description` text,
  `function` varchar(100) DEFAULT NULL,
  `line` int(10) unsigned DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `deprecated_since` varchar(10) DEFAULT NULL,
  `use_instead` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_developer_log`
--

INSERT INTO `exp_developer_log` (`log_id`, `timestamp`, `viewed`, `description`, `function`, `line`, `file`, `deprecated_since`, `use_instead`) VALUES
(1, 1329687990, 'n', 'A third-party add-on is calling $this->load->library(''security''),\n				which is deprecated as the CI_Security class has been moved to Core, so it is always loaded.', NULL, NULL, NULL, NULL, NULL),
(2, 1329688330, 'n', NULL, 'hash()', 376, '/home/jackarmley16/jackarmley.com/eesys/expressionengine/third_party/iexpression/mod.iexpression.php', '2.0', 'Security_helper::do_hash');

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_cache`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache` (
  `cache_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `cache_date` int(10) unsigned NOT NULL DEFAULT '0',
  `total_sent` int(6) unsigned NOT NULL,
  `from_name` varchar(70) NOT NULL,
  `from_email` varchar(70) NOT NULL,
  `recipient` text NOT NULL,
  `cc` text NOT NULL,
  `bcc` text NOT NULL,
  `recipient_array` mediumtext NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  `plaintext_alt` mediumtext NOT NULL,
  `mailinglist` char(1) NOT NULL DEFAULT 'n',
  `mailtype` varchar(6) NOT NULL,
  `text_fmt` varchar(40) NOT NULL,
  `wordwrap` char(1) NOT NULL DEFAULT 'y',
  `priority` char(1) NOT NULL DEFAULT '3',
  PRIMARY KEY (`cache_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `exp_email_cache`
--

INSERT INTO `exp_email_cache` (`cache_id`, `cache_date`, `total_sent`, `from_name`, `from_email`, `recipient`, `cc`, `bcc`, `recipient_array`, `subject`, `message`, `plaintext_alt`, `mailinglist`, `mailtype`, `text_fmt`, `wordwrap`, `priority`) VALUES
(1, 1303470629, 1, 'Jack', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk', '', '', '', 'Test', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(2, 1303470755, 1, 'Jack', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Test', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(3, 1303471206, 2, 'Jack', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk,jack_armley@yahoo.co.uk', '', '', '', 'Test 2', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'text', 'none', 'y', '3'),
(4, 1303471234, 2, 'Jack', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk,jack_armley@yahoo.co.uk', '', '', '', 'Test 2', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(5, 1303471501, 2, 'Jack', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk,jack_armley@yahoo.co.uk', '', '', '', 'Hi Charles, take a look at my new site', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(6, 1303484197, 2, 'Jack', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk,lou_macleod@hotmail.co.uk', '', '', '', 'Hi Charles, my website is ready for you to see!', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'text', 'none', 'y', '3');
INSERT INTO `exp_email_cache` (`cache_id`, `cache_date`, `total_sent`, `from_name`, `from_email`, `recipient`, `cc`, `bcc`, `recipient_array`, `subject`, `message`, `plaintext_alt`, `mailinglist`, `mailtype`, `text_fmt`, `wordwrap`, `priority`) VALUES
(7, 1303484218, 2, 'Jack', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk,lou_macleod@hotmail.co.uk', '', '', '', 'Hi Charles, my website is ready for you to see!', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(8, 1303484537, 1, 'Jack Armley', 'jack_armley@yahoo.co.uk', 'charles.daltonmoore@idioplatform.com', '', '', '', 'Hi Charles, my new website is ready for you to see!', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	<style type="text/css" media="screen"><!--\n		/*base*/\n			font{font-size:1em;}\n			body{font-family:Arial, Helvetica, sans-serif;margin:0;padding:0;text-align:left;}\n			strong{font-weight:bold;}\n			em{font-style:italic;}\n			table,table tr,table tr td{margin:0;padding:0;border:none;}\n			img,table img{border:0;margin:0;padding:0;display:block;}\n			\n			p{font-family:Arial, Helvetica, sans-serif;font-size:10px;line-height:10px;margin:0;color:#000000;}\n			a{text-decoration:none;}\n			a:hover{text-decoration:underline;}\n			 -->\n	</style>\n	<table background="images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p1.gif" height="140" alt="Hi Charles, Take a look at my new site" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="183" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-image_website.gif" border="0" height="183" alt="www.jackarmley.co.uk" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p2.gif" height="77" alt="Also, download my updated CV" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/cv.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="58" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p3.gif" height="58" alt="Have a great" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="46" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://vimeo.com/4103589" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_p4.gif" border="0" height="46" alt="Easter Weekend" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(9, 1304460968, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk', '', '', '', 'Web Designer vacancy (via magculture.com)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	\n	<table background="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></a></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tco_london/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p1.gif" height="200" alt="Hi Alex, I''d love to be a web designer at The Church of London!" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/cv_and_coverletter-030511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="20" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-link_websiteurl.gif" border="0" height="20" style="margin: 0; border: 0; padding: 0; display: block;" width="125" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(10, 1304460987, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Web Designer vacancy (via magculture.com)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0">\n	\n	<table background="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/wrapper-bg_gradient.jpg" cellspacing="0" id="content-wrapper" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="100%">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="173"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" style="margin: 0; border: 0; padding: 0; display: block;" width="162" /></a></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="107" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tco_london/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="140" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p1.gif" height="200" alt="Hi Alex, I''d love to be a web designer at The Church of London!" style="margin: 0; border: 0; padding: 0; display: block;" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><table cellspacing="0" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="269">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="219"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" style="margin: 0; border: 0; padding: 0; display: block;" width="219" /></td>\n                            <td align="left" height="77" valign="top" style="margin: 0; border: none; padding: 0;" width="50"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/cv_and_coverletter-030511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" style="margin: 0; border: 0; padding: 0; display: block;" width="50" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="26" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" style="margin: 0; border: 0; padding: 0; display: block;" width="107" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="right" height="20" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-link_websiteurl.gif" border="0" height="20" style="margin: 0; border: 0; padding: 0; display: block;" width="125" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" height="50" valign="top" style="margin: 0; border: none; padding: 0;" width="269"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" style="margin: 0; border: 0; padding: 0; display: block;" width="1" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;" width="118"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" style="margin: 0; border: 0; padding: 0; display: block;" width="118" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(11, 1304491566, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk', '', '', '', 'Web Designer', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tco_london/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="140" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p1.gif" height="200" alt="Hi Alex, I''d love to be a web designer at The Church of London!" width="269" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/cv_and_coverletter-030511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(12, 1304491710, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jobs@thechurchoflondon.com', '', '', '', 'Web Designer', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tco_london/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="140" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p1.gif" height="200" alt="Hi Alex, I''d love to be a web designer at The Church of London!" width="269" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/cv_and_coverletter-030511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3');
INSERT INTO `exp_email_cache` (`cache_id`, `cache_date`, `total_sent`, `from_name`, `from_email`, `recipient`, `cc`, `bcc`, `recipient_array`, `subject`, `message`, `plaintext_alt`, `mailinglist`, `mailtype`, `text_fmt`, `wordwrap`, `priority`) VALUES
(13, 1304512490, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'alex@thechurchoflondon.com ', '', '', '', 'Web Designer', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tco_london/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="140" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p1.gif" height="200" alt="Hi Alex, I''d love to be a web designer at The Church of London!" width="269" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/cv_and_coverletter-030511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://jackarmley.co.uk/site_assets/eflyer/tco_london/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(14, 1304536584, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Front End Developer vacancy (via the "It''s Nice That" job-board)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tangentone-040511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="177" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_p1.gif" height="177" alt="Hi Peter, I''d love to be a front end developer at Tangent One!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/cv_and_coverletter-040511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(15, 1304536832, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'peter.miller@tangentone.co.uk', '', '', '', 'Front End Developer vacancy (via the "It''s Nice That" job-board)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/tangentone-040511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="177" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_p1.gif" height="177" alt="Hi Peter, I''d love to be a front end developer at Tangent One!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/cv_and_coverletter-040511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/tangentone-040511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(16, 1304547425, 2, 'Jack Armley', 'aloha@jackarmley.co.uk', 'lou_macleod@hotmail.co.uk,jack_armley@yahoo.co.uk', '', '', '', 'Application for any available vacancies (via meetup.com "London Web" group)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/precedent-040511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="327" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_p1.gif" height="327" alt="Hi Nicholas, I heard from meetup.com that you''re on the hunt for talented developers; I''d love to be part of the precendent team!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/cv_and_coverletter-040511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(17, 1304578216, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'nicholas.oliver@precedent.co.uk', '', '', '', 'Application for available vacancies (via meetup . com "London Web" group)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/precedent-040511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="327" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_p1.gif" height="327" alt="Hi Nicholas, I heard from meetup.com that you''re on the hunt for talented developers; I''d love to be part of the precendent team!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/cv_and_coverletter-040511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/precedent-040511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(20, 1304865108, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Potential Web Designer vacancy?', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_p1.gif" height="209" alt="Hi Matt, I''d love to be a web designer at Perth Web!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(19, 1304864997, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Web/UI Designer job vacancy (via "It''s Nice That")', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p1.gif" height="209" alt="Hi Jon, I''d love to be a web/ui designer at JRD-Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3');
INSERT INTO `exp_email_cache` (`cache_id`, `cache_date`, `total_sent`, `from_name`, `from_email`, `recipient`, `cc`, `bcc`, `recipient_array`, `subject`, `message`, `plaintext_alt`, `mailinglist`, `mailtype`, `text_fmt`, `wordwrap`, `priority`) VALUES
(21, 1304920924, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Web Developer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_p1.gif" height="209" alt="Hi Matt, I''d love to be a web developer at Perth Web!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(22, 1304921028, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jobs@perthweb.com.au', '', '', '', 'Web Developer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_p1.gif" height="209" alt="Hi Matt, I''d love to be a web developer at Perth Web!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/site_assets/eflyer/perthweb-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/perthweb-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(23, 1304921092, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Web/UI Designer job vacancy (via "It''s Nice That")', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p1.gif" height="209" alt="Hi Jon, I''d love to be a web/ui designer at JRD-Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(24, 1304921155, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jobs@jrd-design.co.uk', '', '', '', 'Web/UI Designer job vacancy (via "It''s Nice That")', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p1.gif" height="209" alt="Hi Jon, I''d love to be a web/ui designer at JRD-Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(25, 1304922929, 1, 'Jack Armley', 'jack_armley@yahoo.co.uk', 'jobs@jrd-design.co.uk', '', '', '', 'Web/UI Designer job vacancy (via "It''s Nice That")', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p1.gif" height="209" alt="Hi Jon, I''d love to be a web/ui designer at JRD-Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(26, 1304923014, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jobs@jrd-design.co.uk', '', '', '', 'Web/UI Designer job vacancy (via "It''s Nice That")', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p1.gif" height="209" alt="Hi Jon, I''d love to be a web/ui designer at JRD-Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(27, 1304923080, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'info@jrd-design.co.uk', '', '', '', 'Web/UI Designer job vacancy (via "It''s Nice That")', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="209" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p1.gif" height="209" alt="Hi Jon, I''d love to be a web/ui designer at JRD-Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/cv_and_coverletter-080511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/jrddesign-080511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3');
INSERT INTO `exp_email_cache` (`cache_id`, `cache_date`, `total_sent`, `from_name`, `from_email`, `recipient`, `cc`, `bcc`, `recipient_array`, `subject`, `message`, `plaintext_alt`, `mailinglist`, `mailtype`, `text_fmt`, `wordwrap`, `priority`) VALUES
(28, 1304968563, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Web Designer / Developer vacancy (as advertised on seek.com.au)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="193" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_p1.gif" height="193" alt="Hi There, I''d love to be a web designer at Digital Union!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/cv_and_coverletter-090511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(29, 1304968640, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'contact@digitalunion.com.au', '', '', '', 'Web Designer / Developer vacancy (as advertised on seek.com.au)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="193" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_p1.gif" height="193" alt="Hi There, I''d love to be a web designer at Digital Union!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/cv_and_coverletter-090511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/digitalunion-090511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(30, 1304969412, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Web /Graphic Designer vacancy (as advertised on seek.com.au)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_p1.gif" height="167" alt="Hi George, I''d love to be a graphic/web designer at Slick Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/cv_and_coverletter-090511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(31, 1304969575, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'george@slickdesign.com.au', '', '', '', 'Web /Graphic Designer vacancy (as advertised on seek.com.au)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_p1.gif" height="167" alt="Hi George, I''d love to be a graphic/web designer at Slick Design!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/cv_and_coverletter-090511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/slickwebdesign-090511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(32, 1305226523, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Vacancy for a Mid-Level Web Designer (found through Google)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_p1.gif" height="167" alt="Hi George, I''d love to be a web designer at Reactive!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/cv_and_coverletter-090511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(33, 1305232908, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Vacancy for a Mid-Level Web Designer (found through Google)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_p1.gif" height="167" alt="Hi There, I''d love to be a web designer at Reactive!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/cv_and_coverletter-120511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(34, 1305232977, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'jack_armley@yahoo.co.uk', '', '', '', 'Any opportunities for a Web Designer to join the Internet Dreams team?', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_p1.gif" height="175" alt="Hi There, I''d love to be a web designer at Internet Dreams!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/cv_and_coverletter-120511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3');
INSERT INTO `exp_email_cache` (`cache_id`, `cache_date`, `total_sent`, `from_name`, `from_email`, `recipient`, `cc`, `bcc`, `recipient_array`, `subject`, `message`, `plaintext_alt`, `mailinglist`, `mailtype`, `text_fmt`, `wordwrap`, `priority`) VALUES
(35, 1305268848, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'contact@netdreams.co.uk', '', '', '', 'Any opportunities for a Web Designer to join the Internet Dreams team?', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_p1.gif" height="175" alt="Hi There, I''d love to be a web designer at Internet Dreams!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/cv_and_coverletter-120511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/internetdreams-120511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(36, 1305268869, 1, 'Jack Armley', 'aloha@jackarmley.co.uk', 'uk.enquiries@reactive.com', '', '', '', 'Vacancy for a Mid-Level Web Designer (found through Google)', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" text="#000000" marginwidth="0" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" leftmargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;">\n	\n	<table cellspacing="0" background="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/wrapper-bg_gradient.jpg" border="0" id="content-wrapper" width="100%" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" width="100%" style="margin: 0; border: none; padding: 0;">\n           	    <table cellspacing="0" border="0" id="content-inner" width="560" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" width="173" style="margin: 0; border: none; padding: 0;"><a href="http://jackarmley.co.uk/" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/header-logo_jackarmley.gif" border="0" height="107" alt="Jack Armley" width="162" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                    <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="107" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="25" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                          </tr>\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td align="right" valign="top" style="margin: 0; border: none; padding: 0;"><p style="font-size: 10px; margin: 0; font-family: Arial, Helvetica, sans-serif; line-height: 10px; color: #000000;"><font size="2" color="#666666" face="Arial, Helvetica, sans-serif" style="font-size: 1em;"><a href="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/index.html" style="text-decoration: none;">view this online</a></font></p></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="167" align="left" valign="top" width="209" style="margin: 0; border: none; padding: 0;"><img src="http://jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_p1.gif" height="167" alt="Hi There, I''d love to be a web designer at Reactive!" width="269" /></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><table cellspacing="0" border="0" width="269" cellpadding="0" style="margin: 0; border: none; padding: 0;">\n                          <tr style="margin: 0; border: none; padding: 0;">\n                            <td height="77" align="left" valign="top" width="219" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_p2.gif" height="77" alt="Download my CV and covering letter" width="219" /></td>\n                            <td height="77" align="left" valign="top" width="50" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/cv_and_coverletter-120511.pdf" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_cvdl.gif" border="0" height="77" alt="Here (download CV)" width="50" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                          </tr>\n                        </table></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="26" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-replaced_signoff.gif" height="26" alt="Thanks, Jack" width="107" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n					    <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="20" align="right" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.co.uk" style="text-decoration: none;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/content-link_websiteurl.gif" border="0" height="20" width="125" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                      </tr>\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td height="50" align="left" valign="top" width="269" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="50" width="1" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                      </tr>\n                    </table></td>\n                    <td align="left" valign="top" width="118" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.co.uk/site_assets/eflyer/reactive-120511/images/spacer.gif" height="1" width="118" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n                </table></td>\n		  </tr>\n	</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'y', '3'),
(37, 1327893930, 2, 'Jack Armley', 'aloha@jackarmley.com', 'jack_armley@yahoo.co.uk', 'jack_armley@yahoo.co.uk', '', '', 'CSS & HTML designer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left;" leftmargin="0" style="background-color:#ECECEC;">\n	\n	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="" bgcolor="#ECECEC" id="content-wrapper" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/bg-header.jpg" alt="Jack Armley" width="600" height="88" border="0" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-intro.gif" alt="hi there! I''d love to be part of the team at Interweb!" width="600" height="237" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-bodycopy.gif" alt="I saw the position of a CSS and HTML designer advertised on seek and it was music to my ears - I think I''d be \na great addition to the team" width="599" height="123" /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/link-cv.gif" alt="DOwnlaod my CV and cover letter" width="600" height="176" border="0" /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><table style="margin: 0; border: none; padding: 0;" width="599" border="0" cellspacing="0" cellpadding="0">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/"><img src="http://www.jackarmley.com/v2/eflyer_images/link-url.gif" alt="jackarmley.com" width="299" height="60" border="0" /></a></td>\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://twitter.com/#!/jackarmley"><img src="http://www.jackarmley.com/v2/eflyer_images/link-twitter.gif" alt="@jackarmley" width="301" height="60" border="0" /></a></td>\n                      </tr>\n                    </table></td>\n                  </tr>\n                </table></td>\n		  </tr>\n</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'n', '3'),
(38, 1327894131, 2, 'Jack Armley', 'aloha@jackarmley.com', 'jack_armley@yahoo.co.uk', 'jack_armley@yahoo.co.uk', '', '', 'CSS & HTML designer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left; background-color:#ECECEC;" leftmargin="0">\n	\n	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="" bgcolor="#ECECEC" id="content-wrapper" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/bg-header.jpg" alt="Jack Armley" width="600" height="88" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-intro.gif" alt="hi there! I''d love to be part of the team at Interweb!" width="600" height="237" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-bodycopy.gif" alt="I saw the position of a CSS and HTML designer advertised on seek and it was music to my ears - I think I''d be \na great addition to the team" width="599" height="123" style="margin: 0; border: 0; padding: 0; display: block;"  /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/link-cv.gif" alt="Downlaod my CV and cover letter" width="600" height="176" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><table style="margin: 0; border: none; padding: 0;" width="599" border="0" cellspacing="0" cellpadding="0">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/"><img src="http://www.jackarmley.com/v2/eflyer_images/link-url.gif" alt="jackarmley.com" width="299" height="60" border="0" style="margin: 0; border: 0; padding: 0; display: block;"  /></a></td>\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://twitter.com/#!/jackarmley"><img src="http://www.jackarmley.com/v2/eflyer_images/link-twitter.gif" alt="@jackarmley" width="301" height="60" border="0"  style="margin: 0; border: 0; padding: 0; display: block;"/></a></td>\n                      </tr>\n                    </table></td>\n                  </tr>\n                </table></td>\n		  </tr>\n</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'n', '3'),
(39, 1327896529, 2, 'Jack Armley', 'aloha@jackarmley.com', 'jack_armley@yahoo.co.uk', 'jack_armley@yahoo.co.uk', '', '', 'CSS & HTML designer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left; background-color:#ECECEC;" leftmargin="0">\n	\n	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="" bgcolor="#ECECEC" id="content-wrapper" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/bg-header.jpg" alt="Jack Armley" width="600" height="88" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-intro.gif" alt="hi there! I''d love to be part of the team at Interweb!" width="600" height="237" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-bodycopy.gif" alt="I saw the position of a CSS and HTML designer advertised on seek and it was music to my ears - I think I''d be \na great addition to the team" width="599" height="123" style="margin: 0; border: 0; padding: 0; display: block;"  /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="/jackarmley.com/v2/eflyer_images/cv_and_coverletter.pdf"><img src="http://www.jackarmley.com/v2/eflyer_images/link-cv.gif" alt="Download my CV and cover letter" width="600" height="176" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><table style="margin: 0; border: none; padding: 0;" width="599" border="0" cellspacing="0" cellpadding="0">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/"><img src="http://www.jackarmley.com/v2/eflyer_images/link-url.gif" alt="jackarmley.com" width="299" height="60" border="0" style="margin: 0; border: 0; padding: 0; display: block;"  /></a></td>\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://twitter.com/#!/jackarmley"><img src="http://www.jackarmley.com/v2/eflyer_images/link-twitter.gif" alt="@jackarmley" width="301" height="60" border="0"  style="margin: 0; border: 0; padding: 0; display: block;"/></a></td>\n                      </tr>\n                    </table></td>\n                  </tr>\n                </table></td>\n		  </tr>\n</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'n', '3'),
(40, 1327896594, 2, 'Jack Armley', 'aloha@jackarmley.com', 'jack_armley@yahoo.co.uk', 'jack_armley@yahoo.co.uk', '', '', 'CSS & HTML designer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left; background-color:#ECECEC;" leftmargin="0">\n	\n	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="" bgcolor="#ECECEC" id="content-wrapper" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/bg-header.jpg" alt="Jack Armley" width="600" height="88" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-intro.gif" alt="hi there! I''d love to be part of the team at Interweb!" width="600" height="237" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-bodycopy.gif" alt="I saw the position of a CSS and HTML designer advertised on seek and it was music to my ears - I think I''d be \na great addition to the team" width="599" height="123" style="margin: 0; border: 0; padding: 0; display: block;"  /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="/jackarmley.com/v2/eflyer_images/cv_and_coverletter.pdf"><img src="http://www.jackarmley.com/v2/eflyer_images/link-cv.gif" alt="Download my CV and cover letter" width="600" height="176" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><table style="margin: 0; border: none; padding: 0;" width="599" border="0" cellspacing="0" cellpadding="0">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/"><img src="http://www.jackarmley.com/v2/eflyer_images/link-url.gif" alt="jackarmley.com" width="299" height="60" border="0" style="margin: 0; border: 0; padding: 0; display: block;"  /></a></td>\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://twitter.com/#!/jackarmley"><img src="http://www.jackarmley.com/v2/eflyer_images/link-twitter.gif" alt="@jackarmley" width="301" height="60" border="0"  style="margin: 0; border: 0; padding: 0; display: block;"/></a></td>\n                      </tr>\n                    </table></td>\n                  </tr>\n                </table></td>\n		  </tr>\n</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'n', '3'),
(41, 1327896663, 2, 'Jack Armley', 'aloha@jackarmley.com', 'jack_armley@yahoo.co.uk', 'jack_armley@yahoo.co.uk', '', '', 'CSS & HTML designer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left; background-color:#ECECEC;" leftmargin="0">\n	\n	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="" bgcolor="#ECECEC" id="content-wrapper" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/bg-header.jpg" alt="Jack Armley" width="600" height="88" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-intro.gif" alt="hi there! I''d love to be part of the team at Interweb!" width="600" height="237" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-bodycopy.gif" alt="I saw the position of a CSS and HTML designer advertised on seek and it was music to my ears - I think I''d be \na great addition to the team" width="599" height="123" style="margin: 0; border: 0; padding: 0; display: block;"  /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/v2/eflyer_images/cv_and_coverletter.pdf"><img src="http://www.jackarmley.com/v2/eflyer_images/link-cv.gif" alt="Download my CV and cover letter" width="600" height="176" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><table style="margin: 0; border: none; padding: 0;" width="599" border="0" cellspacing="0" cellpadding="0">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/"><img src="http://www.jackarmley.com/v2/eflyer_images/link-url.gif" alt="jackarmley.com" width="299" height="60" border="0" style="margin: 0; border: 0; padding: 0; display: block;"  /></a></td>\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://twitter.com/#!/jackarmley"><img src="http://www.jackarmley.com/v2/eflyer_images/link-twitter.gif" alt="@jackarmley" width="301" height="60" border="0"  style="margin: 0; border: 0; padding: 0; display: block;"/></a></td>\n                      </tr>\n                    </table></td>\n                  </tr>\n                </table></td>\n		  </tr>\n</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'n', '3'),
(42, 1327896803, 1, 'Jack Armley', 'aloha@jackarmley.com', 'jobs@interweb.com.au', '', '', '', 'CSS & HTML designer vacancy', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />\n	<title>Jack Armley</title>\n\n<style type="text/css">\na:hover { text-decoration: underline !important; }\n</style>\n</head>\n<body marginheight="0" topmargin="0" marginwidth="0" text="#000000" vlink="#666666" alink="#666666" link="#666666" bottommargin="0" style="margin: 0; font-family: Arial, Helvetica, sans-serif; padding: 0; text-align: left; background-color:#ECECEC;" leftmargin="0">\n	\n	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="" bgcolor="#ECECEC" id="content-wrapper" style="margin: 0; border: none; padding: 0;">\n		  <tr style="margin: 0; border: none; padding: 0;">\n		    <td align="center" valign="top" style="margin: 0; border: none; padding: 0;" width="100%">\n           	    <table cellspacing="0" id="content-inner" border="0" style="margin: 0; border: none; padding: 0;" cellpadding="0" width="560">\n                  <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/bg-header.jpg" alt="Jack Armley" width="600" height="88" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-intro.gif" alt="hi there! I''d love to be part of the team at Interweb!" width="600" height="237" style="margin: 0; border: 0; padding: 0; display: block;" /></td>\n                  </tr>\n				    <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><img src="http://www.jackarmley.com/v2/eflyer_images/replaced-bodycopy.gif" alt="I saw the position of a CSS and HTML designer advertised on seek and it was music to my ears - I think I''d be \na great addition to the team" width="599" height="123" style="margin: 0; border: 0; padding: 0; display: block;"  /></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/v2/eflyer_images/cv_and_coverletter.pdf"><img src="http://www.jackarmley.com/v2/eflyer_images/link-cv.gif" alt="Download my CV and cover letter" width="600" height="176" border="0" style="margin: 0; border: 0; padding: 0; display: block;" /></a></td>\n                  </tr>\n				   <tr style="margin: 0; border: none; padding: 0;">\n                    <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><table style="margin: 0; border: none; padding: 0;" width="599" border="0" cellspacing="0" cellpadding="0">\n                      <tr style="margin: 0; border: none; padding: 0;">\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://www.jackarmley.com/"><img src="http://www.jackarmley.com/v2/eflyer_images/link-url.gif" alt="jackarmley.com" width="299" height="60" border="0" style="margin: 0; border: 0; padding: 0; display: block;"  /></a></td>\n                        <td align="left" valign="top" style="margin: 0; border: none; padding: 0;"><a href="http://twitter.com/#!/jackarmley"><img src="http://www.jackarmley.com/v2/eflyer_images/link-twitter.gif" alt="@jackarmley" width="301" height="60" border="0"  style="margin: 0; border: 0; padding: 0; display: block;"/></a></td>\n                      </tr>\n                    </table></td>\n                  </tr>\n                </table></td>\n		  </tr>\n</table>\n</body>\n</html>\n', '', 'n', 'html', 'none', 'n', '3');

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_cache_mg`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache_mg` (
  `cache_id` int(6) unsigned NOT NULL,
  `group_id` smallint(4) NOT NULL,
  PRIMARY KEY (`cache_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_email_cache_mg`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_email_cache_ml`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache_ml` (
  `cache_id` int(6) unsigned NOT NULL,
  `list_id` smallint(4) NOT NULL,
  PRIMARY KEY (`cache_id`,`list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_email_cache_ml`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_email_console_cache`
--

CREATE TABLE IF NOT EXISTS `exp_email_console_cache` (
  `cache_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `cache_date` int(10) unsigned NOT NULL DEFAULT '0',
  `member_id` int(10) unsigned NOT NULL,
  `member_name` varchar(50) NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `recipient` varchar(70) NOT NULL,
  `recipient_name` varchar(50) NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  PRIMARY KEY (`cache_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_email_console_cache`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_email_tracker`
--

CREATE TABLE IF NOT EXISTS `exp_email_tracker` (
  `email_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_date` int(10) unsigned NOT NULL DEFAULT '0',
  `sender_ip` varchar(16) NOT NULL,
  `sender_email` varchar(75) NOT NULL,
  `sender_username` varchar(50) NOT NULL,
  `number_recipients` int(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_email_tracker`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_entry_ping_status`
--

CREATE TABLE IF NOT EXISTS `exp_entry_ping_status` (
  `entry_id` int(10) unsigned NOT NULL,
  `ping_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entry_id`,`ping_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_entry_ping_status`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_entry_versioning`
--

CREATE TABLE IF NOT EXISTS `exp_entry_versioning` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL,
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `version_date` int(10) NOT NULL,
  `version_data` mediumtext NOT NULL,
  PRIMARY KEY (`version_id`),
  KEY `entry_id` (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_entry_versioning`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_extensions`
--

CREATE TABLE IF NOT EXISTS `exp_extensions` (
  `extension_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(50) NOT NULL DEFAULT '',
  `method` varchar(50) NOT NULL DEFAULT '',
  `hook` varchar(50) NOT NULL DEFAULT '',
  `settings` text NOT NULL,
  `priority` int(2) NOT NULL DEFAULT '10',
  `version` varchar(10) NOT NULL DEFAULT '',
  `enabled` char(1) NOT NULL DEFAULT 'y',
  PRIMARY KEY (`extension_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `exp_extensions`
--

INSERT INTO `exp_extensions` (`extension_id`, `class`, `method`, `hook`, `settings`, `priority`, `version`, `enabled`) VALUES
(1, 'Matrix_ext', 'channel_entries_tagdata', 'channel_entries_tagdata', '', 10, '2.2.4', 'y'),
(2, 'Playa_ext', 'channel_entries_tagdata', 'channel_entries_tagdata', '', 9, '4.0.4.1', 'y'),
(3, 'Safecracker_ext', 'form_declaration_modify_data', 'form_declaration_modify_data', '', 10, '2.1', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `exp_field_formatting`
--

CREATE TABLE IF NOT EXISTS `exp_field_formatting` (
  `formatting_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(10) unsigned NOT NULL,
  `field_fmt` varchar(40) NOT NULL,
  PRIMARY KEY (`formatting_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=85 ;

--
-- Dumping data for table `exp_field_formatting`
--

INSERT INTO `exp_field_formatting` (`formatting_id`, `field_id`, `field_fmt`) VALUES
(1, 1, 'none'),
(2, 1, 'br'),
(3, 1, 'xhtml'),
(4, 2, 'none'),
(5, 2, 'br'),
(6, 2, 'xhtml'),
(7, 3, 'none'),
(8, 3, 'br'),
(9, 3, 'xhtml'),
(10, 4, 'none'),
(11, 4, 'br'),
(12, 4, 'xhtml'),
(13, 5, 'none'),
(14, 5, 'br'),
(15, 5, 'xhtml'),
(16, 6, 'none'),
(17, 6, 'br'),
(18, 6, 'xhtml'),
(19, 7, 'none'),
(20, 7, 'br'),
(21, 7, 'xhtml'),
(22, 8, 'none'),
(23, 8, 'br'),
(24, 8, 'xhtml'),
(25, 9, 'none'),
(26, 9, 'br'),
(27, 9, 'xhtml'),
(28, 10, 'none'),
(29, 10, 'br'),
(30, 10, 'xhtml'),
(31, 11, 'none'),
(32, 11, 'br'),
(33, 11, 'xhtml'),
(34, 12, 'none'),
(35, 12, 'br'),
(36, 12, 'xhtml'),
(37, 13, 'none'),
(38, 13, 'br'),
(39, 13, 'xhtml'),
(40, 14, 'none'),
(41, 14, 'br'),
(42, 14, 'xhtml'),
(43, 15, 'none'),
(44, 15, 'br'),
(45, 15, 'xhtml'),
(46, 16, 'none'),
(47, 16, 'br'),
(48, 16, 'xhtml'),
(49, 17, 'none'),
(50, 17, 'br'),
(51, 17, 'xhtml'),
(78, 26, 'xhtml'),
(77, 26, 'br'),
(76, 26, 'none'),
(75, 25, 'xhtml'),
(74, 25, 'br'),
(73, 25, 'none'),
(72, 24, 'xhtml'),
(71, 24, 'br'),
(70, 24, 'none'),
(61, 21, 'none'),
(62, 21, 'br'),
(63, 21, 'xhtml'),
(64, 22, 'none'),
(65, 22, 'br'),
(66, 22, 'xhtml'),
(67, 23, 'none'),
(68, 23, 'br'),
(69, 23, 'xhtml'),
(79, 27, 'none'),
(80, 27, 'br'),
(81, 27, 'xhtml'),
(82, 28, 'none'),
(83, 28, 'br'),
(84, 28, 'xhtml');

-- --------------------------------------------------------

--
-- Table structure for table `exp_field_groups`
--

CREATE TABLE IF NOT EXISTS `exp_field_groups` (
  `group_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `exp_field_groups`
--

INSERT INTO `exp_field_groups` (`group_id`, `site_id`, `group_name`) VALUES
(1, 1, 'Blog'),
(2, 1, 'Why i love easter egg'),
(3, 1, 'Work'),
(4, 1, 'Page'),
(6, 1, 'Bespoke post');

-- --------------------------------------------------------

--
-- Table structure for table `exp_fieldtypes`
--

CREATE TABLE IF NOT EXISTS `exp_fieldtypes` (
  `fieldtype_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` varchar(12) NOT NULL,
  `settings` text,
  `has_global_settings` char(1) DEFAULT 'n',
  PRIMARY KEY (`fieldtype_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `exp_fieldtypes`
--

INSERT INTO `exp_fieldtypes` (`fieldtype_id`, `name`, `version`, `settings`, `has_global_settings`) VALUES
(1, 'select', '1.0', 'YTowOnt9', 'n'),
(2, 'text', '1.0', 'YTowOnt9', 'n'),
(3, 'textarea', '1.0', 'YTowOnt9', 'n'),
(4, 'date', '1.0', 'YTowOnt9', 'n'),
(5, 'file', '1.0', 'YTowOnt9', 'n'),
(6, 'multi_select', '1.0', 'YTowOnt9', 'n'),
(7, 'checkboxes', '1.0', 'YTowOnt9', 'n'),
(8, 'radio', '1.0', 'YTowOnt9', 'n'),
(9, 'rel', '1.0', 'YTowOnt9', 'n'),
(10, 'wygwam', '2.4.0.2', 'YToyOntzOjExOiJsaWNlbnNlX2tleSI7czoyNToiMDAyMDA3NjYwMjI3NTAwMTI2OTM4Mjk5MiI7czoxMjoiZmlsZV9icm93c2VyIjtzOjI6ImVlIjt9', 'y'),
(11, 'matrix', '2.2.0.1', 'YTowOnt9', 'y'),
(12, 'pt_checkboxes', '1.0.3', 'Tjs=', 'n'),
(13, 'pt_dropdown', '1.0.3', 'Tjs=', 'n'),
(14, 'pt_multiselect', '1.0.3', 'Tjs=', 'n'),
(15, 'pt_radio_buttons', '1.0.3', 'Tjs=', 'n'),
(16, 'playa', '4.0.4.1', 'YTowOnt9', 'y'),
(17, 'safecracker_file', '2.1', 'YTowOnt9', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `exp_file_categories`
--

CREATE TABLE IF NOT EXISTS `exp_file_categories` (
  `file_id` int(10) unsigned DEFAULT NULL,
  `cat_id` int(10) unsigned DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT '0',
  `is_cover` char(1) DEFAULT 'n',
  KEY `file_id` (`file_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_file_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_file_dimensions`
--

CREATE TABLE IF NOT EXISTS `exp_file_dimensions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `upload_location_id` int(4) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT '',
  `short_name` varchar(255) DEFAULT '',
  `resize_type` varchar(50) DEFAULT '',
  `width` int(10) DEFAULT '0',
  `height` int(10) DEFAULT '0',
  `watermark_id` int(4) unsigned DEFAULT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `upload_location_id` (`upload_location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_file_dimensions`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_file_watermarks`
--

CREATE TABLE IF NOT EXISTS `exp_file_watermarks` (
  `wm_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `wm_name` varchar(80) DEFAULT NULL,
  `wm_type` varchar(10) DEFAULT 'text',
  `wm_image_path` varchar(100) DEFAULT NULL,
  `wm_test_image_path` varchar(100) DEFAULT NULL,
  `wm_use_font` char(1) DEFAULT 'y',
  `wm_font` varchar(30) DEFAULT NULL,
  `wm_font_size` int(3) unsigned DEFAULT NULL,
  `wm_text` varchar(100) DEFAULT NULL,
  `wm_vrt_alignment` varchar(10) DEFAULT 'top',
  `wm_hor_alignment` varchar(10) DEFAULT 'left',
  `wm_padding` int(3) unsigned DEFAULT NULL,
  `wm_opacity` int(3) unsigned DEFAULT NULL,
  `wm_hor_offset` int(11) DEFAULT NULL,
  `wm_vrt_offset` int(11) DEFAULT NULL,
  `wm_x_transp` int(4) DEFAULT NULL,
  `wm_y_transp` int(4) DEFAULT NULL,
  `wm_font_color` varchar(7) DEFAULT NULL,
  `wm_use_drop_shadow` char(1) DEFAULT 'y',
  `wm_shadow_distance` int(3) unsigned DEFAULT NULL,
  `wm_shadow_color` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`wm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_file_watermarks`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_files`
--

CREATE TABLE IF NOT EXISTS `exp_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned DEFAULT '1',
  `title` varchar(255) DEFAULT NULL,
  `upload_location_id` int(4) unsigned DEFAULT '0',
  `rel_path` varchar(255) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(10) DEFAULT '0',
  `uploaded_by_member_id` int(10) unsigned DEFAULT '0',
  `upload_date` int(10) DEFAULT NULL,
  `modified_by_member_id` int(10) unsigned DEFAULT '0',
  `modified_date` int(10) DEFAULT NULL,
  `file_hw_original` varchar(20) DEFAULT NULL,
  `description` text,
  `credit` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  KEY `upload_location_id` (`upload_location_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=95 ;

--
-- Dumping data for table `exp_files`
--

INSERT INTO `exp_files` (`file_id`, `site_id`, `title`, `upload_location_id`, `rel_path`, `mime_type`, `file_name`, `file_size`, `uploaded_by_member_id`, `upload_date`, `modified_by_member_id`, `modified_date`, `file_hw_original`, `description`, `credit`, `location`) VALUES
(1, 1, 'generalimg-404_page.png', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/generalimg-404_page.png', 'image/png', 'generalimg-404_page.png', 3327, 1, 1309699462, 1, 1323909830, '274 346', NULL, NULL, NULL),
(3, 1, 'graphicassets-biopic.png', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/graphicassets-biopic.png', 'image/png', 'graphicassets-biopic.png', 8187, 1, 1309699462, 1, 1323909830, '190 132', NULL, NULL, NULL),
(4, 1, 'slide-cmnmicrosite_appinfuniverse_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-cmnmicrosite_appinfuniverse_01.jpg', 'image/jpeg', 'slide-cmnmicrosite_appinfuniverse_01.jpg', 30641, 1, 1309699462, 1, 1323909830, '254 459', NULL, NULL, NULL),
(5, 1, 'blogimg-bltproof_webfonts2.png', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/blogimg-bltproof_webfonts2.png', 'image/png', 'blogimg-bltproof_webfonts2.png', 54847, 1, 1309699462, 1, 1323909830, '218 608', NULL, NULL, NULL),
(6, 1, 'slide-cmnmicrosite_appinfuniverse_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-cmnmicrosite_appinfuniverse_02.jpg', 'image/jpeg', 'slide-cmnmicrosite_appinfuniverse_02.jpg', 18374, 1, 1309699462, 1, 1323909830, '254 459', NULL, NULL, NULL),
(7, 1, 'blogimg-bulletproof_webfont.png', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/blogimg-bulletproof_webfont.png', 'image/png', 'blogimg-bulletproof_webfont.png', 55028, 1, 1309699462, 1, 1323909830, '485 384', NULL, NULL, NULL),
(8, 1, 'slide-cornexchangenew_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-cornexchangenew_01.jpg', 'image/jpeg', 'slide-cornexchangenew_01.jpg', 31450, 1, 1309699462, 1, 1323909830, '254 459', NULL, NULL, NULL),
(9, 1, 'blogimg-clarityvssmooth.png', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/blogimg-clarityvssmooth.png', 'image/png', 'blogimg-clarityvssmooth.png', 5780, 1, 1309699462, 1, 1323909830, '178 241', NULL, NULL, NULL),
(10, 1, 'blogimg-objectifyyourcssh.png', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/blogimg-objectifyyourcssh.png', 'image/png', 'blogimg-objectifyyourcssh.png', 10786, 1, 1309699462, 1, 1323909830, '239 300', NULL, NULL, NULL),
(11, 1, 'slide-cornexchangenew_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-cornexchangenew_02.jpg', 'image/jpeg', 'slide-cornexchangenew_02.jpg', 24755, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(12, 1, 'slide-eea_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-eea_03.jpg', 'image/jpeg', 'slide-eea_03.jpg', 37959, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(13, 1, 'slide-doneanddusted_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-doneanddusted_01.jpg', 'image/jpeg', 'slide-doneanddusted_01.jpg', 34994, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(14, 1, 'slide-eea_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-eea_04.jpg', 'image/jpeg', 'slide-eea_04.jpg', 33443, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(15, 1, 'slide-fst_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-fst_01.jpg', 'image/jpeg', 'slide-fst_01.jpg', 25594, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(16, 1, 'slide-doneanddusted_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-doneanddusted_02.jpg', 'image/jpeg', 'slide-doneanddusted_02.jpg', 24745, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(17, 1, 'slide-fst_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-fst_02.jpg', 'image/jpeg', 'slide-fst_02.jpg', 22601, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(18, 1, 'slide-eea_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-eea_01.jpg', 'image/jpeg', 'slide-eea_01.jpg', 29962, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(19, 1, 'slide-fst_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-fst_03.jpg', 'image/jpeg', 'slide-fst_03.jpg', 21288, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(20, 1, 'slide-eea_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-eea_02.jpg', 'image/jpeg', 'slide-eea_02.jpg', 33660, 1, 1309699462, 1, 1323909831, '254 459', NULL, NULL, NULL),
(21, 1, 'slide-immediatetheatre_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-immediatetheatre_01.jpg', 'image/jpeg', 'slide-immediatetheatre_01.jpg', 36190, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(22, 1, 'slide-fst_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-fst_04.jpg', 'image/jpeg', 'slide-fst_04.jpg', 24710, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(23, 1, 'slide-immediatetheatre_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-immediatetheatre_02.jpg', 'image/jpeg', 'slide-immediatetheatre_02.jpg', 36897, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(24, 1, 'slide-immediatetheatre_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-immediatetheatre_03.jpg', 'image/jpeg', 'slide-immediatetheatre_03.jpg', 33392, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(25, 1, 'slide-iluv2_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-iluv2_01.jpg', 'image/jpeg', 'slide-iluv2_01.jpg', 37487, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(26, 1, 'slide-mosj_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-mosj_01.jpg', 'image/jpeg', 'slide-mosj_01.jpg', 31100, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(27, 1, 'slide-iluv2_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-iluv2_02.jpg', 'image/jpeg', 'slide-iluv2_02.jpg', 27994, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(28, 1, 'slide-mosj_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-mosj_02.jpg', 'image/jpeg', 'slide-mosj_02.jpg', 39138, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(29, 1, 'slide-iluv2_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-iluv2_03.jpg', 'image/jpeg', 'slide-iluv2_03.jpg', 31568, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(30, 1, 'slide-iluv2_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-iluv2_04.jpg', 'image/jpeg', 'slide-iluv2_04.jpg', 29636, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(31, 1, 'slide-nnf11_05.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-nnf11_05.jpg', 'image/jpeg', 'slide-nnf11_05.jpg', 35357, 1, 1309699463, 1, 1323909833, '254 459', NULL, NULL, NULL),
(32, 1, 'slide-tbai_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-tbai_01.jpg', 'image/jpeg', 'slide-tbai_01.jpg', 22918, 1, 1309699463, 1, 1323909833, '254 459', NULL, NULL, NULL),
(33, 1, 'slide-tbai_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-tbai_02.jpg', 'image/jpeg', 'slide-tbai_02.jpg', 25667, 1, 1309699463, 1, 1323909833, '254 459', NULL, NULL, NULL),
(34, 1, 'slide-mosj_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-mosj_03.jpg', 'image/jpeg', 'slide-mosj_03.jpg', 24460, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(35, 1, 'slide-tbai_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-tbai_03.jpg', 'image/jpeg', 'slide-tbai_03.jpg', 24755, 1, 1309699463, 1, 1323909833, '254 459', NULL, NULL, NULL),
(36, 1, 'slide-tbai_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-tbai_04.jpg', 'image/jpeg', 'slide-tbai_04.jpg', 15154, 1, 1309699463, 1, 1323909833, '254 459', NULL, NULL, NULL),
(37, 1, 'slide-nnf11_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-nnf11_01.jpg', 'image/jpeg', 'slide-nnf11_01.jpg', 36541, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(38, 1, 'slide-nnf11_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-nnf11_02.jpg', 'image/jpeg', 'slide-nnf11_02.jpg', 39442, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(39, 1, 'slide-nnf11_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-nnf11_03.jpg', 'image/jpeg', 'slide-nnf11_03.jpg', 38988, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(40, 1, 'slide-nnf11_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-nnf11_04.jpg', 'image/jpeg', 'slide-nnf11_04.jpg', 37927, 1, 1309699463, 1, 1323909832, '254 459', NULL, NULL, NULL),
(41, 1, 'slide-ymt_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-ymt_01.jpg', 'image/jpeg', 'slide-ymt_01.jpg', 40461, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(42, 1, 'slide-ymt_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-ymt_02.jpg', 'image/jpeg', 'slide-ymt_02.jpg', 29334, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(43, 1, 'slide-ymt_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-ymt_03.jpg', 'image/jpeg', 'slide-ymt_03.jpg', 37117, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(44, 1, 'slide-thamesfestival_01.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-thamesfestival_01.jpg', 'image/jpeg', 'slide-thamesfestival_01.jpg', 39990, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(45, 1, 'slide-ymt_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-ymt_04.jpg', 'image/jpeg', 'slide-ymt_04.jpg', 43444, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(46, 1, 'thumb-cmnmicrosite_appinfuniverse.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-cmnmicrosite_appinfuniverse.jpg', 'image/jpeg', 'thumb-cmnmicrosite_appinfuniverse.jpg', 6001, 1, 1309699464, 1, 1323909833, '126 169', NULL, NULL, NULL),
(47, 1, 'slide-thamesfestival_02.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-thamesfestival_02.jpg', 'image/jpeg', 'slide-thamesfestival_02.jpg', 39114, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(48, 1, 'slide-thamesfestival_03.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-thamesfestival_03.jpg', 'image/jpeg', 'slide-thamesfestival_03.jpg', 34088, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(49, 1, 'slide-thamesfestival_04.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-thamesfestival_04.jpg', 'image/jpeg', 'slide-thamesfestival_04.jpg', 42657, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(50, 1, 'slide-thamesfestival_05.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/slide-thamesfestival_05.jpg', 'image/jpeg', 'slide-thamesfestival_05.jpg', 41200, 1, 1309699464, 1, 1323909833, '254 459', NULL, NULL, NULL),
(51, 1, 'thumb-immediatetheatre.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-immediatetheatre.jpg', 'image/jpeg', 'thumb-immediatetheatre.jpg', 5533, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(52, 1, 'thumb-cornexchangenew.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-cornexchangenew.jpg', 'image/jpeg', 'thumb-cornexchangenew.jpg', 6877, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(53, 1, 'thumb-mosj.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-mosj.jpg', 'image/jpeg', 'thumb-mosj.jpg', 5006, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(54, 1, 'thumb-doneanddusted.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-doneanddusted.jpg', 'image/jpeg', 'thumb-doneanddusted.jpg', 7236, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(55, 1, 'thumb-nnf11.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-nnf11.jpg', 'image/jpeg', 'thumb-nnf11.jpg', 4747, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(56, 1, 'thumb-eea.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-eea.jpg', 'image/jpeg', 'thumb-eea.jpg', 5513, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(57, 1, 'thumb-tbai.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-tbai.jpg', 'image/jpeg', 'thumb-tbai.jpg', 5191, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(58, 1, 'thumb-fst.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-fst.jpg', 'image/jpeg', 'thumb-fst.jpg', 4848, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(59, 1, 'thumb-thamesfestival.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-thamesfestival.jpg', 'image/jpeg', 'thumb-thamesfestival.jpg', 8380, 1, 1309699464, 1, 1323909835, '126 169', NULL, NULL, NULL),
(60, 1, 'thumb-iluv2.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-iluv2.jpg', 'image/jpeg', 'thumb-iluv2.jpg', 7921, 1, 1309699464, 1, 1323909834, '126 169', NULL, NULL, NULL),
(61, 1, 'thumb-ymt.jpg', 1, '/home/jackarmley16/jackarmley.co.uk/images/uploads/images/thumb-ymt.jpg', 'image/jpeg', 'thumb-ymt.jpg', 8260, 1, 1309699465, 1, 1323909835, '126 169', NULL, NULL, NULL),
(68, 1, 'blogimg-xmastreesinthewild.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/blogimg-xmastreesinthewild.png', 'image/png', 'blogimg-xmastreesinthewild.png', 29788, 1, 1325521760, 1, 1325521760, '500 323', NULL, NULL, NULL),
(66, 1, 'blogimg-keepingacleansheet.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/blogimg-keepingacleansheet.png', 'image/png', 'blogimg-keepingacleansheet.png', 12974, 1, 1323909830, 1, 1323909830, '264 347', NULL, NULL, NULL),
(67, 1, 'thumb-nnf10.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/thumb-nnf10.jpg', 'image/jpeg', 'thumb-nnf10.jpg', 5143, 1, 1323909834, 1, 1323909834, '126 169', NULL, NULL, NULL),
(69, 1, 'artimg-know_your_desc.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/artimg-know_your_desc.jpg', 'image/jpeg', 'artimg-know_your_desc.jpg', 217436, 1, 1327854043, 1, 1327854324, '553 1000', NULL, NULL, NULL),
(71, 1, 'tn-artimg-know_your_desc.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/tn-artimg-know_your_desc.jpg', 'image/jpeg', 'tn-artimg-know_your_desc.jpg', 49848, 1, 1327854707, 1, 1327854707, '254 459', NULL, NULL, NULL),
(72, 1, 'artimg-bulletproof_webfont.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/artimg-bulletproof_webfont.png', 'image/png', 'artimg-bulletproof_webfont.png', 55030, 1, 1327858373, 1, 1327858373, '485 384', NULL, NULL, NULL),
(73, 1, 'artimg-clarityvssmooth.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/artimg-clarityvssmooth.png', 'image/png', 'artimg-clarityvssmooth.png', 5775, 1, 1327858515, 1, 1327858515, '178 241', NULL, NULL, NULL),
(74, 1, 'artimg-objectifyyourcssh.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/artimg-objectifyyourcssh.png', 'image/png', 'artimg-objectifyyourcssh.png', 10783, 1, 1327858630, 1, 1327858630, '239 300', NULL, NULL, NULL),
(75, 1, 'tn-artimg-new_site.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/tn-artimg-new_site.jpg', 'image/jpeg', 'tn-artimg-new_site.jpg', 38605, 1, 1327864059, 1, 1327864855, '260 469', NULL, NULL, NULL),
(76, 1, 'artimg-new_site.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/artimg-new_site.jpg', 'image/jpeg', 'artimg-new_site.jpg', 172554, 1, 1327864087, 1, 1327864087, '553 1000', NULL, NULL, NULL),
(78, 1, 'slide-nailsinc-couture_01.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/slide-nailsinc-couture_01.png', 'image/png', 'slide-nailsinc-couture_01.png', 384184, 1, 1327876289, 1, 1327876289, '553 1000', NULL, NULL, NULL),
(79, 1, 'slide-nailsinc-couture_02.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/slide-nailsinc-couture_02.jpg', 'image/jpeg', 'slide-nailsinc-couture_02.jpg', 99236, 1, 1327876600, 1, 1327876600, '553 1000', NULL, NULL, NULL),
(80, 1, 'slide-nailsinc-tryiton_01.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/slide-nailsinc-tryiton_01.jpg', 'image/jpeg', 'slide-nailsinc-tryiton_01.jpg', 279613, 1, 1327886055, 1, 1327886055, '553 1000', NULL, NULL, NULL),
(81, 1, 'thumb-tangentsnowball.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/thumb-tangentsnowball.jpg', 'image/jpeg', 'thumb-tangentsnowball.jpg', 65290, 1, 1327889066, 1, 1327889066, '260 469', NULL, NULL, NULL),
(83, 1, NULL, 0, NULL, NULL, NULL, 181453, 0, 1327889242, 1, 1327889238, '553 1000', NULL, NULL, NULL),
(88, 1, 'slide-tangentsnowball_01.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/slide-tangentsnowball_01.jpg', 'image/jpeg', 'slide-tangentsnowball_01.jpg', 181453, 1, 1327889377, 1, 1327889377, '553 1000', NULL, NULL, NULL),
(85, 1, NULL, 0, NULL, NULL, NULL, 181453, 0, 1327889312, 1, 1327889308, '553 1000', NULL, NULL, NULL),
(87, 1, NULL, 0, NULL, NULL, NULL, 181453, 0, 1327889358, 1, 1327889355, '553 1000', NULL, NULL, NULL),
(89, 1, 'slide-tangentsnowball_02.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/slide-tangentsnowball_02.jpg', 'image/jpeg', 'slide-tangentsnowball_02.jpg', 151644, 1, 1327889402, 1, 1327889402, '553 1000', NULL, NULL, NULL),
(90, 1, 'slide-tangentsnowball_03.png', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/slide-tangentsnowball_03.png', 'image/png', 'slide-tangentsnowball_03.png', 538737, 1, 1327889430, 1, 1327889430, '553 1000', NULL, NULL, NULL),
(91, 1, 'tn-artimg-fancyabbr.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/tn-artimg-fancyabbr.jpg', 'image/jpeg', 'tn-artimg-fancyabbr.jpg', 39864, 1, 1328061702, 1, 1328061702, '260 469', NULL, NULL, NULL),
(92, 1, 'tn-artimg-css3_bcrumbnav.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/tn-artimg-css3_bcrumbnav.jpg', 'image/jpeg', 'tn-artimg-css3_bcrumbnav.jpg', 68106, 1, 1328461042, 1, 1328461042, '260 469', NULL, NULL, NULL),
(93, 1, 'artimg-fittext.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/artimg-fittext.jpg', 'image/jpeg', 'artimg-fittext.jpg', 294042, 1, 1329067385, 1, 1329067385, '553 1000', NULL, NULL, NULL),
(94, 1, 'tn-artimg-fittext.jpg', 1, '/home/jackarmley16/jackarmley.com/images/uploads/images/tn-artimg-fittext.jpg', 'image/jpeg', 'tn-artimg-fittext.jpg', 110316, 1, 1329067403, 1, 1329067403, '260 469', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_attachments`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_attachments` (
  `attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL,
  `pref_id` int(10) unsigned NOT NULL,
  `entry_date` int(10) NOT NULL,
  `server_path` varchar(150) NOT NULL,
  `filename` varchar(150) NOT NULL,
  `extension` varchar(7) NOT NULL,
  `filesize` int(10) NOT NULL,
  `emailed` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`attachment_id`),
  KEY `entry_id` (`entry_id`),
  KEY `pref_id` (`pref_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_freeform_attachments`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_entries`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_entries` (
  `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `weblog_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `form_name` varchar(50) NOT NULL,
  `template` varchar(150) NOT NULL,
  `entry_date` int(10) NOT NULL,
  `edit_date` int(10) NOT NULL,
  `status` char(10) NOT NULL DEFAULT 'open',
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `website` varchar(50) NOT NULL,
  `street1` varchar(50) NOT NULL,
  `street2` varchar(50) NOT NULL,
  `street3` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postalcode` varchar(50) NOT NULL,
  `phone1` varchar(50) NOT NULL,
  `phone2` varchar(50) NOT NULL,
  `fax` varchar(50) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `exp_freeform_entries`
--

INSERT INTO `exp_freeform_entries` (`entry_id`, `group_id`, `weblog_id`, `author_id`, `ip_address`, `form_name`, `template`, `entry_date`, `edit_date`, `status`, `name`, `email`, `website`, `street1`, `street2`, `street3`, `city`, `state`, `country`, `postalcode`, `phone1`, `phone2`, `fax`, `message`) VALUES
(1, 1, 0, 1, '127.0.0.1', 'Contact form', 'contact_adminnotification', 1303048532, 1303048532, 'open', 'Jack ', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'stuff'),
(2, 1, 0, 1, '127.0.0.1', 'Contact form', 'contact_adminnotification', 1303048958, 1303048958, 'open', 'Jack ', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'stuff'),
(3, 1, 0, 1, '127.0.0.1', 'Contact form', 'contact_adminnotification', 1303066869, 1303066869, 'open', 'Jack', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'fwefw efwefwerfer feerer  er erkjekjr kejrhkerjkejr kejrkgejrhkgjerh kgjehrkjerhkejrhjerkhr'),
(4, 1, 0, 1, '94.194.134.131', 'Contact form', 'contact_adminnotification', 1303156898, 1303156898, 'open', 'Jack', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'fwkejfhwekjfh wkj wwefwef f ew wfe'),
(5, 1, 0, 1, '94.194.134.131', 'Contact form', 'contact_adminnotification', 1303158081, 1303158081, 'open', 'Jack', 'jack@cogdesign.com', '', '', '', '', '', '', '', '', '', '', '', 'Test'),
(6, 1, 0, 1, '94.194.134.131', 'Contact form', 'contact_adminnotification', 1303158212, 1303158212, 'open', 'Jack', 'jack@cogdesign.com', '', '', '', '', '', '', '', '', '', '', '', 'Test'),
(7, 1, 0, 1, '94.194.134.131', 'Contact form', 'contact_adminnotification', 1303159116, 1303159116, 'open', 'Jack', 'jack@cogdesign.com', '', '', '', '', '', '', '', '', '', '', '', 'dwqfwef wfwe ewef'),
(8, 3, 0, 0, '86.178.126.102', 'Contact form', 'contact_adminnotification', 1305038756, 1305038756, 'open', 'Alice Coyle', 'alicepomegranate@btinternet.com', '', '', '', '', '', '', '', '', '', '', '', 'I''d like to say...\nGreat web-site Jack!!  All those snazzy bits !!  My you have come a long way since the Birth Rites web-site - well done.\n...now about the anatomy of the heart.....'),
(9, 3, 0, 0, '86.178.126.102', 'Contact form', 'contact_adminnotification', 1305039037, 1305039037, 'open', 'Alice Coyle', 'alicepomegranate@btinternet.com', '', '', '', '', '', '', '', '', '', '', '', 'I''d like to say... there''s a typo in you blurb about ''Told by an Idiot \ncatalogue is spelt well.....catalogue ....'),
(10, 3, 0, 0, '91.224.160.4', 'Contact form', 'contact_adminnotification', 1306312127, 1306312127, 'open', 'xfather123', 'xfather@gmail.com', '', '', '', '', '', '', '', '', '', '', '', 'iRbnOU this is delisious!\nxfather123'),
(11, 3, 0, 0, '193.60.53.188', 'Contact form', 'contact_adminnotification', 1307546039, 1307546039, 'open', 'alicepmegranate@btinternet.com', 'alicepmegranate@btinternet.com', '', '', '', '', '', '', '', '', '', '', '', 'I''d like to say...  hi jack - hope you are working hard'),
(12, 3, 0, 0, '193.60.53.188', 'Contact form', 'contact_adminnotification', 1308067369, 1308067369, 'open', 'alicepomegranate@btinternet.com', 'alicepomegranate@btinternet.com', '', '', '', '', '', '', '', '', '', '', '', 'I''d like to say...hi jack- new job!!!!!  How is it going? I''ve been thinking about you hoping you are enjoying it all.   big hugs - a xoxox'),
(13, 3, 0, 0, '193.60.70.49', 'Contact form', 'contact_adminnotification', 1311171931, 1311171931, 'open', 'Your MUm!!!', 'alicepomegranate@btinternet.com', '', '', '', '', '', '', '', '', '', '', '', 'I''d like to say... time to get together soon!!!!'),
(14, 3, 0, 0, '82.28.89.161', 'Contact form', 'contact_adminnotification', 1315082312, 1315082312, 'open', 'Hamish', 'hammy_maccas@hotmail.com', '', '', '', '', '', '', '', '', '', '', '', 'you''re a dick and its audience audiEnce............... dick'),
(15, 3, 0, 0, '189.112.189.28', 'Contact form', 'contact_adminnotification', 1317623392, 1317623392, 'open', 'pdvvsn', 'jjixlb@wszxpr.com', '', '', '', '', '', '', '', '', '', '', '', 'Bid9sd  <a href="http://ukrglefvpubp.com/">ukrglefvpubp</a>, [url=http://lnzzlpenqmnw.com/]lnzzlpenqmnw[/url], [link=http://aqojifxyzwgs.com/]aqojifxyzwgs[/link], http://figsnaamqfwo.com/'),
(16, 3, 0, 0, '217.45.119.141', 'Contact form', 'contact_adminnotification', 1326369008, 1326369008, 'open', 'James Gwynne', 'james@immediate-theatre.com', '', '', '', '', '', '', '', '', '', '', '', 'I''d like to say...Dear Jack\nI am contacting you from Immediate theatre you developed a website for us a few years ago. I understand that you must be very busy but I was hoping that you could help us out with some problems that we are having. \nI have found it very difficult to find anyone who can offer us support since Cog has stopped offering this service. People seem very willing to build us a new website but not so keen to help manage an existing one. I was wondering if you would be willing to take on a small amount of freelance work or if you would know anyone who would?\nThanks\nJames Gwynne\n'),
(17, 3, 0, 0, '86.178.127.17', 'Contact form', 'contact_adminnotification', 1326924475, 1326924475, 'open', 'Jack', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'Boom'),
(18, 1, 0, 1, '94.194.134.131', 'Contact form', 'contact_adminnotification', 1327352502, 1327352502, 'open', 'Jack', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'Hi there'),
(19, 3, 0, 0, '94.194.134.131', 'Contact form', 'contact_adminnotification', 1327872594, 1327872594, 'open', 'Jack Armley', 'jack_armley@yahoo.co.uk', '', '', '', '', '', '', '', '', '', '', '', 'Boom');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_fields`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_fields` (
  `field_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_order` int(10) NOT NULL DEFAULT '0',
  `field_type` varchar(50) NOT NULL DEFAULT 'text',
  `field_length` int(3) NOT NULL DEFAULT '150',
  `form_name` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `name_old` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `weblog_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `entry_date` int(10) NOT NULL,
  `edit_date` int(10) NOT NULL,
  `editable` char(1) NOT NULL DEFAULT 'y',
  `status` char(10) NOT NULL DEFAULT 'open',
  PRIMARY KEY (`field_id`),
  KEY `name` (`name`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `exp_freeform_fields`
--

INSERT INTO `exp_freeform_fields` (`field_id`, `field_order`, `field_type`, `field_length`, `form_name`, `name`, `name_old`, `label`, `weblog_id`, `author_id`, `entry_date`, `edit_date`, `editable`, `status`) VALUES
(1, 1, 'text', 150, '', 'name', '', 'Name', 0, 0, 0, 0, 'n', ''),
(2, 2, 'text', 150, '', 'email', '', 'Email', 0, 0, 0, 0, 'n', ''),
(3, 3, 'text', 150, '', 'website', '', 'Website', 0, 0, 0, 0, 'n', ''),
(4, 4, 'text', 150, '', 'street1', '', 'Street 1', 0, 0, 0, 0, 'n', ''),
(5, 5, 'text', 150, '', 'street2', '', 'Street 2', 0, 0, 0, 0, 'n', ''),
(6, 6, 'text', 150, '', 'street3', '', 'Street 3', 0, 0, 0, 0, 'n', ''),
(7, 7, 'text', 150, '', 'city', '', 'City', 0, 0, 0, 0, 'n', ''),
(8, 8, 'text', 150, '', 'state', '', 'State', 0, 0, 0, 0, 'n', ''),
(9, 9, 'text', 150, '', 'country', '', 'Country', 0, 0, 0, 0, 'n', ''),
(10, 10, 'text', 150, '', 'postalcode', '', 'Postal Code', 0, 0, 0, 0, 'n', ''),
(11, 11, 'text', 150, '', 'phone1', '', 'Phone 1', 0, 0, 0, 0, 'n', ''),
(12, 12, 'text', 150, '', 'phone2', '', 'Phone 2', 0, 0, 0, 0, 'n', ''),
(13, 13, 'text', 150, '', 'fax', '', 'Fax', 0, 0, 0, 0, 'n', ''),
(14, 14, 'textarea', 500, '', 'message', '', 'Message', 0, 0, 0, 0, 'y', 'open');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_params`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_params` (
  `params_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_date` int(10) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`params_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=942 ;

--
-- Dumping data for table `exp_freeform_params`
--

INSERT INTO `exp_freeform_params` (`params_id`, `entry_date`, `data`) VALUES
(941, 1329812813, 'a:18:{s:15:"require_captcha";s:2:"no";s:9:"form_name";s:12:"Contact form";s:10:"require_ip";s:3:"yes";s:11:"ee_required";s:18:"name|email|message";s:9:"ee_notify";s:20:"aloha@jackarmley.com";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:2:"no";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:24:"contact_userautoresponse";s:8:"template";s:25:"contact_adminnotification";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_preferences`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_preferences` (
  `preference_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `preference_name` varchar(80) NOT NULL,
  `preference_value` text NOT NULL,
  PRIMARY KEY (`preference_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_freeform_preferences`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_templates`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_templates` (
  `template_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `enable_template` char(1) NOT NULL DEFAULT 'y',
  `wordwrap` char(1) NOT NULL DEFAULT 'y',
  `html` char(1) NOT NULL DEFAULT 'n',
  `template_name` varchar(150) NOT NULL,
  `template_label` varchar(150) NOT NULL,
  `data_from_name` varchar(150) NOT NULL,
  `data_from_email` varchar(200) NOT NULL,
  `data_title` varchar(80) NOT NULL,
  `template_data` text NOT NULL,
  PRIMARY KEY (`template_id`),
  KEY `template_name` (`template_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `exp_freeform_templates`
--

INSERT INTO `exp_freeform_templates` (`template_id`, `enable_template`, `wordwrap`, `html`, `template_name`, `template_label`, `data_from_name`, `data_from_email`, `data_title`, `template_data`) VALUES
(1, 'y', 'y', 'n', 'default_template', 'Default Template', '', '', 'Someone has posted to Freeform', 'Someone has posted to Freeform. Here are the details:  \r\n			 		\r\nEntry Date: {entry_date}\r\n{all_custom_fields}'),
(2, 'y', 'n', 'y', 'contact_adminnotification', 'Contact form: admin notification', '{name}', '{email}', '{name} has got in touch, via jackarmley.co.uk', '<p>{name}</p>\n<p>{email</p>\n<p>Message</p>\n{message}'),
(3, 'y', 'n', 'y', 'contact_userautoresponse', 'Contact form: User auto-response', 'Jack', 'aloha@jackarmley.co.uk', 'Thanks for getting in touch!', '<p>Hi {name},</p>\n<p>Thanks for getting in touch, I''ll get back to you as soon as I can</p>');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_user_email`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_user_email` (
  `email_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL,
  `email_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_freeform_user_email`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_global_variables`
--

CREATE TABLE IF NOT EXISTS `exp_global_variables` (
  `variable_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `variable_name` varchar(50) NOT NULL,
  `variable_data` text NOT NULL,
  PRIMARY KEY (`variable_id`),
  KEY `variable_name` (`variable_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `exp_global_variables`
--

INSERT INTO `exp_global_variables` (`variable_id`, `site_id`, `variable_name`, `variable_data`) VALUES
(2, 1, 'gv-home_loving', '<p><a href="http://gridpak.com/">Gridpak</a> by Erskine design, <a href="http://fitvidsjs.com" title="Visit the awesome FitFits.JS site">FitVids.JS</a> (an awesome responsive video plugin by <a href="http://chriscoyier.net/" title="Visit the awesome Chris Coyier''s website">Chris Coyier</a> and <a href="http://paravelinc.com/" title="Visit Paravel inc: you''ll never leave!">Paravel)</a> and <a href="http://www.google.com/landing/chrome/beta/">Chrome beta''s</a> user&ndash; agent string switcher.</p>'),
(3, 1, 'gv-home_using', '<p><a href="http://dabblet.com" title="Visit dabblet and create an awesome dabble!">Dabblet</a> by <a href="http://lea.verou.me/" title="Visit Lea''s website">Lea Verou</a> and friends, and <a href="http://tangentsnowball.github.com/Snowcone/index.html">Snowcone</a>, an icon font I''ve been working on with the Tangent Snowball team, and the principles from <a href="http://smacss.com/">SMACSS</a> by Jonathan Snook,</p>');

-- --------------------------------------------------------

--
-- Table structure for table `exp_html_buttons`
--

CREATE TABLE IF NOT EXISTS `exp_html_buttons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `tag_name` varchar(32) NOT NULL,
  `tag_open` varchar(120) NOT NULL,
  `tag_close` varchar(120) NOT NULL,
  `accesskey` varchar(32) NOT NULL,
  `tag_order` int(3) unsigned NOT NULL,
  `tag_row` char(1) NOT NULL DEFAULT '1',
  `classname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_html_buttons`
--

INSERT INTO `exp_html_buttons` (`id`, `site_id`, `member_id`, `tag_name`, `tag_open`, `tag_close`, `accesskey`, `tag_order`, `tag_row`, `classname`) VALUES
(1, 1, 0, 'b', '<strong>', '</strong>', 'b', 1, '1', 'btn_b'),
(2, 1, 0, 'i', '<em>', '</em>', 'i', 2, '1', 'btn_i'),
(3, 1, 0, 'blockquote', '<blockquote>', '</blockquote>', 'q', 3, '1', 'btn_blockquote'),
(4, 1, 0, 'a', '<a href="[![Link:!:http://]!]"(!( title="[![Title]!]")!)>', '</a>', 'a', 4, '1', 'btn_a'),
(5, 1, 0, 'img', '<img src="[![Link:!:http://]!]" alt="[![Alternative text]!]" />', '', '', 5, '1', 'btn_img');

-- --------------------------------------------------------

--
-- Table structure for table `exp_iexpression`
--

CREATE TABLE IF NOT EXISTS `exp_iexpression` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `property` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_iexpression`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_layout_publish`
--

CREATE TABLE IF NOT EXISTS `exp_layout_publish` (
  `layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_group` int(4) unsigned NOT NULL DEFAULT '0',
  `channel_id` int(4) unsigned NOT NULL DEFAULT '0',
  `field_layout` text,
  PRIMARY KEY (`layout_id`),
  KEY `site_id` (`site_id`),
  KEY `member_group` (`member_group`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `exp_layout_publish`
--

INSERT INTO `exp_layout_publish` (`layout_id`, `site_id`, `member_group`, `channel_id`, `field_layout`) VALUES
(16, 1, 1, 2, 'a:2:{s:7:"publish";a:14:{s:10:"_tab_label";s:7:"Publish";s:5:"title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:9:"url_title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"status";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:10:"entry_date";a:4:{s:7:"visible";b:1;s:8:"collapse";b:1;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:15:"expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:23:"comment_expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:8:"category";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:11:"new_channel";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:6:"author";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:7:"options";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:4:"ping";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:16:"pages__pages_uri";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:24:"pages__pages_template_id";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}s:7:"details";a:3:{s:10:"_tab_label";s:7:"Details";i:4;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:5;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}}'),
(9, 1, 1, 4, 'a:2:{s:7:"publish";a:14:{s:10:"_tab_label";s:7:"Publish";s:5:"title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:9:"url_title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"status";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"author";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"500%";}s:10:"entry_date";a:4:{s:7:"visible";b:1;s:8:"collapse";b:1;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:15:"expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:23:"comment_expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:8:"category";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:11:"new_channel";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:7:"options";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:4:"ping";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:16:"pages__pages_uri";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}s:24:"pages__pages_template_id";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"360%";}}s:4:"text";a:3:{s:10:"_tab_label";s:4:"Text";i:13;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:14;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}}'),
(26, 1, 1, 1, 'a:3:{s:7:"publish";a:22:{s:10:"_tab_label";s:7:"Publish";s:5:"title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:9:"url_title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"status";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:10:"entry_date";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"author";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:8:"category";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:15:"expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:23:"comment_expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:11:"new_channel";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:7:"options";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:4:"ping";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:16:"pages__pages_uri";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:24:"pages__pages_template_id";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:1;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:2;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:3;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:15;a:4:{s:7:"visible";b:1;s:8:"collapse";b:1;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:16;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:24;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:21;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:22;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}s:5:"image";a:1:{s:10:"_tab_label";s:5:"Image";}s:4:"text";a:1:{s:10:"_tab_label";s:4:"Text";}}'),
(22, 1, 1, 3, 'a:4:{s:7:"publish";a:15:{s:10:"_tab_label";s:7:"Publish";s:5:"title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:9:"url_title";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"status";a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:3:"50%";}s:6:"author";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:10:"entry_date";a:4:{s:7:"visible";b:1;s:8:"collapse";b:1;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:15:"expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:23:"comment_expiration_date";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:8:"category";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:11:"new_channel";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:7:"options";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:4:"ping";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:16:"pages__pages_uri";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}s:24:"pages__pages_template_id";a:4:{s:7:"visible";b:0;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:12;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}s:4:"text";a:6:{s:10:"_tab_label";s:4:"Text";i:11;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:6;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:7;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:8;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:23;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}s:6:"images";a:3:{s:10:"_tab_label";s:6:"Images";i:9;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}i:10;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:0;s:5:"width";s:4:"100%";}}s:10:"screencast";a:2:{s:10:"_tab_label";s:10:"Screencast";i:17;a:4:{s:7:"visible";b:1;s:8:"collapse";b:0;s:11:"htmlbuttons";b:1;s:5:"width";s:4:"100%";}}}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_matrix_cols`
--

CREATE TABLE IF NOT EXISTS `exp_matrix_cols` (
  `col_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned DEFAULT '1',
  `field_id` int(6) unsigned DEFAULT NULL,
  `col_name` varchar(32) DEFAULT NULL,
  `col_label` varchar(50) DEFAULT NULL,
  `col_instructions` text,
  `col_type` varchar(50) DEFAULT 'text',
  `col_required` char(1) DEFAULT 'n',
  `col_search` char(1) DEFAULT 'n',
  `col_order` int(3) unsigned DEFAULT NULL,
  `col_width` varchar(4) DEFAULT NULL,
  `col_settings` text,
  PRIMARY KEY (`col_id`),
  KEY `site_id` (`site_id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `exp_matrix_cols`
--

INSERT INTO `exp_matrix_cols` (`col_id`, `site_id`, `field_id`, `col_name`, `col_label`, `col_instructions`, `col_type`, `col_required`, `col_search`, `col_order`, `col_width`, `col_settings`) VALUES
(1, 1, 9, '-matrix-work-thumb_image', 'Image', '', 'file', 'y', 'n', 0, '33%', 'YToxOntzOjEyOiJjb250ZW50X3R5cGUiO3M6NToiaW1hZ2UiO30='),
(2, 1, 9, '-matrix-work-thumb_alt', 'Alt text', '', 'text', 'y', 'n', 1, '', 'YTozOntzOjQ6Im1heGwiO3M6MzoiMzAwIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYW55Ijt9'),
(3, 1, 10, '-matrix-work-slides_image', 'Image', '', 'file', 'n', 'n', 0, '33%', 'YToyOntzOjk6ImRpcmVjdG9yeSI7czozOiJhbGwiO3M6MTI6ImNvbnRlbnRfdHlwZSI7czozOiJhbGwiO30='),
(4, 1, 10, '-matrix-work-slides_alt', 'Alt text', '', 'text', 'n', 'n', 1, '', 'YTozOntzOjQ6Im1heGwiO3M6MzoiMzAwIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYWxsIjt9'),
(5, 1, 10, '-matrix-work-slides_caption', 'Caption', '', 'text', 'n', 'n', 2, '', 'YTozOntzOjQ6Im1heGwiO3M6MzoiMzAwIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYWxsIjt9'),
(9, 1, 21, 'blog-image_image', 'Image', '', 'file', 'n', 'n', 0, '33%', 'YToyOntzOjk6ImRpcmVjdG9yeSI7czozOiJhbGwiO3M6MTI6ImNvbnRlbnRfdHlwZSI7czozOiJhbGwiO30='),
(10, 1, 21, 'blog-image_alt', 'Alt text', '', 'text', 'n', 'n', 1, '', 'YTozOntzOjQ6Im1heGwiO3M6MzoiMTQwIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYWxsIjt9'),
(11, 1, 21, 'blog-image_caption', 'Caption', '', 'text', 'n', 'n', 2, '', 'YTozOntzOjQ6Im1heGwiO3M6MDoiIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYWxsIjt9'),
(12, 1, 22, 'blog-thumb_image', 'Image', '', 'file', 'n', 'n', 0, '33%', 'YToyOntzOjk6ImRpcmVjdG9yeSI7czoxOiIxIjtzOjEyOiJjb250ZW50X3R5cGUiO3M6NToiaW1hZ2UiO30='),
(13, 1, 22, 'blog-thumb_alt', 'Alt', '', 'text', 'n', 'n', 1, '', 'YTozOntzOjQ6Im1heGwiO3M6MDoiIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYWxsIjt9'),
(14, 1, 22, 'blog-thumb_caption', 'Caption', '', 'text', 'n', 'n', 2, '', 'YTozOntzOjQ6Im1heGwiO3M6MDoiIjtzOjM6ImZtdCI7czo0OiJub25lIjtzOjc6ImNvbnRlbnQiO3M6MzoiYWxsIjt9'),
(15, 1, 21, 'blog-image_border', 'Border', '', 'pt_radio_buttons', 'n', 'n', 3, '', 'YToxOntzOjc6Im9wdGlvbnMiO2E6Mjp7czozOiJ5ZXMiO3M6MzoieWVzIjtzOjI6Im5vIjtzOjI6Im5vIjt9fQ=='),
(16, 1, 22, 'blog-thumb_border', 'Border', '', 'pt_radio_buttons', 'n', 'n', 3, '', 'YToxOntzOjc6Im9wdGlvbnMiO2E6Mjp7czozOiJ5ZXMiO3M6MzoieWVzIjtzOjI6Im5vIjtzOjI6Im5vIjt9fQ=='),
(17, 1, 10, '-matrix-work-slides_border', 'Border', '', 'pt_radio_buttons', 'n', 'n', 3, '', 'YToxOntzOjc6Im9wdGlvbnMiO2E6Mjp7czozOiJ5ZXMiO3M6MzoieWVzIjtzOjI6Im5vIjtzOjI6Im5vIjt9fQ==');

-- --------------------------------------------------------

--
-- Table structure for table `exp_matrix_data`
--

CREATE TABLE IF NOT EXISTS `exp_matrix_data` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned DEFAULT '1',
  `entry_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(6) unsigned DEFAULT NULL,
  `row_order` int(4) unsigned DEFAULT NULL,
  `col_id_1` text,
  `col_id_2` text,
  `col_id_3` text,
  `col_id_4` text,
  `col_id_5` text,
  `col_id_9` text,
  `col_id_10` text,
  `col_id_11` text,
  `col_id_12` text,
  `col_id_13` text,
  `col_id_14` text,
  `col_id_15` text,
  `col_id_16` text,
  `col_id_17` text,
  PRIMARY KEY (`row_id`),
  KEY `site_id` (`site_id`),
  KEY `entry_id` (`entry_id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=96 ;

--
-- Dumping data for table `exp_matrix_data`
--

INSERT INTO `exp_matrix_data` (`row_id`, `site_id`, `entry_id`, `field_id`, `row_order`, `col_id_1`, `col_id_2`, `col_id_3`, `col_id_4`, `col_id_5`, `col_id_9`, `col_id_10`, `col_id_11`, `col_id_12`, `col_id_13`, `col_id_14`, `col_id_15`, `col_id_16`, `col_id_17`) VALUES
(1, 1, 8, 9, 0, '{filedir_1}thumb-thamesfestival.jpg', 'Thames Festival website screenshot, showing the Thames Festival logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 8, 10, 0, NULL, NULL, '{filedir_1}slide-thamesfestival_01.jpg', 'A screengrab from the Thames Festival website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(3, 1, 8, 10, 1, NULL, NULL, '{filedir_1}slide-thamesfestival_02.jpg', 'A screengrab from the Thames Festival website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(4, 1, 9, 9, 0, '{filedir_1}thumb-cornexchangenew.jpg', 'Screenshot of the front page of the Corn Exchange Newbury website, showing the Corn Exchange Newbury logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 9, 10, 0, NULL, NULL, '{filedir_1}slide-cornexchangenew_01.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(6, 1, 9, 10, 1, NULL, NULL, '{filedir_1}slide-cornexchangenew_02.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(7, 1, 10, 9, 0, '{filedir_1}thumb-immediatetheatre.jpg', 'efwwefwef', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, 10, 10, 0, NULL, NULL, '{filedir_1}slide-immediatetheatre_01.jpg', 'fwefwwe', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, 10, 10, 1, NULL, NULL, '{filedir_1}slide-immediatetheatre_02.jpg', 'wefef', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, 10, 10, 2, NULL, NULL, '{filedir_1}slide-immediatetheatre_03.jpg', 'effef', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, 8, 10, 2, NULL, NULL, '{filedir_1}slide-thamesfestival_03.jpg', 'A screengrab from the Thames Festival website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(12, 1, 8, 10, 3, NULL, NULL, '{filedir_1}slide-thamesfestival_04.jpg', 'A screengrab from the Thames Festival website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(13, 1, 8, 10, 4, NULL, NULL, '{filedir_1}slide-thamesfestival_05.jpg', 'A screengrab from the Thames Festival website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(14, 1, 13, 9, 0, '{filedir_1}thumb-tbai.jpg', 'A screengrab from the Told by an Idiot website', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 1, 13, 10, 0, NULL, NULL, '{filedir_1}slide-tbai_01.jpg', 'A screengrab from the Told by an Idiot website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(16, 1, 13, 10, 1, NULL, NULL, '{filedir_1}slide-tbai_02.jpg', 'A screengrab from the Told by an Idiot website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(17, 1, 13, 10, 2, NULL, NULL, '{filedir_1}slide-tbai_03.jpg', 'A screengrab from the Told by an Idiot website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(18, 1, 13, 10, 3, NULL, NULL, '{filedir_1}slide-tbai_04.jpg', 'A screengrab from the Told by an Idiot website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(19, 1, 14, 9, 0, '{filedir_1}thumb-eea.jpg', 'Screenshot of the EEA website, showing the EEA logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 1, 14, 10, 0, NULL, NULL, '{filedir_1}slide-eea_01.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(21, 1, 14, 10, 1, NULL, NULL, '{filedir_1}slide-eea_02.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(22, 1, 14, 10, 2, NULL, NULL, '{filedir_1}slide-eea_03.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(23, 1, 14, 10, 3, NULL, NULL, '{filedir_1}slide-eea_04.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(24, 1, 15, 9, 0, '{filedir_1}thumb-fst.jpg', 'A screenshot of the FST website showing the FST logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, 15, 10, 0, NULL, NULL, '{filedir_1}slide-fst_01.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(26, 1, 15, 10, 1, NULL, NULL, '{filedir_1}slide-fst_02.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(27, 1, 15, 10, 2, NULL, NULL, '{filedir_1}slide-fst_03.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(28, 1, 15, 10, 3, NULL, NULL, '{filedir_1}slide-fst_04.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(29, 1, 16, 9, 0, '{filedir_1}thumb-ymt.jpg', 'YMT logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 1, 16, 10, 0, NULL, NULL, '{filedir_1}slide-ymt_01.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 1, 16, 10, 1, NULL, NULL, '{filedir_1}slide-ymt_02.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 1, 16, 10, 2, NULL, NULL, '{filedir_1}slide-ymt_03.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 1, 16, 10, 3, NULL, NULL, '{filedir_1}slide-ymt_04.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 1, 17, 9, 0, '{filedir_1}thumb-mosj.jpg', 'A screengrab from the Museum of the Order of St John website', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 1, 17, 10, 0, NULL, NULL, '{filedir_1}slide-mosj_01.jpg', 'A screengrab from the Museum of the Order of St John website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(36, 1, 17, 10, 1, NULL, NULL, '{filedir_1}slide-mosj_02.jpg', 'A screengrab from the Museum of the Order of St John website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(37, 1, 17, 10, 2, NULL, NULL, '{filedir_1}slide-mosj_03.jpg', 'A screengrab from the Museum of the Order of St John website', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(38, 1, 18, 9, 0, '{filedir_1}thumb-doneanddusted.jpg', 'Logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 1, 18, 10, 0, NULL, NULL, '{filedir_1}slide-doneanddusted_01.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(40, 1, 18, 10, 1, NULL, NULL, '{filedir_1}slide-doneanddusted_02.jpg', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(41, 1, 24, 9, 0, '{filedir_1}thumb-iluv2.jpg', 'Logo for the iluv2 website', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 1, 24, 10, 0, NULL, NULL, '{filedir_1}slide-iluv2_01.jpg', 'A screenshot of the homepage', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(43, 1, 24, 10, 1, NULL, NULL, '{filedir_1}slide-iluv2_02.jpg', 'A screenshot of the about section', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(44, 1, 24, 10, 2, NULL, NULL, '{filedir_1}slide-iluv2_03.jpg', 'A screenshot of the submit section', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(45, 1, 24, 10, 3, NULL, NULL, '{filedir_1}slide-iluv2_04.jpg', 'A screenshot of the contact page', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(46, 1, 25, 9, 0, '{filedir_1}thumb-nnf11.jpg', 'Screenshot of the NNF11 site, showing part of the logo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 1, 25, 10, 0, NULL, NULL, '{filedir_1}slide-nnf11_01.jpg', 'Screenshot of the homepage', 'The home page, with featured event', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(48, 1, 25, 10, 1, NULL, NULL, '{filedir_1}slide-nnf11_02.jpg', 'Screenshot of the NNF Live section', 'The NNF Live section, with Flickr pics pulled in', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(49, 1, 25, 10, 2, NULL, NULL, '{filedir_1}slide-nnf11_03.jpg', 'Screenshot of the Your Visit section, showing the map', 'The Your Visit section, with custom Google Map markers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(50, 1, 25, 10, 3, NULL, NULL, '{filedir_1}slide-nnf11_04.jpg', 'Screenshot of the events section, filtered by category', 'The event section, colour-coded by category', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(51, 1, 25, 10, 4, NULL, NULL, '{filedir_1}slide-nnf11_05.jpg', 'Screenshot of an event detail page', 'An event detail page', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(52, 1, 26, 9, 0, '{filedir_1}thumb-cmnmicrosite_appinfuniverse.jpg', 'Screenshot of the Approximately Infinite Universe Microsite, showing part of a stylised eye', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 1, 26, 10, 0, NULL, NULL, '{filedir_1}slide-cmnmicrosite_appinfuniverse_01.jpg', 'Screenshot of the homepage', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(54, 1, 26, 10, 1, NULL, NULL, '{filedir_1}slide-cmnmicrosite_appinfuniverse_02.jpg', 'Screenshot of the tour dates page', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(86, 1, 56, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(87, 1, 56, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(82, 1, 54, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(83, 1, 54, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(84, 1, 55, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(85, 1, 55, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(58, 1, 46, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}artimg-know_your_desc.jpg', 'Screenshot of some nicely done CSS (by yours truly)', 'A little CSS from my site', NULL, NULL, NULL, '', NULL, NULL),
(64, 1, 46, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{filedir_1}tn-artimg-know_your_desc.jpg', 'Screenshot of some nicely done CSS (by yours truly)', '', NULL, '', NULL),
(60, 1, 22, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}artimg-objectifyyourcssh.png', 'Illustration of some lego', '', NULL, NULL, NULL, NULL, NULL, NULL),
(61, 1, 32, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}blogimg-keepingacleansheet.png', 'An illustration of bits of code in a wastebasket', '', NULL, NULL, NULL, '', NULL, NULL),
(62, 1, 23, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}artimg-bulletproof_webfont.png', '', '', NULL, NULL, NULL, '', NULL, NULL),
(63, 1, 20, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}artimg-clarityvssmooth.png', 'An illustration of some boxing gloves', '', NULL, NULL, NULL, '', NULL, NULL),
(65, 1, 49, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}artimg-new_site.jpg', 'A screenshot of my old site', 'The blog page from my old site', NULL, NULL, NULL, 'yes', NULL, NULL),
(66, 1, 49, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{filedir_1}tn-artimg-new_site.jpg', 'A screenshot of my old site', '', NULL, 'yes', NULL),
(67, 1, 20, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(68, 1, 23, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(69, 1, 50, 9, 0, '{filedir_1}slide-nailsinc-couture_01.png', 'The Couture section, seen in all formats', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 1, 50, 10, 0, NULL, NULL, '{filedir_1}slide-nailsinc-couture_01.png', 'The Couture section, seen in all formats', 'The Couture section, adapting to some popular screen sizes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(71, 1, 50, 10, 1, NULL, NULL, '{filedir_1}slide-nailsinc-couture_02.jpg', 'The color picker palette for Couture', 'The color picker', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(72, 1, 32, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(73, 1, 50, 10, 2, NULL, NULL, '{filedir_1}slide-nailsinc-tryiton_01.jpg', 'The Try It on section', 'The Try It on section, with top and base coats applied', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes'),
(74, 1, 51, 9, 0, '{filedir_1}thumb-tangentsnowball.jpg', 'A screengrab of the Tangent Snowball site', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 1, 51, 10, 0, NULL, NULL, '{filedir_1}slide-tangentsnowball_01.jpg', 'The home page', 'The home page, on a desktop', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(76, 1, 51, 10, 1, NULL, NULL, '{filedir_1}slide-tangentsnowball_02.jpg', 'Photo of some persona documents', 'Some persona documents we made for the site', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(77, 1, 51, 10, 2, NULL, NULL, '{filedir_1}slide-tangentsnowball_03.png', 'Screenshot of the site on iPhone', 'The mobile version of the site', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(78, 1, 52, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(79, 1, 52, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(80, 1, 53, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(81, 1, 53, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL),
(88, 1, 57, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(89, 1, 57, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{filedir_1}tn-artimg-fancyabbr.jpg', 'A screengrab of the fancy abbr plugin in action', 'My homepage (in a jazzy colour) showing the fancy abbr script', NULL, '', NULL),
(90, 1, 58, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(91, 1, 58, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{filedir_1}tn-artimg-css3_bcrumbnav.jpg', 'Screengrab of the breadcrumb nav', 'A screengrab of the breadcrumb nav', NULL, 'yes', NULL),
(92, 1, 61, 21, 0, NULL, NULL, NULL, NULL, NULL, '{filedir_1}artimg-fittext.jpg', 'Screenshot of my fittext experiment', 'A screengrab of the demo', NULL, NULL, NULL, 'yes', NULL, NULL),
(93, 1, 61, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{filedir_1}tn-artimg-fittext.jpg', 'Screenshot of my fittext experiment', 'A screengrab of the demo', NULL, 'yes', NULL),
(94, 1, 62, 21, 0, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, '', NULL, NULL),
(95, 1, 62, 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_bulletin_board`
--

CREATE TABLE IF NOT EXISTS `exp_member_bulletin_board` (
  `bulletin_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL,
  `bulletin_group` int(8) unsigned NOT NULL,
  `bulletin_date` int(10) unsigned NOT NULL,
  `hash` varchar(10) NOT NULL DEFAULT '',
  `bulletin_expires` int(10) unsigned NOT NULL DEFAULT '0',
  `bulletin_message` text NOT NULL,
  PRIMARY KEY (`bulletin_id`),
  KEY `sender_id` (`sender_id`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_member_bulletin_board`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_member_data`
--

CREATE TABLE IF NOT EXISTS `exp_member_data` (
  `member_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_data`
--

INSERT INTO `exp_member_data` (`member_id`) VALUES
(1),
(2);

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_fields`
--

CREATE TABLE IF NOT EXISTS `exp_member_fields` (
  `m_field_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `m_field_name` varchar(32) NOT NULL,
  `m_field_label` varchar(50) NOT NULL,
  `m_field_description` text NOT NULL,
  `m_field_type` varchar(12) NOT NULL DEFAULT 'text',
  `m_field_list_items` text NOT NULL,
  `m_field_ta_rows` tinyint(2) DEFAULT '8',
  `m_field_maxl` smallint(3) NOT NULL,
  `m_field_width` varchar(6) NOT NULL,
  `m_field_search` char(1) NOT NULL DEFAULT 'y',
  `m_field_required` char(1) NOT NULL DEFAULT 'n',
  `m_field_public` char(1) NOT NULL DEFAULT 'y',
  `m_field_reg` char(1) NOT NULL DEFAULT 'n',
  `m_field_cp_reg` char(1) NOT NULL DEFAULT 'n',
  `m_field_fmt` char(5) NOT NULL DEFAULT 'none',
  `m_field_order` int(3) unsigned NOT NULL,
  PRIMARY KEY (`m_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_member_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_title` varchar(100) NOT NULL,
  `group_description` text NOT NULL,
  `is_locked` char(1) NOT NULL DEFAULT 'y',
  `can_view_offline_system` char(1) NOT NULL DEFAULT 'n',
  `can_view_online_system` char(1) NOT NULL DEFAULT 'y',
  `can_access_cp` char(1) NOT NULL DEFAULT 'y',
  `can_access_content` char(1) NOT NULL DEFAULT 'n',
  `can_access_publish` char(1) NOT NULL DEFAULT 'n',
  `can_access_edit` char(1) NOT NULL DEFAULT 'n',
  `can_access_files` char(1) NOT NULL DEFAULT 'n',
  `can_access_fieldtypes` char(1) NOT NULL DEFAULT 'n',
  `can_access_design` char(1) NOT NULL DEFAULT 'n',
  `can_access_addons` char(1) NOT NULL DEFAULT 'n',
  `can_access_modules` char(1) NOT NULL DEFAULT 'n',
  `can_access_extensions` char(1) NOT NULL DEFAULT 'n',
  `can_access_accessories` char(1) NOT NULL DEFAULT 'n',
  `can_access_plugins` char(1) NOT NULL DEFAULT 'n',
  `can_access_members` char(1) NOT NULL DEFAULT 'n',
  `can_access_admin` char(1) NOT NULL DEFAULT 'n',
  `can_access_sys_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_access_content_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_access_tools` char(1) NOT NULL DEFAULT 'n',
  `can_access_comm` char(1) NOT NULL DEFAULT 'n',
  `can_access_utilities` char(1) NOT NULL DEFAULT 'n',
  `can_access_data` char(1) NOT NULL DEFAULT 'n',
  `can_access_logs` char(1) NOT NULL DEFAULT 'n',
  `can_admin_channels` char(1) NOT NULL DEFAULT 'n',
  `can_admin_upload_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_admin_design` char(1) NOT NULL DEFAULT 'n',
  `can_admin_members` char(1) NOT NULL DEFAULT 'n',
  `can_delete_members` char(1) NOT NULL DEFAULT 'n',
  `can_admin_mbr_groups` char(1) NOT NULL DEFAULT 'n',
  `can_admin_mbr_templates` char(1) NOT NULL DEFAULT 'n',
  `can_ban_users` char(1) NOT NULL DEFAULT 'n',
  `can_admin_modules` char(1) NOT NULL DEFAULT 'n',
  `can_admin_templates` char(1) NOT NULL DEFAULT 'n',
  `can_admin_accessories` char(1) NOT NULL DEFAULT 'n',
  `can_edit_categories` char(1) NOT NULL DEFAULT 'n',
  `can_delete_categories` char(1) NOT NULL DEFAULT 'n',
  `can_view_other_entries` char(1) NOT NULL DEFAULT 'n',
  `can_edit_other_entries` char(1) NOT NULL DEFAULT 'n',
  `can_assign_post_authors` char(1) NOT NULL DEFAULT 'n',
  `can_delete_self_entries` char(1) NOT NULL DEFAULT 'n',
  `can_delete_all_entries` char(1) NOT NULL DEFAULT 'n',
  `can_view_other_comments` char(1) NOT NULL DEFAULT 'n',
  `can_edit_own_comments` char(1) NOT NULL DEFAULT 'n',
  `can_delete_own_comments` char(1) NOT NULL DEFAULT 'n',
  `can_edit_all_comments` char(1) NOT NULL DEFAULT 'n',
  `can_delete_all_comments` char(1) NOT NULL DEFAULT 'n',
  `can_moderate_comments` char(1) NOT NULL DEFAULT 'n',
  `can_send_email` char(1) NOT NULL DEFAULT 'n',
  `can_send_cached_email` char(1) NOT NULL DEFAULT 'n',
  `can_email_member_groups` char(1) NOT NULL DEFAULT 'n',
  `can_email_mailinglist` char(1) NOT NULL DEFAULT 'n',
  `can_email_from_profile` char(1) NOT NULL DEFAULT 'n',
  `can_view_profiles` char(1) NOT NULL DEFAULT 'n',
  `can_edit_html_buttons` char(1) NOT NULL DEFAULT 'n',
  `can_delete_self` char(1) NOT NULL DEFAULT 'n',
  `mbr_delete_notify_emails` varchar(255) DEFAULT NULL,
  `can_post_comments` char(1) NOT NULL DEFAULT 'n',
  `exclude_from_moderation` char(1) NOT NULL DEFAULT 'n',
  `can_search` char(1) NOT NULL DEFAULT 'n',
  `search_flood_control` mediumint(5) unsigned NOT NULL,
  `can_send_private_messages` char(1) NOT NULL DEFAULT 'n',
  `prv_msg_send_limit` smallint(5) unsigned NOT NULL DEFAULT '20',
  `prv_msg_storage_limit` smallint(5) unsigned NOT NULL DEFAULT '60',
  `can_attach_in_private_messages` char(1) NOT NULL DEFAULT 'n',
  `can_send_bulletins` char(1) NOT NULL DEFAULT 'n',
  `include_in_authorlist` char(1) NOT NULL DEFAULT 'n',
  `include_in_memberlist` char(1) NOT NULL DEFAULT 'y',
  `include_in_mailinglists` char(1) NOT NULL DEFAULT 'y',
  PRIMARY KEY (`group_id`,`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_groups`
--

INSERT INTO `exp_member_groups` (`group_id`, `site_id`, `group_title`, `group_description`, `is_locked`, `can_view_offline_system`, `can_view_online_system`, `can_access_cp`, `can_access_content`, `can_access_publish`, `can_access_edit`, `can_access_files`, `can_access_fieldtypes`, `can_access_design`, `can_access_addons`, `can_access_modules`, `can_access_extensions`, `can_access_accessories`, `can_access_plugins`, `can_access_members`, `can_access_admin`, `can_access_sys_prefs`, `can_access_content_prefs`, `can_access_tools`, `can_access_comm`, `can_access_utilities`, `can_access_data`, `can_access_logs`, `can_admin_channels`, `can_admin_upload_prefs`, `can_admin_design`, `can_admin_members`, `can_delete_members`, `can_admin_mbr_groups`, `can_admin_mbr_templates`, `can_ban_users`, `can_admin_modules`, `can_admin_templates`, `can_admin_accessories`, `can_edit_categories`, `can_delete_categories`, `can_view_other_entries`, `can_edit_other_entries`, `can_assign_post_authors`, `can_delete_self_entries`, `can_delete_all_entries`, `can_view_other_comments`, `can_edit_own_comments`, `can_delete_own_comments`, `can_edit_all_comments`, `can_delete_all_comments`, `can_moderate_comments`, `can_send_email`, `can_send_cached_email`, `can_email_member_groups`, `can_email_mailinglist`, `can_email_from_profile`, `can_view_profiles`, `can_edit_html_buttons`, `can_delete_self`, `mbr_delete_notify_emails`, `can_post_comments`, `exclude_from_moderation`, `can_search`, `search_flood_control`, `can_send_private_messages`, `prv_msg_send_limit`, `prv_msg_storage_limit`, `can_attach_in_private_messages`, `can_send_bulletins`, `include_in_authorlist`, `include_in_memberlist`, `include_in_mailinglists`) VALUES
(1, 1, 'Super Admins', '', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'n', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', '', 'y', 'y', 'y', 0, 'y', 20, 60, 'y', 'y', 'y', 'y', 'y'),
(2, 1, 'Banned', '', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', '', 'n', 'n', 'n', 60, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(3, 1, 'Guests', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'n', 'n', '', 'y', 'n', 'y', 15, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(4, 1, 'Pending', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'n', 'n', '', 'y', 'n', 'y', 15, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(5, 1, 'Members', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'y', 'y', 'n', '', 'y', 'n', 'y', 10, 'y', 20, 60, 'y', 'n', 'n', 'y', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_homepage`
--

CREATE TABLE IF NOT EXISTS `exp_member_homepage` (
  `member_id` int(10) unsigned NOT NULL,
  `recent_entries` char(1) NOT NULL DEFAULT 'l',
  `recent_entries_order` int(3) unsigned NOT NULL DEFAULT '0',
  `recent_comments` char(1) NOT NULL DEFAULT 'l',
  `recent_comments_order` int(3) unsigned NOT NULL DEFAULT '0',
  `recent_members` char(1) NOT NULL DEFAULT 'n',
  `recent_members_order` int(3) unsigned NOT NULL DEFAULT '0',
  `site_statistics` char(1) NOT NULL DEFAULT 'r',
  `site_statistics_order` int(3) unsigned NOT NULL DEFAULT '0',
  `member_search_form` char(1) NOT NULL DEFAULT 'n',
  `member_search_form_order` int(3) unsigned NOT NULL DEFAULT '0',
  `notepad` char(1) NOT NULL DEFAULT 'r',
  `notepad_order` int(3) unsigned NOT NULL DEFAULT '0',
  `bulletin_board` char(1) NOT NULL DEFAULT 'r',
  `bulletin_board_order` int(3) unsigned NOT NULL DEFAULT '0',
  `pmachine_news_feed` char(1) NOT NULL DEFAULT 'n',
  `pmachine_news_feed_order` int(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_homepage`
--

INSERT INTO `exp_member_homepage` (`member_id`, `recent_entries`, `recent_entries_order`, `recent_comments`, `recent_comments_order`, `recent_members`, `recent_members_order`, `site_statistics`, `site_statistics_order`, `member_search_form`, `member_search_form_order`, `notepad`, `notepad_order`, `bulletin_board`, `bulletin_board_order`, `pmachine_news_feed`, `pmachine_news_feed_order`) VALUES
(1, 'l', 1, 'l', 2, 'n', 0, 'r', 1, 'n', 0, 'r', 2, 'r', 0, 'l', 0),
(2, 'l', 0, 'l', 0, 'n', 0, 'r', 0, 'n', 0, 'r', 0, 'r', 0, 'n', 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_search`
--

CREATE TABLE IF NOT EXISTS `exp_member_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `search_date` int(10) unsigned NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `fields` varchar(200) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `total_results` int(8) unsigned NOT NULL,
  `query` text NOT NULL,
  PRIMARY KEY (`search_id`),
  KEY `member_id` (`member_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_search`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_members`
--

CREATE TABLE IF NOT EXISTS `exp_members` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` smallint(4) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `unique_id` varchar(40) NOT NULL,
  `crypt_key` varchar(40) DEFAULT NULL,
  `authcode` varchar(10) DEFAULT NULL,
  `email` varchar(72) NOT NULL,
  `url` varchar(150) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `occupation` varchar(80) DEFAULT NULL,
  `interests` varchar(120) DEFAULT NULL,
  `bday_d` int(2) DEFAULT NULL,
  `bday_m` int(2) DEFAULT NULL,
  `bday_y` int(4) DEFAULT NULL,
  `aol_im` varchar(50) DEFAULT NULL,
  `yahoo_im` varchar(50) DEFAULT NULL,
  `msn_im` varchar(50) DEFAULT NULL,
  `icq` varchar(50) DEFAULT NULL,
  `bio` text,
  `signature` text,
  `avatar_filename` varchar(120) DEFAULT NULL,
  `avatar_width` int(4) unsigned DEFAULT NULL,
  `avatar_height` int(4) unsigned DEFAULT NULL,
  `photo_filename` varchar(120) DEFAULT NULL,
  `photo_width` int(4) unsigned DEFAULT NULL,
  `photo_height` int(4) unsigned DEFAULT NULL,
  `sig_img_filename` varchar(120) DEFAULT NULL,
  `sig_img_width` int(4) unsigned DEFAULT NULL,
  `sig_img_height` int(4) unsigned DEFAULT NULL,
  `ignore_list` text,
  `private_messages` int(4) unsigned NOT NULL DEFAULT '0',
  `accept_messages` char(1) NOT NULL DEFAULT 'y',
  `last_view_bulletins` int(10) NOT NULL DEFAULT '0',
  `last_bulletin_date` int(10) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `join_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_visit` int(10) unsigned NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `total_entries` smallint(5) unsigned NOT NULL DEFAULT '0',
  `total_comments` smallint(5) unsigned NOT NULL DEFAULT '0',
  `total_forum_topics` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_posts` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_forum_post_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_email_date` int(10) unsigned NOT NULL DEFAULT '0',
  `in_authorlist` char(1) NOT NULL DEFAULT 'n',
  `accept_admin_email` char(1) NOT NULL DEFAULT 'y',
  `accept_user_email` char(1) NOT NULL DEFAULT 'y',
  `notify_by_default` char(1) NOT NULL DEFAULT 'y',
  `notify_of_pm` char(1) NOT NULL DEFAULT 'y',
  `display_avatars` char(1) NOT NULL DEFAULT 'y',
  `display_signatures` char(1) NOT NULL DEFAULT 'y',
  `parse_smileys` char(1) NOT NULL DEFAULT 'y',
  `smart_notifications` char(1) NOT NULL DEFAULT 'y',
  `language` varchar(50) NOT NULL,
  `timezone` varchar(8) NOT NULL,
  `daylight_savings` char(1) NOT NULL DEFAULT 'n',
  `localization_is_site_default` char(1) NOT NULL DEFAULT 'n',
  `time_format` char(2) NOT NULL DEFAULT 'us',
  `cp_theme` varchar(32) DEFAULT NULL,
  `profile_theme` varchar(32) DEFAULT NULL,
  `forum_theme` varchar(32) DEFAULT NULL,
  `tracker` text,
  `template_size` varchar(2) NOT NULL DEFAULT '20',
  `notepad` text,
  `notepad_size` varchar(2) NOT NULL DEFAULT '18',
  `quick_links` text,
  `quick_tabs` text,
  `show_sidebar` char(1) NOT NULL DEFAULT 'n',
  `pmember_id` int(10) NOT NULL DEFAULT '0',
  `salt` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`member_id`),
  KEY `group_id` (`group_id`),
  KEY `unique_id` (`unique_id`),
  KEY `password` (`password`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_members`
--

INSERT INTO `exp_members` (`member_id`, `group_id`, `username`, `screen_name`, `password`, `unique_id`, `crypt_key`, `authcode`, `email`, `url`, `location`, `occupation`, `interests`, `bday_d`, `bday_m`, `bday_y`, `aol_im`, `yahoo_im`, `msn_im`, `icq`, `bio`, `signature`, `avatar_filename`, `avatar_width`, `avatar_height`, `photo_filename`, `photo_width`, `photo_height`, `sig_img_filename`, `sig_img_width`, `sig_img_height`, `ignore_list`, `private_messages`, `accept_messages`, `last_view_bulletins`, `last_bulletin_date`, `ip_address`, `join_date`, `last_visit`, `last_activity`, `total_entries`, `total_comments`, `total_forum_topics`, `total_forum_posts`, `last_entry_date`, `last_comment_date`, `last_forum_post_date`, `last_email_date`, `in_authorlist`, `accept_admin_email`, `accept_user_email`, `notify_by_default`, `notify_of_pm`, `display_avatars`, `display_signatures`, `parse_smileys`, `smart_notifications`, `language`, `timezone`, `daylight_savings`, `localization_is_site_default`, `time_format`, `cp_theme`, `profile_theme`, `forum_theme`, `tracker`, `template_size`, `notepad`, `notepad_size`, `quick_links`, `quick_tabs`, `show_sidebar`, `pmember_id`, `salt`) VALUES
(1, 1, 'jack_armley', 'Jack', '3efb37ca6335b3bbada5785ea0a4b2bfd5b845005d3e678c97e7e2853eaacd17915b4c2c8e54807c1c4e7db308b0bb7091a76926649b258e51f824acd3b16aa4', '5b70b59757013c2c57cb261799c30300fbbf2263', '572a321f46dd59f65b91f37269d805946cd7db1b', NULL, 'aloha@jackarmley.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'y', 0, 0, '127.0.0.1', 1303040988, 1329850431, 1329857718, 42, 0, 0, 0, 1329067443, 0, 0, 0, 'n', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'english', 'UTC', 'n', 'n', 'us', NULL, NULL, NULL, NULL, '20', NULL, '18', 'Premailer|http://premailer.dialect.ca/|1', 'Channel Fields|index.php?S=d8e62e3d2a1800ce37c5570afac69742493fdded&amp;D=cp&amp;C=admin_content&M=field_group_management|1', 'y', 0, ':-x8K*NpZ$''|Wc`?yeM(%(Ve>;`V|$"FB\\iFT>#$nG6:W~=tS4D7g*902vZAIKo`.1QnHR7x$L.\\s>''9YvIkF''#o#"W$kyzH5MXVI.~1Y|gu.].$Y^zpcGSU/BC}1e;T'),
(2, 1, 'iphoneuser', 'iPhone user', '641b2dbeac74f789618c11f4fdfde42c820eedbe', '8e37fec7327bd9700190014b10c88c3760165d31', NULL, NULL, 'jack_armley@yahoo.co.uk', '', '', '', '', NULL, NULL, NULL, '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'y', 0, 0, '94.194.134.131', 1310203106, 0, 0, 1, 0, 0, 0, 1329693005, 0, 0, 0, 'n', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'english', 'UTC', 'n', 'n', 'us', NULL, NULL, NULL, NULL, '20', NULL, '18', NULL, NULL, 'n', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_attachments`
--

CREATE TABLE IF NOT EXISTS `exp_message_attachments` (
  `attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_name` varchar(50) NOT NULL DEFAULT '',
  `attachment_hash` varchar(40) NOT NULL DEFAULT '',
  `attachment_extension` varchar(20) NOT NULL DEFAULT '',
  `attachment_location` varchar(150) NOT NULL DEFAULT '',
  `attachment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_size` int(10) unsigned NOT NULL DEFAULT '0',
  `is_temp` char(1) NOT NULL DEFAULT 'y',
  PRIMARY KEY (`attachment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_message_attachments`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_message_copies`
--

CREATE TABLE IF NOT EXISTS `exp_message_copies` (
  `copy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `recipient_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_received` char(1) NOT NULL DEFAULT 'n',
  `message_read` char(1) NOT NULL DEFAULT 'n',
  `message_time_read` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_downloaded` char(1) NOT NULL DEFAULT 'n',
  `message_folder` int(10) unsigned NOT NULL DEFAULT '1',
  `message_authcode` varchar(10) NOT NULL DEFAULT '',
  `message_deleted` char(1) NOT NULL DEFAULT 'n',
  `message_status` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`copy_id`),
  KEY `message_id` (`message_id`),
  KEY `recipient_id` (`recipient_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_message_copies`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_message_data`
--

CREATE TABLE IF NOT EXISTS `exp_message_data` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_date` int(10) unsigned NOT NULL DEFAULT '0',
  `message_subject` varchar(255) NOT NULL DEFAULT '',
  `message_body` text NOT NULL,
  `message_tracking` char(1) NOT NULL DEFAULT 'y',
  `message_attachments` char(1) NOT NULL DEFAULT 'n',
  `message_recipients` varchar(200) NOT NULL DEFAULT '',
  `message_cc` varchar(200) NOT NULL DEFAULT '',
  `message_hide_cc` char(1) NOT NULL DEFAULT 'n',
  `message_sent_copy` char(1) NOT NULL DEFAULT 'n',
  `total_recipients` int(5) unsigned NOT NULL DEFAULT '0',
  `message_status` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_message_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_message_folders`
--

CREATE TABLE IF NOT EXISTS `exp_message_folders` (
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `folder1_name` varchar(50) NOT NULL DEFAULT 'InBox',
  `folder2_name` varchar(50) NOT NULL DEFAULT 'Sent',
  `folder3_name` varchar(50) NOT NULL DEFAULT '',
  `folder4_name` varchar(50) NOT NULL DEFAULT '',
  `folder5_name` varchar(50) NOT NULL DEFAULT '',
  `folder6_name` varchar(50) NOT NULL DEFAULT '',
  `folder7_name` varchar(50) NOT NULL DEFAULT '',
  `folder8_name` varchar(50) NOT NULL DEFAULT '',
  `folder9_name` varchar(50) NOT NULL DEFAULT '',
  `folder10_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_message_folders`
--

INSERT INTO `exp_message_folders` (`member_id`, `folder1_name`, `folder2_name`, `folder3_name`, `folder4_name`, `folder5_name`, `folder6_name`, `folder7_name`, `folder8_name`, `folder9_name`, `folder10_name`) VALUES
(1, 'InBox', 'Sent', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_listed`
--

CREATE TABLE IF NOT EXISTS `exp_message_listed` (
  `listed_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `listed_member` int(10) unsigned NOT NULL DEFAULT '0',
  `listed_description` varchar(100) NOT NULL DEFAULT '',
  `listed_type` varchar(10) NOT NULL DEFAULT 'blocked',
  PRIMARY KEY (`listed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_message_listed`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_metaweblog_api`
--

CREATE TABLE IF NOT EXISTS `exp_metaweblog_api` (
  `metaweblog_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `metaweblog_pref_name` varchar(80) NOT NULL DEFAULT '',
  `metaweblog_parse_type` varchar(1) NOT NULL DEFAULT 'y',
  `entry_status` varchar(50) NOT NULL DEFAULT 'NULL',
  `field_group_id` int(5) unsigned NOT NULL DEFAULT '0',
  `excerpt_field_id` int(7) unsigned NOT NULL DEFAULT '0',
  `content_field_id` int(7) unsigned NOT NULL DEFAULT '0',
  `more_field_id` int(7) unsigned NOT NULL DEFAULT '0',
  `keywords_field_id` int(7) unsigned NOT NULL DEFAULT '0',
  `upload_dir` int(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`metaweblog_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_metaweblog_api`
--

INSERT INTO `exp_metaweblog_api` (`metaweblog_id`, `metaweblog_pref_name`, `metaweblog_parse_type`, `entry_status`, `field_group_id`, `excerpt_field_id`, `content_field_id`, `more_field_id`, `keywords_field_id`, `upload_dir`) VALUES
(1, 'Note', 'y', 'open', 5, 0, 18, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_module_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_module_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `module_id` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_module_member_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_modules`
--

CREATE TABLE IF NOT EXISTS `exp_modules` (
  `module_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) NOT NULL,
  `module_version` varchar(12) NOT NULL,
  `has_cp_backend` char(1) NOT NULL DEFAULT 'n',
  `has_publish_fields` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `exp_modules`
--

INSERT INTO `exp_modules` (`module_id`, `module_name`, `module_version`, `has_cp_backend`, `has_publish_fields`) VALUES
(1, 'Comment', '2.2', 'y', 'n'),
(2, 'Email', '2.0', 'n', 'n'),
(3, 'Emoticon', '2.0', 'n', 'n'),
(4, 'Jquery', '1.0', 'n', 'n'),
(5, 'Pages', '2.2', 'y', 'y'),
(6, 'Rss', '2.0', 'n', 'n'),
(7, 'Search', '2.1', 'n', 'n'),
(8, 'Channel', '2.0.1', 'n', 'n'),
(9, 'Member', '2.1', 'n', 'n'),
(10, 'Stats', '2.0', 'n', 'n'),
(11, 'Wygwam', '2.4.0.2', 'y', 'n'),
(12, 'Navee', '2.0.0', 'y', 'n'),
(13, 'Freeform', '3.0.6', 'y', 'n'),
(14, 'Metaweblog_api', '2.1', 'y', 'n'),
(15, 'iexpression', '1.4.1', 'y', 'n'),
(16, 'Playa', '4.0.4.1', 'n', 'n'),
(17, 'Safecracker', '2.1', 'y', 'n'),
(18, 'Tgl_instagram', '1.0', 'y', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `exp_navee`
--

CREATE TABLE IF NOT EXISTS `exp_navee` (
  `navee_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `navigation_id` int(10) DEFAULT NULL,
  `site_id` int(10) DEFAULT NULL,
  `parent` int(10) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `id` varchar(255) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  `include` tinyint(4) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `dateupdated` datetime DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `member_id` int(10) DEFAULT NULL,
  `rel` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `regex` varchar(255) DEFAULT NULL,
  `entry_id` int(10) DEFAULT NULL,
  `channel_id` int(10) DEFAULT NULL,
  `template` int(10) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `custom` varchar(255) DEFAULT NULL,
  `custom_kids` varchar(255) DEFAULT NULL,
  `passive` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`navee_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_navee`
--

INSERT INTO `exp_navee` (`navee_id`, `navigation_id`, `site_id`, `parent`, `text`, `link`, `class`, `id`, `sort`, `include`, `datecreated`, `dateupdated`, `ip_address`, `member_id`, `rel`, `name`, `target`, `regex`, `entry_id`, `channel_id`, `template`, `type`, `custom`, `custom_kids`, `passive`) VALUES
(1, 1, 1, 0, 'Blog', '/jackarmley/index.php/blog/', '', '', 1, 1, '2011-04-17 13:19:21', '2011-04-17 13:19:21', '127.0.0.1', 1, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 1, 0, 'Work', '/jackarmley/index.php/work/', '', '', 2, 1, '2011-04-17 13:19:48', '2011-04-17 13:19:48', '127.0.0.1', 1, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 1, 0, 'About', '/jackarmley/index.php/about/', '', '', 3, 1, '2011-04-17 13:20:07', '2011-04-17 13:20:07', '127.0.0.1', 1, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, 0, 'Contact', '/jackarmley/index.php/contact/', '', '', 4, 1, '2011-04-17 13:20:32', '2011-04-17 13:20:32', '127.0.0.1', 1, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exp_navee_config`
--

CREATE TABLE IF NOT EXISTS `exp_navee_config` (
  `navee_config_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(10) DEFAULT NULL,
  `k` varchar(255) DEFAULT NULL,
  `v` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`navee_config_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_navee_config`
--

INSERT INTO `exp_navee_config` (`navee_config_id`, `site_id`, `k`, `v`) VALUES
(1, 1, 'stylesheet', 'corporate.css'),
(2, 1, 'include_index', 'false');

-- --------------------------------------------------------

--
-- Table structure for table `exp_navee_members`
--

CREATE TABLE IF NOT EXISTS `exp_navee_members` (
  `navee_mem_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(10) DEFAULT NULL,
  `navee_id` int(10) DEFAULT NULL,
  `members` text,
  PRIMARY KEY (`navee_mem_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_navee_members`
--

INSERT INTO `exp_navee_members` (`navee_mem_id`, `site_id`, `navee_id`, `members`) VALUES
(1, 1, 5, 'a:1:{i:0;s:1:"1";}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_navee_navs`
--

CREATE TABLE IF NOT EXISTS `exp_navee_navs` (
  `navigation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(10) DEFAULT NULL,
  `nav_title` varchar(255) DEFAULT NULL,
  `nav_name` varchar(255) DEFAULT NULL,
  `nav_description` varchar(255) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `dateupdated` datetime DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `member_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`navigation_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_navee_navs`
--

INSERT INTO `exp_navee_navs` (`navigation_id`, `site_id`, `nav_title`, `nav_name`, `nav_description`, `datecreated`, `dateupdated`, `ip_address`, `member_id`) VALUES
(1, 1, 'nav-primary', 'Primary', 'Primary navigation', '2011-04-17 13:18:53', '2011-04-17 13:18:53', '127.0.0.1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_online_users`
--

CREATE TABLE IF NOT EXISTS `exp_online_users` (
  `online_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `in_forum` char(1) NOT NULL DEFAULT 'n',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  `anon` char(1) NOT NULL,
  PRIMARY KEY (`online_id`),
  KEY `date` (`date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8978 ;

--
-- Dumping data for table `exp_online_users`
--

INSERT INTO `exp_online_users` (`online_id`, `site_id`, `member_id`, `in_forum`, `name`, `ip_address`, `date`, `anon`) VALUES
(8970, 1, 1, 'n', 'Jack', '217.205.197.194', 1329850557, ''),
(8969, 1, 0, 'n', '', '74.73.253.85', 1329850098, ''),
(8968, 1, 0, 'n', '', '217.205.197.194', 1329851075, ''),
(8966, 1, 0, 'n', '', '217.205.197.194', 1329851075, ''),
(8971, 1, 0, 'n', '', '217.205.197.194', 1329851075, ''),
(8972, 1, 0, 'n', '', '121.138.115.152', 1329852596, ''),
(8973, 1, 0, 'n', '', '217.205.197.194', 1329854171, ''),
(8974, 1, 0, 'n', '', '75.144.21.113', 1329854198, ''),
(8975, 1, 0, 'n', '', '123.125.71.109', 1329856416, ''),
(8976, 1, 0, 'n', '', '220.181.108.168', 1329856455, ''),
(8977, 1, 0, 'n', '', '94.194.134.131', 1329857839, ''),
(8967, 1, 0, 'n', '', '217.205.197.194', 1329851075, '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_pages_configuration`
--

CREATE TABLE IF NOT EXISTS `exp_pages_configuration` (
  `configuration_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(8) unsigned NOT NULL DEFAULT '1',
  `configuration_name` varchar(60) NOT NULL,
  `configuration_value` varchar(100) NOT NULL,
  PRIMARY KEY (`configuration_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_pages_configuration`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_password_lockout`
--

CREATE TABLE IF NOT EXISTS `exp_password_lockout` (
  `lockout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login_date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`lockout_id`),
  KEY `login_date` (`login_date`),
  KEY `ip_address` (`ip_address`),
  KEY `user_agent` (`user_agent`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `exp_password_lockout`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_ping_servers`
--

CREATE TABLE IF NOT EXISTS `exp_ping_servers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `server_name` varchar(32) NOT NULL,
  `server_url` varchar(150) NOT NULL,
  `port` varchar(4) NOT NULL DEFAULT '80',
  `ping_protocol` varchar(12) NOT NULL DEFAULT 'xmlrpc',
  `is_default` char(1) NOT NULL DEFAULT 'y',
  `server_order` int(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_ping_servers`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_playa_relationships`
--

CREATE TABLE IF NOT EXISTS `exp_playa_relationships` (
  `rel_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_entry_id` int(10) unsigned DEFAULT NULL,
  `parent_field_id` int(6) unsigned DEFAULT NULL,
  `parent_col_id` int(6) unsigned DEFAULT NULL,
  `parent_row_id` int(10) unsigned DEFAULT NULL,
  `child_entry_id` int(10) unsigned DEFAULT NULL,
  `rel_order` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`rel_id`),
  KEY `parent_entry_id` (`parent_entry_id`),
  KEY `parent_field_id` (`parent_field_id`),
  KEY `parent_col_id` (`parent_col_id`),
  KEY `parent_row_id` (`parent_row_id`),
  KEY `child_entry_id` (`child_entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_playa_relationships`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_relationships`
--

CREATE TABLE IF NOT EXISTS `exp_relationships` (
  `rel_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `rel_parent_id` int(10) NOT NULL DEFAULT '0',
  `rel_child_id` int(10) NOT NULL DEFAULT '0',
  `rel_type` varchar(12) NOT NULL,
  `rel_data` mediumtext NOT NULL,
  `reverse_rel_data` mediumtext NOT NULL,
  PRIMARY KEY (`rel_id`),
  KEY `rel_parent_id` (`rel_parent_id`),
  KEY `rel_child_id` (`rel_child_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_relationships`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_remember_me`
--

CREATE TABLE IF NOT EXISTS `exp_remember_me` (
  `remember_me_id` varchar(40) NOT NULL DEFAULT '0',
  `member_id` int(10) DEFAULT '0',
  `ip_address` varchar(16) DEFAULT '0',
  `user_agent` varchar(120) DEFAULT '',
  `admin_sess` tinyint(1) DEFAULT '0',
  `site_id` int(4) DEFAULT '1',
  `expiration` int(10) DEFAULT '0',
  `last_refresh` int(10) DEFAULT '0',
  PRIMARY KEY (`remember_me_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_remember_me`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_reset_password`
--

CREATE TABLE IF NOT EXISTS `exp_reset_password` (
  `reset_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `resetcode` varchar(12) NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY (`reset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_reset_password`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_revision_tracker`
--

CREATE TABLE IF NOT EXISTS `exp_revision_tracker` (
  `tracker_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `item_table` varchar(20) NOT NULL,
  `item_field` varchar(20) NOT NULL,
  `item_date` int(10) NOT NULL,
  `item_author_id` int(10) unsigned NOT NULL,
  `item_data` mediumtext NOT NULL,
  PRIMARY KEY (`tracker_id`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_revision_tracker`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_search`
--

CREATE TABLE IF NOT EXISTS `exp_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) NOT NULL DEFAULT '1',
  `search_date` int(10) NOT NULL,
  `keywords` varchar(60) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `total_results` int(6) NOT NULL,
  `per_page` tinyint(3) unsigned NOT NULL,
  `query` longtext,
  `custom_fields` longtext,
  `result_page` varchar(70) NOT NULL,
  PRIMARY KEY (`search_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_search`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_search_log`
--

CREATE TABLE IF NOT EXISTS `exp_search_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) unsigned NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `search_date` int(10) NOT NULL,
  `search_type` varchar(32) NOT NULL,
  `search_terms` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_search_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_security_hashes`
--

CREATE TABLE IF NOT EXISTS `exp_security_hashes` (
  `hash_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `hash` varchar(40) NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7663 ;

--
-- Dumping data for table `exp_security_hashes`
--

INSERT INTO `exp_security_hashes` (`hash_id`, `date`, `ip_address`, `hash`) VALUES
(7662, 1329857834, '94.194.134.131', 'ba161cd7a33399652ff6a51cb5ace0abc12f72e2'),
(7661, 1329857832, '94.194.134.131', '60b7e7e987eba70f8ba5896a47eeee11cb498364'),
(7660, 1329857832, '94.194.134.131', '7f43cc76c651f730c69865b1225bafa9886ae832'),
(7659, 1329857827, '94.194.134.131', '96b6ff96701c2d8d5b3646c41337d77f8cd9c8ba'),
(7657, 1329857813, '94.194.134.131', '5595f99b528cbdf1ea921816f9c5105d5e6326e0'),
(7658, 1329857826, '94.194.134.131', 'a8fec13fdb821214496cf7766540d390a066279b'),
(7656, 1329857802, '94.194.134.131', 'aec56a424084e7f5b4f47a4b1da82b2625e7d8e3'),
(7655, 1329857801, '94.194.134.131', '3566104a2ede9b5813a6af8df1a270ea6aa8d45b'),
(7654, 1329857778, '94.194.134.131', '6999eed23d1ee0c62119427404141b6015fdc4f6'),
(7653, 1329857777, '94.194.134.131', 'db804d6b2be6bd11744b290539edf08838136a14'),
(7652, 1329857776, '94.194.134.131', '82e3990f42203775390f4ce471646f60b9db770b'),
(7651, 1329857771, '94.194.134.131', 'ebef9a8166d1fa39119d7b0a30498c30608b2d62'),
(7650, 1329857771, '94.194.134.131', 'b8e8bcd2ffcab110b95ad31466ebb1f422757e02'),
(7646, 1329857756, '94.194.134.131', 'bca40c54c3d2ea29b50bfb0e803efc8f2fb05cf7'),
(7647, 1329857758, '94.194.134.131', '25dcaed02db295dea51eb532d1f8b6d9b293e9c9'),
(7648, 1329857758, '94.194.134.131', '87538f106db7cc79c6e8b98533268d169dd79397'),
(7649, 1329857767, '94.194.134.131', '0ed3dd83c1ac5341d1897bb3e899a6e809aa59db'),
(7645, 1329857755, '94.194.134.131', '0e8740ab5a2db9a7a6e2482fa8ae88d1108e4af8'),
(7644, 1329857754, '94.194.134.131', 'e174c23a773cfec401c6d7f90940872d412fa00a'),
(7643, 1329857750, '94.194.134.131', '1ed911fb4ebadc2250163b3ab8ea186c87e7a76b'),
(7642, 1329857749, '94.194.134.131', '1b0d508cc90f4f9cc4b0d21f7a7229e879a820d3'),
(7641, 1329857746, '94.194.134.131', 'be94e6e432711970ee871352c9a9d6dc118d438d'),
(7640, 1329857740, '94.194.134.131', '9e70ed386304016e7dae693c763d0f6c4c203b11'),
(7639, 1329857740, '94.194.134.131', '1a6e4e490d8b9c5e698d443c77a4be13fb248ea6'),
(7638, 1329857735, '94.194.134.131', '0b0676278337327790017f01b19525e72182da84'),
(7632, 1329854192, '217.205.197.194', '35c6dc3afebf2fc2b0c5b4fe38a5baf69baee262'),
(7633, 1329854208, '217.205.197.194', 'b4419bb31f9258a06f33dafe5ddfe8f31334b1c0'),
(7634, 1329854216, '217.205.197.194', '40e609a6280e9a2031b804ded875d104a0aecb33'),
(7635, 1329857710, '94.194.134.131', 'be2abe122674261e5f8fee34df2399f4724d43ee'),
(7636, 1329857717, '94.194.134.131', 'b74c6cb0ee6f282f699ebbcdbb3cc72f7055e85c'),
(7637, 1329857718, '94.194.134.131', 'd1b5e11df1ed56290535d2410ff279ca1eab4d35'),
(7631, 1329854191, '217.205.197.194', 'ee16ecbd24ceb6a35219dccd557ab7e937eabcf6'),
(7630, 1329854189, '217.205.197.194', '36cb77a73b3d6628e376419166c1de1ac37a05c3'),
(7629, 1329850445, '217.205.197.194', '1e742927b323ffbc43b401530399fef802210350'),
(7628, 1329850431, '217.205.197.194', 'ff15110235da93a4aa9f8267e5d431a4d546d227'),
(7627, 1329850430, '217.205.197.194', 'fb131c9e6db056bf282de8a85b4d534507605654'),
(7626, 1329850427, '217.205.197.194', '6945caac7423096afbc00579bb2b3ae4747b35c0');

-- --------------------------------------------------------

--
-- Table structure for table `exp_sessions`
--

CREATE TABLE IF NOT EXISTS `exp_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `admin_sess` tinyint(1) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) DEFAULT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`),
  KEY `member_id` (`member_id`),
  KEY `site_id` (`site_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_sessions`
--

INSERT INTO `exp_sessions` (`session_id`, `site_id`, `member_id`, `admin_sess`, `ip_address`, `user_agent`, `last_activity`) VALUES
('b9a689b8ec1375e15d75a9193bf052d0e881d2f8', 1, 1, 1, '217.205.197.194', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:10.0.2) Gecko/20100101 Firefox/10.0.2', 1329854216);

-- --------------------------------------------------------

--
-- Table structure for table `exp_sites`
--

CREATE TABLE IF NOT EXISTS `exp_sites` (
  `site_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `site_label` varchar(100) NOT NULL DEFAULT '',
  `site_name` varchar(50) NOT NULL DEFAULT '',
  `site_description` text,
  `site_system_preferences` text NOT NULL,
  `site_mailinglist_preferences` text NOT NULL,
  `site_member_preferences` text NOT NULL,
  `site_template_preferences` text NOT NULL,
  `site_channel_preferences` text NOT NULL,
  `site_bootstrap_checksums` text NOT NULL,
  `site_pages` text NOT NULL,
  PRIMARY KEY (`site_id`),
  KEY `site_name` (`site_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_sites`
--

INSERT INTO `exp_sites` (`site_id`, `site_label`, `site_name`, `site_description`, `site_system_preferences`, `site_mailinglist_preferences`, `site_member_preferences`, `site_template_preferences`, `site_channel_preferences`, `site_bootstrap_checksums`, `site_pages`) VALUES
(1, 'Jack Armley', 'default_site', NULL, 'YTo5MDp7czoxMDoic2l0ZV9pbmRleCI7czowOiIiO3M6ODoic2l0ZV91cmwiO3M6MjY6Imh0dHA6Ly93d3cuamFja2FybWxleS5jb20vIjtzOjE2OiJ0aGVtZV9mb2xkZXJfdXJsIjtzOjMzOiJodHRwOi8vd3d3LmphY2thcm1sZXkuY29tL3RoZW1lcy8iO3M6MTU6IndlYm1hc3Rlcl9lbWFpbCI7czoyMjoiYWxvaGFAamFja2FybWxleS5jby51ayI7czoxNDoid2VibWFzdGVyX25hbWUiO3M6MDoiIjtzOjIwOiJjaGFubmVsX25vbWVuY2xhdHVyZSI7czo3OiJjaGFubmVsIjtzOjEwOiJtYXhfY2FjaGVzIjtzOjM6IjE1MCI7czoxMToiY2FwdGNoYV91cmwiO3M6NDQ6Imh0dHA6Ly9sb2NhbGhvc3QvamFja2FybWxleS9pbWFnZXMvY2FwdGNoYXMvIjtzOjEyOiJjYXB0Y2hhX3BhdGgiO3M6NDM6IkM6XHhhbXBwXGh0ZG9jc1xqYWNrYXJtbGV5XGltYWdlc1xjYXB0Y2hhc1wiO3M6MTI6ImNhcHRjaGFfZm9udCI7czoxOiJ5IjtzOjEyOiJjYXB0Y2hhX3JhbmQiO3M6MToieSI7czoyMzoiY2FwdGNoYV9yZXF1aXJlX21lbWJlcnMiO3M6MToibiI7czoxNzoiZW5hYmxlX2RiX2NhY2hpbmciO3M6MToibiI7czoxODoiZW5hYmxlX3NxbF9jYWNoaW5nIjtzOjE6Im4iO3M6MTg6ImZvcmNlX3F1ZXJ5X3N0cmluZyI7czoxOiJuIjtzOjEzOiJzaG93X3Byb2ZpbGVyIjtzOjE6Im4iO3M6MTg6InRlbXBsYXRlX2RlYnVnZ2luZyI7czoxOiJuIjtzOjE1OiJpbmNsdWRlX3NlY29uZHMiO3M6MToibiI7czoxMzoiY29va2llX2RvbWFpbiI7czowOiIiO3M6MTE6ImNvb2tpZV9wYXRoIjtzOjA6IiI7czoxNzoidXNlcl9zZXNzaW9uX3R5cGUiO3M6MToiYyI7czoxODoiYWRtaW5fc2Vzc2lvbl90eXBlIjtzOjI6ImNzIjtzOjIxOiJhbGxvd191c2VybmFtZV9jaGFuZ2UiO3M6MToieSI7czoxODoiYWxsb3dfbXVsdGlfbG9naW5zIjtzOjE6InkiO3M6MTY6InBhc3N3b3JkX2xvY2tvdXQiO3M6MToieSI7czoyNToicGFzc3dvcmRfbG9ja291dF9pbnRlcnZhbCI7czoxOiIxIjtzOjIwOiJyZXF1aXJlX2lwX2Zvcl9sb2dpbiI7czoxOiJ5IjtzOjIyOiJyZXF1aXJlX2lwX2Zvcl9wb3N0aW5nIjtzOjE6InkiO3M6MjQ6InJlcXVpcmVfc2VjdXJlX3Bhc3N3b3JkcyI7czoxOiJuIjtzOjE5OiJhbGxvd19kaWN0aW9uYXJ5X3B3IjtzOjE6InkiO3M6MjM6Im5hbWVfb2ZfZGljdGlvbmFyeV9maWxlIjtzOjA6IiI7czoxNzoieHNzX2NsZWFuX3VwbG9hZHMiO3M6MToieSI7czoxNToicmVkaXJlY3RfbWV0aG9kIjtzOjc6InJlZnJlc2giO3M6OToiZGVmdF9sYW5nIjtzOjc6ImVuZ2xpc2giO3M6ODoieG1sX2xhbmciO3M6MjoiZW4iO3M6MTI6InNlbmRfaGVhZGVycyI7czoxOiJ5IjtzOjExOiJnemlwX291dHB1dCI7czoxOiJuIjtzOjEzOiJsb2dfcmVmZXJyZXJzIjtzOjE6Im4iO3M6MTM6Im1heF9yZWZlcnJlcnMiO3M6MzoiNTAwIjtzOjExOiJ0aW1lX2Zvcm1hdCI7czoyOiJ1cyI7czoxNToic2VydmVyX3RpbWV6b25lIjtzOjM6IlVUQyI7czoxMzoic2VydmVyX29mZnNldCI7czowOiIiO3M6MTY6ImRheWxpZ2h0X3NhdmluZ3MiO3M6MToibiI7czoyMToiZGVmYXVsdF9zaXRlX3RpbWV6b25lIjtzOjM6IlVUQyI7czoxNjoiZGVmYXVsdF9zaXRlX2RzdCI7czoxOiJuIjtzOjE1OiJob25vcl9lbnRyeV9kc3QiO3M6MToieSI7czoxMzoibWFpbF9wcm90b2NvbCI7czo0OiJtYWlsIjtzOjExOiJzbXRwX3NlcnZlciI7czowOiIiO3M6MTM6InNtdHBfdXNlcm5hbWUiO3M6MDoiIjtzOjEzOiJzbXRwX3Bhc3N3b3JkIjtzOjA6IiI7czoxMToiZW1haWxfZGVidWciO3M6MToibiI7czoxMzoiZW1haWxfY2hhcnNldCI7czo1OiJ1dGYtOCI7czoxNToiZW1haWxfYmF0Y2htb2RlIjtzOjE6Im4iO3M6MTY6ImVtYWlsX2JhdGNoX3NpemUiO3M6MDoiIjtzOjExOiJtYWlsX2Zvcm1hdCI7czo1OiJwbGFpbiI7czo5OiJ3b3JkX3dyYXAiO3M6MToieSI7czoyMjoiZW1haWxfY29uc29sZV90aW1lbG9jayI7czoxOiI1IjtzOjIyOiJsb2dfZW1haWxfY29uc29sZV9tc2dzIjtzOjE6InkiO3M6ODoiY3BfdGhlbWUiO3M6NzoiZGVmYXVsdCI7czoyMToiZW1haWxfbW9kdWxlX2NhcHRjaGFzIjtzOjE6Im4iO3M6MTY6ImxvZ19zZWFyY2hfdGVybXMiO3M6MToieSI7czoxMjoic2VjdXJlX2Zvcm1zIjtzOjE6InkiO3M6MTk6ImRlbnlfZHVwbGljYXRlX2RhdGEiO3M6MToieSI7czoyNDoicmVkaXJlY3Rfc3VibWl0dGVkX2xpbmtzIjtzOjE6Im4iO3M6MTY6ImVuYWJsZV9jZW5zb3JpbmciO3M6MToibiI7czoxNDoiY2Vuc29yZWRfd29yZHMiO3M6MDoiIjtzOjE4OiJjZW5zb3JfcmVwbGFjZW1lbnQiO3M6MDoiIjtzOjEwOiJiYW5uZWRfaXBzIjtzOjA6IiI7czoxMzoiYmFubmVkX2VtYWlscyI7czowOiIiO3M6MTY6ImJhbm5lZF91c2VybmFtZXMiO3M6MDoiIjtzOjE5OiJiYW5uZWRfc2NyZWVuX25hbWVzIjtzOjA6IiI7czoxMDoiYmFuX2FjdGlvbiI7czo4OiJyZXN0cmljdCI7czoxMToiYmFuX21lc3NhZ2UiO3M6MzQ6IlRoaXMgc2l0ZSBpcyBjdXJyZW50bHkgdW5hdmFpbGFibGUiO3M6MTU6ImJhbl9kZXN0aW5hdGlvbiI7czoyMToiaHR0cDovL3d3dy55YWhvby5jb20vIjtzOjE2OiJlbmFibGVfZW1vdGljb25zIjtzOjE6InkiO3M6MTM6ImVtb3RpY29uX3BhdGgiO3M6NDM6Imh0dHA6Ly9sb2NhbGhvc3QvamFja2FybWxleS9pbWFnZXMvc21pbGV5cy8iO3M6MTk6InJlY291bnRfYmF0Y2hfdG90YWwiO3M6NDoiMTAwMCI7czoxNzoibmV3X3ZlcnNpb25fY2hlY2siO3M6MToieSI7czoxNzoiZW5hYmxlX3Rocm90dGxpbmciO3M6MToibiI7czoxNzoiYmFuaXNoX21hc2tlZF9pcHMiO3M6MToieSI7czoxNDoibWF4X3BhZ2VfbG9hZHMiO3M6MjoiMTAiO3M6MTM6InRpbWVfaW50ZXJ2YWwiO3M6MToiOCI7czoxMjoibG9ja291dF90aW1lIjtzOjI6IjMwIjtzOjE1OiJiYW5pc2htZW50X3R5cGUiO3M6NzoibWVzc2FnZSI7czoxNDoiYmFuaXNobWVudF91cmwiO3M6MDoiIjtzOjE4OiJiYW5pc2htZW50X21lc3NhZ2UiO3M6NTA6IllvdSBoYXZlIGV4Y2VlZGVkIHRoZSBhbGxvd2VkIHBhZ2UgbG9hZCBmcmVxdWVuY3kuIjtzOjE3OiJlbmFibGVfc2VhcmNoX2xvZyI7czoxOiJ5IjtzOjE5OiJtYXhfbG9nZ2VkX3NlYXJjaGVzIjtzOjM6IjUwMCI7czoxNzoidGhlbWVfZm9sZGVyX3BhdGgiO3M6NDE6Ii9ob21lL2phY2thcm1sZXkxNi9qYWNrYXJtbGV5LmNvbS90aGVtZXMvIjtzOjEwOiJpc19zaXRlX29uIjtzOjE6InkiO30=', 'YTozOntzOjE5OiJtYWlsaW5nbGlzdF9lbmFibGVkIjtzOjE6InkiO3M6MTg6Im1haWxpbmdsaXN0X25vdGlmeSI7czoxOiJuIjtzOjI1OiJtYWlsaW5nbGlzdF9ub3RpZnlfZW1haWxzIjtzOjA6IiI7fQ==', 'YTo0NDp7czoxMDoidW5fbWluX2xlbiI7czoxOiI0IjtzOjEwOiJwd19taW5fbGVuIjtzOjE6IjUiO3M6MjU6ImFsbG93X21lbWJlcl9yZWdpc3RyYXRpb24iO3M6MToibiI7czoyNToiYWxsb3dfbWVtYmVyX2xvY2FsaXphdGlvbiI7czoxOiJ5IjtzOjE4OiJyZXFfbWJyX2FjdGl2YXRpb24iO3M6NToiZW1haWwiO3M6MjM6Im5ld19tZW1iZXJfbm90aWZpY2F0aW9uIjtzOjE6Im4iO3M6MjM6Im1icl9ub3RpZmljYXRpb25fZW1haWxzIjtzOjA6IiI7czoyNDoicmVxdWlyZV90ZXJtc19vZl9zZXJ2aWNlIjtzOjE6InkiO3M6MjI6InVzZV9tZW1iZXJzaGlwX2NhcHRjaGEiO3M6MToibiI7czoyMDoiZGVmYXVsdF9tZW1iZXJfZ3JvdXAiO3M6MToiNSI7czoxNToicHJvZmlsZV90cmlnZ2VyIjtzOjY6Im1lbWJlciI7czoxMjoibWVtYmVyX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MTQ6ImVuYWJsZV9hdmF0YXJzIjtzOjE6InkiO3M6MjA6ImFsbG93X2F2YXRhcl91cGxvYWRzIjtzOjE6InkiO3M6MTA6ImF2YXRhcl91cmwiO3M6NDM6Imh0dHA6Ly9sb2NhbGhvc3QvamFja2FybWxleS9pbWFnZXMvYXZhdGFycy8iO3M6MTE6ImF2YXRhcl9wYXRoIjtzOjQyOiJDOi94YW1wcC9odGRvY3MvamFja2FybWxleS9pbWFnZXMvYXZhdGFycy8iO3M6MTY6ImF2YXRhcl9tYXhfd2lkdGgiO3M6MzoiNDAwIjtzOjE3OiJhdmF0YXJfbWF4X2hlaWdodCI7czozOiI0MDAiO3M6MTM6ImF2YXRhcl9tYXhfa2IiO3M6MjoiNTAiO3M6MTM6ImVuYWJsZV9waG90b3MiO3M6MToibiI7czo5OiJwaG90b191cmwiO3M6NDk6Imh0dHA6Ly9sb2NhbGhvc3QvamFja2FybWxleS9pbWFnZXMvbWVtYmVyX3Bob3Rvcy8iO3M6MTA6InBob3RvX3BhdGgiO3M6NDg6IkM6L3hhbXBwL2h0ZG9jcy9qYWNrYXJtbGV5L2ltYWdlcy9tZW1iZXJfcGhvdG9zLyI7czoxNToicGhvdG9fbWF4X3dpZHRoIjtzOjM6IjEwMCI7czoxNjoicGhvdG9fbWF4X2hlaWdodCI7czozOiIxMDAiO3M6MTI6InBob3RvX21heF9rYiI7czoyOiI1MCI7czoxNjoiYWxsb3dfc2lnbmF0dXJlcyI7czoxOiJ5IjtzOjEzOiJzaWdfbWF4bGVuZ3RoIjtzOjM6IjUwMCI7czoyMToic2lnX2FsbG93X2ltZ19ob3RsaW5rIjtzOjE6Im4iO3M6MjA6InNpZ19hbGxvd19pbWdfdXBsb2FkIjtzOjE6Im4iO3M6MTE6InNpZ19pbWdfdXJsIjtzOjU3OiJodHRwOi8vbG9jYWxob3N0L2phY2thcm1sZXkvaW1hZ2VzL3NpZ25hdHVyZV9hdHRhY2htZW50cy8iO3M6MTI6InNpZ19pbWdfcGF0aCI7czo1NjoiQzoveGFtcHAvaHRkb2NzL2phY2thcm1sZXkvaW1hZ2VzL3NpZ25hdHVyZV9hdHRhY2htZW50cy8iO3M6MTc6InNpZ19pbWdfbWF4X3dpZHRoIjtzOjM6IjQ4MCI7czoxODoic2lnX2ltZ19tYXhfaGVpZ2h0IjtzOjI6IjgwIjtzOjE0OiJzaWdfaW1nX21heF9rYiI7czoyOiIzMCI7czoxOToicHJ2X21zZ191cGxvYWRfcGF0aCI7czo0OToiQzoveGFtcHAvaHRkb2NzL2phY2thcm1sZXkvaW1hZ2VzL3BtX2F0dGFjaG1lbnRzLyI7czoyMzoicHJ2X21zZ19tYXhfYXR0YWNobWVudHMiO3M6MToiMyI7czoyMjoicHJ2X21zZ19hdHRhY2hfbWF4c2l6ZSI7czozOiIyNTAiO3M6MjA6InBydl9tc2dfYXR0YWNoX3RvdGFsIjtzOjM6IjEwMCI7czoxOToicHJ2X21zZ19odG1sX2Zvcm1hdCI7czo0OiJzYWZlIjtzOjE4OiJwcnZfbXNnX2F1dG9fbGlua3MiO3M6MToieSI7czoxNzoicHJ2X21zZ19tYXhfY2hhcnMiO3M6NDoiNjAwMCI7czoxOToibWVtYmVybGlzdF9vcmRlcl9ieSI7czoxMToidG90YWxfcG9zdHMiO3M6MjE6Im1lbWJlcmxpc3Rfc29ydF9vcmRlciI7czo0OiJkZXNjIjtzOjIwOiJtZW1iZXJsaXN0X3Jvd19saW1pdCI7czoyOiIyMCI7fQ==', 'YTo2OntzOjExOiJzdHJpY3RfdXJscyI7czoxOiJ5IjtzOjg6InNpdGVfNDA0IjtzOjk6IjQwNC9pbmRleCI7czoxOToic2F2ZV90bXBsX3JldmlzaW9ucyI7czoxOiJuIjtzOjE4OiJtYXhfdG1wbF9yZXZpc2lvbnMiO3M6MToiNSI7czoxNToic2F2ZV90bXBsX2ZpbGVzIjtzOjE6InkiO3M6MTg6InRtcGxfZmlsZV9iYXNlcGF0aCI7czo2NzoiL2hvbWUvamFja2FybWxleTE2L2phY2thcm1sZXkuY29tL2Vlc3lzL2V4cHJlc3Npb25lbmdpbmUvdGVtcGxhdGVzLyI7fQ==', 'YTo5OntzOjIxOiJpbWFnZV9yZXNpemVfcHJvdG9jb2wiO3M6MzoiZ2QyIjtzOjE4OiJpbWFnZV9saWJyYXJ5X3BhdGgiO3M6MDoiIjtzOjE2OiJ0aHVtYm5haWxfcHJlZml4IjtzOjU6InRodW1iIjtzOjE0OiJ3b3JkX3NlcGFyYXRvciI7czoxMDoidW5kZXJzY29yZSI7czoxNzoidXNlX2NhdGVnb3J5X25hbWUiO3M6MToibiI7czoyMjoicmVzZXJ2ZWRfY2F0ZWdvcnlfd29yZCI7czo4OiJjYXRlZ29yeSI7czoyMzoiYXV0b19jb252ZXJ0X2hpZ2hfYXNjaWkiO3M6MToibiI7czoyMjoibmV3X3Bvc3RzX2NsZWFyX2NhY2hlcyI7czoxOiJ5IjtzOjIzOiJhdXRvX2Fzc2lnbl9jYXRfcGFyZW50cyI7czoxOiJ5Ijt9', 'YToyOntzOjQzOiIvaG9tZS9qYWNrYXJtbGV5MTYvamFja2FybWxleS5jb20vaW5kZXgucGhwIjtzOjMyOiI2OTFiNTVkMjdjYzIxOWIyMzQyZGYyMTNjZjRiZjdkNiI7czo3OiJlbWFpbGVkIjthOjA6e319', 'YToxOntpOjE7YTozOntzOjM6InVybCI7czoyNjoiaHR0cDovL3d3dy5qYWNrYXJtbGV5LmNvbS8iO3M6NDoidXJpcyI7YTowOnt9czo5OiJ0ZW1wbGF0ZXMiO2E6MDp7fX19');

-- --------------------------------------------------------

--
-- Table structure for table `exp_snippets`
--

CREATE TABLE IF NOT EXISTS `exp_snippets` (
  `snippet_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) NOT NULL,
  `snippet_name` varchar(75) NOT NULL,
  `snippet_contents` text,
  PRIMARY KEY (`snippet_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_snippets`
--

INSERT INTO `exp_snippets` (`snippet_id`, `site_id`, `snippet_name`, `snippet_contents`) VALUES
(4, 1, 'sn-header_pri', '<header id="gl-header_pri" role="banner" class="clearfix">\n	{if segment_1!=""}\n		<h1><a href="{path=''/''}"><span>Jack Armley</span></a></h1>\n	{/if}\n	{if segment_1==""}\n		<h1><span>Jack Armley</span></h1>\n	{/if}\n	<nav role="navigation" id="gl-nav_pri">\n		<ul>\n			<li><a href="{path=''articles/''}">Articles</a></li>\n			<li><a href="{path=''work/''}">Work</a></li>\n			<li><a href="{path=''is/''}">Me</a></li>\n			<li><a href="{path=''contact/''}">Contact</a></li>\n		</ul>\n	</nav>	\n</header>'),
(3, 1, 'sn-head_meta', '<meta name="viewport" content="width=device-width,user-scalable=no, scale=1, maximum-scale=1.0" />\n<link rel="shortcut icon" href="{site_url}v2/assets/images/favicon.ico" />\n<link rel="apple-touch-icon-precomposed" href="{site_url}v2/assets/images/appletouch_icon.png" />\n<!--[if lt IE 9]>\n	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>	\n	<link rel="stylesheet" href="{site_url}v2/css/screen.css" media="screen" />\n	<link rel="stylesheet" href="{site_url}v2/css/mobile.css" media="screen" />\n<![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> \n	<link rel="stylesheet" href="{site_url}v2/css/screen.css" media="screen" />\n<!--<![endif]-->\n<link rel="stylesheet" href="{site_url}v2/css/print.css" media="print" />\n<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>\n<script src="{site_url}v2/scripts/mysite.js"></script>\n<script>\n  var _gaq = _gaq || [];\n  _gaq.push([''_setAccount'', ''UA-19743700-1'']);\n  _gaq.push([''_trackPageview'']);\n  (function() {\n    var ga = document.createElement(''script''); ga.type = ''text/javascript''; ga.async = true;\n    ga.src = (''https:'' == document.location.protocol ? ''https://ssl'' : ''http://www'') + ''.google-analytics.com/ga.js'';\n    var s = document.getElementsByTagName(''script'')[0]; s.parentNode.insertBefore(ga, s);\n  })();\n</script>'),
(5, 1, 'sn-page_footer', '<footer id="gl-page_footer" class="clearfix">\n	<section class="mod-gridunit gu-float gu-four">\n		<h1 class="app-shavetopmargin">Colophon</h1>\n		<div class="app-setcol setcol-two">\n			<p>Headings are set in <a href="http://www.theleagueofmoveabletype.com/ostrich-sans" title="Check it out on the LOMT site">Ostrich Sans</a>, from the League of Movable Type. Body copy is Georgia (as it was more readable than <a href="http://www.google.com/webfonts/specimen/Podkova" title="See a preview on Google Fonts">Podkova</a>). UI icons are from <a href="http://tangentsnowball.github.com/Snowcone/index.html" title="Visit the Snowcone repo">Snowcone,</a> a scalable @font-face icon set developed by myself and the lovely folks at Tangent Snowball. Responsive videos work a treat thanks to <a href="http://fitvidsjs.com" title="Visit the awesome FitFits.JS site">FitVids.JS</a>, by <a href="http://chriscoyier.net/" title="Visit the awesome Chris Coyier''s website">Chris Coyier</a> and <a href="http://paravelinc.com/" title="Visit Paravel inc: you''ll never leave!">Paravel</a>. The flexible grid system is inspired by an <a href="http://elliotjaystocks.com/blog/a-better-photoshop-grid-for-responsive-web-design/" title="Read the article on Elliot''s website">article</a> by the great Elliot Jay Stocks, and the site is powered by <a href="http://expressionengine.com/" title="Visit the Expression Engine site">Expression Engine.</a> Curious? Find the site on <a href="https://github.com/jackarmley/mysite" title="View source, Github style">Github.</a></p>\n		</div>\n	</section>\n	<section class="mod-gridunit gu-float_rt gu-last gu-two">\n		<h1 class="app-shavetopmargin">Let''s socialize</h1>\n		<ul class="app-plainlist ext-icons">\n			<li><a class="app-ico ico_link" href="http://www.twitter.com/jackarmley" title="Find me on Twitter">Find me on Twitter</a></li>\n			<li><a class="app-ico ico_link" href="http://foursquare.com/jackarmley" title="Follow me on Foursquare">Follow me on Foursquare</a></li>\n			<li><a class="app-ico ico_link" href="http://github.com/jackarmley" title="Fork me on Github">Fork me on Github</a></li>\n			<li><a class="app-ico ico_link" href="http://pinterest.com/jackalope/" title="Repin me on Pinterest">Repin me on Pinterest</a></li>\n		</ul>\n	</section>\n</footer>');

-- --------------------------------------------------------

--
-- Table structure for table `exp_specialty_templates`
--

CREATE TABLE IF NOT EXISTS `exp_specialty_templates` (
  `template_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `enable_template` char(1) NOT NULL DEFAULT 'y',
  `template_name` varchar(50) NOT NULL,
  `data_title` varchar(80) NOT NULL,
  `template_data` text NOT NULL,
  PRIMARY KEY (`template_id`),
  KEY `template_name` (`template_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `exp_specialty_templates`
--

INSERT INTO `exp_specialty_templates` (`template_id`, `site_id`, `enable_template`, `template_name`, `data_title`, `template_data`) VALUES
(1, 1, 'y', 'offline_template', '', '<!doctype HTML>\n<!--[if lt IE 9]><html class="noscript oldie" id="pg-home" lang="en"><![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="noscript" id="pg-home" lang="en"  manifest="jackarmley.appcache?v=1"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>Be back soon : Jack Armley</title>\n		<meta name="viewport" content="width=device-width,user-scalable=no, scale=1, maximum-scale=1.0" />\n<link rel="shortcut icon" href="http://www.jackarmley.com/v2/assets/images/favicon.ico" />\n<link rel="apple-touch-icon-precomposed" href="http://www.jackarmley.com/v2/assets/images/appletouch_icon.png" />\n<!--[if lt IE 9]>\n	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>	\n	<link rel="stylesheet" href="http://www.jackarmley.com/v2/css/screen.css" media="screen" />\n	<link rel="stylesheet" href="http://www.jackarmley.com/v2/css/mobile.css" media="screen" />\n<![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> \n	<link rel="stylesheet" href="http://www.jackarmley.com/v2/css/screen.css" media="screen" />\n<!--<![endif]-->\n<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>\n<script src="http://www.jackarmley.com/v2/scripts/mysite.js"></script>\n<script>\n  var _gaq = _gaq || [];\n  _gaq.push([''_setAccount'', ''UA-19743700-1'']);\n  _gaq.push([''_trackPageview'']);\n  (function() {\n    var ga = document.createElement(''script''); ga.type = ''text/javascript''; ga.async = true;\n    ga.src = (''https:'' == document.location.protocol ? ''https://ssl'' : ''http://www'') + ''.google-analytics.com/ga.js'';\n    var s = document.getElementsByTagName(''script'')[0]; s.parentNode.insertBefore(ga, s);\n  })();\n</script>\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			<header id="gl-header_pri" role="banner" class="clearfix">\n				<h1><span>Jack Armley</span></h1>	\n			</header>\n			<h1 id="gl-section_title">Out to lunch</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				<section class="clearfix mod-gridunit gu-center gu-four" role="main">\n						<h1 class="app-page_title">I''ve just gone to get a Cornetto; fancy one?</h1>	\n						<p>I''m just making a few changes to my site, but I''ll be back real soon. Whilst you''re waiting, why not go for a walk, or play some paddle ball?</p>\n				</section>	\n			</div>\n		</div>\n		<footer id="gl-page_footer" class="clearfix">\n			<section class="mod-gridunit gu-float gu-four">\n				<h1 class="app-shavetopmargin">Colophon</h1>\n				<div class="app-setcol setcol-two">\n					<p>Headings are set in <a href="http://www.theleagueofmoveabletype.com/ostrich-sans" title="Check it out on the LOMT site">Ostrich Sans</a>, from the League of Movable Type. Body copy is Georgia (as it was more readable than <a href="http://www.google.com/webfonts/specimen/Podkova" title="See a preview on Google Fonts">Podkova</a>). UI icons are from <a href="http://tangentsnowball.github.com/Snowcone/index.html" title="Visit the Snowcone repo">Snowcone,</a> a scalable @font-face icon set developed by myself and the lovely folks at Tangent Snowball. Responsive videos work a treat thanks to <a href="http://fitvidsjs.com" title="Visit the awesome FitFits.JS site">FitVids.JS</a>, by <a href="http://chriscoyier.net/" title="Visit the awesome Chris Coyier''s website">Chris Coyier</a> and <a href="http://paravelinc.com/" title="Visit Paravel inc: you''ll never leave!">Paravel</a>. The flexible grid system is inspired by an <a href="http://elliotjaystocks.com/blog/a-better-photoshop-grid-for-responsive-web-design/" title="Read the article on Elliot''s website">article</a> by the great Elliot Jay Stocks, and the site is powered by <a href="http://expressionengine.com/" title="Visit the Expression Engine site">Expression Engine.</a> Curious? Find the site on <a href="https://github.com/jackarmley/mysite" title="View source, Github style">Github.</a></p>\n				</div>\n			</section>\n			<section class="mod-gridunit gu-float_rt gu-last gu-two">\n				<h1 class="app-shavetopmargin">Let''s socialize</h1>\n				<ul class="app-plainlist ext-icons">\n					<li><a class="app-ico ico_link" href="http://www.twitter.com/jackarmley" title="Find me on Twitter">Find me on Twitter</a></li>\n					<li><a class="app-ico ico_link" href="http://foursquare.com/jackarmley" title="Follow me on Foursquare">Follow me on Foursquare</a></li>\n					<li><a class="app-ico ico_link" href="http://github.com/jackarmley" title="Fork me on Github">Fork me on Github</a></li>\n					<li><a class="app-ico ico_link" href="http://pinterest.com/jackalope/" title="Repin me on Pinterest">Repin me on Pinterest</a></li>\n				</ul>\n			</section>\n		</footer>\n	</body>		\n</html>'),
(2, 1, 'y', 'message_template', '', '<html>\n<head>\n\n<title>{title}</title>\n\n<meta http-equiv=''content-type'' content=''text/html; charset={charset}'' />\n\n{meta_refresh}\n\n<style type="text/css">\n\nbody { \nbackground-color:	#ffffff; \nmargin:				50px; \nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n  \na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:active {\ncolor:				#ccc;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#000 1px solid;\nbackground-color: 	#DEDFE3;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n\nul {\nmargin-bottom: 		16px;\n}\n\nli {\nlist-style:			square;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		8px;\nmargin-bottom: 		8px;\ncolor: 				#000;\n}\n\n</style>\n\n</head>\n\n<body>\n\n<div id="content">\n\n<h1>{heading}</h1>\n\n{content}\n\n<p>{link}</p>\n\n</div>\n\n</body>\n\n</html>'),
(3, 1, 'y', 'admin_notify_reg', 'Notification of new member registration', 'New member registration site: {site_name}\n\nScreen name: {name}\nUser name: {username}\nEmail: {email}\n\nYour control panel URL: {control_panel_url}'),
(4, 1, 'y', 'admin_notify_entry', 'A new channel entry has been posted', 'A new entry has been posted in the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nPosted by: {name}\nEmail: {email}\n\nTo read the entry please visit: \n{entry_url}\n'),
(5, 1, 'y', 'admin_notify_mailinglist', 'Someone has subscribed to your mailing list', 'A new mailing list subscription has been accepted.\n\nEmail Address: {email}\nMailing List: {mailing_list}'),
(6, 1, 'y', 'admin_notify_comment', 'You have just received a comment', 'You have just received a comment for the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nLocated at: \n{comment_url}\n\nPosted by: {name}\nEmail: {email}\nURL: {url}\nLocation: {location}\n\n{comment}'),
(7, 1, 'y', 'mbr_activation_instructions', 'Enclosed is your activation code', 'Thank you for your new member registration.\n\nTo activate your new account, please visit the following URL:\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}\n\n{site_url}'),
(8, 1, 'y', 'forgot_password_instructions', 'Login information', '{name},\n\nTo reset your password, please go to the following page:\n\n{reset_url}\n\nYour password will be automatically reset, and a new password will be emailed to you.\n\nIf you do not wish to reset your password, ignore this message. It will expire in 24 hours.\n\n{site_name}\n{site_url}'),
(9, 1, 'y', 'reset_password_notification', 'New Login Information', '{name},\n\nHere is your new login information:\n\nUsername: {username}\nPassword: {password}\n\n{site_name}\n{site_url}'),
(10, 1, 'y', 'validated_member_notify', 'Your membership account has been activated', '{name},\n\nYour membership account has been activated and is ready for use.\n\nThank You!\n\n{site_name}\n{site_url}'),
(11, 1, 'y', 'decline_member_validation', 'Your membership account has been declined', '{name},\n\nWe''re sorry but our staff has decided not to validate your membership.\n\n{site_name}\n{site_url}'),
(12, 1, 'y', 'mailinglist_activation_instructions', 'Email Confirmation', 'Thank you for joining the "{mailing_list}" mailing list!\n\nPlease click the link below to confirm your email.\n\nIf you do not want to be added to our list, ignore this email.\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}'),
(13, 1, 'y', 'comment_notification', 'Someone just responded to your comment', '{name_of_commenter} just responded to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comment at the following URL:\n{comment_url}\n\n{comment}\n\nTo stop receiving notifications for this comment, click here:\n{notification_removal_url}'),
(14, 1, 'y', 'comments_opened_notification', 'New comments have been added', 'Responses have been added to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comments at the following URL:\n{comment_url}\n\n{comments}\n{comment} \n{/comments}\n\nTo stop receiving notifications for this entry, click here:\n{notification_removal_url}'),
(15, 1, 'y', 'private_message_notification', 'Someone has sent you a Private Message', '\n{recipient_name},\n\n{sender_name} has just sent you a Private Message titled ‘{message_subject}’.\n\nYou can see the Private Message by logging in and viewing your inbox at:\n{site_url}\n\nContent:\n\n{message_content}\n\nTo stop receiving notifications of Private Messages, turn the option off in your Email Settings.\n\n{site_name}\n{site_url}'),
(16, 1, 'y', 'pm_inbox_full', 'Your private message mailbox is full', '{recipient_name},\n\n{sender_name} has just attempted to send you a Private Message,\nbut your inbox is full, exceeding the maximum of {pm_storage_limit}.\n\nPlease log in and remove unwanted messages from your inbox at:\n{site_url}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_stats`
--

CREATE TABLE IF NOT EXISTS `exp_stats` (
  `stat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `total_members` mediumint(7) NOT NULL DEFAULT '0',
  `recent_member_id` int(10) NOT NULL DEFAULT '0',
  `recent_member` varchar(50) NOT NULL,
  `total_entries` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_topics` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_posts` mediumint(8) NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_forum_post_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_visitor_date` int(10) unsigned NOT NULL DEFAULT '0',
  `most_visitors` mediumint(7) NOT NULL DEFAULT '0',
  `most_visitor_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_cache_clear` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`stat_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_stats`
--

INSERT INTO `exp_stats` (`stat_id`, `site_id`, `total_members`, `recent_member_id`, `recent_member`, `total_entries`, `total_forum_topics`, `total_forum_posts`, `total_comments`, `last_entry_date`, `last_forum_post_date`, `last_comment_date`, `last_visitor_date`, `most_visitors`, `most_visitor_date`, `last_cache_clear`) VALUES
(1, 1, 2, 2, 'iPhone user', 38, 0, 0, 0, 1329066773, 0, 0, 1329857839, 38, 1305099979, 1330437469);

-- --------------------------------------------------------

--
-- Table structure for table `exp_status_groups`
--

CREATE TABLE IF NOT EXISTS `exp_status_groups` (
  `group_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_status_groups`
--

INSERT INTO `exp_status_groups` (`group_id`, `site_id`, `group_name`) VALUES
(1, 1, 'Statuses'),
(2, 1, 'Work');

-- --------------------------------------------------------

--
-- Table structure for table `exp_status_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_status_no_access` (
  `status_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`status_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_status_no_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_statuses`
--

CREATE TABLE IF NOT EXISTS `exp_statuses` (
  `status_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `status` varchar(50) NOT NULL,
  `status_order` int(3) unsigned NOT NULL,
  `highlight` varchar(30) NOT NULL,
  PRIMARY KEY (`status_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_statuses`
--

INSERT INTO `exp_statuses` (`status_id`, `site_id`, `group_id`, `status`, `status_order`, `highlight`) VALUES
(1, 1, 1, 'open', 1, '009933'),
(2, 1, 1, 'closed', 2, '990000'),
(3, 1, 2, 'open', 1, '009933'),
(4, 1, 2, 'closed', 2, '990000'),
(5, 1, 2, 'Featured', 3, '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_template_groups`
--

CREATE TABLE IF NOT EXISTS `exp_template_groups` (
  `group_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  `group_order` int(3) unsigned NOT NULL,
  `is_site_default` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`),
  KEY `group_name_idx` (`group_name`),
  KEY `group_order_idx` (`group_order`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `exp_template_groups`
--

INSERT INTO `exp_template_groups` (`group_id`, `site_id`, `group_name`, `group_order`, `is_site_default`) VALUES
(25, 1, 'contact', 2, 'n'),
(31, 1, 'sandbox', 8, 'n'),
(27, 1, 'home', 4, 'y'),
(30, 1, '404', 7, 'n'),
(29, 1, 'livelook', 6, 'n'),
(28, 1, 'is', 5, 'n'),
(26, 1, 'work', 3, 'n'),
(24, 1, 'articles', 1, 'n');

-- --------------------------------------------------------

--
-- Table structure for table `exp_template_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_template_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `template_group_id` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`template_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_template_member_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_template_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_template_no_access` (
  `template_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`template_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_template_no_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_templates`
--

CREATE TABLE IF NOT EXISTS `exp_templates` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(6) unsigned NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `save_template_file` char(1) NOT NULL DEFAULT 'n',
  `template_type` varchar(16) NOT NULL DEFAULT 'webpage',
  `template_data` mediumtext,
  `template_notes` text,
  `edit_date` int(10) NOT NULL DEFAULT '0',
  `last_author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cache` char(1) NOT NULL DEFAULT 'n',
  `refresh` int(6) unsigned NOT NULL DEFAULT '0',
  `no_auth_bounce` varchar(50) NOT NULL DEFAULT '',
  `enable_http_auth` char(1) NOT NULL DEFAULT 'n',
  `allow_php` char(1) NOT NULL DEFAULT 'n',
  `php_parse_location` char(1) NOT NULL DEFAULT 'o',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`template_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`),
  KEY `template_name` (`template_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=56 ;

--
-- Dumping data for table `exp_templates`
--

INSERT INTO `exp_templates` (`template_id`, `site_id`, `group_id`, `template_name`, `save_template_file`, `template_type`, `template_data`, `template_notes`, `edit_date`, `last_author_id`, `cache`, `refresh`, `no_auth_bounce`, `enable_http_auth`, `allow_php`, `php_parse_location`, `hits`) VALUES
(52, 1, 29, 'index', 'y', 'webpage', '', NULL, 1327875554, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(53, 1, 30, 'index', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="p-thanks_page noscript oldie" id="pg-404" lang="en"><![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="noscript" id="pg-404" lang="en"  manifest="jackarmley.appcache?v=1"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>Are you lost? : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">404</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				<section class="clearfix mod-gridunit gu-center gu-four" role="main">\n						<h1 class="app-page_title">Opps!</h1>	\n						<p>Oh deary me, either the page you''re looking for has moved, or you have typed a <abbr title="Uniform Resource Locator">URL</abbr> that doesn''t exist</p>\n						<a class="app-button ext-center app-ico ico-outline_back" href="{path=''/''}">Head on home</a>			\n				</section>	\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1328045658, 1, 'n', 0, '', 'n', 'n', 'o', 1465),
(54, 1, 31, 'post', 'y', 'webpage', '<!doctype HTML>\n{exp:channel:entries channel="bespoke_post" disable="categories|member_data|pagination" status="open"}\n<!--[if lt IE 9]><html class="p-blankcanvas noscript oldie" id="bespoke-{bespoke-cssclass}" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="p-blankcanvas noscript" id="bespoke-{bespoke-cssclass}" lang="en"  manifest="jackarmley.appcache?v=1"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<meta name="viewport" content="width=device-width,user-scalable=no, scale=1, maximum-scale=1.0" /> \n		<title>{title} : {site_name}</title>\n		{sn-head_meta}\n		{bespoke-headercalls}\n	</head>\n	<body>\n		<div id="gl-mask"></div>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title" class="app-ico ico_outline_down">{title}</h1>\n			{bespoke-content}	\n		</div>\n		<footer id="gl-page_footer" class="clearfix">\n			<section>\n				<h1 class="app-shavetopmargin">Colophon</h1>\n				{bespoke-footer}\n			</section>\n		</footer>\n	</body>		\n</html>\n{/exp:channel:entries}', NULL, 1329065657, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(55, 1, 31, 'index', 'y', 'webpage', '', NULL, 1329065657, 1, 'n', 0, '', 'n', 'n', 'o', 302),
(50, 1, 29, 'work-detail', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="p-work_detail noscript oldie" id="pg-work" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="p-work_detail noscript" id="pg-work" lang="en" manifest="jackarmley.appcache?v=1"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="Closed|Open|Featured" limit="1" show_future_entries="yes"}{title}{/exp:channel:entries} &ndash; Work : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Work</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="Closed|Open|Featured" limit="1" show_future_entries="yes"}\n					<article class="clearfix">\n						<div class="state-slider clearfix">\n							<ul class="slides">\n								{work-slides}\n									<li>\n										<figure>\n											<img src="{-matrix-work-slides_image}" alt="{-matrix-work-slides_alt}" />\n											<figcaption>{-matrix-work-slides_caption}</figcaption>\n										</figure>\n									</li>\n								{/work-slides}\n							</ul>\n						</div>\n						<h1 class="app-page_title">{title}</h1>\n						<div class="mod-gridunit gu-float gu-four">\n							{work-standfirst}\n							{work-body}	\n							{work-extended}			\n						</div>\n						<aside class="mod-gridunit gu-float_rt gu-last gu-two">\n							<ul class="app-plainlist ext-icons app-panel app-setflushwithparagraph">\n								{if work-url}\n									<li><a class="app-ico ico_link" href="{work-url}" title="Visit {work-url}">Visit site</a></li>\n								{/if}\n								<li><a class="app-ico ico_outline_left" href="{path=''work''}" title="">Back to work listing</a></li>\n							</ul>\n						</aside>	\n					</article>	\n				{/exp:channel:entries}\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327875554, 1, 'n', 0, '', 'n', 'n', 'o', 32),
(47, 1, 26, 'index', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="noscript oldie" id="pg-work" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="noscript" id="pg-work" lang="en"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>Work : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Work</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="Featured" limit="1" dynamic="no" show_future_entries="yes"}\n					<article class="clearfix app-division">\n						{work-slides limit="1"}\n							<figure class="app-imgwithfig_pri">\n								<img src="{-matrix-work-slides_image}" alt="{-matrix-work-slides_alt}" />\n							</figure>\n						{/work-slides}\n						<h1 class="app-page_title">{title}</h1>\n						<div class="app-setcol setcol-three">\n							{work-body}\n						</div>\n						<a class="app-button ext-center" href="{title_permalink=''v2-work/detail''}" title="Read more">Read more</a>\n					</article>	\n				{/exp:channel:entries}\n				<div class="app-grid_listing clearfix">\n					{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="open" limit="15" sort="asc" orderby="title" dynamic="no" show_future_entries="yes"}	\n						<article class="mod-gridunit gu-float {switch=''||gu-last''} gu-two">\n							<h1>{title}</h1>\n							{work-thumb limit="1"}\n								<figure>\n									<img src="{-matrix-work-thumb_image}" alt="{-matrix-work-thumb_alt}" class="app-border" />\n								</figure>\n							{/work-thumb}\n							{work-summary}\n							<a class="app-button ext-receessive" href="{title_permalink=''v2-work/detail''}" title="Read more">Read more</a>\n						</article>\n						{switch="||<div class=''clear''></div>"}\n					{/exp:channel:entries}\n				</div>\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327869529, 1, 'n', 0, '', 'n', 'n', 'o', 178),
(48, 1, 27, 'index', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="noscript oldie" id="pg-home" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--><html class="noscript" id="pg-home" lang="en" manifest="jackarmley.appcache?v=1"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" /> \n		<title>{site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">My name''s Jack; I''m a web designer</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				<div id="pg-home_intro">\n					<p class="app-page_title app-division">My idea of a good time is writing a nice bit of semantic markup, or some extensible <abbr title="Cascading Style Sheets">CSS</abbr></p>\n					<div class="app-division clearfix">\n						<article class="mod-gridunit gu-float gu-three">\n							{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="Featured" sort="desc" limit="1" dynamic="no" show_future_entries="yes"}\n								<h1 class="app-ico ico_view">{title}</h1>\n								{work-thumb limit="1"}\n									<img src="{-matrix-work-thumb_image}" alt="{-matrix-work-thumb_alt}" />\n								{/work-thumb}\n								{work-summary}\n								<a class="app-button ext-receessive" href="{title_permalink=''v2-work/detail''}">Read more</a>\n							{/exp:channel:entries}\n						</article>\n						<article class="mod-gridunit gu-float gu-last gu-three">\n							{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="open" limit="1" sort="desc" show_future_entries="yes"}\n								<h1 class="app-ico ico_edit">{title}</h1>\n								{blog-thumb limit="1"}\n									<img src="{blog-thumb_image}" alt="{blog-thumb_alt}" {if blog-thumb_border == "yes" }class="app-border"{/if} />\n								{/blog-thumb}\n								{blog-summary}\n								<a class="app-button ext-receessive" href="{title_permalink=''v2-articles/post''}">Read more</a>\n							{/exp:channel:entries}\n						</article>\n					</div>\n					<section class="mod-gridunit gu-float gu-two">\n						<h1 class="app-ico ico_heart">I''m loving</h1>\n						<p><a href="http://gridpak.com/">Gridpak</a> by Erskine design, <a href="http://flipboard.com/">Flipboard</a> for iPhone and <a href="http://www.google.com/landing/chrome/beta/">Chrome beta''s</a> user&ndash; agent string switcher.</p>\n					</section>\n					<section class="mod-gridunit gu-float gu-two">\n						<h1 class="app-ico ico_settings">I''m using</h1>\n						<p>The principles from <a href="http://smacss.com/">SMACSS</a> by Jonathan Snook, <a href="http://www.mozilla.org/en-US/firefox/aurora/">Firefox Aurora''s</a> developer tools and <a href="http://tangentsnowball.github.com/Snowcone/index.html">Snowcone</a>, an icon font I''ve been working on with the Tangent Snowball team.</p>\n					</section>\n					<article class="ext-tweet mod-gridunit gu-last gu-float gu-two">\n						<h1 class="app-ico ico_twitter">From the twitter</h1>\n						{exp:twitter_timeline screen_name="jackarmley" limit="1" twitter_refresh="30" use_stale_cache="no" create_links="user_mentions|hashtags|urls"}\n							<blockquote>\n								<p>&quot;{text}&quot;</p>\n								<footer>\n									<p>{status_relative_date} ago</p>\n								</footer>					\n							</blockquote>\n						{/exp:twitter_timeline}\n					</article>\n				</div>		\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327869529, 1, 'n', 0, '', 'n', 'n', 'o', 545),
(49, 1, 28, 'index', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="noscript oldie" id="pg-me" lang="en"><![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="noscript" id="pg-me" lang="en"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>About me : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">It''s all about me</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="page" disable="categories|member_data|pagination" status="open" limit="1" dynamic="no" entry_id="12"}		\n					<h1 class="app-page_title">My name is Jack;<br />I’m a web designer</h1>\n					<article class="mod-gridunit gu-float gu-four">\n						{page-standfirst}\n						{page-body}		\n					</article>\n				{/exp:channel:entries}		\n				<aside class="mod-gridunit gu-float_rt gu-last gu-two" id="gl-content_sec">\n					<h1 class="app-shavetopmargin">Recently, on the twitter&hellip;</h1>\n					{exp:twitter_timeline screen_name="jackarmley" limit="3" twitter_refresh="30" use_stale_cache="no" create_links="user_mentions|hashtags|urls"}\n						<article class="mod-listitem ext-tweet">\n							<blockquote>\n								<p>&quot;{text}&quot;</p>\n								<footer>\n									<p>{status_relative_date} ago</p>\n								</footer>					\n							</blockquote>\n						</article>\n					{/exp:twitter_timeline}\n				</aside>\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327869529, 1, 'n', 0, '', 'n', 'n', 'o', 300),
(51, 1, 29, 'article-post', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="p-article_post noscript oldie" id="pg-articles" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="p-article_post noscript" id="pg-articles" lang="en"  manifest="jackarmley.appcache?v=1"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="closed|open"}{title}{/exp:channel:entries} &ndash; Articles : {site_name}</title>\n		<script src="http://platform.twitter.com/anywhere.js?id=xJT0yI00uwLJDo4DJFtXg&amp;v=1" type="text/javascript"></script>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Articles</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="closed|open"}\n					<article class="clearfix">\n						<div class="mod-gridunit gu-center gu-four">\n							<hgroup>\n								<h1 class="app-page_title">{title}</h1>\n								<h2 class="app-pagetitle_subinfo">Posted on {entry_date format="%F %j%S, %Y"}</h2>\n							</hgroup>\n							<div class="app-division">\n								{blog-image limit="1"}\n									<figure class="app-imgwithfig_pri app-division">\n										<img src="{blog-image_image}" alt="{blog-image_alt}" {if blog-image_border == "yes" }class="app-border"{/if} />\n										<figcaption>{blog-image_caption}</figcaption>\n									</figure>		\n								{/blog-image}\n								{blog-standfirst}\n								{blog-body}\n								{blog-extended}\n							</div>\n							<footer>\n								<section class="app-division">\n									<h1>Tweet this</h1>\n									<div id="gl-tweetbox"></div>\n								</section>\n								<section>\n									<h1>Add a comment</h1>	\n									<div id="disqus_thread">\n									</div>\n								</section>\n								<script>\n									var disqus_identifier = ''{entry_id'';\n									var disqus_url = ''{site_url}articles/post/{url_title}'';\n								</script>\n							</footer>	\n							<a id="gl-toplink" class="app-ico ico_outline_up app-button ext-center" href="#" title="">Back to top</a>					\n						</div>\n					</article>\n				{/exp:channel:entries}	\n			</div>\n		</div>\n		{sn-page_footer}	\n	</body>		\n</html>', NULL, 1327875554, 1, 'n', 0, '', 'n', 'n', 'o', 263),
(42, 1, 24, 'post', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="p-article_post noscript oldie" id="pg-articles" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="p-article_post noscript" id="pg-articles" lang="en"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="open"}{title}{/exp:channel:entries} &ndash; Articles : {site_name}</title>\n		<script src="http://platform.twitter.com/anywhere.js?id=xJT0yI00uwLJDo4DJFtXg&amp;v=1" type="text/javascript"></script>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Articles</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="open"}\n					<article class="clearfix">\n						<div class="mod-gridunit gu-center gu-four">\n							<hgroup>\n								<h1 class="app-page_title">{title}</h1>\n								<h2 class="app-pagetitle_subinfo">Posted on {entry_date format="%F %j%S, %Y"}</h2>\n							</hgroup>\n							<div class="app-division">\n								{blog-image limit="1"}\n									<figure class="app-imgwithfig_pri app-division">\n										<img src="{blog-image_image}" alt="{blog-image_alt}" {if blog-image_border == "yes" }class="app-border"{/if} />\n										<figcaption>{blog-image_caption}</figcaption>\n									</figure>		\n								{/blog-image}\n								{blog-standfirst}\n								{blog-body}\n								{blog-extended}\n							</div>\n							<footer>\n								<section class="app-division">\n									<h1>Tweet this</h1>\n									<div id="gl-tweetbox"></div>\n								</section>\n								<section>\n									<h1>Add a comment</h1>	\n									<div id="disqus_thread">\n									</div>\n								</section>\n								<script>\n									var disqus_identifier = ''{entry_id'';\n									var disqus_url = ''{site_url}index.php/v2-articles/post/{url_title}'';\n								</script>\n							</footer>	\n							<a id="gl-toplink" class="app-ico ico_outline_up app-button ext-center" href="#" title="">Back to top</a>					\n						</div>\n					</article>\n				{/exp:channel:entries}	\n			</div>\n		</div>\n		{sn-page_footer}	\n	</body>		\n</html>', NULL, 1327869521, 1, 'n', 0, '', 'n', 'n', 'o', 887),
(43, 1, 24, 'index', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="noscript oldie" id="pg-articles" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="noscript" id="pg-articles" lang="en"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>Articles : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Articles</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="open" limit="1" dynamic="no" sort="desc" show_future_entries="yes"}\n					<article class="clearfix app-division">\n						<div class="mod-gridunit gu-center gu-four">\n							<h1 class="app-page_title">{title}</h1>\n							{blog-image limit="1"}\n								<figure class="app-imgwithfig_pri">\n									<img src="{blog-image_image}" alt="{blog-image_alt}" {if blog-image_border == "yes" }class="app-border"{/if} />\n									<figcaption>{blog-image_caption}</figcaption>\n								</figure>		\n							{/blog-image}\n							<div class="app-setcol setcol-two">\n								{blog-body}\n							</div>\n						<a class="app-button ext-center" href="{title_permalink=''v2-articles/post''}" title="Read more">Read more</a>\n						</div>\n					</article>	\n				{/exp:channel:entries}\n				<div class="app-grid_listing clearfix">\n					{exp:channel:entries channel="blog" disable="categories|member_data|pagination" status="open" limit="15" offset="1" dynamic="no" sort="desc" show_future_entries="yes"}\n						<article class="mod-gridunit gu-float {switch=''||gu-last''} gu-two">\n							<h1>{title}</h1>\n							{blog-summary}\n							<a class="app-button ext-receessive" href="{title_permalink=''v2-articles/post''}" title="Read more">Read more</a>\n						</article>\n						{switch="||<div class=''clear''></div>"}\n					{/exp:channel:entries}\n				</div>\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327869521, 1, 'n', 0, '', 'n', 'n', 'o', 198),
(44, 1, 25, 'ta_muchly', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="p-thanks_page noscript oldie" id="pg-contact" lang="en"><![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="p-thanks_page noscript" id="pg-contact" lang="en"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>Thanks for getting in&ndash; touch : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Contact me</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				<section class="clearfix mod-gridunit gu-center gu-four" role="main">\n						<h1 class="app-page_title">Ta muchly!</h1>	\n						<p>Thanks for getting in&ndash; touch. I''ll get back to you as soon as I can.</p>\n						<a class="app-button ext-center app-ico ico-outline_back" href="{path=''v2-contact''}">Head on back</a>			\n				</section>	\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327869521, 1, 'n', 0, '', 'n', 'n', 'o', 1),
(45, 1, 25, 'index', 'y', 'webpage', '', NULL, 1327869521, 1, 'n', 0, '', 'n', 'n', 'o', 118),
(46, 1, 26, 'detail', 'y', 'webpage', '<!doctype HTML>\n<!--[if lt IE 9]><html class="p-work_detail noscript oldie" id="pg-work" lang="en"> <![endif]-->\n<!--[if (gte IE 9)|!(IE)]><!--> <html class="p-work_detail noscript" id="pg-work" lang="en"><!--<![endif]-->\n	<head>\n		<meta charset="utf-8" />\n		<title>{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="Open|Featured" limit="1" show_future_entries="yes"}{title}{/exp:channel:entries} &ndash; Work : {site_name}</title>\n		{sn-head_meta}\n	</head>\n	<body>\n		<div id="gl-wrapper_page">\n			{sn-header_pri}\n			<h1 id="gl-section_title">Work</h1>\n			<div id="gl-content_wrapper" class="clearfix">\n				{exp:channel:entries channel="work" disable="categories|member_data|pagination" status="Open|Featured" limit="1" show_future_entries="yes"}\n					<article class="clearfix">\n						<div class="state-slider clearfix">\n							<ul class="slides">\n								{work-slides}\n								<img src="{-matrix-work-slides_image}" alt="{-matrix-work-slides_alt}" />\n									<li>\n										<figure>\n											<img src="{-matrix-work-slides_image}" alt="{-matrix-work-slides_alt}" />\n											<figcaption>{-matrix-work-slides_caption}</figcaption>\n										</figure>\n									</li>\n								{/work-slides}\n							</ul>\n						</div>\n						<h1 class="app-page_title">{title}</h1>\n						<div class="mod-gridunit gu-float gu-four">\n							{work-standfirst}\n							{work-body}	\n							{work-extended}			\n						</div>\n						<aside class="mod-gridunit gu-float_rt gu-last gu-two">\n							<ul class="app-plainlist ext-icons app-panel app-setflushwithparagraph">\n								{if work-url}\n									<li><a class="app-ico ico_link" href="{work-url}" title="Visit {work-url}">Visit site</a></li>\n								{/if}\n								<li><a class="app-ico ico_outline_left" href="{path=''v2-work''}" title="">Back to work listing</a></li>\n							</ul>\n						</aside>	\n					</article>	\n				{/exp:channel:entries}\n			</div>\n		</div>\n		{sn-page_footer}\n	</body>		\n</html>', NULL, 1327869529, 1, 'n', 0, '', 'n', 'n', 'o', 446);

-- --------------------------------------------------------

--
-- Table structure for table `exp_tgl_instagram_settings`
--

CREATE TABLE IF NOT EXISTS `exp_tgl_instagram_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(8) unsigned NOT NULL DEFAULT '1',
  `var` varchar(60) NOT NULL,
  `var_value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `exp_tgl_instagram_settings`
--

INSERT INTO `exp_tgl_instagram_settings` (`id`, `site_id`, `var`, `var_value`) VALUES
(8, 1, 'client_secret', 'f227326c3d8a4495afd850d54f3f622c'),
(7, 1, 'client_id', '4760a9378d1f4ddf8554d41df071205a');

-- --------------------------------------------------------

--
-- Table structure for table `exp_throttle`
--

CREATE TABLE IF NOT EXISTS `exp_throttle` (
  `throttle_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL,
  `locked_out` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`throttle_id`),
  KEY `ip_address` (`ip_address`),
  KEY `last_activity` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `exp_throttle`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_upload_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_upload_no_access` (
  `upload_id` int(6) unsigned NOT NULL,
  `upload_loc` varchar(3) NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`upload_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_upload_no_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `exp_upload_prefs`
--

CREATE TABLE IF NOT EXISTS `exp_upload_prefs` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `name` varchar(50) NOT NULL,
  `server_path` varchar(255) DEFAULT NULL,
  `url` varchar(100) NOT NULL,
  `allowed_types` varchar(3) NOT NULL DEFAULT 'img',
  `max_size` varchar(16) DEFAULT NULL,
  `max_height` varchar(6) DEFAULT NULL,
  `max_width` varchar(6) DEFAULT NULL,
  `properties` varchar(120) DEFAULT NULL,
  `pre_format` varchar(120) DEFAULT NULL,
  `post_format` varchar(120) DEFAULT NULL,
  `file_properties` varchar(120) DEFAULT NULL,
  `file_pre_format` varchar(120) DEFAULT NULL,
  `file_post_format` varchar(120) DEFAULT NULL,
  `batch_location` varchar(255) DEFAULT NULL,
  `cat_group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_upload_prefs`
--

INSERT INTO `exp_upload_prefs` (`id`, `site_id`, `name`, `server_path`, `url`, `allowed_types`, `max_size`, `max_height`, `max_width`, `properties`, `pre_format`, `post_format`, `file_properties`, `file_pre_format`, `file_post_format`, `batch_location`, `cat_group`) VALUES
(1, 1, 'Images', '/home/jackarmley16/jackarmley.com/images/uploads/images/', 'http://www.jackarmley.com/images/uploads/images/', 'img', '', '', '', '', '', '', '', '', '', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_wygwam_configs`
--

CREATE TABLE IF NOT EXISTS `exp_wygwam_configs` (
  `config_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `config_name` varchar(32) DEFAULT NULL,
  `settings` text,
  PRIMARY KEY (`config_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_wygwam_configs`
--

INSERT INTO `exp_wygwam_configs` (`config_id`, `config_name`, `settings`) VALUES
(1, 'Basic', 'YTo1OntzOjc6InRvb2xiYXIiO2E6Njp7aTowO3M6NjoiU291cmNlIjtpOjE7czo4OiJNYXhpbWl6ZSI7aToyO3M6MTA6IlNob3dCbG9ja3MiO2k6MztzOjk6IlBhc3RlVGV4dCI7aTo0O3M6NDoiTGluayI7aTo1O3M6NjoiVW5saW5rIjt9czo2OiJoZWlnaHQiO3M6MzoiMjAwIjtzOjE0OiJyZXNpemVfZW5hYmxlZCI7czoxOiJ5IjtzOjExOiJjb250ZW50c0NzcyI7YTowOnt9czoxMDoidXBsb2FkX2RpciI7czowOiIiO30='),
(2, 'Full', 'YTo2OntzOjc6InRvb2xiYXIiO2E6MjI6e2k6MDtzOjY6IlNvdXJjZSI7aToxO3M6ODoiTWF4aW1pemUiO2k6MjtzOjEwOiJTaG93QmxvY2tzIjtpOjM7czo5OiJQYXN0ZVRleHQiO2k6NDtzOjQ6IkxpbmsiO2k6NTtzOjY6IlVubGluayI7aTo2O3M6NjoiQW5jaG9yIjtpOjc7czo2OiJGb3JtYXQiO2k6ODtzOjQ6IkJvbGQiO2k6OTtzOjY6Ikl0YWxpYyI7aToxMDtzOjY6IlN0cmlrZSI7aToxMTtzOjk6IlN1YnNjcmlwdCI7aToxMjtzOjExOiJTdXBlcnNjcmlwdCI7aToxMztzOjEyOiJOdW1iZXJlZExpc3QiO2k6MTQ7czoxMjoiQnVsbGV0ZWRMaXN0IjtpOjE1O3M6MTA6IkJsb2NrcXVvdGUiO2k6MTY7czo1OiJJbWFnZSI7aToxNztzOjExOiJTcGVjaWFsQ2hhciI7aToxODtzOjg6IlJlYWRNb3JlIjtpOjE5O3M6MToiLyI7aToyMDtzOjY6IlN0eWxlcyI7aToyMTtzOjE6Ii8iO31zOjY6ImhlaWdodCI7czozOiIyMDAiO3M6MTQ6InJlc2l6ZV9lbmFibGVkIjtzOjE6InkiO3M6MTE6ImNvbnRlbnRzQ3NzIjthOjA6e31zOjEwOiJ1cGxvYWRfZGlyIjtzOjE6IjEiO3M6MjA6Imlnbm9yZUVtcHR5UGFyYWdyYXBoIjtzOjE6InkiO30=');
