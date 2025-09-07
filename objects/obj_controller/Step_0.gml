if(keyboard_check_pressed(ord("R"))) {
	room_restart();
}

if(keyboard_check_pressed(vk_left)) {
	if (room_previous(room) != -1) {
		room_goto_previous();
	}
}

if(keyboard_check_pressed(vk_right)) {
	if (room_next(room) != -1) {
		room_goto_next();
	}
}