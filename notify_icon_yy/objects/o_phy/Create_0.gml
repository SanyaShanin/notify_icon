/// @description Insert description here
// You can write your code in this editor

maxspeed = 8;
jspeed = 10;
incr = 0.8;
grav = 1;
skolz = 5;
mass = 1;

dir = 1;

function InWater() {
	return place_meeting(x, y, o_water);
}
function OnGround() {
	return place_meeting(x, y + 1, o_block) || y + 1 >= Ground.Y(x);
}
function DoStep(dir) {
	if (dir == 0) exit;
	self.dir = sign(dir);
	if (sign(dir) != sign(hspeed) || abs(hspeed) < (mass <= 1 ? maxspeed : maxspeed * 0.7)) {
		hspeed += incr * 2 * sign(dir);
	}
}
function DoJump() {
	if (OnGround() && (InWater() || mass <= 1)) {
		vspeed = -abs(jspeed);
		return 1;
	}
	return 0;
}

mess = noone;
fixed = false;