<div id="navEE">
	
	<?php 
	if (strlen($alert)>0){ ?>
		<div class="navee_alert"><?= $alert ?><a href='javascript:;' class='x'>X</a></div>
	<?php } 
	if (strlen($helper)>0){ ?>
		<div class="navee_helper"><?= $helper ?><a href='javascript:;' class='x'>X</a></div>
	<?php } ?>
	<div id="add-nav-group">
	<?=form_open('C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=add_navigation_handler')?>
		<ol class="required">
			<li>
				<label for="navee_name">Name:</label>
				<input type="input" name="navee_name" />
			</li>
			
			<li>
				<label for="navee_title">Title:</label>
				<input type="input" name="navee_title" />
				<span>single word, no spaces</span>
			</li>
			
			<li>
				<label for="navee_description">Description:</label>
				<input type="input" name="navee_description" />
			</li>
		</ol>
		<input type="submit" class="create-nav-group btn action" value="<?= lang('cp_an_add_nav_group') ?>" name="navee_submit" />
	<?=form_close()?>
	</div>
</div>
