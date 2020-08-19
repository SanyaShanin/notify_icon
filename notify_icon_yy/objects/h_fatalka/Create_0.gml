/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

dialoge = false;

ff = function() {
		o = instance_create_depth(x, y, depth - 1, o_item);
		o.item = item_anime;
	}

dd = new Dialoge([id, h_goose], [
	[id, "Привет гусь, че такой грустный, концовка аниме плохая?", 3],
	[h_goose, "Нет, bigtexas хочет выпить весь квас!", 3],
	[id, "Да зачем тебе этот квас, на вот лучше тебе, тут короче вампир собирает гарем", 4],
	[h_goose, "Ну может посмотрю", 2],
	[id, "Аниме!", 1, ff]
])