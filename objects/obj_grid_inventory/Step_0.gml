// Move all items to the top
if(keyboard_check_pressed(ord("T"))) {
	stash_tidy(stash);
	refresh();
}

// Display the inventory data in the console
if(keyboard_check_pressed(ord("D"))) {
	stash_debug(stash);
}

// Save the current state of the stash
if(keyboard_check_pressed(ord("S"))) {
	serialized = stash_serialize(stash);
}

// Load last saved state
if(keyboard_check_pressed(ord("L"))) {
	if(!is_undefined(serialized)) {
		stash = stash_deserialize(serialized);
		refresh();
	}
}