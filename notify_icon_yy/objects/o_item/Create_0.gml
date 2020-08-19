/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

Pick = function() {
	if (is_struct(h_goose.item)) {
		h_goose.item.Down();
	}
	item.Pick();
	instance_destroy();
}