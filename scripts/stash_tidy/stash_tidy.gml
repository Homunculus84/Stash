function stash_tidy(_stash) {
	
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		_stack.__priority = -_i;
		++_i;
	}
	
	array_sort(_stash, function(_stack_a, _stack_b) {
		if(_stack_a.is_empty()) { return 1; }
		if(_stack_b.is_empty()) { return -1; }
		return _stack_b.__priority - _stack_a.__priority;
	});
	
	_i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		struct_remove(_stack, "__priority");
		++_i;
	}
	
}