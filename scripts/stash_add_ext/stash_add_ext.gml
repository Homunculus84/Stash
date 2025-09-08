function stash_add_ext(_stash, _item, _quantity, _max_size, _template = new StashStack()){
	__stash_assert_is_stack(_template);
	
	var _remaining = _quantity;
	_remaining -= stash_add(_stash, _item, _quantity);
	
	while(_remaining > 0 && array_length(_stash) < _max_size) {
		var _size	= array_length(_stash);
		
		if(_template.allows(_item)) {
			var _stack = _template.clone(_remaining, _item);
			_remaining -= _stack.quantity;
			_stash[_size] = _stack;
			_stack.trigger("create");
		}
		else {
			break;
		}
	}
	
	return _quantity - _remaining;
	
}