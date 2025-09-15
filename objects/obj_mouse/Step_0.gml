slot.visible = !stack.empty();
slot.x = mouse_x + 4;
slot.y = mouse_y + 4;

if(keyboard_check_pressed(ord("M"))) {
	stack.clear();
}