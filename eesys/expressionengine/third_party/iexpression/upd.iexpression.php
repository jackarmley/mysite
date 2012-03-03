<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class iexpression_upd { 

    var $version        = '1.4.1'; 
     
    function iexpression_upd( $switch = TRUE ) 
    { 
		// Make a local reference to the ExpressionEngine super object
		$this->EE =& get_instance();
    } 


	function install() {
		$this->EE->load->dbforge();
	
		$data = array(
			'module_name' => 'iexpression' ,
			'module_version' => $this->version,
			'has_cp_backend' => 'y'
		);
	
		$fields = array(
				'id'	=>	array('type' => 'int',
							'constraint'	=>	'6',
							'unsigned'	=>	TRUE,
							'auto_increment'=>	TRUE),
				'property'	=>	array(
							'type' 				=> 'varchar',
							'constraint'		=> '255',
							'null' => FALSE
							), 
				'value' 		=> array(
							'type' => 'TEXT',
			 				'null' => FALSE), 
				);
	
		$this->EE->dbforge->add_field($fields);
		$this->EE->dbforge->add_key('id', TRUE);
		$this->EE->dbforge->create_table('iexpression');
			
		$this->EE->db->insert('modules', $data); 

		$data = array(
			'class' 	=> 'Iexpression',
			'method' 	=> 'incoming'
		);
		$this->EE->db->insert('actions', $data);

		
		return TRUE;
	}
	
	function uninstall() { 
		$this->EE->load->dbforge();
	
		$this->EE->db->select('module_id');
		$query = $this->EE->db->get_where('modules', array('module_name' => 'iexpression'));
	
		$this->EE->db->where('module_id', $query->row('module_id'));
		$this->EE->db->delete('module_member_groups');
	
		$this->EE->db->where('module_name', 'iexpression');
		$this->EE->db->delete('modules');
	
		$this->EE->db->where('class', 'Iexpression');
		$this->EE->db->delete('actions');
	
		$this->EE->db->where('class', 'Iexpression_mcp');
		$this->EE->db->delete('actions');
	
		$this->EE->dbforge->drop_table('iexpression');
	
		return TRUE;
	}	
	
	function update($current = ''){
		return $current!=$this->version;
	}	

}