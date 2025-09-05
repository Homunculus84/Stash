function stash_count(_stash, _item = undefined) {
	
	var _count = 0;
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		if(is_undefined(_item) || _stack.item_equals(_item)) {
			_count += _stack.quantity;
		}
		++_i;
	}
		
	return _count;
	
}