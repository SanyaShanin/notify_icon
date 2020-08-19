global.phase = 0;
d = new Dialoge([h_goose], [
		[h_goose, "Аа-ах!", 1],
		[h_goose, "Какой чудесный день чтобы искупаться!", 2],
		[h_goose, "Надо быстрее бежать в пруд!!!", 1.5]
	])
	
d.Start();

global.dialoge_uw = new Dialoge([h_goose, h_texas_static], [
	[h_goose, "Привет, ты кто?", 2],
	[h_texas_static, "Я Bigtexas", 1.5],
	[h_goose, "Можно пройти?", 1.5],
	[h_texas_static, "Стой! Это моё озеро!", 3],
	[h_goose, "С чего бы?", 1.5],
	[h_texas_static, "Уходи отсюда! Я сначала выпью это озеро а потом выпью весь квас!", 3],
	[h_goose, "О нет! Надо остановить его!", 2]
])

global.dialoge_zhenya = new Dialoge([h_goose, h_zhenya], [
	[h_zhenya, "Привет, заходи, но хватит убивать моих уток из арболета", 3],
	[h_goose, "Я не за этим пришёл! Bigtexas хочет выпить весь квас!", 2.5],
	[h_zhenya, "Да, я слышал, что он украл квас в ларьке, бери гвозди на заднем дворе и стреляй по вору! Либо спроси что другие подскажут", 4],
	[h_goose, "Жень иди и сам прогани", 2], 
	[h_zhenya, "Блять как ты заебал. У тебя нет нихуя задачи сейчас, которую можно увидеть и сразу понять. Пиздуй короче, хуйня какая-то. Больше заебёшь меня, чем я с этого поимею", 4]
])

global.dialoge_kolya = new Dialoge([h_goose, h_kolya], [
	[h_kolya, "Привет, гусь", 1],
	[h_goose, "Ты работу ищешь?", 0.7],
	[h_kolya, "Да, я слишком много смеялся и меня уволили", 2],
	[h_goose, "Давай ты поможешь мне одолеть квасового похитителя!", 2],
	[h_kolya, "У меня кое-что есть, выпьешь и все твои проблемы решаться, держи", 2.5, function() {
		var o = instance_create_depth(h_goose.x, h_goose.y, h_goose.depth - 1, o_item);
		o.item = item_sperm;
	}]
]);

global.f_phase1 = function()
{
	global.phase = 1;
	global.dialoge_uw.Start();
	with (inst_33E8C1C4) instance_destroy(); 
	with inst_702F8711 instance_destroy();
}

global.f_phase2 = function()
{
	global.phase = 2;
	global.dialoge_zhenya.Start();
}

global.f_phase3 = function()
{
	global.phase = 2;
	global.dialoge_kolya.Start();
}

global.fboss_dialoge = new Dialoge([h_texas_boss, h_goose], [
	[h_goose, "Я тебя побежду!", 2],
	[h_texas_boss, "Нет, я тебя!", 2],
	[h_goose, "Кряяяя!", 2]
])

global.fboss = function() {
	h_texas_boss.active = true;
	instance_create_depth(6900, -2000, 0, o_block).image_yscale = 1000;
	global.fboss_dialoge.Start();
}

global.fanime = function() {
	if (!keyboard_check_pressed(ord("K"))) exit;
	
	global.result = "И вы до старости смотрели аниме\nХорошая концовка";
	room_goto(r_result)
}