// Move all items to the top
if(keyboard_check_pressed(ord("T"))) {
	stash_tidy(stash);
	refresh();
}

// Display the inventory data in the console
if(keyboard_check_pressed(ord("D"))) {
	stash_print(stash);
}