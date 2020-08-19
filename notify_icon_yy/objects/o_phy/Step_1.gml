/// @description Insert description here
// You can write your code in this editor
var cy = Ground.Y(x);
var dr = 0;
if (Ground.Y(x + 10) > cy + skolz)
	dr = 1;
if (Ground.Y(x - 10) > cy + skolz)
	dr = -1;
	
if (OnGround())
	hspeed += (incr + 0.3) * dr;
	
if (place_meeting(x, y, o_water)) {
	var w = instance_nearest(x, y, o_water);
	
	if (y > w.y + sprite_height/2) {
		if (vspeed > -2 ) {
			vspeed -= grav * (mass <= 1 ? 1.3 : 0.7);
		}
	}
}