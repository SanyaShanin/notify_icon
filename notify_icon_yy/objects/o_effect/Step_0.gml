/// @description Insert description here
// You can write your code in this editor
f++;
if (f > frames) {
	f = 0;
	effect_create_above(type, x + random_range(-0.2, 0.2) * sprite_width, y + random_range(-0.2, 0.2) * sprite_height, size, color)
}