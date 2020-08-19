/// @description Insert description here
// You can write your code in this editor

event_inherited();


	if (distance_to_object(h_goose) > 100) {
		DoStep(h_goose.x - x);
	} else {
		if (!active) {
			active = 1;
			dialoge_flower_get.Start();
		}
		if (active == 1 && h_goose.item == item_flower) {
			active = 2;
			dialoge_gg.Start();
		}
	}