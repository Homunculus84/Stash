function stash_remove_rule(_stash, _id) {
	
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		_stack.remove_rule(_id);
		++_i;
	}
	
}