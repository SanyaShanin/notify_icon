/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (is_struct(item)) {
	item.Draw();
}

var it = instance_nearest(x, y, o_item), pick = false;
if (instance_exists(it)) {
	if (distance_to_object(it) < 50) {
		pick = true;
	}
}

if (pick) {
	if (!is_struct(mess)) {
		draw_set_color(c_black);
		draw_set_halign(fa_center)
		draw_set_valign(fa_bottom)
		draw_set_font(f_norm);
		draw_text(x, y - sprite_height - 15, "Нажмите I чтобы подобрать")
	}
}

if (keyboard_check_pressed(ord("I"))) {
	if (is_struct(item)) {
		item.Down();
	}
	if (pick) {
		it.Pick();
	}
}