<?php  
// 
// iExpression Module for ExpressionEngine 2.X
// 
// This contents of this file are Copyright RED When Excited Ltd 2010
// 
	
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

require_once(dirname(__FILE__) . "/iexpressionBase.php");

class Iexpression extends iexpressionBase{

	// 
	// Constructor and base XMLRPC Redirection
	// 
	function Iexpression(){
		// Make a local reference to the ExpressionEngine super object
		$this->EE =& get_instance();

		$this->EE->lang->loadfile('iexpression');

		$this->assignToParentCategories = ($this->EE->config->item('auto_assign_cat_parents') == 'n') ? FALSE : TRUE;
	}

	function incoming(){
		$this->useChannel = TRUE;	
	
		$this->EE->load->library('xmlrpc');
		$this->EE->load->library('xmlrpcs');

		$this->EE->xmlrpcs->initialize(array('functions' => $this->createFunctionRedirects(), 'object' => $this, 'xss_clean' => FALSE));
		ob_start();
		$this->EE->xmlrpcs->serve();
	}

	// 
	// XMLRPC version specific implementations
	// 
	function send_error_message($errorCode, $errorMessage){
		if (ob_get_level()>0){
			ob_end_clean();	
		}
		
    	return $this->EE->xmlrpc->send_error_message($errorCode, $errorMessage);        		
	}
		
	function send_response($response){
		if (ob_get_level()>0){
			ob_end_clean();	
		}
		return $this->EE->xmlrpc->send_response($response);
	}

	// 
	// Version specific database implementations
	// 
	function executeQuery($sql){
		return $this->EE->db->query($sql);
	}

	function rowCount($queryResult){
		return $queryResult->num_rows();
	}
	
	function rowArray($queryResult){
		return $queryResult->row_array();
	}
	
	function resultArray($queryResult){
		return $queryResult->result_array();
	}
	
	// 	
	// Gets the last insert id	
	// 	
	function getLastInsertId(){
		return $this->EE->db->insert_id();
	}	
	
	// 
	// EE version specific abstractions
	// 		
	function currentSiteId(){
		return $this->EE->config->item('site_id');
	}			
		
	function rightNow(){
		return $this->EE->localize->now;
	}

	//This is done by the EE engine in 2.x
	function createURLTitle($title,$channelId){
		return $title;
	}	
	
	function currentIP(){
		return $this->EE->input->ip_address();
	}
	
	function escapeDBString($theString){
		return $this->EE->db->escape_str($theString);
	}	
		
	function getPlugins(){
		$exclude = array('auto_xhtml');

		$standardFormatters = array('none', 'br', 'xhtml');
		$lengthEXT = strlen(EXT);

		if ($fp = @opendir(PATH_PI)){
			while (FALSE !== ($file = readdir($fp))){
				if (strncasecmp($file, 'pi.', 3) == 0 && substr($file, -$lengthEXT) == EXT && strlen($file) > strlen('pi.'.EXT)){
					$file = substr($file, 3, -$lengthEXT);

					if ( ! in_array($file, $exclude)){
						$standardFormatters[] = $file;
					}
				}
			}

			closedir($fp);
		}

		if ($fp = @opendir(PATH_THIRD.'plugins/')){
			while (FALSE !== ($file = readdir($fp))){
				if (strncasecmp($file, 'pi.', 3) == 0 && substr($file, -$lengthEXT) == EXT && strlen($file) > strlen('pi.'.EXT)){
					$file = substr($file, 3, -$lengthEXT);

					if ( ! in_array($file, $exclude)){
						$standardFormatters[] = $file;
					}
				}
			}

			closedir($fp);
		}

		sort($standardFormatters);
		return $standardFormatters;
	}		
	
    function honorDST(&$metaData){
		if ($this->EE->config->item('honor_entry_dst') == 'y'){
			$metaData['dst_enabled'] = ($this->EE->config->item('daylight_savings') == 'y') ? 'y' : 'n';
		}
	}	
	
	function iso8601Decode($time){
		$t = 0;

		if (preg_match('/([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})/', $time, $regs)){
			$t = mktime($regs[4], $regs[5], $regs[6], $regs[2], $regs[3], $regs[1]);
		}
		return $t;
	}    
	
	function makeHumanReadable($time){
		$phpTime = strtotime($time);
		return date("Y-m-d h:i A",$phpTime);
	}	

	// 
	// Take the data prepared by the base class and use it to update the database
	// 	
	function doUpdate($metaData,$entryData,$channelId,$entryId){
		$this->EE->db->query($this->EE->db->update_string('exp_channel_titles', $metaData, "entry_id = '$entryId'"));
		$this->EE->db->query($this->EE->db->update_string('exp_channel_data', $entryData, "entry_id = '$entryId'"));

		//Update channels and stats
		if ($this->EE->config->item('new_posts_clear_caches') == 'y'){
			$this->EE->functions->clear_caching('all');
		} else {
			$this->EE->functions->clear_caching('sql');
		}
		$this->EE->stats->update_channel_stats($channelId);


		//Success
		return $this->send_response(array(1,'boolean'));
	}

	// 
	// Take the data constructed by the base class and use the 2.X API to post it
	// 	
	function doPost($metaData,$entryData,$channelId){
		$entryData['site_id']	= $this->defaultSiteId;
		$entryData['versioning_enabled'] = 'n';

		
		$mergedData = array_merge($metaData, $entryData);
		$mergedData['categories'] = $this->categories;

		$this->EE->session->userdata = array_merge(
			$this->EE->session->userdata,
			array(
				'group_id'			=> $this->userInformation['group_id'],
				'member_id'			=> $this->userInformation['member_id'],
				'assigned_channels'	=> $this->userInformation['assigned_channels']
			)
		);

		$this->EE->load->library('api');
		$this->EE->api->instantiate('channel_entries');
		
		if ( ! $this->EE->api_channel_entries->submit_new_entry($channelId, $mergedData)){
			$errors = $this->EE->api_channel_entries->get_errors();
			$error = "";
			
			foreach ($errors as $key=> $value){
				if (strlen($error)==0){
					$error = "$value $key";
				} else {
					$error .= ", $value $key";
				}
			}
			return $this->send_error_message('500',$error);
		}
		
		//Return Entry ID of new entry
		$response = array(
			$this->EE->api_channel_entries->entry_id, 'string'
		);

		//We're done, record the new id as it will
		//be needed for any relationships
		$this->newEntryId = $this->EE->api_channel_entries->entry_id;


		return $this->send_response($response);
	}

	// 
	// Loads the typography module
	// 	
	function initTypography(){
		$this->EE->load->library('typography');
		$this->EE->typography->initialize();
		$this->EE->typography->encode_email = FALSE;
		$this->EE->config->set_item('enable_emoticons', 'n');		
	}
			
	function parseType($theString,$settings){
		return $this->EE->typography->parse_type($theString, $settings);
	}		
		
	function removeDoubleSlashes($fromString){
		return $this->EE->functions->remove_double_slashes($fromString);
	}
		
	function getPreference($name){
		return $this->EE->config->item($name);
	}
			
	function getEntryFields($entryId){
     	$sql = "SELECT DISTINCT(wt.entry_id), wt.*,exp_channel_data.entry_id FROM exp_channel_titles wt, exp_channel_data WHERE wt.entry_id = exp_channel_data.entry_id AND wt.entry_id = '$entryId' ";

		
		return $this->executeQuery($sql);
	}
		
	function appendDataToFile($data,$locationDetails){
		$this->EE->load->library('security');
		$this->EE->load->helper('path');
		
		$filename = $data['name'];
		$uploadPath = set_realpath($this->EE->functions->remove_double_slashes($locationDetails['server_path'] .'/'));
		
		if (!$fp = @fopen($uploadPath.$filename,'a')){
			return $this->send_error_message('500','Could not append data to file');
    	}
    	
    	$result = @fwrite($fp, $data['bits']);
		@fclose($fp);
		
		return !($result === FALSE);
	}	
	
	
	function deleteFile($filename,$locationDetails){
		$this->EE->load->library('security');
		$this->EE->load->helper('path');
		
		$filePath = set_realpath($this->EE->functions->remove_double_slashes($locationDetails['server_path'] .'/'));
		
		return unlink($filePath.$filename);
	}
	
	function saveFile($binaryData,$locationDetails){
		$this->EE->load->library('security');
		
		$filename = preg_replace("/\s+/", "_", $binaryData['name']);
		$filename = $this->EE->security->sanitize_filename($filename);
		
		$this->EE->load->helper('path');
		
		$uploadPath = set_realpath($this->EE->functions->remove_double_slashes($locationDetails['server_path'] .'/'));
		
		$filename = $this->uniqueFilename($filename, $uploadPath);
		
		if ( ! $fp = @fopen($uploadPath.$filename,FOPEN_WRITE_CREATE_DESTRUCTIVE)){
			return $this->send_error_message('500','Could not write file '.$uploadPath.$filename.' -- '.$locationDetails['server_path']);
		}
		
		@fwrite($fp, $binaryData['bits']);
		@fclose($fp);
		
		@chmod($uploadPath.$filename, FILE_WRITE_MODE);
		
		$response = array(array('filename' => array($filename,'string'),'url' => array($this->EE->functions->remove_double_slashes($locationDetails['url'] .'/').$filename,'string')),'struct');
		
		return $this->send_response($response);
	}		
				
	function apiDeleteEntry($entryId){
	
		$this->EE->session->userdata = array_merge(
			$this->EE->session->userdata,
			array(
				'group_id'			=> $this->userInformation['group_id'],
				'member_id'			=> $this->userInformation['member_id'],
				'assigned_channels'	=> $this->userInformation['assigned_channels']
			)
		);

		// Delete the entry
		$this->EE->load->library('api');
		$this->EE->api->instantiate('channel_entries');

		$result = $this->EE->api_channel_entries->delete_entry($entryId);
		
		if (!$result){
			$errors = implode(', ', $this->EE->api_channel_entries->get_errors());
			return $this->send_error_message('500',$errors);
		} else {
			return $this->send_response(array(1,'boolean'));
		}
	}		
    
	function validateWithAuthLibrary($username,$password){
		$libraryPath = APPPATH;
		$libraryPath .= '/libraries/Auth.php';
		
		if (!file_exists($libraryPath)){
			return FALSE;
		}
        
		return TRUE;
		$this->EE->load->library('auth');
		$this->EE->load->auth->initialize();
		$result = $this->EE->auth->authenticate_username($username,$password); 		
		if ($result === FALSE){
			return FALSE;
		}
		return TRUE;
	}
    
	public function log($message){
		$this->EE->load->library('logger');
		
		$this->EE->logger->log_action($message);		
	}		
    
	function validateMember($username, $password){
		$sql = " SELECT exp_members.screen_name,
        exp_members.member_id,
        exp_members.email,
        exp_members.url,
        exp_members.group_id,
        exp_member_groups.*,
        exp_members.avatar_filename
        FROM exp_members, exp_member_groups
        WHERE username = '".$this->EE->db->escape_str($username)."'
        AND exp_members.group_id = exp_member_groups.group_id ";
        
		$sha_sql = "AND password = '".$this->EE->functions->hash(stripslashes($password))."'";
		$md5_sql = "AND password = '".md5(stripslashes($password))."'";
        
		$query = $this->EE->db->query($sql.$sha_sql);
        
		if ($query->num_rows() == 0){
			$query = $this->EE->db->query($sql.$md5_sql);
			if ($query->num_rows() == 0){
				if ($this->validateWithAuthLibrary($username,$password)){
					$query = $this->EE->db->query($sql);
					if ($query->num_rows() == 0){
						return FALSE;
					}				
				} else {
					return FALSE;
				}
			}
		}

		foreach ($query->row_array() as $key => $val){
			$this->userInformation[$key] = $val;
		}

		$membersChannels = array();

		if ($this->userInformation['group_id'] == 1){
			$result = $this->EE->db->query("SELECT channel_id FROM exp_channels");
		} else {
			$result = $this->EE->db->query("SELECT channel_id FROM exp_channel_member_groups WHERE group_id = '".$this->userInformation['group_id']."'");
		}

		if ($result->num_rows() > 0){
			foreach ($result->result_array() as $row){
				$membersChannels[] = $row['channel_id'];
			}
		} else {
			return FALSE;
		}

		$this->userInformation['assigned_channels'] = $membersChannels;

		$this->EE->session->userdata = array_merge(
			$this->EE->session->userdata,
			$this->userInformation
		);

		return TRUE;
	}

	function parseChannel($channelId){
		$channelId			= trim($channelId);
		$this->entryStatus		= 'open';

		$sql				= "SELECT channel_id, channel_url, comment_url, deft_category, channel_html_formatting, site_id FROM exp_channels WHERE ";
		$this->channelSQL	= $this->EE->functions->sql_andor_string($channelId, 'exp_channels.channel_id');
		$sql				= (substr($this->channelSQL, 0, 3) == 'AND') ? $sql.substr($this->channelSQL, 3) : $sql.$this->channelSQL;
		$query				= $this->EE->db->query($sql);

		if ($query->num_rows() == 0){
			return $this->EE->xmlrpc->send_error_message('804', $this->EE->lang->line('invalid_channel'));
		}

		$this->defaultChannelId		= $query->row('channel_id');
		$this->channelURL		= $query->row('channel_url');
		$this->commentURL		= $query->row('comment_url');
		$this->defaultCategory	= $query->row('deft_category');
		$this->channelHTMLFormat		= $query->row('channel_html_formatting');
		$this->defaultSiteId			= $query->row('site_id');

		if ($this->defaultSiteId != $this->EE->config->item('site_id')){
			$this->EE->config->site_prefs('', $this->defaultSiteId);
			$this->assignToParentCategories = ($this->EE->config->item('auto_assign_cat_parents') == 'n') ? FALSE : TRUE;
		}

		foreach ($query->result_array() as $row){
			if ( ! in_array($row['channel_id'], $this->userInformation['assigned_channels']) && $this->userInformation['group_id'] != '1'){
				return $this->EE->xmlrpc->send_error_message('803', $this->EE->lang->line('invalid_channel'));
			}
		}

		$query = $this->EE->db->query("SELECT * FROM exp_channel_fields, exp_channels
							  WHERE exp_channels.field_group = exp_channel_fields.group_id
							  {$this->channelSQL}");

		foreach($query->result_array() as $row){
			$fieldData = array();
			foreach ($row as $col => $val){
				$fieldData[$col] = $val;
			}
			$this->channelFields[$row['field_id']] = $fieldData;
		}
	}

}