event_inherited();

#region Methods

random_item = function(_stack) {	
	var _item_id = global.item_ids[irandom(array_length(global.item_ids) - 1)];
	var _item = global.items[$ _item_id];
	_stack.set(irandom_range(1, _item.stack_size), _item);
}

slot_action_main = function(_slot) {
	__stash_trace(_slot);
}

slot_action_alt = function(_slot) {
	__stash_trace(_slot);
}

#endregion

#region Init

var _template = new StashStack().
	on("create", random_item).
	on("update", function(_stack) { if(_stack.is_empty()) { random_item(_stack); } }, self);

cols	= 4;
stash	= stash_create(cols, _template);
slots	= array_create(array_length(stash));

build();

#endregion