function StashItemAdapter() constructor {
	
	static equals = function(_item_a, _item_b) {
		return _item_a == _item_b;
	}
	
	static stacks_with = function(_item_a, _item_b) {
		return _item_a == _item_b;
	}
	
	static stack_size = function(_item) {
		return 99;
	}
	
	static clone = function(_item) {
		return _item;
	}
	
	static serialize = function(_item) {
		return _item;
	}
	
	static deserialize = function(_item) {
		return _item;
	}
	
}