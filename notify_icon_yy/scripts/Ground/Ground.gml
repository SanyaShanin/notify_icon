// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro Ground global._ground
function _Ground() constructor{
	points = [];
	precision = 16;
	path = noone;
	
	Init = function(path) {
		self.path = path;
		view = new View(view_camera[0]);
		points = array_create(room_width div precision);
		for(var i = 0; i < array_length(points); i++) {
			points[i] = path_get_y(path, i / (array_length(points) - 1));
		}
	}
	
	Draw = function() {
		draw_set_colour(c_black)
		var startcalc = view.Rect().x div precision, calcw = startcalc + (view.Rect().w div precision) + 2;
		draw_primitive_begin(pr_trianglestrip);
		for(var i = startcalc; i < calcw; i++) {
			var spoint = max(0, i), epoint = min(array_length(points) - 1, i + 1);
			var x0 = spoint * precision, y0 = points[spoint], x1 = epoint * precision, y1 = points[epoint];
			draw_vertex(x0, y0);
			draw_vertex(x1, y1);
			draw_vertex(x0, y0 + 2000);
			draw_vertex(x1, y1 + 2000);
		}
		draw_primitive_end();
		draw_set_colour(c_white);
		draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(s_earth, 0));
		for(var i = startcalc; i < calcw; i++) {
			var spoint = max(0, i), epoint = min(array_length(points) - 1, i + 1);
			var x0 = spoint * precision, y0 = points[spoint], x1 = epoint * precision, y1 = points[epoint];
			draw_vertex_texture(x0, y0, 0, 0);
			draw_vertex_texture(x1, y1, 1, 0);
			draw_vertex_texture(x0, y0 + 16, 0, 1);
			draw_vertex_texture(x1, y1 + 16, 1, 1);
		}
		draw_primitive_end();
	}
	
	Y = function(x) {
		return path_get_y(path, x / room_width);	
	}
}
Ground = new _Ground();