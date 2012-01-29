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
Location:			./system/expressionengine/third_party/modules/navee/mod.navee.php
Contact:			navee@booyant.com  / 978.OKAY.BOB
Version:			1.1.2

*/

if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Navee {

    var $version						= '1.1.2';
    var $navigation_id					= 0;
    var $navee_id						= 0;
    var $parent							= 0;
    var $recursive						= true;
    var $ignore_include_in_nav			= false;
    var $nav_class						= "";
    var $nav_id							= "";
    var $last_class						= "";
    var $first_class					= "";
    var $selected_class					= "selected";
    var $no_selected					= false;
    var $selected_class_on_parents		= false;
    var $list_type						= "ul";
    var $nav							= array();
    var $no_last_anchor					= false;
    var $spacer							= "";
    var $no_last_spacer					= false;
    var $last_item						= "";
    var $last_item_link					= "";
    var $has_kids						= false;
    var $kid_count						= 0;

	function Navee(){
		// ExpressionEngine super object
		$this->EE =& get_instance();	
		$this->site_id = $this->EE->config->item('site_id');
		// Comment out the following line to enable caching
		$this->EE->db->cache_off();
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	N A V
	//
	//		P A R A M E T E R S
	//		------------------------
	//			* nav_title
	//			* start_node					(optional)
	//			* no_children					(optional)
	//			* class 						(optional)
	//			* id 							(optional)
	//			* ignore_include_in_nav			(optional)
	//			* selected_class_on_parents 	(optional)
	//			* last_class					(optional)
	//			* first_class					(optional)
	//			* selected_class				(optional)
	//			* no_selected					(optional)
	//			* list_type						(optional)
	//
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function nav(){
		
		$output="";
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		// Set Parameters
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		if ($this->EE->TMPL->fetch_param("nav_title")){
			$this->EE->db->select("navigation_id");
			$this->EE->db->where("nav_title", $this->EE->TMPL->fetch_param("nav_title"));
			$this->EE->db->where("site_id", $this->site_id);
			$q = $this->EE->db->get("navee_navs", 1);
			if ($q->num_rows() > 0){
				$row = $q->row();
				$this->navigation_id = $row->navigation_id;
			}
			$q->free_result();
		}

			if ($this->navigation_id){
				if ($this->EE->TMPL->fetch_param("start_node")){
					if (is_numeric($this->EE->TMPL->fetch_param("start_node"))){
						$this->parent = $this->EE->TMPL->fetch_param("start_node");
					} else {
						$this->EE->db->select("navee_id");
						$this->EE->db->where("link", $this->EE->TMPL->fetch_param("start_node"));
						$this->EE->db->where("navigation_id", $this->navigation_id);
						$this->EE->db->where("site_id", $this->site_id);
						$q = $this->EE->db->get("navee", 1); 
			
						if ($q->num_rows() > 0){
							$row = $q->row();
							$this->parent = $row->navee_id;
						}
						$q->free_result();
					}
				}

				if ($this->EE->TMPL->fetch_param("selected_class_on_parents")){
					$this->selected_class_on_parents = true;
				}

				if ($this->EE->TMPL->fetch_param("no_children")){
					$this->recursive = false;
				}

				if ($this->EE->TMPL->fetch_param("class")){
					$this->nav_class = $this->EE->TMPL->fetch_param("class");
				}

				if ($this->EE->TMPL->fetch_param("id")){
					$this->nav_id = $this->EE->TMPL->fetch_param("id");
				}

				if ($this->EE->TMPL->fetch_param("ignore_include_in_nav")){
					$this->ignore_include_in_nav = true;
				}

				if ($this->EE->TMPL->fetch_param("last_class")){
					$this->last_class = $this->EE->TMPL->fetch_param("last_class");
				}

				if ($this->EE->TMPL->fetch_param("first_class")){
					$this->first_class = $this->EE->TMPL->fetch_param("first_class");
				}

				if ($this->EE->TMPL->fetch_param("selected_class")){
					$this->selected_class = $this->EE->TMPL->fetch_param("selected_class");
				}

				if ($this->EE->TMPL->fetch_param("list_type") == "ol"){
					$this->list_type = "ol";
				}

				if ($this->EE->TMPL->fetch_param("no_selected")){
					$this->no_selected = true;
				}

				if ($this->navigation_id){
					// We have a Navigation ID, so let's build the navigation
					$this->nav = $this->_getNav($this->navigation_id, $this->parent, $this->recursive, $this->ignore_include_in_nav);
					// Style the navigation for output
					$output = $this->_styleNav($this->nav);	

				}
			} else {
				// Some quick, in-template error messaging
				//$output = "NavEE Notice: You must enter a nav_title.";
				$output = "";
			}

		return $output;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	C U S T O M
	//
	//		P A R A M E T E R S
	//		------------------------
	//			* nav_title
	//			* start_node					(optional)
	//			* no_children					(optional)
	//			* class 						(optional)
	//			* id 							(optional)
	//			* ignore_include_in_nav			(optional)
	//			* selected_class_on_parents 	(optional)
	//			* last_class					(optional)
	//			* first_class					(optional)
	//			* selected_class				(optional)
	//			* no_selected					(optional)
	//			* wrap_type						(optional)
	//
	//		V A R I A B L E S
	//		------------------------------
	//			* navee_id
	//			* navigation_id
	//			* text
	//			* link
	//			* class
	//			* id
	//			* rel
	//			* name
	//			* target
	//			* has_kids
	//			* kid_count
	//
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function custom(){

		$output="";

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		// Set Parameters
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		if ($this->EE->TMPL->fetch_param("nav_title")){
			$this->EE->db->select("navigation_id");
			$this->EE->db->where("nav_title", $this->EE->TMPL->fetch_param("nav_title"));
			$this->EE->db->where("site_id", $this->site_id);
			$q = $this->EE->db->get("navee_navs", 1);
			if ($q->num_rows() > 0){
				$row = $q->row();
				$this->navigation_id = $row->navigation_id;
			}
			$q->free_result();
		}

			if ($this->navigation_id){
				if ($this->EE->TMPL->fetch_param("start_node")){
					if (is_numeric($this->EE->TMPL->fetch_param("start_node"))){
						$this->parent = $this->EE->TMPL->fetch_param("start_node");
					} else {
						$this->EE->db->select("navee_id");
						$this->EE->db->where("link", $this->EE->TMPL->fetch_param("start_node"));
						$this->EE->db->where("navigation_id", $this->navigation_id);
						$this->EE->db->where("site_id", $this->site_id);
						$q = $this->EE->db->get("navee", 1); 
			
						if ($q->num_rows() > 0){
							$row = $q->row();
							$this->parent = $row->navee_id;
						}
						$q->free_result();
					}
				}

				if ($this->EE->TMPL->fetch_param("selected_class_on_parents")){
					$this->selected_class_on_parents = true;
				}

				if ($this->EE->TMPL->fetch_param("no_children")){
					$this->recursive = false;
				}

				if ($this->EE->TMPL->fetch_param("class")){
					$this->nav_class = $this->EE->TMPL->fetch_param("class");
				}

				if ($this->EE->TMPL->fetch_param("id")){
					$this->nav_id = $this->EE->TMPL->fetch_param("id");
				}

				if ($this->EE->TMPL->fetch_param("ignore_include_in_nav")){
					$this->ignore_include_in_nav = true;
				}

				if ($this->EE->TMPL->fetch_param("last_class")){
					$this->last_class = $this->EE->TMPL->fetch_param("last_class");
				}

				if ($this->EE->TMPL->fetch_param("first_class")){
					$this->first_class = $this->EE->TMPL->fetch_param("first_class");
				}

				if ($this->EE->TMPL->fetch_param("selected_class")){
					$this->selected_class = $this->EE->TMPL->fetch_param("selected_class");
				}

				if ($this->EE->TMPL->fetch_param("wrap_type")){
					if (strtolower($this->EE->TMPL->fetch_param("wrap_type"))=="none"){
						$this->list_type = "";
					} else {
						$this->list_type = $this->EE->TMPL->fetch_param("wrap_type");
					}
				}

				if ($this->EE->TMPL->fetch_param("no_selected")){
					$this->no_selected = true;
				}

				if ($this->navigation_id){
					// We have a Navigation ID, so let's build the navigation
					$this->nav = $this->_getNav($this->navigation_id, $this->parent, $this->recursive, $this->ignore_include_in_nav);
					// Style the navigation for output
					$output = $this->_styleCustom($this->nav);
				}
			} else {
				// Some quick, in-template error messaging
				$output = "NavEE Notice: You must enter a nav_title.";
			}

		return $output;
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	C R U M B S
	//
	//		P A R A M E T E R S
	//		------------------------
	//			* nav_title
	//			* list_type					(optional)
	//			* class						(optional)
	//			* id						(optional)
	//			* ignore_include_in_nav		(optional)
	//			* no_last_anchor			(optional)
	//			* last_item					(optional)
	//			* last_item_link			(optional)
	//
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function crumbs(){

		$output="";
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		// Set Parameters
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		if ($this->EE->TMPL->fetch_param("nav_title")){
			$this->EE->db->select("navigation_id");
			$this->EE->db->where("nav_title", $this->EE->TMPL->fetch_param("nav_title"));
			$this->EE->db->where("site_id", $this->site_id);
			$q = $this->EE->db->get("navee_navs", 1);
			if ($q->num_rows() > 0){
				$row = $q->row();
				$this->navigation_id = $row->navigation_id;
			}
			$q->free_result();
		}

		if ($this->EE->TMPL->fetch_param("list_type") == "ol"){
				$this->list_type = "ol";
			}

			if ($this->EE->TMPL->fetch_param("class")){
				$this->nav_class = $this->EE->TMPL->fetch_param("class");
			}

			if ($this->EE->TMPL->fetch_param("id")){
				$this->nav_id = $this->EE->TMPL->fetch_param("id");
			}

			if ($this->EE->TMPL->fetch_param("ignore_include_in_nav")){
				$this->ignore_include_in_nav = true;
			}
			
			if ($this->EE->TMPL->fetch_param("no_last_anchor")){
				$this->no_last_anchor = true;
			}
			
			if ($this->EE->TMPL->fetch_param("last_item")){
				$this->last_item = $this->EE->TMPL->fetch_param("last_item");
			}
			
			if ($this->EE->TMPL->fetch_param("last_item_link")){
				$this->last_item_link = $this->EE->TMPL->fetch_param("last_item_link");
			}

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		// Everything looks good, let's do this thing
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

			$this->EE->db->select("navee_id,link");

			if ($this->navigation_id){
				$this->EE->db->where("navigation_id", $this->navigation_id);
			}
			$this->EE->db->where("site_id", $this->site_id);
			$this->EE->db->like("link", $this->EE->uri->uri_string());
			$q = $this->EE->db->get("navee");

			if ($q->num_rows() > 0){
				foreach ($q->result() as $r){
					if ($this->_stripLink($r->link) == $this->EE->uri->uri_string()){
						$this->navee_id = $r->navee_id;
						break;
					}
				}
			}

			$q->free_result();

			if ($this->navee_id){
				$crumbArray = $this->_getCrumbs($this->navee_id);
				
				if (strlen($this->last_item)>0){
					$pushMe = array();
					$pushMe["text"] 		= $this->last_item;
					$pushMe["link"] 		= $this->last_item_link;
					$pushMe["navee_id"]		= "";
					$pushMe["parent"]		= "";
					$pushMe["class"]		= "";
					$pushMe["id"]			= "";
					$pushMe["rel"]			= "";
					$pushMe["name"]			= "";
					$pushMe["target"]		= "";

					array_push($crumbArray, $pushMe);
				}
				$output = $this->_styleCrumbs($crumbArray);
				
			} else {
				$this->EE->db->select("navee_id, regex");
				$this->EE->db->where("navigation_id", $this->navigation_id);
				$this->EE->db->where("site_id", $this->site_id);
				$q = $this->EE->db->get("navee"); 

				if ($q->num_rows() > 0){
					foreach ($q->result() as $r){
						if (strlen($r->regex) > 0){
							if (preg_match($r->regex, $this->EE->uri->uri_string())){
								$crumbArray = $this->_getCrumbs($r->navee_id);
								
								if (strlen($this->last_item)>0){
									$pushMe = array();
									$pushMe["text"] 		= $this->last_item;
									$pushMe["link"] 		= $this->last_item_link;
									$pushMe["navee_id"]		= "";
									$pushMe["parent"]		= "";
									$pushMe["class"]		= "";
									$pushMe["id"]			= "";
									$pushMe["rel"]			= "";
									$pushMe["name"]			= "";
									$pushMe["target"]		= "";
				
									array_unshift($crumbArray, $pushMe);
								}
								$output = $this->_styleCrumbs($crumbArray);
								break;
							}
						}
					}
				}
				$q->free_result();
			}

		return $output;
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	C U S T O M _ C R U M B S
	//
	//		P A R A M E T E R S
	//		------------------------
	//			* nav_title
	//			* class						(optional)
	//			* id						(optional)
	//			* ignore_include_in_nav		(optional)
	//			* wrap_type					(optional)
	//			* spacer					(optional)
	//			* no_last_spacer			(optional)
	//			* last_item					(optional)
	//			* last_item_link			(optional)
	//
	//
	//		V A R I A B L E S
	//		------------------------
	//
	//			* text
	//			* link
	//			* navee_id
	//			* navigation_id
	//			* class
	//			* id
	//			* rel
	//			* name
	//			* target
	//			* spacer
	//			* is_last_item
	//
	//
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function custom_crumbs(){

		$output="";

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		// Set Parameters
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
			if ($this->EE->TMPL->fetch_param("nav_title")){
				$this->EE->db->select("navigation_id");
				$this->EE->db->where("nav_title", $this->EE->TMPL->fetch_param("nav_title"));
				$this->EE->db->where("site_id", $this->site_id);
				$q = $this->EE->db->get("navee_navs", 1);
				if ($q->num_rows() > 0){
					$row = $q->row();
					$this->navigation_id = $row->navigation_id;
				}
				$q->free_result();
			}

			if ($this->EE->TMPL->fetch_param("wrap_type")){
				if (strtolower($this->EE->TMPL->fetch_param("wrap_type"))=="none"){
					$this->list_type = "";
				} else {
					$this->list_type = $this->EE->TMPL->fetch_param("wrap_type");
				}
			}

			if ($this->EE->TMPL->fetch_param("class")){
				$this->nav_class = $this->EE->TMPL->fetch_param("class");
			}

			if ($this->EE->TMPL->fetch_param("id")){
				$this->nav_id = $this->EE->TMPL->fetch_param("id");
			}

			if ($this->EE->TMPL->fetch_param("ignore_include_in_nav")){
				$this->ignore_include_in_nav = true;
			}
			
			if ($this->EE->TMPL->fetch_param("spacer")){
				$this->spacer = $this->EE->TMPL->fetch_param("spacer");
			}
			
			if ($this->EE->TMPL->fetch_param("no_last_spacer")){
				$this->no_last_spacer = true;
			}
			
			if ($this->EE->TMPL->fetch_param("last_item")){
				$this->last_item = $this->EE->TMPL->fetch_param("last_item");
			}
			
			if ($this->EE->TMPL->fetch_param("last_item_link")){
				$this->last_item_link = $this->EE->TMPL->fetch_param("last_item_link");
			}

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
		// Everything looks good, let's do this thing
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

			if ($this->navigation_id){
				$this->EE->db->select("navee_id,link");
				$this->EE->db->where("navigation_id", $this->navigation_id);
				$this->EE->db->where("site_id", $this->site_id);
				$this->EE->db->like("link", $this->EE->uri->uri_string());
				$q = $this->EE->db->get("navee");

				if ($q->num_rows() > 0){
					foreach ($q->result() as $r){
						if ($this->_stripLink($r->link) == $this->EE->uri->uri_string()){
							$this->navee_id = $r->navee_id;
							break;
						}
					}
				}

				$q->free_result();
				
				if ($this->navee_id){
					$crumbArray = $this->_getCrumbs($this->navee_id);
					
					if (strlen($this->last_item)>0){
						$pushMe = array();
						$pushMe["text"] 		= $this->last_item;
						$pushMe["link"] 		= $this->last_item_link;
						$pushMe["navee_id"]		= "";
						$pushMe["parent"]		= "";
						$pushMe["class"]		= "";
						$pushMe["id"]			= "";
						$pushMe["rel"]			= "";
						$pushMe["name"]			= "";
						$pushMe["target"]		= "";
	
						array_push($crumbArray, $pushMe);
					}
					$output = $this->_styleCustomCrumbs($crumbArray);
				} else {
					$this->EE->db->select("navee_id, regex");
					$this->EE->db->where("navigation_id", $this->navigation_id);
					$this->EE->db->where("site_id", $this->site_id);
					$q = $this->EE->db->get("navee"); 

					if ($q->num_rows() > 0){
						foreach ($q->result() as $r){
							if (strlen($r->regex) > 0){
								if (preg_match($r->regex, $this->EE->uri->uri_string())){
									$crumbArray = $this->_getCrumbs($r->navee_id);
									
									if (strlen($this->last_item)>0){
										$pushMe = array();
										$pushMe["text"] 		= $this->last_item;
										$pushMe["link"] 		= $this->last_item_link;
										$pushMe["navee_id"]		= "";
										$pushMe["parent"]		= "";
										$pushMe["class"]		= "";
										$pushMe["id"]			= "";
										$pushMe["rel"]			= "";
										$pushMe["name"]			= "";
										$pushMe["target"]		= "";
					
										array_push($crumbArray, $pushMe);
									}
									$output = $this->_styleCustomCrumbs($crumbArray);
									break;
								}
							}
						}
					}
					$q->free_result();
				}
				
			}
		return $output;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   N A V 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleNav($nav, $depth=0){

		$returnMe = "";

		if (sizeof($nav)>0){
			$returnMe .= "<".$this->list_type;
			// If this is the first <ul> apply assigned class & id
			if ($depth == 0){
				if (strlen($this->nav_id)>0){
					$returnMe .= " id='".$this->nav_id."'";
				}
				
				if (strlen($this->nav_class)>0){
					$returnMe .= " class='".$this->nav_class."'";
				}
			}

			$returnMe .= ">";
			$count = 0;
			$navCount = sizeof($nav);

			foreach ($nav as $k=>$v){

				$class = "";
				$count++;

				// Open the <li> for our nav item
					$returnMe .= "<li";

				// Add appropriate 'selected' classes
					if (!$this->no_selected){
						if (strlen($v["regex"]) > 0) {
							if (preg_match($v["regex"], $this->EE->uri->uri_string())){
								$class .= $this->selected_class;
							}
						} else {
							// If this page matches the link
							if ($this->_stripLink($v["link"]) == $this->EE->uri->uri_string()){
								$class .= $this->selected_class;
							}

						}

						if ($this->selected_class_on_parents){
							// Check to see if descendent is selected
							if (!preg_match("/".$this->selected_class."/i", $class)){
								if($this->_isDescendentSelected($v["kids"])){
									$class .= $this->selected_class;
								}
							}
						}
					}

				// Add first/last classes
					if (strlen($this->last_class)>0){
						if ($count == $navCount){
							if (strlen($class)>0){
								$class .= " ";
							}
							$class .= $this->last_class;
						}
					}

					if (strlen($this->first_class)>0){
						if ($count == 1){
							if (strlen($class)>0){
								$class .= " ";
							}
							$class .= $this->first_class;
						}
					}

				// Apply class
					if (strlen($v["class"])>0){
						if (strlen($class)>0){
							$class .= " ";
						}
						$class .= $v["class"];
					}

					if (strlen($class)>0){
						$returnMe .= " class='".$class."'";
					}

				// Apply ID
					if (strlen($v["id"])>0){
						$returnMe .= " id='".$v["id"]."'";
					}

				$returnMe .= ">";

				// Begin <a>
				if (strlen($v["link"]) > 0){		
					$returnMe .= "<a href='".$v["link"]."'";
	
					// Rel, Name and Target
						if (strlen($v["rel"])){
							$returnMe .= " rel='".$v["rel"]."'";
						}
	
						if (strlen($v["name"])){
							$returnMe .= " name='".$v["name"]."'";
						}
	
						if (strlen($v["target"])){
							$returnMe .= " target='".$v["target"]."'";
						}
	
					$returnMe .= ">".$v["text"]."</a>";
				} else {
					$returnMe .= $v["text"];
				}

				// If our nav item has kids, let's recurse
				if (sizeof($v["kids"])>0){
					$returnMe .= $this->_styleNav($v["kids"],$depth+1);
				}

				// Close out the </li>
				$returnMe .= "</li>";
			}
			$returnMe .= "</".$this->list_type.">";
		}
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   C U S T O M
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleCustom($nav, $depth=0){

		$returnMe = "";

		if (sizeof($nav)>0){

			$count = 0;
			$navCount = sizeof($nav);

			foreach($nav as $k=>$v){

				$class = "";
				$count++;

				// Add appropriate 'selected' classes
					if (!$this->no_selected){
						if (strlen($v["regex"]) > 0) {
							if (preg_match($v["regex"], $this->EE->uri->uri_string())){
								$class .= $this->selected_class;
							}
						} else {
							// If this page matches the link
							if ($this->_stripLink($v["link"]) == $this->EE->uri->uri_string()){
								$class .= $this->selected_class;
							}
						}

						if ($this->selected_class_on_parents){
							// Check to see if descendent is selected
							if (!preg_match("/".$this->selected_class."/i", $class)){
								if($this->_isDescendentSelected($v["kids"])){
									$class .= $this->selected_class;
								}
							}
						}
					}

				// Add first/last classes
					if (strlen($this->last_class)>0){
						if ($count == $navCount){
							if (strlen($class)>0){
								$class .= " ";
							}
							$class .= $this->last_class;
						}
					}

					if (strlen($this->first_class)>0){
						if ($count == 1){
							if (strlen($class)>0){
								$class .= " ";
							}
							$class .= $this->first_class;
						}
					}

				// Apply item class
					if (strlen($v["class"])>0){
						if (strlen($class)>0){
							$class .= " ";
						}
						$class .= $v["class"];
					}

				if (sizeof($v["kids"])>0){
					$kids 				= $this->_styleCustom($v["kids"],$depth+1);
					$this->has_kids 	= true;
					$this->kid_count	= count($v["kids"]);
				} else {
					$kids = "";
				}

				$vars[] = array(
							'text'				=> $v["text"],
							'link'				=> $v["link"],
							'kids'				=> $kids,
							'navee_id'			=> $v["navee_id"],
							'navigation_id'		=> $this->navigation_id,
							'class'				=> $class,
							'id'				=> $v["id"],
							'rel'				=> $v["rel"],
							'name'				=> $v["name"],
							'target'			=> $v["target"],
							'level'				=> $depth+1,
							'has_kids'			=> $this->has_kids,
							'kid_count'			=> $this->kid_count
				);

				$returnMe = $this->EE->TMPL->parse_variables($this->EE->TMPL->tagdata, $vars);

			}

		}

		$openTagContents = "";

		if ($depth == 0){
			if (strlen($this->nav_id)>0){
				$openTagContents .= " id='".$this->nav_id."'";
			}
		}

		if (strlen($this->nav_class)>0){
			$openTagContents .= " class='".$this->nav_class."'";
		}
		
		if (strlen($this->list_type)>0){
			$returnMe = "<".$this->list_type.$openTagContents.">".$returnMe."</".$this->list_type.">";
		}
		
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   C R U M B S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleCrumbs($crumbs){

		$returnMe = "";
		if ($this->no_last_anchor){
			$count = 1;
		} else {
			$count = 0;
		}
		
		$crumbCount = sizeof($crumbs);

		if ($crumbCount > 0){
			$returnMe = "<".$this->list_type;

			if (strlen($this->nav_class)>0){
				$returnMe .= " class='".$this->nav_class."'";
			}

			if (strlen($this->nav_id)>0){
				$returnMe .= " id='".$this->nav_id."'";
			}

			$returnMe .= ">";

			foreach ($crumbs as $k=>$v){
				if ($count < $crumbCount){
					$returnMe .= "<li><a href='".$v["link"]."'>".$v["text"]."</a></li>";
				} else {
					$returnMe .= "<li>".$v["text"]."</li>";
				}
				$count++;
			}
			$returnMe .= "</".$this->list_type.">";
		}
		return $returnMe;

	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T Y L E   C U S T O M   C R U M B S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _styleCustomCrumbs($crumbs){

		$returnMe = "";
		$count = 1;
		$crumbCount = sizeof($crumbs);

		if ($crumbCount > 0){
		
			if (strlen($this->list_type) > 0){
				$returnMe = "<".$this->list_type;
	
				if (strlen($this->nav_class)>0){
					$returnMe .= " class='".$this->nav_class."'";
				}
	
				if (strlen($this->nav_id)>0){
					$returnMe .= " id='".$this->nav_id."'";
				}
	
				$returnMe .= ">";
			}

			foreach ($crumbs as $k=>$v){
				$vars[] = array(
							'text'				=> $v["text"],
							'link'				=> $v["link"],
							'navee_id'			=> $v["navee_id"],
							'navigation_id'		=> $this->navigation_id,
							'class'				=> $v["class"],
							'id'				=> $v["id"],
							'rel'				=> $v["rel"],
							'name'				=> $v["name"],
							'target'			=> $v["target"],
							'spacer'			=> (($count == $crumbCount) && ($this->no_last_spacer) ? "" : $this->spacer),
							'is_last_item'		=> ($count == $crumbCount) ? True : False

				);
				
				// If no_last_spacer has been passed and this is
				// the last item, remove spacer
				
				
				

				$myCrumbs = $this->EE->TMPL->parse_variables($this->EE->TMPL->tagdata, $vars);

				$count++;
			}
			$returnMe .= $myCrumbs;
			if (strlen($this->list_type) > 0){
				$returnMe .= "</".$this->list_type.">";
			}
		}
		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   N A V
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _getNav($navId, $parent=0, $recursive=true, $ignoreInclude=false){

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
								nm.members");
		$this->EE->db->from("navee AS n");
		$this->EE->db->join("navee_members AS nm", "nm.navee_id=n.navee_id", "LEFT OUTER");
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
				$hasAccess = false;
				if (strlen($r->members)>0){
					$memberGroups = unserialize($r->members);
					if (in_array($this->EE->session->userdata['group_id'], $memberGroups)){
						$hasAccess = true;
					}
				} else {
					$hasAccess = true;
				}
				
				if ($hasAccess){
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
					
					if ($recursive){
						$nav[$count]["kids"]	= $this->_getNav($navId, $r->navee_id, $recursive, $ignoreInclude);
					} else {
						$nav[$count]["kids"]	= array();
					}
				}
								
				$count++;
			}
		}
		$q->free_result();
		return $nav;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	G E T   C R U M B S
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _getCrumbs($navee_id, $crumbs=array()){

		$this->EE->db->select("*");
		$this->EE->db->where("site_id", $this->site_id);
		$this->EE->db->where("navee_id", $navee_id);

		if ($this->navigation_id){
			$this->EE->db->where("navigation_id", $this->navigation_id);
		}

		if (!$this->ignore_include_in_nav){
			$this->EE->db->where("include", 1);
		}

		$q = $this->EE->db->get("navee");

		if ($q->num_rows() > 0){
			$r = $q->row();

			$pushMe = array();
			$pushMe["text"] 		= $r->text;
			$pushMe["link"] 		= $r->link;
			$pushMe["navee_id"]		= $r->navee_id;
			$pushMe["parent"]		= $r->parent;
			$pushMe["class"]		= $r->class;
			$pushMe["id"]			= $r->id;
			$pushMe["rel"]			= $r->rel;
			$pushMe["name"]			= $r->name;
			$pushMe["target"]		= $r->target;

			array_unshift($crumbs, $pushMe);

			if ($r->parent > 0){
				$crumbs = $this->_getCrumbs($r->parent, $crumbs);
			}
		}

		$q->free_result();
		return $crumbs;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	// I S    D E S C E N D E N T   S E L E C T E D 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _isDescendentSelected($kids){
		$returnMe = false;

		if (sizeof($kids)>0){
			foreach ($kids as $k=>$v){				
				if (strlen($v["regex"]) > 0) {
					if (preg_match($v["regex"], $this->EE->uri->uri_string())){
						$returnMe = true;
						return $returnMe;
					}
				} else {
					// If this page matches the link
					if ($this->_stripLink($v["link"]) == $this->EE->uri->uri_string()){
						$returnMe = true;
						return $returnMe;
					}
				}

				if (sizeof($v["kids"])>0){
					$returnMe = $this->_isDescendentSelected($v["kids"]);
				}
			}
		}

		return $returnMe;
	}

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	//	S T R I P   L I N K
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>

	function _stripLink($link){
		$link = preg_replace('/.*index\.php\/*/i', '', $link);
		$link = preg_replace('/(\#|\?).*$/i', '', $link);
		$link = preg_replace('/^\//i', '', $link);
		$link = preg_replace('/\/$/i', '', $link);
		$link = preg_replace('/[\.]+\//i', '', $link);
		return $link;	
	}

}