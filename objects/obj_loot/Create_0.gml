stash = stash_create(4);

slots = array_create(array_length(stash));
for(var _i = 0; _i < array_length(stash); _i++) {
	var _item = instance_create_layer(x + _i * 24 + 16, y + 16, "layer_instances", obj_slot);
	var _stack = stash[_i];
	
	with(_item) {
		stack = _stack;
		action_main = function() { }
		action_alt = function() { discard(); rand(); }
		
		rand();
	} 
	
	slot[_i] = _item;
}