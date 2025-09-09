// Inherit parent event
event_inherited();

#region	Methods

// Limit each item to a single stack
add = function(_quantity, _item) { 
	var _stack_index = stash_find(stash, _item);
	
	// If item exists, try adding
	if(_stack_index >= 0) {
		return stash_add(stash, _quantity, _item);
	}
	// If not, try creating a new stack
	else if(array_length(stash) < max_size) {
		var _stack = template.clone(_quantity, _item);
		if(!_stack.is_empty()) { 
			array_push(stash,_stack); 
			refresh();
		}
		return _stack.quantity;
	}
	else {
		return 0;
	}
}

// Override default inventory left click action
slot_action_main = function(_slot) {
	var _mouse_stack = obj_mouse.stack;
	if(!_mouse_stack.is_empty()) { return; }
	_slot.stack.remove(1);
}

// Override default inventory right click action
slot_action_alt = function(_slot) {
	var _mouse_stack = obj_mouse.stack;
	if(!_mouse_stack.is_empty()) { return; }
	_slot.stack.clear();
}

#endregion

#region Init

// Define a reusable template to be used when creating new stacks
template	= new StashStack().
	on("clear", function(_stack) { stash_pack(stash); refresh(); }, self);

max_size	= 8;
labels		= true;

build();

#endregion