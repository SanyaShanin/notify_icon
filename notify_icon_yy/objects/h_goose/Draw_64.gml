draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(f_big);
if (is_struct(item)) {
	draw_text(10, 10, item.name);
}

if (h_texas_boss.active) {
	var cx = display_get_gui_width() / 2 - hp * 32;
	repeat(hp) {
		cx += 64;
		draw_sprite(s_heart, 0, cx, 64)
	}
}