/// @description Insert description here
// You can write your code in this editor

var r = new View(cview).Rect().Absolute();
if (!instance_exists(instance) && (x < r.x || x > r.w) || !created) {
	instance = instance_create_depth(x, y, depth, o_item);
	instance.item = item;
}

created = true;