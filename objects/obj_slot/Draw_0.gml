if(is_undefined(stack)) { exit; }

draw_sprite(sprite_index, 0, x, y);

if(!stack.is_empty()) {
	draw_sprite(spr_items, stack.item.image_index, x, y);
}

if(stack.quantity > 1) {

}
