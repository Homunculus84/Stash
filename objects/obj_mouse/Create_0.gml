/*
	Can hold an item stack at mouse coordinates
*/

stack		= new StashStack();
slot		= instance_create_layer(mouse_x, mouse_y, "layer_instances", obj_slot);
slot.stack	= stack;