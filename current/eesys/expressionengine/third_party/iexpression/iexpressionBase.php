<?php
// 
// iExpression base class for two different module versions
// 
// This contents of this file are Copyright RED When Excited Ltd 2010
// 
class iexpressionBase{	
	//EE Boiler Plate
    var $return_data	= ''; 

	//Version Control
	var $useChannel 	= FALSE;
	
    var $knownFields = array("text","date","textarea","wygwam","select","radio","rel","checkboxes","multi_select","file","gallery_image");
    
	//Defaults
	var $defaultTitle			= 'iExpression Title';		
	var $defaultChannelId		= '1';						
	var $defaultSiteId			= '1';						
	var $defaultCategory		= '';

	//User
	var $userInformation		= array();	

	//Channel Data
	var $channel				= '';
	var $channelURL				= '';
	var $channelHTMLFormat		= 'none';					
	var $channelFields			= array();
	var $commentURL				= '';

	//Categories
	var $categories 			= array();					
	var $assignToParentCategories = TRUE;						
	var $parentCategories		= array();

	//Fields
	var $fieldFormat			= array();					

	//Entries
	var $entryStatus	= 'null';
	var $newEntryId		= -1;

	//Globals
    var $kLineBreak		= "\r\n";			
	
	//File upload location details
	var $locationDetails = array();

	function iexpressionBase(){
	}
	
	// 
	// Returns the redirection functions for the XMLRPC server class to use
	// 
	function createFunctionRedirects(){

    	$functions = array(
						  'iExpression.getUploadLocationContents'	=> array('function' => 'IExpression.getUploadLocationContents'),	//
						  'iExpression.getFileThumbnail'			=> array('function' => 'IExpression.getFileThumbnail'),				//NA
    					  'iExpression.version'						=> array('function' => 'IExpression.version'),						//
    					  'iExpression.entryStats'					=> array('function' => 'IExpression.entryStats'),
    					  'iExpression.channelDescription'			=> array('function' => 'IExpression.weblogDescription'),
    					  'iExpression.describeUser'				=> array('function' => 'IExpression.describeUser'),
    					  'iExpression.getUsersChannels'			=> array('function' => 'IExpression.getUsersChannels'),
    					  'iExpression.deleteEntry'					=> array('function' => 'IExpression.deleteEntry'),
						  'iExpression.deleteGalleryEntry'			=> array('function' => 'IExpression.deleteGalleryEntry'),
    					  'iExpression.getRecentEntryTitles'		=> array('function' => 'IExpression.getRecentEntryTitles'),
    					  'iExpression.getEntry'					=> array('function' => 'IExpression.getEntry'),
    					  'iExpression.getUploadLocations'			=> array('function' => 'IExpression.getUploadLocations'),			//
    					  'iExpression.uploadFile'					=> array('function' => 'IExpression.uploadFile'),					//
    					  'iExpression.newEntry'					=> array('function' => 'IExpression.newEntry'),
						  'iExpression.updateEntry'					=> array('function' => 'IExpression.updateEntry'),
						  'iExpression.removeFile'					=> array('function' => 'IExpression.removeFileFromLocation'),		//
						  'iExpression.appendToFile'				=> array('function' => 'IExpression.appendToFile'),					//
						  'iExpression.applyFormat'					=> array('function' => 'IExpression.applyFormat')
						  );

		return $functions;		
	}

	// 	
	// Converts the supplied sql string targetted to EE 1.X to channels (EE 2.X). Note this is a dumb string substitution and should 
	// not be used on data containing user supplied text or strings that contain blog or weblog
	// 
	function correctSQL($sql){
		if (!$this->useChannel){
			return $sql;
		}
		return str_replace("blog","channel",str_replace("weblog", "channel",$sql));
	}

	// 	
	// Converts the supplied ExpressionEngine formated date into an iso8601 format date
	// 
	function changeDateFormat($eeDate){		
		return array(date('Ymd\TH:i:s',$eeDate).'Z','dateTime.iso8601');
	}	
	
	// 	
	// Returns true if the supplied string has the supplied extension
	// 
	function hasPrefix($str, $text){
		$rest = substr($text, 0, strlen($str));
		if($rest == $str){
			return true;
		} else {
			return false;
		}
	}	
	
	//
	// Gets the choices available to the supplied field, recursively looking down if the
	// choices are dictated by another field
	//	
	function getChoicesForField(&$fieldDetail, $fieldId){
		$results = $this->executeQuery($this->correctSQL("SELECT field_pre_populate,field_pre_blog_id AS prechan,field_pre_field_id,field_list_items FROM exp_weblog_fields WHERE field_id='$fieldId'"));

		$row = $this->rowArray($results);

		if ($row['field_pre_populate']=='y'){
						
			$fieldDetail['prepopulate'] = array('YES','string');
			$fieldDetail['prepopulateFromChannel'] = array($row['prechan'],'int');
			$fieldDetail['prepopulateFromField'] = array($row['field_pre_field_id'],'int');
			
			return "";
		} else {
			$choices = explode("\n",$row['field_list_items']);
			// $blankIndex = $this->useChannel ? 1 : 0;
			// 
			// if ($blankIndex == 1){
			// 	$choices[0]=array("2.1Workaround",'string');
			// }
			
			$parsedChoices = array();
			foreach($choices as $index => $choice){
				$parsedChoices[] = array($choice,'string');
			}
			
			return array($parsedChoices,'array');
		}

	}		
	
	//
	// Gets the setting given the supplied key. If they key is not present the default value it returned
	//	
	function getSetting($key,$defaultValue){
        $sql = "SELECT value FROM exp_iexpression WHERE property='$key'"; 
        
		$results = $this->executeQuery($sql);
		
		if ($this->rowCount($results) == 0){
			return $defaultValue;
		}
		$row=$this->rowArray($results);
		return $row['value'];
	}
		
	//
	// Method: getCategories
	// Parameters: weblogId/channelId
	// Description
	// Gets a hierarchical set of categories for the given channel
	function getCategories($forChannelId){
		$cats = array();
    	
    	$sql = "SELECT exp_categories.* FROM   exp_categories, exp_weblogs WHERE  FIND_IN_SET(exp_categories.group_id, REPLACE(exp_weblogs.cat_group, '|', ',')) AND exp_weblogs.weblog_id = '$forChannelId'"; 
						
    	$results = $this->executeQuery($this->correctSQL($sql));
    	
    	if ($this->rowCount($results) > 0){
    		foreach($this->resultArray($results) as $row){
    			$cat = array();
    			
    			$cat['id'] = array($row['cat_id'],'int');
	      		$cat['name'] = array($row['cat_name'],'string');
	      		$cat['parentId'] = array($row['parent_id'],'int');
				$cat['description'] = array($row['cat_description'],'string');
				$cat['urlTitle'] = array($row['cat_url_title'],'string');
				$cat['order'] = array($row['cat_order'],'int');
				$cat['imageURL'] = array($row['cat_image'],'string');
				
	      		array_push($cats, array($cat, 'struct'));
    		}
    	}
		
		return $cats;
	}
	
	//
	// Method: getCategories
	// Parameters: weblogId/channelId
	// Description
	// Gets a hierarchical set of categories for the given channel
	function getStatuses($forChannelId){
		$statuses = array();
    	
    	$sql = "SELECT exp_statuses.* FROM   exp_statuses, exp_weblogs WHERE  FIND_IN_SET(exp_statuses.group_id, REPLACE(exp_weblogs.status_group, '|', ',')) AND exp_weblogs.weblog_id = '$forChannelId'"; 
				
    	$results = $this->executeQuery($this->correctSQL($sql));
    	
    	if ($this->rowCount($results) > 0){
    		foreach($this->resultArray($results) as $row){
    			$status = array();
    			
    			$status['id'] = array($row['status_id'],'int');
	      		$status['name'] = array($row['status'],'string');
				$status['order'] = array($row['status_order'],'int');
				$status['highlight'] = array($row['highlight'],'string');
				
	      		array_push($statuses, array($status, 'struct'));
    		}
    	}
		
		return $statuses;
	}
	
	function getGalleryCategories($galleryId){
		$cats = array();
    	
    	$sql = "SELECT * FROM exp_gallery_categories WHERE gallery_id = '$galleryId'"; 
		
    	$results = $this->executeQuery($this->correctSQL($sql));
    	
    	if ($this->rowCount($results) > 0){
    		foreach($this->resultArray($results) as $row){
    			$cat = array();
    			
    			$cat['id'] = array($row['cat_id'],'int');
	      		$cat['name'] = array($row['cat_name'],'string');
	      		$cat['parentId'] = array($row['parent_id'],'int');
				$cat['description'] = array($row['cat_description'],'string');
				$cat['urlTitle'] = array($row['cat_name'],'string');
				$cat['order'] = array($row['cat_order'],'int');
				$cat['imageURL'] = array('','string');
				
	      		array_push($cats, array($cat, 'struct'));
    		}
    	}
		
		return $cats;
	}

	function getGalleryStatuses($galleryId){
		$statuses = array();

		$status = array();		
		$status['id'] = array(0,'int');
		$status['name'] = array('open','string');
		$status['order'] = array('0','int');
		$status['highlight'] = array('009900','string');		
		array_push($statuses, array($status, 'struct'));
    	
		$status = array();		
		$status['id'] = array(1,'int');
		$status['name'] = array('closed','string');
		$status['order'] = array('1','int');
		$status['highlight'] = array('990000','string');		
		array_push($statuses, array($status, 'struct'));
				
		return $statuses;
	}
	
	function createBaseChannelFieldDescription($name,$label,$instructions,$format,$htmlEditor,$maxLength,$type,$required,$order,$showByDefault){
		$fieldDetail = array();
		
		$fieldDetail['name']   = array($name,'string');
		$fieldDetail['label']   = array($label,'string');
		$fieldDetail['instructions']   = array($instructions,'string');
		
		$fieldDetail['format']     = array($format,'string');
		$fieldDetail['htmlEditor'] = array($htmlEditor == 'y' ? 'YES' : 'NO' ,'string');
		$fieldDetail['maxLength'] = array($maxLength,'int');
		$fieldDetail['type']      = array($type,'string');
				
		$fieldDetail['required'] = array($required == 'y' ? 'YES' : 'NO' ,'string');
		$fieldDetail['order'] = array($order,'string');
		$fieldDetail['showByDefault'] = array($showByDefault == 'n' ? 'YES' : 'NO','string');
		
		return $fieldDetail;
	}
	
	function modifyGalleryFieldDescription($galleryDetails,&$fieldDetail,$customFieldPrefix){
		switch ($fieldDetail['type'][0]){
			case 'i':
				$fieldDetail['type'][0]='text';
				break;
			case 't':
				$fieldDetail['type'][0]='textarea';
				break;
			case 's':
				$fieldDetail['type'][0]='select';
				$choices = explode("\n",$galleryDetails[$customFieldPrefix.'_list']);				
				$parsedChoices = array();
				foreach($choices as $index => $choice){
					$parsedChoices[] = array($choice,'string');
				}
				$fieldDetail['allowedValues'] = array($parsedChoices,'array');							
				break;
		}
	}
	
	function createGalleryFieldDescription($galleryDetails,$customField){
		$fieldSuffixes = array('one','two','three','four','five','six');
		
		$fieldPrefix = 'gallery_cf_'.$fieldSuffixes[$customField-1];
		
		//Don't return anything if it's not enabled
		if ($galleryDetails[$fieldPrefix]!='y'){
			return array();
		}
		
		$fieldData = $this->createBaseChannelFieldDescription(
							$fieldPrefix,
							$galleryDetails[$fieldPrefix.'_label'],
							'',
							$galleryDetails[$fieldPrefix.'_formatting'],
							$galleryDetails[$fieldPrefix.'_formatting'] == 'xhtml' ? 'y' : 'n',
							-1,
							$galleryDetails[$fieldPrefix.'_type'],
							'n',
							1+$customField,
							'y');
		
		$this->modifyGalleryFieldDescription($galleryDetails,$fieldData,$fieldPrefix);
		
		return $fieldData;
	}
	
	//
	// Method: galleryDescription
	// Parameters: galleryId
	// Description
	// Returns base details of the gallery including field types and ordering
	function galleryDescription($galleryId){
		
		$gallerySqlResults = $this->executeQuery("SELECT * FROM exp_galleries WHERE gallery_id='$galleryId'");
		
		if ($this->rowCount($gallerySqlResults)==0){
			return $this->send_error_message('404','Gallery not found');
		}
		
		$galleryDetails = $this->rowArray($gallerySqlResults);
		
		$details = array();
		
		$details['channelId'] = array(0-$galleryId,'int');
		$details['channelURL'] = array($galleryDetails['gallery_url'],'string');
		$details['commentURL'] = array($galleryDetails['gallery_comment_url'],'string');
		$details['categories'] = array($this->getGalleryCategories($galleryId),'struct');
		$details['statuses'] = array($this->getGalleryStatuses($galleryId),'struct');
		$details['deftCategory'] = array('','string');
		$details['allowHTMLFormatting'] = array('NO','string');
		
		$fields = array();
		
		//Add the image file entry first
		$fields[0] = array($this->createBaseChannelFieldDescription('image','Image',' ','none','n',-1,'gallery_image','y',0,'y'),'struct');
		
		//Add the caption in second
		$fields[1] = array($this->createBaseChannelFieldDescription(
					'caption','Caption',' ',
					$galleryDetails['gallery_text_formatting'],$galleryDetails['gallery_text_formatting'] == 'xhtml' ? 'y' : 'n',-1,'textarea',
					'n',1,'y'),'struct');
		
		//Then add custom fields as required
		for ($i=1;$i<7;$i++){
			$fieldResult = $this->createGalleryFieldDescription($galleryDetails,$i);
			if (count($fieldResult)>0){
				$fields[$i+1]=array($fieldResult,'struct');
			}
		}
		
		$details['fields'] = array($fields,'struct');
        
		$response = array($details,'struct');
		
		return $this->send_response($response);		
	}
	
	//
	// Method: ffFieldDescription
	// Parameters: &fieldDetails,&field
	function desribeFF(&$fieldDetails, &$fieldDetail){
		$fieldId = substr($fieldDetails['field_type'],9);
//		error_log('field id '.$fieldId);
		$ffResults = $this->executeQuery("SELECT * FROM exp_ff_fieldtypes WHERE fieldtype_id = '$fieldId'");
		if ($this->rowCount($ffResults)==0){
			return;
		}
		$ffDetails = $this->rowArray($ffResults);
		$ffSettings = unserialize( $fieldDetails['ff_settings'] );
		
		switch($ffDetails['class']){
//			case 'ff_checkbox':
//				$fieldDetail['type']=array('checkboxes','string');
//				$fieldDetail['allowedValues']=array('y'
			default:
				error_log($ffDetails['class']);
				$fieldDetail['type']=array($ffDetails['class'],'string');				
		}
		
	}
	
	//
	// Method: applyFormat
	// Parameters: username, password, format, textToBeFormatted
	// Description
	// Applies the specified formatting to the supplied string and returns the string
	function applyFormat($plist){
    	$parameters = $plist->output_parameters();
    	
    	//Inform them the request is malformed
    	if (count($parameters)!=4){
	    	return $this->send_error_message('400', 'Bad request');
    	}
    	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$format	  = $parameters[2];
		$toBeFormatted = $parameters[3];
		
		//Validate username and password and load the remainder of the member's data    	
    	if ( ! $this->validateMember($parameters['0'], $parameters['1'])){
    		return $this->send_error_message('401', $this->detailedError=='' ? 'Unauthorized' : $this->detailedError);
    	}

		$this->initTypography();
		
		$settings['html_format']	= $this->channelHTMLFormat;
		$settings['auto_links']		= 'n';
		$settings['allow_img_url']	= 'y';
		$settings['text_format']    = $format;		
		
		$nowFormatted = $this->parseType($toBeFormatted,$settings);
		
		$results = array('formatted' => array($nowFormatted,'string'), 'original' => array($toBeFormatted,'string'), 'format' => array($format,'string'));
		
		return $this->send_response(array($results,'struct'));
	}
	
	
	//
	// Method: weblogDescription
	// Parameters: username, password, weblogID
	// Description
	// Returns base details of the weblog/channel/blog including field types and ordering
	//	
	function weblogDescription($plist){
    	$parameters = $plist->output_parameters();
    	
    	//Inform them the request is malformed
    	if (count($parameters)!=3){
	    	return $this->send_error_message('400', 'Bad request');
    	}
    	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$weblogId = $parameters[2];

		//Validate username and password and load the remainder of the member's data    	
    	if ( ! $this->validateMember($parameters['0'], $parameters['1'])){
    		return $this->send_error_message('401', $this->detailedError=='' ? 'Unauthorized' : $this->detailedError);
    	}

		//If it's a gallery, use a different description
		if ($weblogId < 0){
			return $this->galleryDescription(0-$weblogId);
		}
    	
    	//Validate the user has edit access to the selected group
    	if ( ! $this->userInformation['can_access_edit'] && $this->userInformation['group_id'] != '1'){
    		return $this->send_error_message('403', 'Forbidden!!'.' '.print_r($this->userInformation,TRUE));
    	}
    	
    	$response = $this->parseChannel($weblogId);
    	
    	//Did an error occur? If not populate with an actual response
    	if ($response==NULL){
    	
   			$details = array();
   			
   			$details['channelId'] = array($this->defaultChannelId,'int');
   			$details['channelURL'] = array($this->channelURL,'string');
   			$details['commentURL'] = array($this->commentURL,'string');
   			$details['deftCategory'] = array($this->defaultCategory,'string');
   			$details['commentURL'] = array($this->commentURL,'string');
			$details['allowHTMLFormatting'] = array($this->channelHTMLFormat,'string');
			$details['categories'] = array($this->getCategories($weblogId),'struct');
			$details['statuses'] = array($this->getStatuses($weblogId),'struct');
 
 			$fields = array();

			foreach ($this->channelFields as $field_id => $fieldDetails){
				$fieldDetail = array();
				
				$fieldDetail['name']   = array($fieldDetails['field_name'],'string');
				$fieldDetail['label']   = array($fieldDetails['field_label'],'string');
				$fieldDetail['instructions']   = array($fieldDetails['field_instructions'],'string');
				
				$fieldDetail['format']     = array($fieldDetails['field_fmt'],'string');
				$fieldDetail['htmlEditor'] = array($fieldDetails['field_show_fmt'] == 'y' ? 'YES' : 'NO' ,'string');
				$fieldDetail['maxLength'] = array($fieldDetails['field_maxl'],'int');
				
				$fieldDetail['type'] = array($fieldDetails['field_type'],'string');					
				
				switch ($fieldDetails['field_type']){
					case 'rel':
						if ($fieldDetails['field_related_to']!='blog' && $fieldDetails['field_related_to']!='channel'){
							$fieldDetail['relatedChannel'] = array(0-$fieldDetails['field_related_id'],'int');
						} else {							
							$fieldDetail['relatedChannel'] = array($fieldDetails['field_related_id'],'int');
						}
						$fieldDetail['relatedChannelSortBy'] = array($fieldDetails['field_related_orderby'],'string');
						$fieldDetail['relatedChannelSortOrder'] = array($fieldDetails['field_related_sort'],'string');
						break;
					case 'checkboxes':
					case 'multi_select':
					case 'radio':
					case 'select':
						$fieldDetail['allowedValues'] = $this->getChoicesForField($fieldDetail,$field_id);							
						break;
					case 'file':
						$fieldDetail['allowedFileTypes'] = array($fieldDetails['field_content_type'],'string');
						break;
					default:
						//
						//Is this a FieldFrame field? http://pixelandtonic.com/fieldframe 
						//
						if ($this->hasPrefix('ftype_id_',$fieldDetails['field_type'])){
							$this->desribeFF($fieldDetails, $fieldDetail);
						} 				
				}
				
				$fieldDetail['required'] = array($fieldDetails['field_required'] == 'y' ? 'YES' : 'NO' ,'string');
				$fieldDetail['order'] = array($fieldDetails['field_order'],'string');
				$fieldDetail['showByDefault'] = array($fieldDetails['field_is_hidden'] == 'n' ? 'YES' : 'NO','string');
				
				
				$fields[$field_id] = array($fieldDetail,'struct');
			}         
			
 			$details['fields'] = array($fields,'struct');
        
			$response = array($details,'struct');
			
			return $this->send_response($response);
		    				
    	} else {
    		return $response;
    	}
	}
	
	//
	// Method: entryStats
	// Parameters: username,password,entryId
	// Description
	// Providing the user has access to the control panel, and read acess to the post will return the
	// basic statistics for that post (views)
	//	
	function entryStats($plist){    	    	
    	$parameters = $plist->output_parameters();   	
    	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$entry_id = $parameters[2];

		//Validate username and password and load the remainder of the member's data    	
    	if ( ! $this->validateMember($parameters['0'], $parameters['1'])){
    		return $this->send_error_message('401', $this->detailedError=='' ? 'Unauthorized' : $this->detailedError);
    	}

    	
    	//Validate the user has edit access to the selected group
    	if ( ! $this->userInformation['can_access_edit'] && $this->userInformation['group_id'] != '1'){
    		return $this->send_error_message('403', 'Forbidden');
    	}

		$query = $this->getEntryFields($entry_id);

		//If we have no results then bug out
		if ($this->rowCount($query)==0){	
			return $this->send_error_message('404', 'No resource found');
		}

		$row = $this->rowArray($query);

		$entryDetails = array(
							'title' => array($row['title'],'string'),
							'urlTitle' => array($row['url_title'],'string'),
							'status' => array($row['status'],'string'),
							'commentsAllowed' => array($row['allow_comments'] == 'y' ? 'YES' : 'NO','string'),
							'trackBacksAllowed' => array($row['allow_trackbacks'] == 'y' ? 'YES' : 'NO','string'),
							'sticky' => array($row['sticky'] == 'y' ? 'YES' : 'NO','string'),
							'viewCountOne' => array($row['view_count_one'],'int'),
							'viewCountTwo' => array($row['view_count_two'],'int'),
							'viewCountThree' => array($row['view_count_three'],'int'),
							'viewCountFour' => array($row['view_count_four'],'int')
						  );
       	
		$response = array($entryDetails,'struct');
	
		return $this->send_response($response);
	}

	//
	// Method: getUploadLocations
	// Parameters: username, password
	// Description
	// Gets the available upload locations for a user
	//	
	function getUploadLocations($plist){    	
    	$parameters = $plist->output_parameters();

		if (count($parameters)!=2){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	
		
    	$username = $parameters[0];
    	$password = $parameters[1];

    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	

		//Find out which upload areas they are blocked from
		$blockedUploads = array();
    	if ($this->userInformation['group_id'] != '1'){
    		$blockedFrom = $this->executeQuery("SELECT upload_id FROM exp_upload_no_access WHERE member_group = '".$this->userInformation['group_id']."'");
    		
			foreach ($this->resultArray($blockedFrom) as $blockedOne){
				$blockedUploads[] = $blockedOne['upload_id'];
			}        
    	}

		$sql = "SELECT * FROM exp_upload_prefs ";
		//If they have blocked access to some locations add a condition to ensure none of those are made available
		if (count($blockedUploads)>0){
			$sql.=" WHERE id NOT IN(".implode(",",$blockedUploads).")";
		}
		
		$results = $this->executeQuery($sql);
		
		if ($this->rowCount($results)==0){
    		return $this->send_error_message('404', 'User has no upload locations');
		}

		$response=array();

		foreach ($this->resultArray($results) as $row){
			$locationData = array();
			foreach ($row as $key=>$value){
				$locationData[$key]=array($value,'string');
			}
			$response[]=array($locationData,'struct');
		}
			
		return $this->send_response(array($response,'struct'));
	}

	// 	
	// Tests to see if a user group has permission to access the identified location
	// 
	function checkAccessToFileLocation($locationId,$groupId){
    	if ($groupId != '1'){
    		$blockedCount = $this->executeQuery("SELECT COUNT(*) AS count FROM exp_upload_no_access WHERE upload_id = '$locationId' AND member_group = '$groupId'");
        
        	$blockedRow = $this->rowArray($blockedCount);
        
            if ($blockedRow['count'] != 0){
		    	return $this->send_error_message('401', "Unauthorized");
            }
    	}		
		return NULL;
	}

	// 	
	// Gets the location details and returns them in an array or NULL if the location does not exist
	// 
	function getFileLocationDetails($locationId){
    	$locationDetails = $this->executeQuery("SELECT * FROM exp_upload_prefs WHERE id = '$locationId'");
		if ($this->rowCount($locationDetails)==0){
			return NULL;
		}
		
		return $this->rowArray($locationDetails);
	}

	// 		
	// Resizes an image and encode it to be displayed on the client. It does not perform any security checks as anyone
	// can download images.
	// 
	function getFileThumbnail($plist){
		$parameters = $plist->output_parameters();
		
		if (count($parameters)!=2){
			return $this->send_error_message('400','Bad request');
		}
				
		$filename = $parameters[0];
		$uploadLocation = $parameters[1];
		
		$locationDetails = $this->getFileLocationDetails($uploadLocation);
		if ($locationDetails==NULL){
			return $this->send_error_message('404','Could not find location');
		}

		//First see if there is already a thumbnail file created by EE
		$existingThumbnailFilename = $locationDetails['server_path'].str_replace(".","_thumb.",$filename);
		if (file_exists($existingThumbnailFilename)){
			$handle = @fopen($existingThumbnailFilename, "r");
			$imageBinary = @fread($handle, @filesize($existingThumbnailFilename));
			@fclose($handle);			
			
			$results = array();
			$results[] = array($imageBinary,'base64');
			
			$response = array($results,'struct');
			
			return $this->send_response($response);
		}
				
		//get the full path
		$filename = $locationDetails['server_path'].$filename;

		//Load the image and prepare to resize
		$image_info = getimagesize($filename);
		$image_type = $image_info[2];
		if( $image_type == IMAGETYPE_JPEG ) {
		   $image = imagecreatefromjpeg($filename);
		} elseif( $image_type == IMAGETYPE_GIF ) {
		   $image = imagecreatefromgif($filename);
		} elseif( $image_type == IMAGETYPE_PNG ) {
		   $image = imagecreatefrompng($filename);
		} else {
			return $this->send_error_message('500','Unsupported image format');
		}
		
		//Desired width
		$width = 200;
		
		//Resize and make a jpeg before returning the data
	 	$ratio = $width / imagesx($image);
	    $height = imagesy($image) * $ratio;
		$new_image = imagecreatetruecolor($width, $height);
	    imagecopyresampled($new_image, $image, 0, 0, 0, 0, $width, $height, imagesx($image), imagesy($image));
		imagejpeg($new_image,$existingThumbnailFilename);
				
		//Now we have a thumbnail, we can call ourselves and return that thumbnail
		return $this->getFileThumbnail($plist);
	}

	function appendToFile($plist){
    	$parameters = $plist->output_parameters();
    	
		if (count($parameters)!=4){
	    	return $this->send_error_message('400', 'Bad request');
		}    	
		
    	$username 		= $parameters[0];
    	$password 		= $parameters[1];
    	$uploadLocation = $parameters[2];
		$data			= $parameters[3];
		
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	
		
		//Make sure they have permission
        $results = $this->checkAccessToFileLocation($uploadLocation,$this->userInformation['group_id']);
		if ($results!=NULL){
			return $results;
		}
		
		$locationDetails = $this->getFileLocationDetails($uploadLocation);
		if ($locationDetails==NULL){
			return $this->send_error_message('404','Could not find resource');
		}
		
		if ($this->appendDataToFile($data,$locationDetails)){
			return $this->send_response(array('1','boolean'));			
		} else {
			return $this->send_error_message('503','Could not append data to file');
		}		
	}
	
	function removeFileFromLocation($plist){
    	$parameters = $plist->output_parameters();
    	
		if (count($parameters)!=4){
	    	return $this->send_error_message('400', 'Bad request');
		}    	
		
    	$username 		= $parameters[0];
    	$password 		= $parameters[1];
    	$uploadLocation = $parameters[2];
		$fileName		= $parameters[3];
		
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	
		
		//Make sure they have permission
        $results = $this->checkAccessToFileLocation($uploadLocation,$this->userInformation['group_id']);
		if ($results!=NULL){
			return $results;
		}
		
		$locationDetails = $this->getFileLocationDetails($uploadLocation);
		if ($locationDetails==NULL){
			return $this->send_error_message('404','Could not find resource');
		}
		
		if ($this->deleteFile($fileName,$locationDetails)){
			return $this->send_response(array('1','boolean'));			
		} else {
			return $this->send_error_message('503','Could not delete file');
		}
	}
	
	// 	
	// Retrieves a directory listing for the specified location. 
	// Returns: struct{'result' => array('file1','file2')}
	// 
	function getUploadLocationContents($plist){
    	$parameters = $plist->output_parameters();
    	
		if (count($parameters)!=3){
	    	return $this->send_error_message('400', 'Bad request');
		}    	
		
    	$username 		= $parameters[0];
    	$password 		= $parameters[1];
    	$uploadLocation = $parameters[2];

    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	

		//Make sure they have permission
        $results = $this->checkAccessToFileLocation($uploadLocation,$this->userInformation['group_id']);
		if ($results!=NULL){
			return $results;
		}
		
		$locationDetails = $this->getFileLocationDetails($uploadLocation);
		if ($locationDetails==NULL){
			return $this->send_error_message('404','Could not find resource');
		}
		
				
		//Simple non-rescursive file walk (as EE doesn't seem to support nested folders)
		$dir = $locationDetails['server_path'];
		$results = array();
		$count = 0;
		if (is_dir($dir)) {
		    if ($dh = opendir($dir)) {
		        while (($file = readdir($dh)) !== false) {
					if (!is_dir($file)){
						if (strpos($file,"_thumb.")===false)
						$results["file$count"]=array($file,'string');
						$count++;
					}
		        }
		        closedir($dh);
		    }
		}

		$response = array($results,'struct');	
		
		return $this->send_response($response);
		
	}

	function saveFileToPath($fileName,$uploadPath,$data){
		if (!$fp = @fopen($uploadPath.$fileName,'wb')){
			return $this->send_error_message('500','Could not write file');
    	}
    	
    	@fwrite($fp, $data);
		@fclose($fp);
		
		@chmod($uploadPath.$filename, 0777);	
		return NULL;
	}
	
	//
	// Method: uploadFile
	// Parameters: username, password, uploadLocationId, data
	// Description
	// Uploads a file to the specified location
	//	
	function uploadFile($plist){    	
    	$parameters = $plist->output_parameters();
    	
		if (count($parameters)!=4){
	    	return $this->send_error_message('400', 'Bad request');
		}    	
		
    	$username 		= $parameters[0];
    	$password 		= $parameters[1];
    	$uploadLocation = $parameters[2];

    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	

		//Make sure they have permission
        $results = $this->checkAccessToFileLocation($uploadLocation,$this->userInformation['group_id']);
		if ($results!=NULL){
			return $results;
		}

    	$locationDetails = $this->getFileLocationDetails($uploadLocation);
		
    	if ($locationDetails==NULL){
			return $this->send_error_message('404','No such upload location');
    	}        
        

        //Fork off to location implementations
        return $this->saveFile($parameters[3],$locationDetails);        
	}
		
	//
	// Method: describeUser
	// Parameters: username, password
	// Description
	// Gets information about the user defined in the information above
	//	
	function describeUser($plist){    	
    	$parameters = $plist->output_parameters();

		if (count($parameters)!=2){
	    	return $this->send_error_message('403', "Insufficient Parameters");
		}    	
		
    	$username = $parameters[0];
    	$password = $parameters[1];

    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password: $username $password");
		}    	

		$response = array(array(
								'nickname' =>
								array($this->userInformation['screen_name'],'string'),
								'userid' =>
								array($this->userInformation['member_id'],'string'),
								'url' =>
								array($this->userInformation['url'],'string'),
								'email' =>
								array($this->userInformation['email'],'string'),
								'avatar' =>
								array($this->getPreference('avatar_url').$this->userInformation['avatar_filename'],'string')
							  ),
						'struct');
	
		return $this->send_response($response);
	}

	//
	// Method: getUsersGalleries
	// Parameters: standardChannels
	// Description
	// Gets galleries a user can post to
	//		
	function getUsersGalleries(&$standardChannels){
		//Only supported in 1.6
		if ($this->useChannel){
			return;
		}
		
		$sql = "SELECT gallery_id, gallery_full_name, gallery_url FROM exp_galleries";
		$results = $this->executeQuery($sql);
		if ($this->rowCount($results)==0){
			return;
		}
		
    	foreach($this->resultArray($results) as $row) {
    		$gallery =array();
			$gallery = array(array(
								  "url" => array($row['gallery_url'],"string"),
								  "blogid" => array(0-$row['gallery_id'],"string"),
								  "blogName" => array($row['gallery_full_name'],"string")
								  ),'struct');
    		$standardChannels[]=$gallery;
		}		
	}
	
	//
	// Method: getUsersChannels
	// Parameters: username, password
	// Description
	// Gets channels a user can post to
	//		
	function getUsersChannels($plist){
    	$parameters = $plist->output_parameters();

    	
 		if (count($parameters)!=2){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
		}    	
   	
    	$username = $parameters[0];
    	$password = $parameters[1];

    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('403', "Incorrect username and/or password");
    	}


    	$sql = "SELECT weblog_id, blog_title, blog_url FROM exp_weblogs WHERE weblog_id IN (".implode(',', $this->userInformation['assigned_channels']).")";
    	
    	if ($this->useChannel){
	    	$sql = "SELECT channel_id, channel_title, channel_url FROM exp_channels WHERE channel_id IN (".implode(',', $this->userInformation['assigned_channels']).")";
    	}

		$results = $this->executeQuery($sql);
    	    	
    	if ($this->rowCount($results)==0){
    		return $this->send_error_message('404', 'User has no channels');
    	}
    	
    	$weblogs = array();

    	foreach($this->resultArray($results) as $row) {
    		$weblog=array();
    		if ($this->useChannel){
				$weblog = array(array(
								"url" => array($row['channel_url'],"string"),
								"blogid" => array($row['channel_id'],"string"),
								"blogName" => array($row['channel_title'],"string")
								),'struct');
    		} else {
				$weblog = array(array(
								"url" => array($row['blog_url'],"string"),
								"blogid" => array($row['weblog_id'],"string"),
								"blogName" => array($row['blog_title'],"string")
								),'struct');
    		}
    		$weblogs[]=$weblog;
		}
		
		$this->getUsersGalleries($weblogs);

		$response = array($weblogs,'array');	
    	return $this->send_response($response);
	}	
	
	//
	// Method: deleteGalleryEntry
	// Parameters: username, password, entryId
	// Description
	// 
	// Deletes a gallery entry (action performed and permissions checked against the supplied credentials)
	//	
    function deleteGalleryEntry($plist){
    	global $STAT;
    	$parameters = $plist->output_parameters();   	
    	
 		if (count($parameters)!=3){
			return $this->send_error_message('400', 'Bad request');
		}    	
		
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$entryId = $parameters[2];
    	
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('401', "Unauthorized user");
    	}
    	
    	//Is the user a super user, or do they have ANY permissions for deleting their own or other's posts
    	if (   $this->userInformation['group_id'] != '1' AND !$this->userInformation['can_delete_self_entries'] AND ! $this->userInformation['can_delete_all_entries']){
    		return $this->send_error_message('403', 'Forbidden user cannot delete images');
        }
                
		//Remove entry and comments. File is not deleted
    	$this->executeQuery("DELETE FROM exp_gallery_entries WHERE entry_id = '$entryId'");
    	$this->executeQuery("DELETE FROM exp_gallery_comments WHERE entry_id = '$entryId'");
    			
		return $this->send_response(array(1,'boolean'));	
    }	
	
	//
	// Method: deleteEntry
	// Parameters: username, password, entryId
	// Description
	// 
	// Deletes a post (action performed and permissions checked against the supplied credentials)
	//	
    function deleteEntry($plist){
    	global $STAT;
    	$parameters = $plist->output_parameters();   	
    	
 		if (count($parameters)!=3){
			return $this->send_error_message('400', 'Bad request');
		}    	
   	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$entryId = $parameters[2];
    	
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('401', "Unauthorized user");
    	}
    	
    	//Is the user a super user, or do they have ANY permissions for deleting their own or other's posts
    	if (   $this->userInformation['group_id'] != '1' AND !$this->userInformation['can_delete_self_entries'] AND ! $this->userInformation['can_delete_all_entries']){
    		return $this->send_error_message('403', 'Forbidden user cannot delete entries');
        }
        
        
        //If we are in EE 2.X then just use the API to delete the post
        if ($this->useChannel){
        	return $this->apiDeleteEntry($entryId);
        }

		//Get entry, and confirm existence
    	$sql = $this->correctSQL("SELECT weblog_id, author_id, entry_id FROM exp_weblog_titles WHERE entry_id = '$entryId'");
    	$results = $this->executeQuery($sql);
    	
    	if ($this->rowCount($results)==0){
        	return $this->send_error_message('404', '$entryId resource missing');        
    	}
    	
    	$resultsRow = $this->rowArray($results);

    	$authorId = $resultsRow['author_id'];
		$weblogId = $resultsRow['weblog_id'];;

		//Check permissions    	
    	if ($this->userInformation['group_id'] != '1'){
    		//Have they been assigned this weblog?
    		if ( ! in_array($weblog_id, $this->userInformation['assigned_weblogs'])){
	    		return $this->send_error_message('403', 'Forbidden user not assigned weblog');
			}
			
			//Are they the author and can they delete their own entries?
			if ($authorId == $this->userInformation['member_id']){
                if ( ! $this->userInformation['can_delete_self_entries']){             
		    		return $this->send_error_message('403', 'Forbidden user cannot delete own entries');
                }
            } else {
                if ( ! $this->userInformation['can_delete_all_entries']){             
		    		return $this->send_error_message('403', 'Forbidden user cannot delete other users entries');
                }
            }
        }
        
		//Do Delete
		$this->executeQuery($this->correctSQL("DELETE FROM exp_weblog_titles WHERE entry_id = '$entryId'"));
		$this->executeQuery($this->correctSQL("DELETE FROM exp_weblog_data WHERE entry_id = '$entryId'"));
		$this->executeQuery($this->correctSQL("DELETE FROM exp_category_posts WHERE entry_id = '$entryId'"));
		$this->executeQuery($this->correctSQL("DELETE FROM exp_trackbacks WHERE entry_id = '$entryId'"));
		
		$this->executeQuery("UPDATE exp_members SET total_entries = total_entries-1 WHERE member_id = '$authorId'");
					
		//Delete comments on the entry
		$confirmResults = $this->executeQuery("SELECT author_id FROM exp_comments WHERE status = 'o' AND entry_id = '$entryId' AND author_id != '0'");
								
		if ($this->rowCount($confirmResults) > 0){
			foreach($this->resultArray($confirmResults) as $row){
				$returns = $this->executeQuery("SELECT COUNT(*) AS count FROM exp_comments WHERE status = 'o' AND entry_id = '$entryId' AND author_id = '".$row['author_id']."'");
				$returnsRowArray = $this->rowArray($returns);						
				$this->executeQuery("UPDATE exp_members SET total_comments = total_comments - ".$returnsRowArray['count']."' WHERE member_id = '".$row['author_id']."'");
			}
		}
					
		$this->executeQuery("DELETE FROM exp_comments WHERE entry_id = '$entryId'");

		//Delete any relationships
		$this->deleteRelationshipsFor($entryId);
		
		//Update stats etc
    	$STAT->update_weblog_stats($weblogId);
		$STAT->update_comment_stats($weblogId);
		$STAT->update_trackback_stats($weblogId);

		return $this->send_response(array(1,'boolean'));	
    }
	
	// 
	// Returns the data type (for XML_RPC) of the specified fieldId. Field data is read from the parsed channel
	// 
	function getFieldDataType($fieldId){
		switch ($this->channelFields[$fieldId]['field_type']){
			case 'date':
				return 'dateTime.iso8601';
			default:
				return 'string';
		}
	}

	// 	
	// Gets the data for the specified field, respecting parsing, field, and format settings
	// 
	function getFieldData($fieldId,$parseText,$settings,$format,$value){
		if ($parseText){
			$settings['text_format'] = $format;
		}	
	
		switch ($this->channelFields[$fieldId]['field_type']){
			case 'rel':
				return $this->getRelatedEntryId($value);
			case 'date':
				return date('Ymd\TH:i:s',$value).'Z';
			default:
				if ($parseText){
					return $this->parseType($value,$settings);
				} else {
					return $value;
				}
		}
	}	

	// 
	// Deletes relationships for an entry, will not do anything for EE 2.1
	// 
	function deleteRelationshipsFor($entryId){	
		//Skip this on 2.1, the API does it
		if ($this->useChannel){
			return;
		}
		$this->executeQuery("DELETE FROM exp_relationships WHERE rel_parent_id='$entryId' OR rel_child_id='$entryId'");
	}

	// 		
	// Checks for an existing relationship between two entries, and creates it if it does not already exist returning the correct
	// relationship id afterwards		
	// 		
	function deleteRelationship($relationshipId){
		$this->executeQuery("DELETE FROM exp_relationships WHERE rel_id='$relationshipId'");
	}

	// 
	// Gets the entry id for the relationship identified
	// 
	function getRelatedEntryId($relationshipId){
		$relResults = $this->executeQuery("SELECT rel_child_id FROM exp_relationships WHERE rel_id='$relationshipId'");
		if ($this->rowCount($relResults)==0){
			return -1;
		}
		
		$row = $this->rowArray($relResults);
		return $row['rel_child_id'];
	}
	
	// 
	// Creates a new relationship, returning the id of the created relationship
	// 
	function createRelationship($parentEntryId,$childEntryId){
		$sql = "INSERT INTO exp_relationships (rel_parent_id,rel_child_id,rel_type) VALUES ('$parentEntryId','$childEntryId','blog')";
		if ($this->useChannel){
			$sql = "INSERT INTO exp_relationships (rel_parent_id,rel_child_id,rel_type) VALUES ('$parentEntryId','$childEntryId','channel')";
		}
		$this->executeQuery($sql);
		
		return $this->getLastInsertId();
	}

	// 
	// Updates a potentially existing relationship, returning the id (regardless of whether or not it has changed)
	// 
	function updateRelationship($relationshipId,$parentEntryId,$childEntryId){
		$eRelResults = $this->executeQuery("SELECT rel_parent_id, rel_child_id FROM exp_relationships WHERE rel_id='$relationshipId'");
				
		//If we already have a relationship for this id then confirm that the 
		//parent and child are the same, if they are, then just return the current id
		//otherwise, delete the relationship and carry on as if we hadn't found it
		if ($this->rowCount($eRelResults)!=0){
			$currentRelationshipDetails = $this->rowArray($eRelResults);
			if (($parentEntryId == $currentRelationshipDetails['rel_parent_id']) && ($childEntryId == $currentRelationshipDetails['rel_child_id'])){
				return $relationshipId;
			}
			
			$this->deleteRelationship($relationshipId);
		}
		
		//However we got here, there is now no relationship in the database
		return $this->createRelationship($parentEntryId,$childEntryId);	
	}

	function getGalleryFieldValue($galleryDetails,$entryDetails,$customField){
		$fieldSuffixes = array('one','two','three','four','five','six');
		
		$fieldPrefix = 'gallery_cf_'.$fieldSuffixes[$customField-1];
		
		//Don't return anything if it's not enabled
		if ($galleryDetails[$fieldPrefix]!='y'){
			return array();
		}
		
		return  array(
					  array(
							'format' => array($galleryDetails[$fieldPrefix.'_formatting'],'string'),
							'data'   => array($entryDetails['custom_field_'.$fieldSuffixes[$customField-1]],'string')
							),'struct');
	}
	
	function getGalleryEntryImageURL($entryDetails, $galleryDetails){
		$imageFile = $entryDetails['filename'].$entryDetails['extension'];
		$galleryImageURL = $galleryDetails['gallery_image_url'];

	
		$catResults = $this->executeQuery("SELECT * FROM exp_gallery_categories WHERE cat_id = ".$entryDetails['cat_id']);
		
		if ($this->rowCount($catResults)==0){
			return $galleryImageURL.$imageFile;
		}
		
		$catDetails = $this->rowArray($catResults);
		if (strlen($catDetails['cat_folder'])==0){
			return $galleryImageURL.$imageFile;
		}
		
		return $galleryImageURL.$catDetails['cat_folder']."/".$imageFile;
	}
	
	function getGalleryEntry($galleryId,$entryId,$parseText){
		$gallerySqlResults = $this->executeQuery("SELECT * FROM exp_galleries WHERE gallery_id='$galleryId'");
		if ($this->rowCount($gallerySqlResults)==0){
			return $this->send_error_message('404','Gallery not found');
		}
		$galleryDetails = $this->rowArray($gallerySqlResults);
		
		$entryResults = $this->executeQuery("SELECT * FROM exp_gallery_entries WHERE entry_id=$entryId");
		if ($this->rowCount($entryResults)==0){
			return $this->send_error_message('404','Entry not found');
		}
		$entryDetails = $this->rowArray($entryResults);
		
		//Prepare the response
		$response = array();    	
		
		$convert_breaks = 'none';
		$link = $galleryDetails['gallery_url'].'image_full/'.$entryId.'/';
		
		$cat_array = array();    		
		$sql = "SELECT cat_name FROM exp_gallery_categories WHERE cat_id=".$entryDetails['cat_id'];		
		$results = $this->executeQuery($sql);    		
		if ($this->rowCount($results) > 0){
			foreach($this->resultArray($results) as $rrow){
				$cat_array[] = array($rrow['cat_name'], 'string');
			}
		}
		
		//Start to construct the field data
		
		//0 is the image itself
		$entryFieldData[0] = array(array('format' => array('none','string'),'data'   => array($this->getGalleryEntryImageURL($entryDetails, $galleryDetails),'string')),'struct');
		
		//1 is the caption
		$entryFieldData[1] = array(array('format' => array($galleryDetails['gallery_text_formatting'],'string'),'data'   => array($entryDetails['caption'],'string')),'struct');
				
		//Then add custom fields as required
		for ($i=1;$i<7;$i++){
			$fieldResult = $this->getGalleryFieldValue($galleryDetails,$entryDetails,$i);
			if (count($fieldResult)>0){
				$entryFieldData[$i+1]=$fieldResult;
			}
		}
						
		//Add in special data
		$entry_data['fields']=array($entryFieldData,'struct');
		$entry_data['categories']=array($cat_array,'array');
		$entry_data['permaLink']=array($link,'string');
		$entry_data['link']=array($link,'string');
		$entry_data['status']=array($entryDetails['status'] == 'o' ? 'open' : 'closed','string');
		
		//Change the date-fields
		$entry_data['title']=array($entryDetails['title'],'string');
		$entry_data['dateCreated']=$this->changeDateFormat($entryDetails['entry_date']);
		$entry_data['channelid'] = array(0-$galleryId,'string');
		$entry_data['parsed']=array($parseText,'string');
		array_push($response, array($entry_data,'struct'));
				
		return $this->send_response(array($response,'struct'));
	}
	
	//
	// Method: getEntry
	// Parameters: username, password, channelId, entryId, parsed
	// Description
	// Gets the identified entry. If parsed is set the field results will be parsed before being returned 
	// (for example if being previewed)
	//		
	function getEntry($plist){
    	$parameters = $plist->output_parameters();

    	if (count($parameters)!=5){
			return $this->send_error_message('400', 'Bad request');    	
    	}

    	$username = $parameters[0];
    	$password = $parameters[1];
    	$channelId = $parameters[2];
    	$entryId  = $parameters[3];
		$parseText = $parameters[4] == 'YES';

		//Basic access checks
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('401', "Unauthorized user");
    	}

		if ($channelId<0){
			return $this->getGalleryEntry(0-$channelId,$entryId,$parseText);
		}
		
    	if ($this->useChannel){
			if ( ! $this->userInformation['can_access_content'] && $this->userInformation['group_id'] != '1'){
	    		return $this->send_error_message('403', 'Forbidden user cannot view entries');
			}
    	} else {
	    	if ( ! $this->userInformation['can_access_edit'] && $this->userInformation['group_id'] != '1'){
	    		return $this->send_error_message('403', 'Forbidden user cannot edit entries');
	    	}
    	}
    	

		$sql = "SELECT wt.*, wd.* FROM exp_weblog_titles wt, exp_weblog_data wd WHERE wt.entry_id = wd.entry_id AND wt.entry_id = '$entryId' ";
		$this->send_error_message('100','test-3');

		if ($this->userInformation['group_id'] != '1' && ! $this->userInformation['can_edit_other_entries']){
			$sql .= "AND wt.author_id = '".$this->userInformation['member_id']."' ";
		}

		$sql = $this->correctSQL($sql);

    	$parseError = $this->parseChannel($channelId);
    	
    	if ($parseError!=NULL){
    		return $parseError;
    	}
    	
    	$queryResults = $this->executeQuery($sql);
    	
		if ($this->rowCount($queryResults) == 0){
        	return $this->send_error_message('404', 'No entries found.');        
		}
    	
    	if ($parseText){
    		$this->initTypography();
    	}
    	
		$settings = array();
		$settings['html_format']	= $this->channelHTMLFormat;
		$settings['auto_links']		= 'n';
		$settings['allow_img_url']	= 'y';

		$response = array();    	
		
		$queryResultArray = $this->resultArray($queryResults);
		foreach($queryResultArray as $row){
			$entryFieldData = array();
		
			$convert_breaks = 'none';
			$link = $this->removeDoubleSlashes($this->commentURL.'/'.$row['url_title'] .'/'); 

    		$cat_array = array();    		
    		$sql = "SELECT	exp_categories.cat_id, exp_categories.cat_url_title FROM	exp_category_posts, exp_categories WHERE	exp_category_posts.cat_id = exp_categories.cat_id AND		exp_category_posts.entry_id = '".$row['entry_id']."' ORDER BY cat_id";
    				
    		$results = $this->executeQuery($sql);    		
    		if ($this->rowCount($results) > 0){
    			foreach($this->resultArray($results) as $rrow){
    				$cat_array[] = array($rrow['cat_url_title'], 'string');
    			}
    		}
    		
    		// Sent Trackbacks
			$pings = array();
			if (isset($row['sent_trackbacks'])){
				$current_pings = (strlen($row['sent_trackbacks']) > 0) ? explode("\n", trim($row['sent_trackbacks'])) : array();
				
				if (sizeof($current_pings) > 0){	
					foreach($current_pings as $value){
						$pings[] = array($value, 'string');
					}
				}				
			}

    		//Push all of the columns into the entry data, some will 
			$entry_data = array();
			foreach($row as $key=>$value){
				if ($this->hasPrefix('field_id_',$key)){
	    			$fieldId = substr($key,9);
	    			if (isset($this->channelFields[$fieldId])){
	    				
	    				$dataContents = $this->getFieldData($fieldId,$parseText,$settings,$row['field_ft_'.$fieldId],$value);
						$dataType = $this->getFieldDataType($fieldId);
	    			
	      				$entryFieldData[$fieldId] = array(
	      												array(
	      													'format' => array($row['field_ft_'.$fieldId],'string'),
	      													'data' => array($dataContents,$dataType)
	      												)
	      											,'struct');
	    			}
	    		} else if ($this->hasPrefix('field_ft_',$key)){
	    			//Do nothing, it's been included when the id was hit
	    		} else {
					$entry_data[$key]=array($value,'string');
				}
			}
			
			//Add in special data
			$entry_data['fields']=array($entryFieldData,'struct');
			$entry_data['categories']=array($cat_array,'array');
			$entry_data['trackBackPingURLs']=array($pings,'array');
			
			$entry_data['permaLink']=array($link,'string');
			$entry_data['link']=array($link,'string');
			
			//Change the date-fields
			$entry_data['dateCreated']=$this->changeDateFormat($row['entry_date']);
			unset($entry_data['entry_date']);
			$entry_data['dateLastEdited']=$this->changeDateFormat($row['edit_date']);
			unset($entry_data['edit_date']);
			$entry_data['expirationDate']=$this->changeDateFormat($row['expiration_date']);
			unset($entry_data['expiration_date']);
			$entry_data['commentExpirationDate']=$this->changeDateFormat($row['comment_expiration_date']);
			unset($entry_data['comment_expiration_date']);

			if (!$this->useChannel){
				$entry_data['channelid'] = array($row['weblog_id'],'string');
			}

			$entry_data['parsed']=array($parameters[4],'string');
						
			array_push($response, array($entry_data,'struct'));
		}

		return $this->send_response(array($response,'struct'));    	
	}

	//
	// Method: getRecentGalleryEntryTitles
	// Parameters: username, password, channelId [,limit=10]
	// Description
	// Get the specified number of most recently posted article by date (defaults to 10 if no limit is supplied)
	//	
	function getRecentGalleryEntryTitles($galleryId,$limit){
		
    	$sql = "SELECT entry_id, title, gallery_id, author_id, entry_date FROM  exp_gallery_entries WHERE gallery_id=$galleryId ORDER BY entry_date desc LIMIT 0, {$limit}";
		
		$queryResults = $this->executeQuery($this->correctSQL($sql));
		
		if ($this->rowCount($queryResults) == 0){
        	return $this->send_error_message('404', 'No entries found.');        
		}
				
    	$response = array();
    	
		foreach($this->resultArray($queryResults) as $row){	
    		$entry_data = array(array(
									  'userid' => array($row['author_id'],'string'),
									  'dateCreated' => array(date('Ymd\TH:i:s',$row['entry_date']).'Z','dateTime.iso8601'),
									  'title' => array($row['title'], 'string'),
									  'postid' => array($row['entry_id'],'string'),
									  ),
								'struct');
			
			array_push($response, $entry_data);	
		}
		
		return $this->send_response(array($response, 'array'));		
	}
	
	//
	// Method: getRecentEntryTitles
	// Parameters: username, password, channelId [,limit=10]
	// Description
	// Get the specified number of most recently posted article by date (defaults to 10 if no limit is supplied)
	//	
    function getRecentEntryTitles($plist){
    	$parameters = $plist->output_parameters();   	
    	
    	if (count($parameters)<3){
			return $this->send_error_message('400', 'Bad request');    	
    	}
    	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$channelId = $parameters[2];
    	$limit = ( ! empty($parameters[3]) && is_numeric($parameters[3])) ? $parameters[3] : '10';
    	
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('401', "Unauthorized user");
    	}
    	
		if ($channelId < 0){
			return $this->getRecentGalleryEntryTitles(0-$channelId,$limit);
		}
		
    	if ( ! $this->userInformation['can_access_edit'] && $this->userInformation['group_id'] != '1'){
    		return $this->send_error_message('403', "Forbidden user cannot view entries");
    	}
    	
    	$this->parseChannel($channelId);

    	$sql = "SELECT DISTINCT(wt.entry_id), wt.title, wt.weblog_id, wt.author_id, wt.entry_date FROM   exp_weblog_titles wt, exp_weblog_data WHERE wt.entry_id = exp_weblog_data.entry_id ";
		
		if ($this->userInformation['group_id'] != '1' && ! $this->userInformation['can_edit_other_entries']){            
            $sql .= "AND wt.author_id = '".$this->userInformation['member_id']."' ";
        }
		
		if ($this->useChannel){
			$sql .= str_replace('exp_channels.channel_id','wt.channel_id', $this->channelSQL)." ";
		} else {
			$sql .= str_replace('exp_weblogs.weblog_id','wt.weblog_id', $this->weblog_sql)." ";
		}
		
		$sql .= "ORDER BY entry_date desc LIMIT 0, {$limit}";

		$queryResults = $this->executeQuery($this->correctSQL($sql));
		
		if ($this->rowCount($queryResults) == 0){
        	return $this->send_error_message('404', 'No entries found.');        
		}
		

    	$response = array();
    	
		foreach($this->resultArray($queryResults) as $row){	
    		$entry_data = array(array(
									'userid' => array($row['author_id'],'string'),
									'dateCreated' => array(date('Ymd\TH:i:s',$row['entry_date']).'Z','dateTime.iso8601'),
									'title' => array($row['title'], 'string'),
									'postid' => array($row['entry_id'],'string'),
									),
							   'struct');
    										   
			array_push($response, $entry_data);	
		}
		
		return $this->send_response(array($response, 'array'));
    }
	
	//
	// Method: version
	// Parameters: username, password
	// Description
	// Returns the version of iExpression supported by the module. If no or incorrect username and password details are supplied
	// the method first checks that if it should respond to anonymouse identification requests (defaults to YES) and if so responds with 
	// a 403 error which can be identified as iExpression. Otherwise full details of the CMS and iExpression version are returned. 
	//	
	function version($plist){    	
    	$parameters = $plist->output_parameters();

		if (count($parameters)!=2){
    		return $this->send_error_message('403', '5734a9dfa34f0665e65a0e9cf280895e');		
		}    	
		
    	$username = $parameters[0];
    	$password = $parameters[1];

    	if ( ! $this->validateMember($username, $password)){
    		return $this->send_error_message('403', "5734a9dfa34f0665e65a0e9cf280895e user=$username and password=$password");
		}    	
    	
    	$sql = "SELECT site_label, site_description FROM exp_sites WHERE site_id='".$this->currentSiteId()."'";

		$results = $this->executeQuery($sql);
    	
    	$versionDetails = array(
							'iExpression' => array('1.4','string'),
							'CMSVersion' => array(APP_VER,'string'),
							'CMS' => array(APP_NAME,'string'),
							'CMSBuild' => array(APP_BUILD,'string')
							);

		if ($this->rowCount($results)>0){
			$row = $this->rowArray($results);
			$versionDetails['siteName'] = array($row['site_label'],'string');
			$versionDetails['siteDescription'] = array($row['site_description'],'string');
		}

    	
		$response = array($versionDetails,'struct');
	
		return $this->send_response($response);
	}
	
	// 
	// Validates the categories for an entry
	// 
    function checkCategories($channelId, $array, $debug = '0'){
    	
    	$this->categories = array_unique($array);
    	
    	$sql = "SELECT exp_categories.cat_id, exp_categories.cat_url_title, exp_categories.parent_id FROM   exp_categories, exp_weblogs WHERE  FIND_IN_SET(exp_categories.group_id, REPLACE(exp_weblogs.cat_group, '|', ',')) AND exp_weblogs.weblog_id = '$channelId'"; 
    				
    	$queryResults = $this->executeQuery($this->correctSQL($sql));
    	
    	if ($this->rowCount($queryResults) == 0){
    		return $this->send_error_message('400','No valid categories');
    	}
    	
    	$good		= 0;
    	$all_cats	= array();
    	
    	foreach($this->resultArray($queryResults) as $row){
    		$all_cats[$row['cat_id']] = $row['cat_url_title'];
    		
    		if (in_array($row['cat_id'], $this->categories) OR in_array($row['cat_url_title'], $this->categories)){
    			$good++;
    			$cat_names[$row['cat_id']] = $row['cat_url_title'];
    			
    			if ($this->assignToParentCategories == TRUE && $row['parent_id'] != '0'){
    				$this->parentCategories[$row['parent_id']] = 'Parent';
    			}
    		}
    	}
    		
    	if ($good < sizeof($this->categories)){
    		return $this->send_error_message('400','Invalid categories');
    	} else {
    		$this->categories = $cat_names;
    		
    		if ($this->assignToParentCategories == TRUE && sizeof($this->parentCategories) > 0){
    			foreach($this->parentCategories as $pussy => $galore){
    				$this->categories[$pussy] = $all_cats[$pussy];
    			}
    		}
    	}
    	
    	return NULL;
    }
    
	// 
	// Generates a unique file name for a given directory
	// 
  	function uniqueFilename($filename, $uploadPath){
  		$i = 0;
  		$subtype = '.jpg';

  		$x			= explode('.',$filename);
		$name		=  ( ! isset($x['1'])) ? $filename : $x['0'];
		$sfx		=  ( ! isset($x['1']) OR is_numeric($x[sizeof($x) - 1])) ? $subtype : '.'.$x[sizeof($x) - 1];
		$name		=  (substr($name,-1) == '_' || substr($name,-1) == '-') ? substr($name,0,-1) : $name;
  		$filename	= $name.$sfx;
  		
		while (file_exists($uploadPath.$filename))
		{
			$i++;
			$n			=  ($i > 10) ? -2 : -1;
			$x			= explode('.',$filename);
			$name		=  ( ! isset($x['1'])) ? $filename : $x['0'];
			$sfx		=  ( ! isset($x['1'])) ? '' : '.'.$x[sizeof($x) - 1];
			$name		=  ($i==1) ? $name : substr($name,0,$n);
			$name		=  (substr($name,-1) == '_' || substr($name,-1) == '-') ? substr($name,0,-1) : $name;
			$filename	=  $name."$i".$sfx;
		}
		
		return $filename;
	}
		
	//
	// Validates that the user can edit entries in the specified channel, returns NULL if everything is OK, or an
	// error if there are permissions issues
	//
	function canEditEntry($channelId, $entryAuthor){
		//Super users can do anything
		if ($this->userInformation['group_id']==1){
			return NULL;
		}
		
		
    	if ( ! $this->userInformation['can_access_edit']){
			return $this->send_error_message('401','User does not have permission to edit posts');
    	}
    	
    	if ( ! $this->userInformation['can_edit_other_entries'] && $this->userInformation['member_id']!=$entryAuthor){
            if (count($this->userInformation['assigned_weblogs']) == 0){
				return $this->send_error_message('401','User does not have permission to edit other posts');
            }
        }	



		return NULL;
	}	

	// 		
	// Helper function which converts XMLPRC formatted fields into EE SQL formatted fields	
	// 	
	function convertXMLRPCFieldsToSQLFields(&$postData, $forceSQL=FALSE){
		//While we are here, any fields that are dates or relationships need to be converted also...
		foreach ($postData['fields'] as $postedFieldId => $postedFieldValue){
			
			switch ($this->channelFields[$postedFieldId]['field_type']){
				case 'date':
					if ( ! empty($postData['fields'][$postedFieldId])){
						//ExpressionEngine 2.1 for custom date fields does not accept it's own format, 
						//and instead of converting to unix timestamp
						//we should convert into their human readable form
						if ($this->useChannel && !$forceSQL){
							$postData['fields'][$postedFieldId] = $this->makeHumanReadable($postData['fields'][$postedFieldId]);
						} else {
							$postData['fields'][$postedFieldId] = $this->iso8601Decode($postData['fields'][$postedFieldId]);
						}				
					}			
					break;
				case 'rel':
					break;
			}			
		}
		
	}	
			
	//
	// Updates an entry with the supplied data, the post data should be supplied in the same format as if newEntry was being called
	// Parameters: username, password, channelId, entryId, postData, status
	//
	function updateEntry($plist){
    	$parameters = $plist->output_parameters();   	
    
    	if (count($parameters)!=6){
			return $this->send_error_message('400', 'Bad request '.print_r($parameters,TRUE));    	
    	}
    	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$channelId = $parameters[2];
		$entryId = $parameters[3];
    	$postData = $parameters[4];
		$status = $parameters[5];    	

    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('401', "Unauthorized user");
    	}

		if ($channelId<0){
			return $this->updateGalleryEntry(0-$channelId,$entryId,$status,$postData);
		}
		
		$this->defaultTitle = $postData['title'];

		$this->parseChannel($channelId);
        
        //Now strip out any unsupported fields from the field definitions to ensure they are not included in the update
    	foreach($this->channelFields as $field_id => $field_data){
            $theFieldType = $field_data['field_type'];
            if (!in_array($theFieldType, $this->knownFields, TRUE)){
                unset($this->channelFields[$field_id]);
            }
        }
        
				
		$this->entryStatus=$status;
				
		//Gather existing post data
		$sql = "SELECT wt.weblog_id, wt.author_id, wt.title, wt.url_title,wb.blog_title, wb.blog_url FROM (exp_weblog_titles wt, exp_weblogs wb) WHERE wt.weblog_id = wb.weblog_id AND wt.entry_id = '".$this->escapeDBString($entryId)."' ";
		
		$currentEntryData = $this->executeQuery($this->correctSQL($sql));
				
		if ($this->rowCount($currentEntryData)==0){
			return $this->send_error_message('404','Entry not found');
		}
		
		$currentEntryDataRow = $this->rowArray($currentEntryData);		

		
		//Ensure this user has permission to edit this entry
		$permCheck = $this->canEditEntry($channelId,$currentEntryDataRow['author_id']);
		if ($permCheck != NULL){
			return $permCheck;
		}
				
		//Start preparing the updated post
		$this->defaultChannelId	= $channelId;
		$this->defaultTitle		= $postData['title'];

		//Correct the formats of any dates, forcing them directly to SQL format for 2.1 (as we are not using the API)
		$this->convertXMLRPCFieldsToSQLFields($postData,TRUE);

        $metadata = array(
        					'entry_id'          => $entryId,
							'title'             => $postData['title'],
							'ip_address'		=> $this->currentIP(),
							'status'            => $this->entryStatus
						  );
		
		$metadata['edit_date'] = date("YmdHis");

		//Strip-out alter what isn't needed or is different for 2.X
		if ($this->useChannel){
			unset($metadata['allow_trackbacks']);
			unset($metadata['weblog_id']);
		}						  
						  
		//Construct the entry data    	
    	$entry_data = array();
    	    	    	
    	$convert_breaks = ( ! isset($postData['convertLineBreaks'])) ? '' : $postData['convertLineBreaks'];
    	if ($convert_breaks != ''){
    		$plugins = $this->getPlugins();
    		
    		if ( ! in_array($convert_breaks, $plugins)){
    			$convert_breaks = '';
    		}
    	}
    	
    	foreach($this->channelFields as $field_id => $field_data){
    		//Move the formatting information and post data from the client into the structure ready to post
			if (!isset($field_data['1'])){
				$field_data['1']='none';
			}
			$entry_data['field_ft_'.$field_id] = ($convert_breaks != '') ? $convert_breaks : $field_data['1'];
			if (isset($postData['formats'][$field_id])){
				$entry_data['field_ft_'.$field_id] = $postData['formats'][$field_id];
			}
			if (!isset($postData['fields'][$field_id])){
				$postData['fields'][$field_id]= NULL;
			}
    		$entry_data['field_id_'.$field_id] = $postData['fields'][$field_id];
    	}
    	    					
    	$this->honorDST($metadata);    
		
		//
		// Update categories for entry
		//
		$this->executeQuery("DELETE FROM exp_category_posts WHERE entry_id = '$entryId'");
        if ( ! empty($postData['categories']) && sizeof($postData['categories']) > 0){
			$cats = array();
			
			foreach($postData['categories'] as $cat){
				if (trim($cat) != ''){
					$cats[] = $cat;
				}
			}
			
			if (sizeof($cats) == 0 && ! empty($deft_category)){
				$cats = array($deft_category);
			}
			
			if (sizeof($cats) > 0){
				$this->checkCategories($channelId,array_unique($cats));
				if (sizeof($this->categories) > 0){
					foreach($this->categories as $catid => $cat_name){
						$this->executeQuery("INSERT INTO exp_category_posts (entry_id, cat_id) VALUES ('".$entryId."', '$catid')");
					}        
				} 
			}			
		}

    	$updateResult =  $this->doUpdate($metadata,$entry_data,$channelId,$entryId);

		//
		// Now update relationships (not before, it will be overwritten by the general update)
		//
		$currentFieldData = $this->rowArray($this->executeQuery($this->correctSQL("SELECT * FROM exp_weblog_data WHERE entry_id='$entryId'")));		
		foreach ($postData['fields'] as $postedFieldId => $postedFieldValue){
			if ($this->channelFields[$postedFieldId]['field_type']=='rel'){
				
					//Column to update and acquire the current value from
					$columnName = "field_id_$postedFieldId";
					$currentRelationshipId = $currentFieldData[$columnName];

					//Get a new id and if necessary update the relationship for the field
					$relationshipId = $this->updateRelationship($currentRelationshipId, $entryId, $postedFieldValue);
										
					if ($currentRelationshipId != $relationshipId){
						$this->executeQuery($this->correctSQL("UPDATE exp_weblog_data SET $columnName='$relationshipId' WHERE entry_id='$entryId'"));						
					}
			}
		}

		return $updateResult;
	}
	
	//
	// "Simulates" an upload of an image to the gallery following the same rules applied in the CP
	//
	function createGalleryImage($uploadPath, $imageName, $imageData, $galleryDetails,&$entryData){
		$imageName = $this->uniqueFilename($imageName, $uploadPath);
		$result = $this->saveFileToPath($imageName,$uploadPath,$imageData);
		
		if ($result != NULL){
			return $result;
		}
		
		//image name and $upload_path is just that
		$image_name = $imageName;
        		
		$x = explode(".", $image_name);
		$extension	= '.'.end($x);
		$filename	= str_replace($extension, '', $image_name);
		
		//Now that's done set the entryData to reflect it
		$entryData['filename'] = $filename;
		$entryData['extension'] = $extension;
		
		//Prepare to create thumbnails if needed
		if ($galleryDetails['gallery_create_thumb'] == 'y'){
			$thumbs['thumb'] = array($galleryDetails['gallery_thumb_prefix'],  $galleryDetails['gallery_thumb_width'],  $galleryDetails['gallery_thumb_height'], $galleryDetails['gallery_thumb_quality']);			
		}
		
		if ($galleryDetails['gallery_create_medium'] == 'y'){
			$thumbs['med'] = array($galleryDetails['gallery_medium_prefix'], $galleryDetails['gallery_medium_width'], $galleryDetails['gallery_medium_height'], $galleryDetails['gallery_medium_quality']);			
		}
		
		require PATH_CORE.'core.image_lib'.EXT;
		$IM = new Image_lib();
		
		$vals = $IM->get_image_properties($uploadPath.$imageName, TRUE);
		
		$entryData['width'] = $vals['width'];
		$entryData['height'] = $vals['height'];
		$entryData['t_width'] = 0;
		$entryData['t_height'] = 0;
		$entryData['m_width'] = 0;
		$entryData['m_height'] = 0;

		if (isset($thumbs) AND count($thumbs) > 0)
		{
			foreach ($thumbs as $key => $val)
			{
				$res = $IM->set_properties(			
										   array(
												 'resize_protocol'	=> $galleryDetails['gallery_image_protocal'],
												 'libpath'			=> $galleryDetails['gallery_image_lib_path'],
												 'maintain_ratio'	=> ($galleryDetails['gallery_maintain_ratio'] == 'y') ? TRUE : FALSE,
												 'thumb_prefix'		=> $val['0'],
												 'file_path'		=> $uploadPath,
												 'file_name'		=> $imageName,
												 'new_file_name'	=> $imageName,
												 'quality'			=> $val['3'],
												 'dst_width'		=> $val['1'],
												 'dst_height'		=> $val['2']
												 )
										   );
				
				if ($res === FALSE OR ! $IM->image_resize()){
					error_log("Error creating thumbnails");
				}
				
				if ($key == 'thumb'){
					$entryData['t_width'] = $IM->dst_width;
					$entryData['t_height'] = $IM->dst_height;
				} else {
					$entryData['m_width'] = $IM->dst_width;
					$entryData['m_height'] = $IM->dst_height;
				}
				
				$IM->initialize();
			}		
		}		
		return NULL;
	}
	
  	function updateGalleryCategoryTotals($categoryId)
  	{
  		global $DB;

		$query = $DB->query("SELECT COUNT(*) AS count FROM exp_gallery_entries WHERE cat_id= '".$DB->escape_str($categoryId)."'");
		$tot = $query->row['count'];
		$query = $DB->query("SELECT MAX(entry_date) AS max_date FROM exp_gallery_entries 
							WHERE cat_id= '".$DB->escape_str($categoryId)."'");
		$date = ($query->num_rows > 0 && is_numeric($query->row['max_date'])) ? $query->row['max_date'] : '0';
		$query = $DB->query("SELECT views FROM exp_gallery_entries WHERE cat_id= '".$DB->escape_str($categoryId)."'");

		$views = 0;		
		if ($query->num_rows > 0){
			foreach($query->result as $row){
				$views = $views + $row['views'];
			}
		}
		
		$query = $DB->query("SELECT comment_date FROM exp_gallery_comments egc, exp_gallery_entries ege WHERE egc.entry_id = ege.entry_id AND egc.status = 'o' AND ege.cat_id = '".$DB->escape_str($categoryId)."' ORDER BY egc.comment_date desc LIMIT 1");
	
        $comment_date = ($query->num_rows == 0) ? 0 : $query->row['comment_date'];
		
		$query = $DB->query("SELECT COUNT(egc.comment_id) AS count FROM exp_gallery_comments egc, exp_gallery_entries ege WHERE egc.entry_id = ege.entry_id AND ege.status = 'o' AND ege.cat_id = '".$DB->escape_str($categoryId)."'");
		
        $total_comments = $query->row['count'];
		
		$DB->query("UPDATE exp_gallery_categories SET total_files = '{$tot}', total_views = '{$views}', recent_entry_date = '{$date}', total_comments = '{$total_comments}', recent_comment_date = '{$comment_date}' WHERE cat_id = '".$DB->escape_str($categoryId)."'");
  	}	
	
	function updateGalleryEntry($galleryId,$entryId,$status,$postData){
        global $DSP, $IN, $DB, $FNS, $LANG, $PREFS, $SESS, $LOC, $EXT;
				
		//Get the gallery settings
		$galleryResults = $this->executeQuery("SELECT * FROM exp_galleries WHERE gallery_id='$galleryId'");
		if ($this->rowCount($galleryResults)==0){
			return $this->send_error_message('404','Gallery not found');
		}
		$galleryDetails = $this->rowArray($galleryResults);
		
		//Get the catgory details
		$categoryName = $postData['categories'][0];
		$categoryResults = $this->executeQuery("SELECT * FROM exp_gallery_categories WHERE gallery_id='$galleryId' AND cat_name='$categoryName'");
		if ($this->rowCount($categoryResults)==0){
			return $this->send_error_message('509','Specified category '.$categoryName.' was not found');
		}
		$categoryDetails = $this->rowArray($categoryResults);
		$categoryId = $categoryDetails['cat_id'];
		
		//Determine the save path
		$catFolder = ($categoryDetails['cat_folder'] != '') ? $categoryDetails['cat_folder'] : '';
        $uploadPath = $FNS->remove_double_slashes($galleryDetails['gallery_upload_path'].'/'.$catFolder.'/');
		
		//Create the base data, the rest will be created by the image uploading thing
		$data = array(
					  'entry_id'			=> $entryId,
					  'gallery_id'			=> $galleryId,
					  'cat_id'				=> $categoryId,
					  'author_id'			=> $this->userInformation['member_id'],
					  'title'				=> $postData['title'],
					  'caption'				=> $postData['fields'][1],
					  'status'				=> $status,
					  'custom_field_one'	=> $postData['fields'][2],
					  'custom_field_two'	=> $postData['fields'][3],
					  'custom_field_three'	=> $postData['fields'][4],
					  'custom_field_four'	=> $postData['fields'][5],
					  'custom_field_five'	=> $postData['fields'][6],
					  'custom_field_six'	=> $postData['fields'][7]
					  );		

		//Do we need to upload a new image?
		if (strlen($postData['fields'][0])>512){
			//Create the image in the correct location etc
			$result = $this->createGalleryImage($uploadPath, $postData['title'].'.png', $postData['fields'][0], $galleryDetails, &$data);
			
			if ($result != NULL){
				return $result;
			}			
		}
		
		$DB->query($DB->update_string('exp_gallery_entries', $data, "entry_id = '$entryId'"));
		
		$this->updateGalleryCategoryTotals($categoryId);		
		
		return $this->send_response(array(1,'boolean'));
	}
	
	
	function newGalleryEntry($galleryId,$postData,$status){
        global $DSP, $IN, $DB, $FNS, $LANG, $PREFS, $SESS, $LOC, $EXT;
		
		//Get the gallery settings
		$galleryResults = $this->executeQuery("SELECT * FROM exp_galleries WHERE gallery_id='$galleryId'");
		if ($this->rowCount($galleryResults)==0){
			return $this->send_error_message('404','Gallery not found');
		}
		$galleryDetails = $this->rowArray($galleryResults);

		//Get the catgory details
		$categoryName = $postData['categories'][0];
		$categoryResults = $this->executeQuery("SELECT * FROM exp_gallery_categories WHERE gallery_id='$galleryId' AND cat_name='$categoryName'");
		if ($this->rowCount($categoryResults)==0){
			return $this->send_error_message('509','Specified category '.$categoryName.' was not found');
		}
		$categoryDetails = $this->rowArray($categoryResults);
		$categoryId = $categoryDetails['cat_id'];
				
		//Determine the save path
		$catFolder = ($categoryDetails['cat_folder'] != '') ? $categoryDetails['cat_folder'] : '';
        $uploadPath = $FNS->remove_double_slashes($galleryDetails['gallery_upload_path'].'/'.$catFolder.'/');
		
		//Create the base data, the rest will be created by the image uploading thing
		$data = array(
		  'entry_id'			=> '',
		  'gallery_id'			=> $galleryId,
		  'cat_id'				=> $categoryId,
		  'author_id'			=> $this->userInformation['member_id'],
		  'title'				=> $postData['title'],
		  'caption'				=> $postData['fields'][1],
		  'status'				=> $status,
		  'views'				=> 0,
		  'entry_date'			=> (!empty($postData['dateCreated']))? $this->iso8601Decode($postData['dateCreated']) : $this->rightNow(),
		  'allow_comments'		=> $galleryDetails['gallery_allow_comments'],
		  'custom_field_one'	=> $postData['fields'][2],
		  'custom_field_two'	=> $postData['fields'][3],
		  'custom_field_three'	=> $postData['fields'][4],
		  'custom_field_four'	=> $postData['fields'][5],
		  'custom_field_five'	=> $postData['fields'][6],
		  'custom_field_six'	=> $postData['fields'][7]
		  );		

		//Create the image in the correct location etc
		$result = $this->createGalleryImage($uploadPath, $postData['title'].'.png', $postData['fields'][0], $galleryDetails, &$data);
		
		if ($result != NULL){
			return $result;
		}
				
        $DB->query($DB->insert_string('exp_gallery_entries', $data));
        $insertId = $DB->insert_id;
		
		$this->updateGalleryCategoryTotals($categoryId);
		
		return $this->send_response(array($insertId,'string'));
	}
	
	//
	// Method: newEntry
	// Parameters: username, password, channelId, postData, status
	// Description
	// 
	// Creates a new entry in the specified channel. The postData should be a structure in the following format:
	//
	//		'title' => title of the post
	//		'allowComments' => YES|NO 				(optional)
	//		'categories' => array('cat','cat') 		(optional)
	//		'dateCreated' => date					(optional)
	//		'convertLineBreaks' => YES | NO			(optional)
	//		'fields' => structure containing
	//				'field_id' => content
	//				'field_id' => content
	//	
    function newEntry($plist){
    	$parameters = $plist->output_parameters();   	
    
    	if (count($parameters)!=5){
			return $this->send_error_message('400', 'Bad request');    	
    	}
    	
    	$username = $parameters[0];
    	$password = $parameters[1];
    	$channelId = $parameters[2];
    	$postData = $parameters[3];
		$status = $parameters[4];
    	
    	if ( ! $this->validateMember($username, $password)){
	    	return $this->send_error_message('401', "Unauthorized user");
    	}

		if ($channelId<0){
			return $this->newGalleryEntry(0-$channelId,$postData,$status);
		}
		
		$this->defaultTitle = $postData['title'];

		$this->parseChannel($channelId);
		
		$this->entryStatus=$status;    	
    	
    	$sql="SELECT deft_comments, cat_group, deft_category,blog_title, blog_url, weblog_notify_emails, weblog_notify, comment_url FROM exp_weblogs WHERE weblog_id = '$channelId'";
    	
    	$channelResults = $this->executeQuery($this->correctSQL($sql)); 
    	
    	if ($this->rowCount($channelResults) == 0){
	    	return $this->send_error_message('404','Missing channel');
        }
        
        $queryRow = $this->rowArray($channelResults);
            	
        //Read it into a set of instance variables
        foreach($queryRow as $key => $value){
        	${$key} =  $value;
        }
        
        $notify_address = ($queryRow['weblog_notify'] == 'y' AND $queryRow['weblog_notify_emails'] != '') ? $queryRow['weblog_notify_emails'] : '';
    	
    	$ping_urls	 = '';
		
		//Set-up comment parameters
		if (isset($postData['allowComments'])){
			$deft_comments = ($postData['allowComments'] == 'YES') ? 'y' : 'n';
		}
		$deft_trackbacks = 'n';
		
		//Sort out categories
		if (isset($postData['categories']) && sizeof($postData['categories']) > 0){
			$cats = array();
			
			foreach($postData['categories'] as $cat){
				if (trim($cat) != ''){
					$cats[] = $cat;
				}
			}
			
			if (sizeof($cats) == 0 && ! empty($deft_category)){
				$cats = array($deft_category);
			}
			
			if (sizeof($cats) > 0){
				$this->checkCategories($channelId,array_unique($cats));
			}
		} elseif( ! empty($deft_category)){
			$this->checkCategories($channelId,array($deft_category));
		}
		

		//Set the created date
		if ( ! empty($postData['dateCreated'])){
			$entry_date = $this->iso8601Decode($postData['dateCreated']);
		} else {
			$entry_date = $this->rightNow();
		}
		
		//Create an array to catch any relationships we will need to add in later
		$deferredRelationships = array();
		
		//While we are here, any fields that are dates need to be converted also...
		foreach ($postData['fields'] as $postedFieldId => $postedFieldValue){
			switch ($this->channelFields[$postedFieldId]['field_type']){
				case 'date':
					if ( ! empty($postData['fields'][$postedFieldId])){
						//ExpressionEngine 2.1 for custom date fields does 
						//not accept it's own format, and instead of converting to unix timestamp
						//we should convert into their human readable form
						if ($this->useChannel){
							$postData['fields'][$postedFieldId] = $this->makeHumanReadable($postData['fields'][$postedFieldId]);
						} else {
							$postData['fields'][$postedFieldId] = $this->iso8601Decode($postData['fields'][$postedFieldId]);
						}				
					}			
					break;
				case 'rel':
					//We need to clear the field (so it doesn't exist) and then we will retrospectively add back in
					//the relationships once the post has been made. No need on 2.1 as it is supported in the API
					if (!$this->useChannel){
						$deferredRelationships[$postedFieldId] = $postData['fields'][$postedFieldId];
						unset($postData['fields'][$postedFieldId]);						
					}
					break;
			}
		}
				
		// ---------------------------------------
    	//  URL Title Unique?
    	// ---------------------------------------*/
		
		$url_title = $this->createURLTitle($this->defaultTitle,$channelId);    	
    	
		// ---------------------------------
        //  Build our query string
        // --------------------------------*/
        
        $metadata = array(
        					'entry_id'          => '',
							'weblog_id'         => $channelId,
							'author_id'         => $this->userInformation['member_id'],
							'title'             => $postData['title'],
							'url_title'         => $url_title,
							'ip_address'		=> $this->currentIP(),
							'entry_date'        => $entry_date,
							'edit_date'			=> gmdate("YmdHis", $entry_date),
							'year'              => gmdate('Y', $entry_date),
							'month'             => gmdate('m', $entry_date),
							'day'               => gmdate('d', $entry_date),
							'status'            => $this->entryStatus,
							'allow_comments'    => $deft_comments,
							'allow_trackbacks'  => $deft_trackbacks
						  );
						  
		//Strip-out alter what isn't needed or is different for 2.X
		if ($this->useChannel){
			$metadata['channel_id'] = $metadata['weblog_id'];
			$metadata['ping_servers'] = array();
			unset($metadata['entry_id']);
			unset($metadata['allow_trackbacks']);
			unset($metadata['url_title']);
			unset($metadata['weblog_id']);
		}						  
						  
		//Construct the entry data    	
    	$entry_data = array();
    	
    	if ($this->useChannel){
	    	$entry_data['channel_id'] = $channelId;
    	} else {
	    	$entry_data['weblog_id'] = $channelId;
    	}
    	    	
    	$convert_breaks = ( ! isset($postData['convertLineBreaks'])) ? '' : $postData['convertLineBreaks'];
    	if ($convert_breaks != ''){
    		$plugins = $this->getPlugins();
    		
    		if ( ! in_array($convert_breaks, $plugins)){
    			$convert_breaks = '';
    		}
    	}
    	
    	foreach($this->channelFields as $field_id => $field_data){
			if (isset($postData['formats'][$field_id])){
				$entry_data['field_ft_'.$field_id] = $postData['formats'][$field_id];
			} else {
				$entry_data['field_ft_'.$field_id] = $field_data['field_fmt'];    		
//	    		return $this->send_error_message('666', print_r($field_data, TRUE));
			}
			
    		//Really should do some specific work here based on field format (field_ft)
    		if (isset($postData['fields'][$field_id])){
	    		$entry_data['field_id_'.$field_id] = $postData['fields'][$field_id];
    		} else {
    			$entry_data['field_id_'.$field_id] = "";
    		}
    	}
    	    			
    	$this->honorDST($metadata);    	
    	
    	$postingResult = $this->doPost($metadata,$entry_data,$channelId);    	

		//Create any relationships as needed
		if ($this->newEntryId>0 && !$this->useChannel){
			foreach ($deferredRelationships as $postedFieldId => $postedFieldValue){
				$columnName = "field_id_$postedFieldId";
				$relationshipId = $this->createRelationship($this->newEntryId,$postedFieldValue);
				$this->executeQuery($this->correctSQL("UPDATE exp_weblog_data SET $columnName='$relationshipId' WHERE entry_id='{$this->newEntryId}'"));
			}
		}

		return $postingResult;
	}
	
	
	
	
}

?>