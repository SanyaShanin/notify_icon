/// @description Insert description here
// You can write your code in this editor

draw_sprite(item.sprite, -1, x, y);
mass = item.mass;

var r = new View(cview).Rect().Absolute();
if (item.delet && (x < r.x || x > r.w)) {
	instance_destroy();
}