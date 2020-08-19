/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

active = false;

dialoge_flower_get = new Dialoge([h_goose, h_goose_girl], 
[
	[h_goose_girl, "Ой, мальчик, как тебя зовут?", 2],
	[h_goose, "блять", 2],
	[h_goose_girl, "принесёшь мне цветочек, милый?", 1.5],
	[h_goose, "...", 1],
	[h_goose, "я встретил настоящую тян!", 2]
]);

dialoge_gg = new Dialoge([h_goose, h_goose_girl], 
[
	[h_goose_girl, "Какой милый цветок! Спасибо!", 2],
	[h_goose, "нуу, кхм, пук-пук, да", 2],
	[h_goose_girl, "Познакомимся?", 1.5],
	[h_goose, "а ну хм ну да давай как бы хм", 2],
	[h_goose, "", 1, function() {
		global.result = "У вас появилась тянка и вы скатились";
		room_goto(r_result)
	}]
]);