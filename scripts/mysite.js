(function(window,undefined ) {
	var sitescripts = {
		ui:{
			//Script to ensure Snowcone will work for legacy browsers, that don't support the :before pseudo class
			addicons:function(){
				//Create object with list of icons
					var icons = {
					    ico_alert: "A",
					    ico_cross: "B",
					    ico_tick: "C",
						ico_expand: "D",
						ico_contract: "E",
						ico_view: "F",
						ico_sync: "G",
						ico_home: "H",
						ico_outline_down: "I",
						ico_outline_up: "J",
						ico_outline_right: "K",
						ico_outline_left: "L",
						ico_stop: "M",
						ico_mapmarker: "N",
						ico_favourite: "O",
						ico_profile: "P",
						ico_magnify: "Q",
						ico_comment: "R",
						ico_settings: "S",
						ico_edit: "T",
						ico_email: "U",
						ico_shop_bag: "V",
						ico_logout: "W", 
						ico_heart: "X", 
						ico_rss: "Z", 
						ico_link: "a", 
						ico_fill_down: "b", 
						ico_fill_up: "c", 
						ico_fill_right: "d", 
						ico_fill_left: "e", 
						ico_facebook: "f", 
						ico_twitter: "g", 
						ico_googleplus: "h", 
						ico_blacklist: "i", 
						ico_twitter_bird: "t", 
						ico_twitter_plain: "u", 
						ico_tag: "t", 
						ico_speedo: "y",  
						ico_tangentsnowball: "z"
					};
				//Detect IE version	
					var browserver = parseInt($.browser.version, 10)
				
				//Run icon insertion	
					if ($.browser.msie && browserver == 6 || browserver == 7){
						$(".app-ico").each(function(){
							var icon = $(this).attr("class").split(/\s/);
							for(key in icons){
								if([key]==icon[1]){
									$(this).prepend("<span class='app-legacy_ico'>" + icons[key] + "</span>");
								};
							}
						});
					}
			}
		},
		pagespecific:{
			contactpage: function(){
				var messageplaceholder=$("#message").text();
				$("#message").focus(
					function(){
						if(messageplaceholder == "Go ahead, say something"){
							$(this).text("");
						}
				});
				$("#message").blur(
					function(){
						if(messageplaceholder == "Go ahead, say something"){
							$(this).text(messageplaceholder);
						}
				});
			}
		},
		mobile:{
			hideurlbar: function(){
				addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
				function hideURLbar(){
					window.scrollTo(0,1);
				}
			}
		}
	} 
window.sitescripts = sitescripts;
})(window);	  
	

$(document).ready(function() {
	//Run globals
		sitescripts.ui.addicons()
		sitescripts.mobile.hideurlbar()	
	//Page specific
		var pageid=$("html").attr("id");
		if(pageid=="pg-contact"){
			sitescripts.pagespecific.contactpage();
		}		 
});
