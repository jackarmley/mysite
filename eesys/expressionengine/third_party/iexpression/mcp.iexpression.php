<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class iexpression_mcp { 

    function iexpression_mcp( $switch = TRUE ) { 
		// Make a local reference to the ExpressionEngine super object
		$this->EE =& get_instance();
		$this->EE->load->helper('form');
    } 

	function index() {         
		$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('iexpression_module_name'));
	
		$this->EE->load->library('javascript');
		$this->EE->javascript->output($this->EE->jquery->corner('.cp_button a'));
		$this->EE->javascript->compile();
	
		$r = $this->EE->lang->line('iexpression_message').'<br />';
		
		$r .= '&nbsp;<br /><div style="border: 1px solid red; width: 80%; padding: 10px;">'.$this->EE->functions->fetch_site_index(0, 0).QUERY_MARKER.'ACT='.$this->EE->cp->fetch_action_id('Iexpression', 'incoming').'</div>';
	
		$r .= '<br clear="all" /><div align="center"><a href="http://www.rwe-uk.com/index.php/iexpression/app">iExpression</a> is &copy; 2010 <a href="http://www.rwe-uk.com/">RED When Excited</a> Ltd. All rights reserved</div>';
		
		return $r;                                                                                                                                   
	}

}