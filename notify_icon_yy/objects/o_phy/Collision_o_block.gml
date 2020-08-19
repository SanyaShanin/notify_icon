
col = false;
if (!place_meeting(x, y - vspeed, o_block)) {
	col = true;
	y = yprevious;
	vspeed = 0;
}
if (!place_meeting(x - hspeed, y, o_block)) {
	col = true;
	x = xprevious;
	hspeed = 0;
}
if (!col) {
	x = xprevious;
	y = yprevious;
	hspeed = 0;
	vspeed = 0;
}