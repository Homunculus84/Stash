function stash_add(_stash, _item, _quantity) {
	
	var _remaining = _quantity;
	var _i;
		
	_i = 0; repeat(array_length(_stash)) {
		if(_remaining <= 0) { break; }
		
		var _stack = _stash[_i];
		
		if(!_stack.is_empty()) {
			_remaining -= _stack.add(_remaining, _item);
		}
		++_i;
	}
		
	_i = 0; repeat(array_length(_stash)) {
		if(_remaining <= 0) { break; }
		
		var _stack = _stash[_i];
		
		if(_stack.is_empty()) {
			_remaining -= _stack.add(_remaining, _item);
		}
		++_i;
	}
	
	return _quantity - _remaining;
	
}
