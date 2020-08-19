/// @description Insert description here
// You can write your code in this editor

if (!h_texas_boss.active) {
	exit;
}
if (!is_struct(h_texas_boss.mess)) {
	h_texas_boss.mess = new Message(-10000, -10000, choose("Какого хуя!", "А!!!!!!!!", "Мамкины отрыжки!!!!!", "Вот что ето за хуета"), 1.2, false);
}

h_texas_boss.hp--;
instance_destroy()