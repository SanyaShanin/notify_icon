/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, h_goose) && (item_req == 0 || h_goose.item == item_req)) {
	
	if (event == "function") {
		variable_global_get(event_act)(event_arg);
	}
	
	if (event == "scene") {
		if (event_act == "play")
			event_arg.speedScale = 1;
		if (event_act == "pause")
			event_arg.speedScale = 0;
		if (event_act == "start") {
			event_arg.speedScale = 1;
			event_arg.headPosition = 0;
		}
	}
	
	if (event == "message") {
		event_arg[0].mess = new Message(-1000, -1000, event_arg[1], event_arg[2], true);
	}
	
	if (type == "once")
		instance_destroy();
}