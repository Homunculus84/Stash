if(is_undefined(stack)) { exit; }

draw_set_font(fnt_default);

draw_sprite(sprite_index, 0, x, y);

if(!stack.empty()) {
	draw_sprite(spr_items, stack.item.image_index, x, y);
	
	if(show_label) {
		draw_set_color(COLOR_LIGHT);
		draw_text(x + sprite_width + 8, y + 2, stack.item.name);
	}
}

if(stack.quantity > 1) {
	// hack: outline text by drawing it multiple times
	draw_set_color(COLOR_DARK);
	draw_text(x, y - 7, stack.quantity);
	draw_text(x, y - 5, stack.quantity);
	draw_text(x - 1, y - 6, stack.quantity);
	draw_text(x + 1, y - 6, stack.quantity);

	draw_set_color(COLOR_LIGHT);
	draw_text(x, y - 6, stack.quantity);
	
}