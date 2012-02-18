<?php 
/*
_|                                                      _|
_|_|_|     _|_|     _|_|   _|    _|   _|_|_| _|_|_|   _|_|_|_|
_|    _| _|    _| _|    _| _|    _| _|    _| _|    _|   _|
_|    _| _|    _| _|    _| _|    _| _|    _| _|    _|   _|
_|_|_|     _|_|     _|_|     _|_|_|   _|_|_| _|    _|     _|_|
                                 _|
                             _|_|

Description:		NavEE Module for Expression Engine 2.0
Developer:			Booyant, Inc.
Website:			www.booyant.com/navee
Location:			./system/expressionengine/third_party/modules/navee/mcp.navee.php
Contact:			navee@booyant.com  / 978.OKAY.BOB
Version:			1.1.2
*/

if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Navee_mcp {

	var $hasErrors 			= false;
	var $message 			= "";
	var $nav				= array();
	var $navee_navs			= array();
	var $site_id			= "1";

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	C O N S T R U C T O R
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function Navee_mcp(){

		// Make a local reference to the ExpressionEngine super object
		$this->EE =& get_instance();
		$this->site_id = $this->EE->config->item('site_id');
		// Comment out the following line to enable caching
		$this->EE->db->cache_off();
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	M O D U L E   M A I N   P A G E
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function index(){
		$vars = array();
		$this->EE->load->library('table');
		$this->EE->load->library('javascript');
		$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('cp_header'));
		
		$this->EE->cp->add_to_head('<link rel="stylesheet" type="text/css" href="'.$this->EE->config->item('theme_folder_url').'/navee/css/navee.css" />');

		// Javascript
			$this->EE->javascript->output(array('

				$("#navEE .x").live("click", function(){
					$(this).parent("div").fadeOut(200);
				});

				$("body").live("click", function(){
					$(".navee_helper").fadeOut(333);
				});

				$("#navEE .navee_delete").click(function(){
					var id = $(this).attr("id").split("_");
					$(".navee_alert").html("'.$this->EE->lang->line('cp_msg_are_you_sure').' <a href=\''.BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=delete_navigation'.AMP.'id="+id[1]+"\' class=\'x\'>'.$this->EE->lang->line('cp_msg_sure').'</a>").fadeIn(333);
				});

				$("#navEE td > div").hover(
					function(){
						if (!$(this).children(".navee_accept").is(":visible")){
							$(this).children(".navee_edit").show();
						}
					},
					function(){
						$(this).children(".navee_edit").hide();
					}
				);

				$(".navee_edit").live("click",function(){
					var id = $(this).attr("id").split("_");
					if (id[2] == "name") {
						content = $(this).siblings("span").children("a").html()
					} else {
						content = $(this).siblings("span").html();
					}
					$(this).hide();
					$(this).siblings(".navee_accept").show();
					$(this).siblings("span").html("<input type=\'text\' value=\'"+content+"\' />");
				});

				$(".navee_accept").live("click", function(){
					var content = $(this).siblings("span").children("input").val();
					var id = $(this).attr("id").split("_");
					
					if (jQuery.trim(content).length > 0){
						$.ajax({
							type: "GET",
							cache: false,
							url: "'.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=update_navigation&content="+content+"&id="+id[3]+"&type="+id[2],
							data: "",
							success: function(msg){
								//alert( "Data Saved: " + msg );
								if (msg.length > 0) {
									$(".navee_alert").html(msg+"<a href=\'javascript:;\' class=\'x\'>X</a>").slideDown(333);
								}

							}
						});

						if (id[2] == "name") {
							content = "<a href=\''.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=manage_navigation&id="+id[3]+"\'>"+content+"</a>";
						}

						$(this).hide();
						$(this).siblings("span").html(content);
						$.ee_notice("'.$this->EE->lang->line('cp_suc_added').'", {type: \'success\'});

					} else {
						$.ee_notice("'.$this->EE->lang->line('cp_err_empty').'", {type: \'error\', open: true});
					}
				});
			'));

			$this->EE->javascript->compile();

		// Check to see if there is anything in the database
			$this->EE->db->select("*");
			$this->EE->db->order_by("nav_name", "ASC");
			$this->EE->db->where("site_id", $this->site_id);
			$q = $this->EE->db->get("navee_navs");
			if ($q->num_rows() > 0){
				// Create a list of navs
					$vars["instructions"] = false;
					foreach ($q->result() as $row){
						$vars["navs"][$row->navigation_id]["navigation_id"] 	= $row->navigation_id;
						$vars["navs"][$row->navigation_id]["nav_name"] 			= $row->nav_name;
						$vars["navs"][$row->navigation_id]["nav_title"] 			= $row->nav_title;
						$vars["navs"][$row->navigation_id]["nav_description"] 	= $row->nav_description;
					}
			} else {
				// How about some instructions to be helpful
					$vars["instructions"] = true;
			}
			$q->free_result();

			$vars["manage_nav_link"]	= BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation';
			$vars["add_nav_link"]		= BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=add_navigation';
			$vars["theme_folder_url"]	= $this->EE->config->item('theme_folder_url');	

		return $this->EE->load->view('index', $vars, TRUE);
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	M A N A G E   N A V I G A T I O N 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function manage_navigation(){
		$vars = array();
		$this->EE->load->library('table');
		$this->EE->load->library('javascript');
		$this->EE->load->library('session');

		$vars["navigation_id"] 	= $this->EE->input->get("id");

		$this->EE->db->select("nav_name");
		$this->EE->db->where("navigation_id", $vars["navigation_id"]);
		$this->EE->db->where("site_id", $this->site_id);
		$q = $this->EE->db->get("navee_navs");

		if ($q->num_rows() == 1){
			$this->EE->db->select("navee_id");
			$this->EE->db->where("navigation_id", $vars["navigation_id"]);
			$this->EE->db->where("site_id", $this->site_id);
			$qNav = $this->EE->db->get("navee");
			if ($qNav->num_rows() == 0){
				$vars["nav_empty"] = true;
			} else {
				$vars["nav_empty"] = false;
			}

			// Set some alerts and helpers

			$vars["alert"] 			= "";
			$vars["helper"] 		= "";
			$vars["selectPages"]	= "";
			$vars["selectPagesBtn"]	= "";
			$vars["enterLinkBtn"]	= "";

			switch($qNav->num_rows()){
				case 0:
					// Get an array of Pages
						$pages 				= $this->EE->config->item('site_pages');
						
						if (isset($pages[$this->site_id]["uris"])){
							$numPages = sizeof($pages[$this->site_id]["uris"]);
						} else {
							$numPages = 0;
						}
						
						$vars["numPages"] 	= $numPages;

					if ($numPages>0){
						$vars["selectPages"] 	= $this->_stylePagesSelect($pages[$this->site_id]["uris"]);
						$vars["selectPagesBtn"] = " or <a href='javascript:;' class='select_pages'>".$this->EE->lang->line('cp_mn_select_pages')."</a>";
						$vars["enterLinkBtn"]	= " or <a href='javascript:;' class='enter_link'>".$this->EE->lang->line('cp_mn_enter_link')."</a>";
					}

					$vars["helper"] = $this->EE->lang->line('cp_hlp_navItem_1');
					break;
				case 1:
					$vars["helper"] = $this->EE->lang->line('cp_hlp_navItem_2');
					break;
				default:
					$vars["helper"] = "";
			}

			$qNav->free_result();

			$r = $q->row();
			$this->EE->cp->set_breadcrumb(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=index', $this->EE->lang->line('navee_module_name'));
			$this->EE->cp->set_variable('cp_page_title', $r->nav_name);
			$this->EE->cp->add_to_head('<link rel="stylesheet" type="text/css" href="'.$this->EE->config->item('theme_folder_url').'navee/css/navee.css" />');

			// Javascript
				$this->EE->javascript->output(array('
					function naveeEncode(str){
						str = str.replace(/\?/g, "__navEE__3f");
						str = str.replace(/;/g, "__navEE__3b");
						return str;
					}
				
					$("#navEE .x").click(function(){
						$(this).parent("div").fadeOut(333);
					});

					$("body").click(function(){
						$(".navee_helper").fadeOut(333);
					});

					$("#navEE #navee_add2Nav").click(function(){

						if ($("#navEE #add_navItem").is(":visible")){
							$("#navEE #add_navItem").slideUp(333);
						} else {
							$.ajax({
									type: "GET",
									cache: false,
									url: "'.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=new_navigation_item_form",
									data: "id='.$vars["navigation_id"].'",
									success: function(msg){
										//alert( "Data Saved: " + msg );
										$("#navEE #add_navItem").html(msg).slideDown(333);
										$("#navEE #add_navItem").slideDown(333);
									}
							});
						}
					});

					$("#navEE #navee_cp_nav li").hover(
						function(){
							$(this).children(".navee_edit").show();
							$(this).children(".navee_trash").show();
							$(this).children(".navee_code").show();
						}, function(){
							$(this).children(".navee_edit").hide();
							$(this).children(".navee_trash").hide();
							$(this).children(".navee_code").hide();
						}
					);

					$("#navEE .navee_code").live("click", function(){
						$(".navee_edit_form").slideUp(333);
						$(this).siblings(".navee_ee_tag").slideToggle(333);
						
					});

					$(".select_pages").live("click", function(){
						$(this).parent("label").parent("li").hide().siblings(".pagesSelect").show();
					});

					$(".enter_link").live("click", function(){
						$(this).parent("label").parent("li").hide().siblings(".naveeLink").show();
					});

					$(".pagesDropdown").live("change", function(){
						$(this).parent("li").siblings(".naveeLink").children("input").val($(this).val());
						$(this).parent("li").siblings(".naveeLink").show();
						$(this).parent("li").hide();
					});

					$("#navEE .navee_edit").live("click", function(){
						$(".navee_edit_form").slideUp(333);
						$(".navee_ee_tag").slideUp(333);
						id = $(this).parent(\'li\').attr(\'id\');
						if ($(this).siblings(".navee_edit_form").is(":visible")){
							$("#navee_cp_nav #"+id+" .navee_edit_form").slideUp(333);
						} else {
							$.ajax({
									type: "GET",
									cache: false,
									url: "'.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=get_navigation_item_form",
									data: "id="+id,
									success: function(msg){
										//alert( "Data Saved: " + msg );
										$("#navee_cp_nav #"+id+" > .navee_edit_form").html(msg).slideDown(333);
									}
							});
						}
					});

					$("#navEE .navee_optional_btn").live("click", function(){
						if ($(this).parent("li").parent("ul").siblings(".navee_optional").is(":visible")){
							$(this).html("'.$this->EE->lang->line('cp_mn_optional').'");
						} else {
							$(this).html("'.$this->EE->lang->line('cp_mn_optional_fewer').'");
						}
						$(this).parent("li").parent("ul").siblings(".navee_optional").slideToggle(333);
					});

					$("#navEE .navee_update_btn").live("click", function(){

						qs 			= "";
						textStr		= "";
						parentId 	= 0;
						old_parent	= 0;

						id = $(this).parent("li").parent("ul").parent("form").parent("div").parent("li").attr("id");

						$(this).parent("li").parent("ul").parent("form").find("input").each(function(){
							if (qs.length > 0){
								qs = qs + "&";
							}
							
							
							if ($(this).attr("type") == "checkbox") {
								if ($(this).is(":checked")) {
									qs = qs + $(this).attr("name") + "=" + encodeURIComponent(naveeEncode($(this).val()));
								}
							} else {
								qs = qs + $(this).attr("name") + "=" + encodeURIComponent(naveeEncode($(this).val()));
							}

							switch($(this).attr("name")){
								case "navee_text":
									textStr = $(this).val();
									break;
								case "old_parent":
									old_parent = $(this).val();
									break;
							}
						});

						$(this).parent("li").parent("ul").parent("form").find("select").each(function(){
							if (qs.length > 0){
								qs = qs + "&";
							}
							qs = qs + $(this).attr("name") + "=" + encodeURIComponent($(this).val());
							
							switch($(this).attr("name")){
								case "navee_parent":
									parentId = $(this).val();
									break;
							}

						});						

						$.ajax({
								type: "GET",
								cache: false,
								url: "'.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=update_navigation_item",
								data: qs,
								success: function(msg){
									//alert( "Data Saved: " + msg );
									if (msg == "error") {
										$.ee_notice("'.$this->EE->lang->line('cp_err_all_req_fields').'", {type: \'error\', open: true});
									} else {
										$.ee_notice("'.$this->EE->lang->line('cp_suc_update_navItem').'", {type: \'success\'});
										$("#"+id+" > div.navee_edit_form").slideUp(333).siblings(".navee_cp_text").html(textStr);
									}
								}
						});

						if (parentId !== old_parent){
							$(this).parent("li").parent("ul").parent("form").children(".old_parent").val(parentId);
							if (parentId == 0){
								$(this).parent("li").parent("ul").parent("form").parent(".navee_edit_form").parent("li").appendTo("#navee_cp_nav > ul");
							} else {
								if ($("#navee_cp_nav #"+parentId+" > ul").length == 0){
								
									$("#navee_cp_nav #"+parentId).append("<ul><li id=\'"+id+"\'>"+$(this).parent("li").parent("ul").parent("form").parent(".navee_edit_form").parent("li").html()+"</li></ul>");
									$(this).parent("li").parent("ul").parent("form").parent(".navee_edit_form").parent("li").remove();
									
									$(".navee_edit_form").slideUp(333);
								} else {
									$(this).parent("li").parent("ul").parent("form").parent(".navee_edit_form").parent("li").appendTo("#navee_cp_nav #"+parentId+" > ul");
								}	
							}
							
							if($("#navee_cp_nav #"+old_parent+" > ul > li").size()==0){
								$("#navee_cp_nav #"+old_parent+" > ul").remove();
							}
						}
					});

					$("#navEE .navee_trash").click(function(){
						var id = $(this).parent("li").attr("id");
						$(".navee_alert").html("'.$this->EE->lang->line('cp_msg_are_you_sure').' <a id=\'navee_trash_'.$vars["navigation_id"].'_"+id+"\' href=\'javascript:;\' class=\'x navee_trash_dump\'>'.$this->EE->lang->line('cp_msg_sure').'</a><a id=\'navee_trash_close_'.$vars["navigation_id"].'_"+id+"\' href=\'javascript:;\' class=\'x navee_trash_no_dump\'>'.$this->EE->lang->line('cp_msg_not_sure').'</a>").css("top", $(window).scrollTop()+100).slideDown(333);
					});

					$("#navEE .navee_trash_dump").live("click", function(){
						var id = $(this).attr("id").split("_");
						var navee_id 	= id[3];
						var nav_id		= id[2];

						$.ajax({
								type: "GET",
								cache: false,
								url: "'.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=delete_navigation_item",
								data: "navid="+nav_id+"&id="+navee_id,
								success: function(msg){
									//alert( "Data Saved: " + msg );
									$.ee_notice("'.$this->EE->lang->line('cp_suc_delete_navItem').'", {type: \'success\'});
									$("#navEE #navee_cp_nav #"+navee_id).remove();
									$(".navee_alert").slideUp(333);
								}
						});
					});

					$("#navEE .navee_trash_no_dump").live("click", function(){
						$(this).parent("div").fadeOut(333);
					});

					$("#navEE #navee_cp_nav ul").sortable({
							opacity: 0.8,
							update: function(event, ui) { 
							var parentId = $(this).parent().attr("id");
							if (parentId == "navee_cp_nav"){
								parentId = 0;
							}
							var ids = $(this).sortable("toArray");
							var gets = "";
							
							for (i=0; i<ids.length; i++){
								if (gets.length > 0){
									gets = gets + ",";
								}
								gets = gets + parentId+"_"+ids[i];
							}

							$.ajax({
								type: "GET",
								cache: false,
								url: "'.html_entity_decode(BASE).'&C=addons_modules&M=show_module_cp&module=navee&method=sort_navigation_items",
								data: "id="+gets,
								success: function(msg){
									//alert( "Data Saved: " + msg );
									
									$.ee_notice("'.$this->EE->lang->line('cp_suc_sorted').'", {type: \'success\'});
							
								}
							});
						}
					});
				'));
				$this->EE->javascript->compile();

			// View Variables
				$this->nav				= $this->_getNav($this->EE->input->get("id"),0,true,true);
				$vars["parents"] 		= $this->_styleNavSelect($this->nav, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				$vars["nav"] 			= $this->_styleNavCP($this->nav);
				$vars["nav_nav"]		= $this->_styleNaveeNavs($this->_getNaveeNavs());
				$vars["navee_parent"] 	= $this->EE->session->flashdata('navee_parent');
				$vars["navee_text"] 	= $this->EE->session->flashdata('navee_text');
				$vars["navee_link"] 	= $this->EE->session->flashdata('navee_link');
				$vars["navee_class"] 	= $this->EE->session->flashdata('navee_class');
				$vars["navee_id"] 		= $this->EE->session->flashdata('navee_id');
				$vars["navee_rel"] 		= $this->EE->session->flashdata('navee_rel');
				$vars["navee_name"] 	= $this->EE->session->flashdata('navee_name');
				$vars["navee_regex"] 	= $this->EE->session->flashdata('navee_regex');
				$vars["navee_target"] 	= $this->_styleTarget($this->EE->session->flashdata('navee_target'));
				$vars["navee_include"]	= $this->_styleIncInNav(1);
				$vars["memberGroups"]	= $this->_styleMemberGroups($this->_getMemberGroups());
			return $this->EE->load->view('manage_navigation', $vars, TRUE);
		} else {
			return false;
		}
		$q->free_result();
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	A D D   N A V I T E M   H A N D L E R
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function add_navitem_handler(){

		$error = false;

		// Let's do some validation
		if (!(	$this->EE->input->post("navee_text") &&
				$this->EE->input->post("navee_navigation_id"))){
				
			$this->hasErrors = true;
			$this->_addMessage($this->EE->lang->line('cp_err_all_req_fields'));	
		}

		if ($this->hasErrors){
			foreach ($_POST as $k=>$v){
				$this->EE->session->set_flashdata($k, $v);
			}

			// If we found errors, let's throw some messages around
			$this->EE->session->set_flashdata('message_failure', $this->message);
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation'.AMP.'id='.$this->EE->input->post("navee_navigation_id"));
		} else {

			// Member Groups
			$memberGroups = $this->_serializeMemberGroups($_POST);
				
			// Everything looks ok, create the navigation
			$cur_date = date('Y-m-d H:i:s');
			$data = array(
				'navigation_id' 	=> $this->EE->input->post("navee_navigation_id"),
				'site_id'			=> $this->site_id,
				'parent' 			=> $this->EE->input->post("navee_parent"),
				'text'				=> $this->EE->input->post("navee_text"),
				'link'				=> $this->EE->input->post("navee_link"),
				'class'				=> $this->EE->input->post("navee_class"),
				'id'				=> $this->EE->input->post("navee_id"),
				'include'			=> $this->EE->input->post("navee_include"),
				'rel'				=> $this->EE->input->post("navee_rel"),
				'name'				=> $this->EE->input->post("navee_name"),
				'target'			=> $this->EE->input->post("navee_target"),
				'sort'				=> $this->_nextSort($this->EE->input->post("navee_navigation_id"), $this->EE->input->post("navee_parent")),
				'datecreated'		=> $cur_date,
				'dateupdated'		=> $cur_date,
				'ip_address'		=> $this->EE->input->ip_address(),
				'member_id'			=> $this->EE->session->userdata['member_id']
			);

			$this->EE->db->insert('navee', $data);
			$id = $this->EE->db->insert_id();
			
			// Insert new entries into navee_members if they exist
			if (strlen($memberGroups)>0){
				$data = array(
					'site_id' 		=> $this->site_id,
					'navee_id' 		=> $id,
					'members' 		=> $memberGroups
				);

				$this->EE->db->insert('navee_members', $data);
			}

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('cp_suc_new_nav_item'));
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation'.AMP.'id='.$this->EE->input->post("navee_navigation_id"));
		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	A D D   N A V I G A T I O N 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function add_navigation(){
		$vars = array();
		$this->EE->load->library('table');
		$this->EE->load->library('javascript');
		$this->EE->cp->set_breadcrumb(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=index', $this->EE->lang->line('navee_module_name'));
		$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('cp_an_add_nav_group'));

		$this->EE->cp->add_to_head('<link rel="stylesheet" type="text/css" href="'.$this->EE->config->item('theme_folder_url').'navee/css/navee.css" />');

		// Javascript
			$this->EE->javascript->output(array('
				$("#navEE .x").click(function(){
					$(this).parent("div").fadeOut(333);
				});
				
				$("body").click(function(){
					$(".navee_helper").fadeOut(333);
				});
			'));

			$this->EE->javascript->compile();

		// Check to see if there is anything in the database
			$this->EE->db->select("navigation_id");
			$q = $this->EE->db->get("navee_navs");

			$vars["alert"] 		= "";
			$vars["helper"] 	="";

			switch($q->num_rows()){
				case 0:
					$vars["helper"] = $this->EE->lang->line('cp_hlp_nav_1');
					break;
				case 1:
					$vars["helper"] = $this->EE->lang->line('cp_hlp_nav_2');
					break;
			}

			$q->free_result();

		return $this->EE->load->view('add_navigation', $vars, TRUE);
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	A D D   N A V I G A T I O N   H A N D L E R
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function add_navigation_handler(){

		$error = false;

		// Let's do some validation
		if (!(	$this->EE->input->post("navee_name") && 
				$this->EE->input->post("navee_title") && 
				$this->EE->input->post("navee_description"))){

			$this->hasErrors = true;
			$this->_addMessage($this->EE->lang->line('cp_err_all_fields'));

		} elseif (!preg_match('/^[a-zA-Z-_]+$/', $this->EE->input->post("navee_title"))){
			$this->hasErrors = true;
			$this->_addMessage($this->EE->lang->line('cp_err_title_format'));
		}

		if ($this->hasErrors){

			// If we found errors, let's throw some messages around
			$this->EE->session->set_flashdata('message_failure', $this->message);
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=add_navigation');
		} else {

			// Everything looks ok, create the navigation
			$cur_date = date('Y-m-d H:i:s');
			$data = array(
				'nav_title' 		=> $this->EE->input->post("navee_title"),
				'site_id'			=> $this->site_id, 
				'nav_name' 			=> $this->EE->input->post("navee_name"), 
				'nav_description'	=> $this->EE->input->post("navee_description"),
				'datecreated'		=> $cur_date,
				'dateupdated'		=> $cur_date,
				'ip_address'		=> $this->EE->input->ip_address(),
				'member_id'			=> $this->EE->session->userdata['member_id']
			);

			$this->EE->db->insert('navee_navs', $data);

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('cp_suc_new_nav'));
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation'.AMP.'id='.$this->EE->db->insert_id());
		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	U P D A T E   N A V I G A T I O N   I T E M 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function update_navigation_item(){
		if ($this->EE->input->get("id") && ($this->EE->input->get("navee_parent") !== $this->EE->input->get("id"))){
			// Let's do some validation
				if (!($this->EE->input->get("navee_text"))){
					$this->hasErrors = true;
				}

				if ($this->hasErrors){
					print("error");
					exit;
				}
				
				// Member Groups
				$memberGroups = $this->_serializeMemberGroups($_GET);

				$this->EE->db->select("*");
				$this->EE->db->where("navee_id", $this->EE->input->get("id"));
				$q = $this->EE->db->get("navee");
				$sort = 1;

				if ($q->num_rows() == 1){
					$r = $q->row();
					if ($r->parent !== $this->EE->input->get("navee_parent")){
						$this->EE->db->select("*");
						$this->EE->db->where("parent", $this->EE->input->get("navee_parent"));
						$this->EE->db->order_by("sort", "desc");
						$qPar = $this->EE->db->get("navee",1);
						if ($qPar->num_rows() == 1){
							$rPar = $qPar->row();
							$sort = $rPar->sort + 1;
						}
						$qPar->free_result();

					} else {
						$sort = $r->sort;
					}
				}
				$q->free_result();

				$data = array(
					'parent' 			=> $this->EE->input->get("navee_parent"),
					'text'				=> $this->_naveeDecode(html_entity_decode($this->EE->input->get("navee_text"),ENT_COMPAT,"UTF-8")),
					'link'				=> $this->_naveeDecode(html_entity_decode($this->EE->input->get("navee_link"),ENT_COMPAT,"UTF-8")),
					'class'				=> $this->_naveeDecode($this->EE->input->get("navee_class")),
					'id'				=> $this->_naveeDecode($this->EE->input->get("navee_id")),	
					'include'			=> $this->EE->input->get("navee_include"),
					'sort'				=> $sort,
					'rel'				=> $this->_naveeDecode($this->EE->input->get("navee_rel")),
					'name'				=> $this->_naveeDecode($this->EE->input->get("navee_name")),
					'target'			=> $this->_naveeDecode($this->EE->input->get("navee_target")),
					'regex'				=> $this->_naveeDecode($this->EE->input->get("navee_regex"))
				);

				$this->EE->db->where('navee_id', $this->EE->input->get("id"));
				$this->EE->db->update('navee', $data);
				
				// Delete any existing entries in navee_members
				$this->EE->db->where("site_id", $this->site_id);
				$this->EE->db->where("navee_id", $this->EE->input->get("id"));
				$this->EE->db->delete('navee_members');
				
				// Insert new entries into navee_members if they exist
				if (strlen($memberGroups)>0){
					$data = array(
						'site_id' 		=> $this->site_id,
						'navee_id' 		=> $this->EE->input->get("id"),
						'members' 		=> $memberGroups
					);

					$this->EE->db->insert('navee_members', $data);
				}
				
				$sort++;
			return true;
		} else {
			return false;
		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   N A V I G A T I O N   I T E M   F O R M
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function get_navigation_item_form(){
		$returnMe = "";

		if ($this->EE->input->get("id")){
			// Get an array of Pages
			$pages 					= $this->EE->config->item('site_pages');
			$selectPages 			= "";
			$selectPagesBtn			= "";
			$enterLinkBtn			= "";
			$memberGroups			= $this->_getMemberGroups();
			$memberGroupsSelected	= $this->_getSelectedMemberGroups($this->EE->input->get("id"));
	
			
			if (isset($pages[$this->site_id]["uris"])){
				$numPages = sizeof($pages[$this->site_id]["uris"]);
			} else {
				$numPages = 0;
			}

			if ($numPages > 0){
				$selectPages = $this->_stylePagesSelect($pages[$this->site_id]["uris"]);
				$selectPagesBtn = " or <a href='javascript:;' class='select_pages'>".$this->EE->lang->line('cp_mn_select_pages')."</a>";
				$enterLinkBtn	= " or <a href='javascript:;' class='enter_link'>".$this->EE->lang->line('cp_mn_enter_link')."</a>";
			}

			$this->EE->db->select("*");
			$this->EE->db->where("navee_id", $this->EE->input->get("id"));
			$q = $this->EE->db->get("navee");
			if ($q->num_rows() == 1){
				$r = $q->row();
				$this->nav = $this->_getNav($r->navigation_id,0,true,true,true,$this->EE->input->get("id"));

				// Form for editing nav item
				$returnMe .= "<form class='naveeCPForm' onsubmit='return false;' name='naveeCPForm_".$r->navee_id."'>
									<input type='hidden' name='id' value='".$r->navee_id."' />
									<input type='hidden' name='old_parent' value='".$r->parent."' class='old_parent' />
									<ol class='required'>
										<li>
											<label for='navee_text'>".$this->EE->lang->line('cp_form_text').":</label>
											<input type='input' name='navee_text' value='".$r->text."' />
										</li>

										<li class='naveeLink'>
											<label for='navee_link'>".$this->EE->lang->line('cp_form_link').$selectPagesBtn.":</label>
											<input type='input' name='navee_link' value='".$r->link."' />
										</li>";

				if ($numPages>0){
					$returnMe .= "<li class='pagesSelect'>
											<label for='navee_pages'>".$this->EE->lang->line('cp_form_pages').$enterLinkBtn.":</label>
											".$selectPages."
										</li>";
				}

				$returnMe .= "<li>
											<label for='navee_parent'>".$this->EE->lang->line('cp_form_parent').":</label>
											<select name='navee_parent'>
												<option value='0'>".$this->EE->lang->line('cp_form_top_level')."</option>
												".$this->_styleNavSelect($this->nav,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",$r->parent)."
											</select>
										</li>
									</ol>

								<div class='navee_optional'>
								<h3>".$this->EE->lang->line('cp_mn_optional_items')."</h3>
									<ol>
										<li>
											<label for='navee_include'>".$this->EE->lang->line('cp_form_include_in')."</label>
											<select name='navee_include'>
												".$this->_styleIncInNav($r->include)."
											</select>
										</li>

										<li>
											<label for='navee_id'>".$this->EE->lang->line('cp_form_id').":</label>
											<input type='input' name='navee_id' value='".$r->id."' />
										</li>

										<li>
											<label for='navee_class'>".$this->EE->lang->line('cp_form_class').":</label>
											<input type='input' name='navee_class' value='".$r->class."' />
										</li>

										<li>
											<label for='navee_rel'>".$this->EE->lang->line('cp_form_rel').":</label>
											<input type='input' name='navee_rel' value='".$r->rel."' />
										</li>

										<li>
											<label for='navee_name'>".$this->EE->lang->line('cp_form_name').":</label>
											<input type='input' name='navee_name' value='".$r->name."' />
										</li>

										<li>
											<label for='navee_target'>".$this->EE->lang->line('cp_form_target')."</label>
											<select name='navee_target'>
												".$this->_styleTarget($r->target)."
											</select>
										</li>

										<li>
											<label for='navee_regex'>".$this->EE->lang->line('cp_form_regex').":</label>
											<input type='input' name='navee_regex' value='".$r->regex."' />
										</li>
										
										<li>
											<label for='navee_member_groups'>".$this->EE->lang->line('cp_form_member_groups').":<br /><em>".$this->EE->lang->line('cp_form_member_groups_desc')."</em></label>
											".$this->_styleMemberGroups($memberGroups, $memberGroupsSelected)."
										</li>
										

									</ol>
								</div>
								<ul class='actions'>
									<li><a href='javascript:;' class='navee_optional_btn btn options'>".$this->EE->lang->line('cp_mn_optional')."</a></li>
									<li><input type='submit' value='".$this->EE->lang->line('cp_mn_update')."' name='navee_update' class='navee_update_btn btn action' /></li>
								</ul>
								</form>";
				$q->free_result();
				print($returnMe);
				exit;
			}
		}
		return false;
	}


	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	N E W   N A V I G A T I O N   I T E M   F O R M
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function new_navigation_item_form(){
		$returnMe = "";
		$this->EE->load->helper('form');

		if ($this->EE->input->get("id")){

			// Get an array of Pages
			$pages 					= $this->EE->config->item('site_pages');
			$selectPages 			= "";
			$selectPagesBtn			= "";
			$enterLinkBtn			= "";
			$memberGroups			= $this->_getMemberGroups();
			
			if (isset($pages[$this->site_id]["uris"])){
				$numPages = sizeof($pages[$this->site_id]["uris"]);
			} else {
				$numPages = 0;
			}

			if ($numPages>0){
				$selectPages = $this->_stylePagesSelect($pages[$this->site_id]["uris"]);
				$selectPagesBtn = " or <a href='javascript:;' class='select_pages'>".$this->EE->lang->line('cp_mn_select_pages')."</a>";
				$enterLinkBtn	= " or <a href='javascript:;' class='enter_link'>".$this->EE->lang->line('cp_mn_enter_link')."</a>";
			}

			$this->nav = $this->_getNav($this->EE->input->get("id"),0,true,true);

			// Form for editing nav item

			$returnMe .= form_open('C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=add_navitem_handler');
			$returnMe .= "<input type='hidden' name='navee_navigation_id' value='".$this->EE->input->get("id")."' />
								<ol class='required'>
									<li>
										<label for='navee_text'>".$this->EE->lang->line('cp_form_text').":</label>
										<input type='input' name='navee_text' value='' />
									</li>

									<li class='naveeLink'>
										<label for='navee_link'>".$this->EE->lang->line('cp_form_link').$selectPagesBtn.":</label>
										<input type='input' name='navee_link' value='' />
									</li>";

			if ($numPages>0){
					$returnMe .= "<li class='pagesSelect'>
											<label for='navee_pages'>".$this->EE->lang->line('cp_form_pages').$enterLinkBtn.":</label>
											".$selectPages."
										</li>";
			}

			$returnMe .= "<li>
										<label for='navee_parent'>".$this->EE->lang->line('cp_form_parent').":</label>
										<select name='navee_parent'>
											<option value='0'>".$this->EE->lang->line('cp_form_top_level')."</option>
											".$this->_styleNavSelect($this->nav,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")."
										</select>
									</li>
								</ol>

							<div class='navee_optional'>
							<h3>".$this->EE->lang->line('cp_mn_optional_items')."</h3>
								<ol>
									<li>
										<label for='navee_include'>".$this->EE->lang->line('cp_form_include_in')."</label>
										<select name='navee_include'>
											".$this->_styleIncInNav()."
										</select>
									</li>

									<li>
										<label for='navee_id'>".$this->EE->lang->line('cp_form_id').":</label>
										<input type='input' name='navee_id' value='' />
									</li>

									<li>
										<label for='navee_class'>".$this->EE->lang->line('cp_form_class').":</label>
										<input type='input' name='navee_class' value='' />
									</li>

									<li>
										<label for='navee_rel'>".$this->EE->lang->line('cp_form_rel').":</label>
										<input type='input' name='navee_rel' value='' />
									</li>

									<li>
										<label for='navee_name'>".$this->EE->lang->line('cp_form_name').":</label>
										<input type='input' name='navee_name' value='' />
									</li>

									<li>
										<label for='navee_target'>".$this->EE->lang->line('cp_form_target')."</label>
										<select name='navee_target'>
											".$this->_styleTarget()."
										</select>
									</li>

									<li>
										<label for='navee_regex'>".$this->EE->lang->line('cp_form_regex').":</label>
										<input type='input' name='navee_regex' value='' />
									</li>
									
									<li>
											<label for='navee_member_groups'>".$this->EE->lang->line('cp_form_member_groups').":<br /><em>".$this->EE->lang->line('cp_form_member_groups_desc')."</em></label>
											".$this->_styleMemberGroups($memberGroups)."
									</li>

								</ol>
							</div>
							<ul class='actions'>
								<li><a href='javascript:;' class='navee_optional_btn btn options'>".$this->EE->lang->line('cp_mn_optional')."</a></li>
								<li><input type='submit' id='add-to-nav-btn' class='btn action' value='".$this->EE->lang->line('cp_mn_submit_add')."' name='navee_submit' /></li>
							</ul>";
			$returnMe .= form_close();

			print($returnMe);
			exit;
		} else {
			return false;
		}
	}


	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	D E L E T E   N A V I G A T I O N   I T E M
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function delete_navigation_item(){
		
		$error = false;
		
		// Let's do some validation
		if (!$this->EE->input->get("id")){		
			$this->hasErrors = true;
			$this->_addMessage($this->EE->lang->line('cp_err_unknown'));	
		}

		if ($this->hasErrors){

			// If we found errors, let's throw some messages around
			$this->EE->session->set_flashdata('message_failure', $this->message);
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation&id='.$this->EE->input->get("navid"));
		} else {

			// Everything looks ok, delete the navigation
			$data = array(
				'navee_id' 		=> $this->EE->input->get("id")
			);

			$this->EE->db->delete('navee', $data);

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('cp_suc_delete_navItem'));
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation&id='.$this->EE->input->get("navid"));

		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S O R T   N A V I G A T I O N   I T E M S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function sort_navigation_items(){
		if ($this->EE->input->get("id")){
			$chunk = split(",", $this->EE->input->get("id"));
			$sort = 1;
			foreach ($chunk as $k=>$v){
				$bit = split("_", $v);
				$parent 	= $bit[0];
				$navee_id 	= $bit[1];

				$data = array(
					'parent' 			=> $parent, 
					'sort'				=> $sort
				);

				$this->EE->db->where('navee_id', $navee_id);
				$this->EE->db->update('navee', $data); 
				$sort++;
			}
			return true;
		} else {
			return false;
		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	D E L E T E   N A V I G A T I O N 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function delete_navigation(){
		
		$error = false;
		
		// Let's do some validation
		if (!$this->EE->input->get("id")){
			$this->hasErrors = true;
			$this->_addMessage($this->EE->lang->line('cp_err_unknown'));
		}

		if ($this->hasErrors){

			// If we found errors, let's throw some messages around
			$this->EE->session->set_flashdata('message_failure', $this->message);
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=index');
		} else {

			// Everything looks ok, delete the navigation
			$data = array(
				'navigation_id' 	=> $this->EE->input->get("id")
			);

			$this->EE->db->delete('navee_navs', $data);

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('cp_suc_delete_nav'));
			$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=index');
		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	U P D A T E   N A V I G A T I O N 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function update_navigation(){

		$error = false;

		$types = array(
				'0' 	=> 'name',
				'1'		=> 'title',
				'2'		=> 'description'
			);

		// Let's do some validation
		if (!($this->EE->input->get("id") && $this->EE->input->get("type") && $this->EE->input->get("content")) && in_array($this->EE->input->get("type"), $types)){
			$this->hasErrors = true;
			$this->_addMessage($this->EE->lang->line('cp_err_unknown'));
		}

		if ($this->EE->input->get("type")=="title"){
			if (!preg_match('/^[a-zA-Z-_]+$/', $this->EE->input->get("content"))){
				$this->hasErrors = true;
				$this->_addMessage($this->EE->lang->line('cp_err_title_format'));
			}
		}

		if ($this->hasErrors){
			// If we found errors, let's throw some messages around
			print($this->message);
			exit;
		} else {

			// Everything looks ok, update the navigation
			$cur_date = date('Y-m-d H:i:s');

			$data = array();
			$data['dateupdated'] 	= $cur_date;
			$data['member_id']		= $this->EE->session->userdata['member_id'];

			switch ($this->EE->input->get("type")) {
				case "name":
				$data['nav_name'] = $this->EE->input->get("content");
				break;
			case "title":
			$data['nav_title'] = $this->EE->input->get("content");
				break;
			case "description":
			$data['nav_description'] = $this->EE->input->get("content");
				break;
		}

			$this->EE->db->where('navigation_id', $this->EE->input->get("id"));
			$this->EE->db->update('navee_navs', $data);

			exit;

		}
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   N A V
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _getNav($navId, $parent=0, $recursive=true, $ignoreInclude=false, $skipOwnKids=false, $skipID=0){

		$nav = array();

		$this->EE->db->select("n.navee_id,
							   n.parent,
							   n.text,
							   n.link,
							   n.class,
							   n.id,
							   n.sort,
							   n.include,
							   n.rel,
							   n.name,
							   n.target,
							   n.regex,
							   nn.nav_title");
		$this->EE->db->from("navee AS n");
		$this->EE->db->join("navee_navs AS nn", "n.navigation_id=nn.navigation_id");
		$this->EE->db->where("n.navigation_id", $navId);
		$this->EE->db->where("n.parent", $parent);
		$this->EE->db->where("n.site_id", $this->site_id);
		$this->EE->db->order_by("n.sort", "asc");
		if (!$ignoreInclude){
			$this->EE->db->where("n.include", 1);
		}
		$q = $this->EE->db->get();
		if ($q->num_rows() > 0){
			$count = 0;
			foreach ($q->result() as $r){
				$nav[$count]["navee_id"] 	= $r->navee_id;
				$nav[$count]["parent"] 		= $r->parent;
				$nav[$count]["text"] 		= $r->text;
				$nav[$count]["link"] 		= $r->link;
				$nav[$count]["class"] 		= $r->class;
				$nav[$count]["id"] 			= $r->id;
				$nav[$count]["sort"] 		= $r->sort;
				$nav[$count]["include"] 	= $r->include;
				$nav[$count]["rel"]			= $r->rel;
				$nav[$count]["name"]		= $r->name;
				$nav[$count]["target"]		= $r->target;
				$nav[$count]["regex"]		= $r->regex;
				$nav[$count]["nav_title"]	= $r->nav_title;

				if ($recursive){
					if ($skipOwnKids){
						if ($skipID == $r->navee_id){
							$nav[$count]["kids"] = array();
						} else {
							$nav[$count]["kids"] = $this->_getNav($navId, $r->navee_id, $recursive, $ignoreInclude, $skipOwnKids, $skipID);
						}
					} else {
						$nav[$count]["kids"] = $this->_getNav($navId, $r->navee_id, $recursive, $ignoreInclude, $skipOwnKids, $skipID);
					}
					
				} else {
					$nav[$count]["kids"] = array();
				}
				$count++;
			}
		}
		$q->free_result();

		return $nav;
	}
	

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   N A V E E   N A V S 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _getNaveeNavs(){

		$navee_navs = array();

		$this->EE->db->select("*");
		$this->EE->db->order_by("nav_name", "ASC");
		$this->EE->db->where("site_id", $this->site_id);
		$q = $this->EE->db->get("navee_navs");
		if ($q->num_rows() > 0){
			foreach ($q->result() as $r){
				$navee_navs[$r->navigation_id]["navigation_id"] 	= $r->navigation_id;
				$navee_navs[$r->navigation_id]["nav_title"] 		= $r->nav_title;
				$navee_navs[$r->navigation_id]["nav_name"] 			= $r->nav_name;
				$navee_navs[$r->navigation_id]["nav_description"] 	= $r->nav_title;
			}
		}
		$q->free_result();

		return $navee_navs;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   N A V E E   N A V S 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleNaveeNavs($navs){

		$returnMe = "<ul id='nav-nav'>";
		$manage_nav_link = BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=manage_navigation';

		foreach ($navs as $k=>$v){
			$returnMe .= "<li><a href='".$manage_nav_link."&id=".$v["navigation_id"]."' title='".$this->EE->lang->line('cp_edit')." ".$this->EE->lang->line('cp_navigation_group').": ".$v["nav_name"]."'>".$v["nav_name"]."</a><li>";
		}

		$returnMe .= "<li class='nav-nav-add'><a href='".BASE.AMP."C=addons_modules".AMP."M=show_module_cp".AMP."module=navee".AMP."method=add_navigation"."' title='".$this->EE->lang->line('cp_mn_add_nav_group')."'>+</a></li>";
		$returnMe .= "</ul>";
		
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   N A V   C P
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleNavCP($nav){
		$returnMe = "";

		if (sizeof($nav)>0){

			$returnMe .= "<ul>";

			foreach ($nav as $k=>$v){
			
				// Open the <li> for our nav item
				$returnMe .= "<li id='".$v["navee_id"]."'><span class='navee_cp_text'>".$v["text"]."</span>";

				// edit/delete functionality
				$returnMe .= "<a class='navee_trash icn' title='".$this->EE->lang->line('cp_delete')."' href='javascript:;'><img src='".$this->EE->config->item('theme_folder_url')."navee/img/trash.png' /></a><a class='navee_edit icn' title='".$this->EE->lang->line('cp_edit')."' href='javascript:;'><img src='".$this->EE->config->item('theme_folder_url')."navee/img/edit.png' /></a><a class='navee_code icn' title='".$this->EE->lang->line('cp_code')."' href='javascript:;'><img src='".$this->EE->config->item('theme_folder_url')."navee/img/process.png' /></a>";
				// Cut/Paste EE tags
				$returnMe .= "<div class='navee_ee_tag'><p>".$this->EE->lang->line('cp_mn_ee_code')."</p><textarea readonly='readonly'>{exp:navee:nav nav_title=\"".$v["nav_title"]."\" start_node=\"".$v["navee_id"]."\"}</textarea></div>";

				// Form for editing nav item
				$returnMe .= "<div class='navee_edit_form'></div>";
				// If our nav item has kids, let's recurse
				if (sizeof($v["kids"])>0){
					$returnMe .= $this->_styleNavCP($v["kids"]);
				}

				// Close out the </li>
				$returnMe .= "</li>";
			}
			$returnMe .= "</ul>";
		}
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   N A V   S E L E C T
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleNavSelect($nav,$spaces="",$selected=""){
		$returnMe = "";

		if (sizeof($nav)>0){
			foreach ($nav as $k=>$v){
				$returnMe .= "<option ";
				
				// Check to see if this is the selected item
				if ($v["navee_id"] == $selected){
					$returnMe .= "selected='selected' ";
				}
				
				$returnMe .= "value='".$v["navee_id"]."'>".$spaces.$v["text"]."</option>";
				if (sizeof($v["kids"])>0){
					$returnMe .= $this->_styleNavSelect($v["kids"],$spaces."&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",$selected);
				}
			}
		}
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   P A G E S   S E L E C T
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _stylePagesSelect($pages){
		$returnMe = "<select name='pages' class='pagesDropdown'><option value=''>Select One</option>";
	
		if (sizeof($pages)>0){
			foreach ($pages as $k=>$v){
				$returnMe .= "<option value='".$v."'>".$v."</option>";
			}
		}
		$returnMe .= "</select>";
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   T A R G E T 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleTarget($val=''){

		$returnMe = "";

		$types = array(
				'None'		=> '',
				'_blank' 	=> '_blank',
				'_parent' 	=> '_parent',
				'_self' 	=> '_self',
				'_top' 		=> '_top'
			);

		foreach ($types as $k=>$v){
			$returnMe .= "<option ";
			if ($val == $v){
				$returnMe .= "selected='selected' ";
			}
			$returnMe .= "value='".$v."'>".$k."</option>";
		}
		
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   I N C   I N   N A V 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleIncInNav($val="1"){
		
		$returnMe = "";
		
		$types = array(
				'True'		=> '1',
				'False' 	=> '0'
			);

		foreach ($types as $k=>$v){
			$returnMe .= "<option ";
			if ($val == $v){
				$returnMe .= "selected='selected' ";
			}
			$returnMe .= "value='".$v."'>".$k."</option>";
		}
		
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	N E X T   S O R T
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _nextSort($navigation_id, $parent=0){
	 	$this->EE->db->select("sort");
	 	$this->EE->db->where("parent", $parent);
	 	$this->EE->db->where("navigation_id", $navigation_id);
	 	$this->EE->db->order_by("sort", "desc");
	 	$q = $this->EE->db->get("navee", 1);
	 	if ($q->num_rows() == 1){
			$r = $q->row();
			return ($r->sort + 1);
		} else {
			return 1;
		}
		$q->free_result();
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   M E M B E R   G R O U P S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _getMemberGroups(){

		$groups = array();

		$this->EE->db->select("group_id, group_title");
		$this->EE->db->order_by("group_title", "ASC");
		$this->EE->db->where("site_id", $this->site_id);
		$q = $this->EE->db->get("member_groups");
		if ($q->num_rows() > 0){
			foreach ($q->result() as $r){
				$groups[$r->group_id]["group_id"] 		= $r->group_id;
				$groups[$r->group_id]["group_title"] 	= $r->group_title;
			}
		}
		$q->free_result();

		return $groups;
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   S E L E C T E D   M E M B E R   G R O U P S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _getSelectedMemberGroups($navee_id){

		$groups = array();

		$this->EE->db->select("members");
		$this->EE->db->where("site_id", $this->site_id);
		$this->EE->db->where("navee_id", $navee_id);
		$q = $this->EE->db->get("navee_members");
		if ($q->num_rows() > 0){
			$row = $q->row();
			$groups = unserialize($row->members);
		}
		$q->free_result();

		return $groups;
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   M E M B E R   G R O U P S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleMemberGroups($groups, $selected = array()){
		$returnMe = "";

		if (sizeof($groups)>0){
			$returnMe .= '<ul class="memberGroups">';
			foreach ($groups as $k=>$v){
				$checked = "";
				if (in_array($v['group_id'], $selected)){
					$checked = "checked='checked' ";
				}
				
				$returnMe .= '<li><input type="checkbox" '.$checked.'name="memGroup_'.$v['group_id'].'" /> '.$v["group_title"].'</li>';
			}
			$returnMe .= '</ul>';
		}
		return $returnMe;
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S E R I A L I Z E   M E M B E R   G R O U P S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _serializeMemberGroups($fields){
		$groups = array();
		$getVar = array();
		$count = 0;
		foreach($fields as $k=>$v){
			
			$getVar = explode("_", $k);
			if (sizeof($getVar) > 0){
				if ($getVar[0] == "memGroup"){
					$groups[$count] = $getVar[1];
					$count++;
				}
			}
		}
		
		if (sizeof($groups) > 0){
			return serialize($groups);
		} else {
			return "";
		}
		
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	A D D   M E S S A G E
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _addMessage($msg){
		if (strlen($this->message) > 0){
			$this->message .= "<br />";
		} else {
			$this->message .= "<h2>NavEE Errors</h2>";
		}

		$this->message .= $msg;
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	N A V E E   D E C O D E
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _naveeDecode($str){
		$str = str_replace("__navEE__3f", "?", $str);
		$str = str_replace("__navEE__3b", ";", $str);
		return $str;
	}

}
?>