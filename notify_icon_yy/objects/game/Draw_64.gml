/// @description Insert description here
// You can write your code in this editor

for(var i = 0; i < ds_list_size(global.messages); i++) {
	draw_set_font(f_norm);
	draw_set_color(c_black);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	if (global.messages[| i].Draw() || !asset_has_tags(room, "level", asset_room)) {
		ds_list_delete(global.messages, i);
		i--;
	}
}