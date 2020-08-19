/// @description Insert description here
// You can write your code in this editor
jspeed = 25;
incr = 0.3;
maxspeed = 14;
if (!active) return;

if (!fixed)
if (DoJump()) {
	if (place_meeting(x, y, h_goose)) {
		h_goose.hp--;
	}
}
if (vspeed < 10) {
	DoStep(h_goose.x - x);
}

if (hp < 0) {
	global.result = "Квасовый ворюга повержен!\nВы живёте долго и счастливо\nНо живы ли вы по-настоящему? Уже не узнать"
	room_goto(r_result);
}

if (h_goose.hp < 0) {
	global.result = "Слишком большая масса, чтобы пережить это приземление, и вы потеряли сознание\nОчнувшись в больнице, вам сказали, что уже второй месяц лежите в коме,\nне было никаких bigtexas'ов, и кваса тоже не существует\n[Правильная концовка]";
	room_goto(r_result)
}