/*
	Persistent controller object.
	Provides room navigation and instructions.
*/

randomize();

draw_intro = function() {
	draw_set_color(COLOR_LIGHT);
	draw_set_font(fnt_default);
	draw_text_ext(16, 16, @"Welcome to the Stash test project.

This project is provided as a test and demo of the Stash script library.

Navigation:

[ Left ] Previous Room
[ Right ] Next Room
[ 'R' ] Restart current room
", -1, room_width - 32);
}

draw_list = function() {
	draw_set_color(COLOR_LIGHT);
	draw_set_font(fnt_default);
	draw_text_ext(144, 64, @"List inventory rules:
- Only 1 stack per item
- Auto grow / shrink
- Max 8 slots

Grab an item from the loot and drop it in the inventory.

Click on an inventory item to remove.

['M'] Discard held item
", -1, 92);
}

draw_grid = function() {
	draw_set_color(COLOR_LIGHT);
	draw_set_font(fnt_default);
	draw_text_ext(144, 64, @"['M'] discard held item
['T'] tidy up inventory
", -1, 92);
}