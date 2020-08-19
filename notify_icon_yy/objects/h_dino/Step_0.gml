/// @description Insert description here
// You can write your code in this editor

if (distance_to_object(h_goose) < 100) {
	if (!dialoge) {
		dialoge = true;
		dd.Start();
	}
	if (keyboard_check_pressed(ord("K"))) {
		active = !active;
	}
}

var epoint = xstart;
if (active) epoint = h_goose.x;
if (active && h_texas_boss.active && !h_texas_boss.fixed) epoint = h_texas_boss.x
if (abs(x - epoint) > 100) {
	DoStep(epoint - x);
}

image_speed = hspeed / 20;