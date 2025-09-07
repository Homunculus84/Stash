#region Methods

refresh = function() {
	if(array_length(stash) != array_length(slots)) { rebuild(); }
	else {
		for(var _i = 0; _i < array_length(slots); _i++) {
			slots[_i].stack = _stash[_i];
		}
	}
}

build = function(_show_labels = false) {
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
			show_labels	= _show_labels; 
		} 
		
		slots[_i] = _slot;
	}
}

slot_action_main = function() {
	//abstract, override
}

slot_action_alt = function() {
	//abstract, override
}

#endregion

#region Init

stash	= [];
slots	= [];
cols	= 1;

#endregion