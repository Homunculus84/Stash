function stash_remove_rule(_stash, _name) {
	
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		_stack.remove_rule(_name);
		++_i;
	}
	
}