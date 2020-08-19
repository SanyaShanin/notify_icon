/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white);
draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(texture, 0));
var sw = sprite_get_width(texture);
var sh = sprite_get_height(texture);
precision = 16;
r = new View(cview).Rect().Absolute();
uv = sprite_get_uvs(texture, 0);
gpu_set_tex_repeat(true);
var startcalc = max(x, r.x) div precision, calcw = (min(x + sprite_width, r.w) div precision) + 2;
for(var i = startcalc; i < calcw; i++) {
	var spoint = max(0, i), epoint = min(array_length(Ground.points) - 1, i + 1);
	var x0 = spoint * precision, y0 = Ground.points[spoint], x1 = epoint * precision, y1 = Ground.points[epoint];
	draw_vertex_texture(x0, y0 + level, x0/sw / scale mod 1, 0);
	draw_vertex_texture(x1, y1 + level, x1/sw / scale mod 1, 0);
	draw_vertex_texture(x0, y0 + level + sh * scale, x0/sw / scale mod 1, 1);
	draw_vertex_texture(x1, y1 + level + sh * scale, x1/sw / scale mod 1, 1);
}
draw_primitive_end();