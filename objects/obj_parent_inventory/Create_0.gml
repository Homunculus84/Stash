/*
	Parent inventory. Defines common inventory behaviour.
*/

#region Methods

// Updates existing slots
refresh = function() {
	if(array_length(stash) != array_length(slots)) { build(); }
	else {
		for(var _i = 0; _i < array_length(slots); _i++) {
			slots[_i].stack = stash[_i];
		}
	}
}

// (Re)builds all slot instances
build = function() {
	for(var _i = 0; _i < array_length(slots); _i++) {
		instance_destroy(slots[_i]);
	}
	
	slots = array_create(array_length(stash));
	
	for(var _i = 0; _i < array_length(stash); _i++) {
		var _stack = stash[_i];
		
		var _slot = instance_create_layer(x + 16 + (_i mod cols) * 24, y + 16 + floor(_i / cols) * 24, "layer_instances", obj_slot);
		with(_slot) { 
			stack		= _stack;
			position	= _i;
			inventory	= other;
			show_label	= other.labels;
		} 
		
		slots[_i] = _slot;
	}
}

// Defines what happens by default when an inventory slot is left clicked (take all / drop all)
slot_action_main = function(_slot) {
	var _mouse_stack = obj_mouse.stack;
	if(_mouse_stack.is_empty()) {
		var _added = _mouse_stack.add(_slot.stack.quantity, _slot.stack.item);
		_slot.stack.remove(_added);
	}
	else {
		var _added = _slot.stack.add(_mouse_stack.quantity, _mouse_stack.item);
		_mouse_stack.remove(_added);
	}
}

// Defines what happens by default when an inventory slot is right clicked (take half / drop 1)
slot_action_alt = function(_slot) {
	var _mouse_stack = obj_mouse.stack;
	if(_mouse_stack.is_empty()) {
		var _added = _mouse_stack.add(_slot.stack.quantity div 2, _slot.stack.item);
		_slot.stack.remove(_added);
	}
	else {
		var _added = _slot.stack.add(1, _mouse_stack.item);
		_mouse_stack.remove(_added);
	}
	
}


#endregion

#region Init

stash	= [];		// Holds StashStack instances
slots	= [];		// Holds obj_slot instances
cols	= 1;		// Number of slots in a single row before wrapping
labels	= false;	// If true, shows the name of the item on the right of the slots

#endregion