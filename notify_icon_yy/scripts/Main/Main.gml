#macro cview view_camera[0]

function View(cam) constructor {
	camera = cam;
	
	Rect = function() {
		return new rect(camera_get_view_x(camera), camera_get_view_y(camera), camera_get_view_width(camera), camera_get_view_height(camera));
	}
}

function vec2(x, y) constructor {
	self.x = x;
	self.y = y;
}

function rect(x, y, w, h) constructor {
	if (argument_count == 4) {
		self.x = x;
		self.y = y;
		self.w = w;
		self.h = h;
	}
	if (argument_count == 3) {
		self.x = x;
		self.y = y;
		self.w = w;
		self.h = w;
	}
	if (argument_count == 0) {
		self.x = 0;
		self.y = 0;
		self.w = 0;
		self.h = 0;
	}
	
	Pos = function() {
		return new vec2(x, y);
	}
	Size = function() {
		return new vec2(w, h);
	}
	Absolute = function() {
		return new rect(x, y, x + w, y + h);
	}
}

global.messages = ds_list_create();
function Message(x, y, text, time, onscreen) constructor {
	ds_list_add(global.messages, self);
	t = -1;
	dialoge = noone;
	self.onscreen = false;
	if (time != undefined) {
		t = time;
	}
	if (onscreen != undefined) {
		self.onscreen = onscreen;
	}
	self.x = x;
	self.y = y;
	self.text = text;
	out = false;
	
	Draw = function() {
		w = string_width_ext(text, -1, 350) + 10;
		h = string_height_ext(text, -1, 350) + 10;
		r = new View(cview).Rect().Absolute();
		cx = x - w/2; cy = y - h - 10;
		if (onscreen) {
			cx = max(cx, r.x);
			cy = max(cy, r.y);
			cx = min(cx, r.w - w);
			cy = min(cy, r.h - h);
		}
		draw_set_color(c_white);
		draw_rectangle(cx - r.x, cy - r.y, cx + w - r.x, cy + h - r.y, false);
		draw_set_color(c_black);
		draw_text_ext(cx + w/2 - r.x, cy + h/2 - r.y, text, -1, 350);
		
		if (t > 0) {
			t -= delta_time * 0.000001;
			if (t <= 0) {
				Delete();
			}
		}
		
		return out;
	}
	
	deleted = false;
	Delete = function() {
		if (deleted) return;
		out = true;
		deleted = true;
		if (is_struct(dialoge)) {
			dialoge.Next();
		}
	}
	
	Pos = function(x, y) {
		self.x = x;
		self.y = y;
	}
}

function Dialoge(objs, messages) constructor {
	self.objs = objs;
	self.messages = messages;
	self.index = 0;
	mess = {deleted: true, Delete: function() {}};
	played = false;
	
	Start = function() {
		played = true;
		index = 0;
		mess = {deleted: true, Delete: function() {}};
		for(var i = 0; i < array_length(objs); i++) {
			objs[i].fixed = true;
		}
		Next();
	}
	
	Next = function() {
		if (!played) return;
		if (index >= array_length(messages)) {
			Stop();
			return;
		}
		var m = messages[index];
		index++;
		
		mess = new Message(-10000, -10000, m[1], m[2], false);
		m[0].mess = mess;
		mess.dialoge = self;
		if (array_length(m) > 3) {
			m[3]();
		}
	}
	
	Stop = function() {
		if (!played) return;
		for(var i = 0; i < array_length(objs); i++) {
			objs[i].fixed = false;
		}
		mess.Delete();
		played = false;
	}
}

function Item(name, sprite, create, draw, pick, down) constructor 
{
	f = 0;
	self.name = name;
	self.sprite = sprite;
	
	Create = function() {
		
	}
	if (create != undefined) {
		Create = create;
	}
	
	Draw = function() {
		draw_sprite(sprite, 0, h_goose.x + h_goose.dir * 20, h_goose.y - h_goose.sprite_height * 0.1);
		if (draw != undefined) {
			draw();
		}
	}
	self.draw = undefined;
	if (draw != undefined)
		self.draw = method(self, draw);
	
	self.pick = pick;
	self.down = down;
	
	Pick = function() {
		h_goose.item = self;
		if (pick != undefined) pick();
	}
	Down = function() {
		h_goose.item = noone;
		var o = instance_create_depth(h_goose.x, h_goose.y - 32, h_goose.depth, o_item);
		o.item = self;
		if (down != undefined) down(o);
	}
	
	mass = 1;
	delet = false;
}

#macro item_kamen global._item_kamen
global._item_kamen = new Item("Булыжник", s_kamen, undefined, undefined, function() {h_goose.mass = 2}, function() {h_goose.mass = 1});
item_kamen.mass = 2;
item_kamen.delet = true;

#macro item_gvozd global._item_gvozd
item_gvozd = new Item("Вакуумные гвозди\nСтрелять - K", s_gvozd, function() {f = 0}, function() {
	f ++;
	if (f > 10)
	if (keyboard_check(ord("K")) || keyboard_check(vk_enter)) {
		f = 0;
		var o = instance_create_depth(h_goose.x, h_goose.y - 32, h_goose.depth - 1, o_gvozd);
		o.hspeed = h_goose.dir * 13;
	}
});



#macro item_sperm global._item_sperm
item_sperm = new Item("Что-то вязкое\nВыпить - K", s_sperm, undefined, function() {
	if (keyboard_check_pressed(ord("K"))) {
		if (!is_struct(h_goose.mess)) {
			h_goose.item = noone;
			h_goose.mess = new Message(-1000, -1000, "Я чувствую уверенность в себе!", 2);
			instance_create_depth(6825, 400, h_goose.depth, h_goose_girl);
		}
	}
});

#macro item_flower global._item_flower
item_flower = new Item("Цветок", s_flower);

#macro item_anime global._item_anime
item_anime = new Item("Странный диск\nподойдите к дисководу и нажмите K", s_anime);

