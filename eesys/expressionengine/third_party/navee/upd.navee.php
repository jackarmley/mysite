<?php 
/*                          
_|                                                      _|
_|_|_|     _|_|     _|_|   _|    _|   _|_|_| _|_|_|   _|_|_|_|
_|    _| _|    _| _|    _| _|    _| _|    _| _|    _|   _|
_|    _| _|    _| _|    _| _|    _| _|    _| _|    _|   _|
_|_|_|     _|_|     _|_|     _|_|_|   _|_|_| _|    _|     _|_|
                                 _|
                             _|_|

Description: 	NavEE Module for Expression Engine 2.0
Developer: 		Booyant, Inc.
Website: 		www.booyant.com/navee
Location: 		./system/expressionengine/third_party/modules/navee/upd.navee.php
Contact: 		navee@booyant.com  / 978.OKAY.BOB
Version: 		1.1.2
*/

if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Navee_upd {

	var $version = '1.1.2';
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
 	//	C O N S T R U C T O R
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	
	function Navee_upd(){
		// Make a local reference to the ExpressionEngine super object
		$this->EE =& get_instance();
	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
 	//	I N S T A L L E R
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	
	function install(){
			
		$this->EE->load->dbforge();

		$data = array(
			'module_name' => 'Navee' ,
			'module_version' => $this->version,
			'has_cp_backend' => 'y',
			'has_publish_fields' => 'n'
		);

		$this->EE->db->insert('modules', $data);
		
		$data = array(
			'class'		=> 'Navee' ,
			'method'	=> 'add_navigation_handler'
		);

		$this->EE->db->insert('actions', $data);

		$fields = array(
						'navee_id'			=> array('type' 		 => 'int',
													'constraint'	 => '10',
													'unsigned'		 => TRUE,
													'auto_increment' => TRUE),
						'navigation_id'		=> array('type'=>'int', 'constraint'=>'10'),
						'site_id'			=> array('type'=>'int', 'constraint'=>'10'),
						'parent'			=> array('type'=>'int', 'constraint'=>'10'),
						'text'				=> array('type'=>'varchar', 'constraint'=>'255'),					
						'link'				=> array('type'=>'varchar', 'constraint'=>'255'),
						'class'				=> array('type'=>'varchar', 'constraint'=>'255'),
						'id'				=> array('type'=>'varchar', 'constraint'=>'255'),	
						'sort'				=> array('type'=>'int', 'constraint'=>'10'),
						'include'			=> array('type'	=> 'tinyint', 'constraint'=>'4'),
						'datecreated'		=> array('type'=>'datetime'),
						'dateupdated'		=> array('type'=>'datetime'),
						'ip_address'		=> array('type'=>'varchar', 'constraint'=>'255'),
						'member_id'			=> array('type'=>'int', 'constraint'=>'10'),
						'rel'				=> array('type'=>'varchar', 'constraint'=>'255'),
						'name'				=> array('type'=>'varchar', 'constraint'=>'255'),
						'target'			=> array('type'=>'varchar', 'constraint'=>'255'),
						'regex'				=> array('type'=>'varchar', 'constraint'=>'255')
									
						);

		$this->EE->dbforge->add_field($fields);
		$this->EE->dbforge->add_key('navee_id', TRUE);
		$this->EE->dbforge->create_table('navee', TRUE);	
		unset($fields);
		
		$fields = array(
						'navigation_id'		=> array('type' 		 => 'int',
													'constraint'	 => '10',
													'unsigned'		 => TRUE,
													'auto_increment' => TRUE),
						'site_id'			=> array('type'=>'int', 'constraint'=>'10'),
						'nav_title'			=> array('type'=>'varchar', 'constraint'=>'255'),
						'nav_name'			=> array('type'=>'varchar', 'constraint'=>'255'),
						'nav_description'	=> array('type'=>'varchar', 'constraint'=>'255'),
						'datecreated'		=> array('type'=>'datetime'),
						'dateupdated'		=> array('type'=>'datetime'),
						'ip_address'		=> array('type'=>'varchar', 'constraint'=>'255'),
						'member_id'			=> array('type'=>'int', 'constraint'=>'10')	
									
						);

		$this->EE->dbforge->add_field($fields);
		$this->EE->dbforge->add_key('navigation_id', TRUE);
		$this->EE->dbforge->create_table('navee_navs', TRUE);	
		unset($fields);
		
		$fields = array(
						'navee_mem_id'		=> array('type' 		 => 'int',
													'constraint'	 => '10',
													'unsigned'		 => TRUE,
													'auto_increment' => TRUE),
						'site_id'			=> array('type'=>'int', 'constraint'=>'10'),
						'navee_id'			=> array('type'=>'int', 'constraint'=>'10'),
						'members'			=> array('type'=>'text', 'null'=>TRUE)
						);

		$this->EE->dbforge->add_field($fields);
		$this->EE->dbforge->add_key('navee_mem_id', TRUE);
		$this->EE->dbforge->create_table('navee_members', TRUE);	
		unset($fields);
	
		return TRUE;
	}
	
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
 	//	U N I N S T A L L E R
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
	
	function uninstall()
	{
		$this->EE->load->dbforge();

		$this->EE->db->select('module_id');
		$query = $this->EE->db->get_where('modules', array('module_name' => 'NavEE'));

		$this->EE->db->where('module_id', $query->row('module_id'));
		$this->EE->db->delete('module_member_groups');

		$this->EE->db->where('module_name', 'Navee');
		$this->EE->db->delete('modules');

		$this->EE->db->where('class', 'Navee');
		$this->EE->db->delete('actions');

		// N O T E 
		// If you would like NavEE to drop it's tables when you uninstall,
		// uncomment the next two lines.
		
		//$this->EE->dbforge->drop_table('navee');
		//$this->EE->dbforge->drop_table('navee_navs');
		
		return TRUE;

	}


	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>
 	//	U P D A T E
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>	
	
	function update($current='')
	{
		return TRUE;
	}
	
}

?>