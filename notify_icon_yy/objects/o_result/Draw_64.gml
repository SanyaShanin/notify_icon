/// @description Insert description here
// You can write your code in this editor
draw_set_font(f_big) 
draw_set_color(c_white)
draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_text_ext(room_width/2, room_height/2, global.result, -1, room_width)
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape)) {
	room_goto(main);
}