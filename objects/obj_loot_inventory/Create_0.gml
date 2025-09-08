// Inherit from parent first
event_inherited();

#region Methods

// Grab a random item from the item database
randomize_item = function(_stack) {	
	var _item_id = global.item_ids[irandom(array_length(global.item_ids) - 1)];
	var _item = global.items[$ _item_id];
	_stack.set(irandom_range(1, _item.stack_size), _item);
}

#endregion

#region Init

// Create a reusable slot template for the loot stacks
var _template = new StashStack().
	on("clear", randomize_item, self).
	on("create", randomize_item, self);

cols	= 4;
stash	= stash_create(cols, _template);

build();

#endregion
