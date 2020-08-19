
is_level = asset_has_tags(room, "level", asset_room);

if (is_level) {
	Ground.Init(asset_get_index(room_get_name(room) + "_ground"));
}