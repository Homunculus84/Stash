function StashItemAdapter() constructor {
	
	static equals = function(_item_a, _item_b) {
		return _item_a == _item_b;
	}
	
	static stacks_with = function(_item_a, _item_b) {
		return _item_a == _item_b;
	}
	
	static stack_size = function(_item) {
		return _item.stack_size;
	}
	
	static clone = function(_item) {
		return _item;
	}
	
	static serialize = function(_item) {
		return _item.id;
	}
	
	static deserialize = function(_id) {
		return global.items[$ _id];
	}
	
}