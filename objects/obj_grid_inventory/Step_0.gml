// Move all items to the top
if(keyboard_check_pressed(ord("T"))) {
	stash_tidy(stash);
	refresh();
}

// Display the inventory data in the console
if(keyboard_check_pressed(ord("D"))) {
	stash_print(stash);
}

// Saves the state of the inventory
if(keyboard_check_pressed(ord("S"))) {
	saved_state = stash_serialize(stash);
}

// Loads the last saved state
if(keyboard_check_pressed(ord("L"))) {
	if(!is_undefined(saved_state)) {
		stash = stash_deserialize(saved_state);
		build(); // Rebuild
	}
}