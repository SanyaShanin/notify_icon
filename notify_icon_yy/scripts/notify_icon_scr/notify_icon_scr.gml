// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NotifyIcon() constructor {
	index = _notify_icon_create(window_handle());
	action = noone;
	
	function SetTip(tip) {
		_notify_icon_add_tip(index, tip);
		return self;
	}
	
	function SetMessage(title, text) {
		_notify_icon_add_message(index, title, text);
		return self;
	}
	
	function Show() {
		_notify_icon_show(index);
		return self;
	}
	
	function Hide() {
		_notify_icon_hide(index);
		return self;
	}
	
	function SetMouseAction(action) {
		self.action = action;
		return self;
	}
	
	function CheckAsyncEvent(async_load_map) {
		if (async_load_map[? "event_type"] == "notify_icon" && async_load_map[? "index"] == index) {
			if (action != noone) {
				action(self);
				return true;
			}
		}
		return false;
	}
}