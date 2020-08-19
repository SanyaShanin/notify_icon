/// @description Insert description here
// You can write your code in this editor

vspeed += grav;
hspeed = max(abs(hspeed) - incr, 0) * sign(hspeed);
if (y > Ground.Y(x)) {
	y = Ground.Y(x);
	vspeed = 0;
}

if (fixed) {
	x = xprevious;
}

if (is_struct(mess)) {
	if (!mess.deleted) {
		mess.Pos(x, y - sprite_height - 20);
	} else
		mess = noone;
}