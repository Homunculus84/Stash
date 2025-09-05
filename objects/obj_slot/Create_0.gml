stack = undefined;
action_main = function() {};
action_alt = function() {};

function discard() {
	stack.clear();	
} 

function rand() {
	var _item_id = global.item_ids[irandom(array_length(global.item_ids) - 1)];
	var _item = global.items[$ _item_id];
	
	stack.set(irandom_range(1, _item.stack_size), _item);
}