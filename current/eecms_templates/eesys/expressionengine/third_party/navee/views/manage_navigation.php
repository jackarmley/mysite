<div id="navEE">
	<?= $nav_nav ?>
	<div class="navee_alert<?php if (strlen($alert) == 0){ ?> hidden<?php } ?>"><?= $alert ?><a href='javascript:;' class='x'>X</a></div>
	<?php 
	if (strlen($helper)>0){ ?>
		<div class="navee_helper"><?= $helper ?><a href='javascript:;' class='x'>X</a></div>
	<?php } ?>
	
	<?php if (!$nav_empty){ ?><a id="navee_add2Nav" class="btn action" href="javascript:;"><?= lang('cp_mn_add_to_navigation') ?></a><?php } ?>
	<div id="add_navItem" <?php if (!$nav_empty){ ?>class="hidden"<?php } ?>">
		<?=form_open('C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=navee'.AMP.'method=add_navitem_handler')?>
		<input type="hidden" name="navee_navigation_id" value="<?= $navigation_id ?>" />
		<ol class="required">
			<li>
				<label for="navee_text"><?= lang('cp_form_text') ?>:</label>
				<input type="input" name="navee_text" value="<?= $navee_text ?>" />
			</li>
			
			<li class="naveeLink">
				<label for="navee_link"><?= lang('cp_form_link') ?><?= $selectPagesBtn ?>:</label>
				<input type="input" name="navee_link" value="<?= $navee_link ?>" />
			</li>
			
			<?php if ($numPages>0){ ?>				
				<li class='pagesSelect'>
					<label for='navee_pages'><?= lang('cp_form_pages') ?><?= $enterLinkBtn ?>:</label>
					<?= $selectPages ?>
				</li>
			<?php } ?>
			<li>
				<label for="navee_parent"><?= lang('cp_form_parent') ?>:</label>
				<select name="navee_parent">
					<option value="0"><?= lang('cp_form_top_level') ?></option>
					<?= $parents ?>
				</select>
			</li>
			
		</ol>
		
		<div class="navee_optional">
		<h3><?= lang('cp_mn_optional_items') ?></h3>
		<ol>
			<li>
				<label for="navee_include"><?= lang('cp_form_include_in') ?></label>
				<select name="navee_include">
					<?= $navee_include ?>
				</select>
			</li>
			<li>
				<label for="navee_id"><?= lang('cp_form_id') ?>:</label>
				<input type="input" name="navee_id" value="<?= $navee_id ?>" />
			</li>
			
			<li>
				<label for="navee_class"><?= lang('cp_form_class') ?>:</label>
				<input type="input" name="navee_class" value="<?= $navee_class ?>" />
			</li>
			
			<li>
				<label for="navee_rel"><?= lang('cp_form_rel') ?>:</label>
				<input type="input" name="navee_rel" value="<?= $navee_rel ?>" />
			</li>
			
			<li>
				<label for="navee_name"><?= lang('cp_form_name') ?>:</label>
				<input type="input" name="navee_name" value="<?= $navee_name ?>" />
			</li>
			
			<li>
				<label for="navee_target"><?= lang('cp_form_target') ?></label>
				<select name="navee_target">
				<?= $navee_target ?>
				</select>
			</li>
			
			<li>
				<label for="navee_regex"><?= lang('cp_form_regex') ?>:</label>
				<input type="input" name="navee_regex" value="<?= $navee_regex ?>" />
			</li>
			
			<li>
				<label for="navee_member_groups"><?= lang('cp_form_member_groups') ?>:<br /><em><?= lang('cp_form_member_groups_desc') ?></em></label>
				
				<?= $memberGroups ?>
			</li>

			
		</ol>
		</div>
		<ul class="actions">
			<li><a href="javascript:;" class="navee_optional_btn btn options"><?= lang('cp_mn_optional') ?></a></li>
			<li><input type="submit" class="btn action" id="add-to-nav-btn" value="<?= lang('cp_mn_submit_add') ?>" name="navee_submit" /></li>
		</ul>
		<?=form_close()?>
	</div>
	<div id="navee_cp_nav">
		<?= $nav ?>
	</div>
</div>
