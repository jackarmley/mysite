<div id="navEE">
	<?php
		if ($instructions){
	?>
		<div class="first-time">
			<div id="support"><h3><?= lang('cp_pre_beta'); ?></h3> <p><?= lang('cp_beta_text'); ?> <a href="http://booyant.com/navee">booyant.com/navee</a></p></div>
			<h2><?= lang('cp_welcome') ?></h2>
			<p><?= lang('cp_first_nav') ?></p>
			
			<h3><?= lang('cp_start') ?></h3>
			<p><?= lang('cp_click_button') ?></p>
			<p><a class="lg btn action" href="<?= $add_nav_link ?>"><?= lang('cp_click_me') ?></a></p>
		</div>
	<?php	
		} else {
	?>
			<div class="navee_alert hidden"></div>
			<table class="mainTable" border="0" cellspacing="0" cellpadding="0">
				<thead>
					<tr>
						<th class="navee_th_name">Name</th>
						<th class="navee_th_title">Title</th>
						<th class="navee_th_desc">Description</th>
						<th class="navee_th_del"></th>
					</tr>
				</thead>
				<tbody>
				<?php foreach($navs AS $nav){ ?>
					<tr>
						<td><div>
							<span><a href='<?= $manage_nav_link ?>&id=<?= $nav["navigation_id"] ?>'><?= $nav["nav_name"] ?></a></span>
							<a class='navee_edit icn' title="<?= lang('cp_edit') ?>" id='navee_edit_name_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/edit-dark.png' /></a>
							<a class='navee_accept icn' title="<?= lang('cp_save') ?>" id='navee_accept_name_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/accept.png' /></a>
						</div></td>
						<td><div>
							<span><?= $nav["nav_title"] ?></span>
							<a class='navee_edit icn' title="<?= lang('cp_edit') ?>" id='navee_edit_title_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/edit-dark.png' /></a>
							<a class='navee_accept icn' title="<?= lang('cp_save') ?>" id='navee_accept_title_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/accept.png' /></a>
						</div></td>
						<td><div>
							<span><?= $nav["nav_description"] ?></span>
							<a class='navee_edit icn' title="<?= lang('cp_edit') ?>" id='navee_edit_description_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/edit-dark.png' /></a>
							<a class='navee_accept icn' title="<?= lang('cp_save') ?>" id='navee_accept_description_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/accept.png' /></a>
						</div></td>
						<td>
							<a class='navee_delete icn' title="<?= lang('cp_delete') ?>" id='navDelete_<?= $nav["navigation_id"] ?>' href='javascript:;'><img src='<?= $theme_folder_url ?>navee/img/trash-dark.png' alt='' /></a>
						</td>
					</tr>
				<?php } ?>
				</tbody>
			</table>
			<a class="btn action" href="<?= $add_nav_link ?>"><?= lang('cp_add_more') ?></a>			
	<?php } ?>

</div>