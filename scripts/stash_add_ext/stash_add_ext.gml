function stash_add_ext(_stash, _item, _quantity, _max_size, _template = undefined){
	
	_template ??= new StashStack();
	__stash_assert_is_stack(_template);
	
	var _remaining = _quantity;
	_remaining -= stash_add(_stash, _item, _quantity);
	
	while(_remaining > 0 && array_length(_stash) < _max_size) {
		var _size = array_length(_stash);
		
		var _stack = _template.clone();
		var _added = _stack.set(_remaining, _item);
		
		if(_added > 0) {
			_remaining -= _added;
			_stash[_size] = _stack;
		}
		else { break; }		
	}
	
	return _quantity - _remaining;
	
}