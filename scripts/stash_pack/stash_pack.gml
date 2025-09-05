function stash_pack(_stash) {

	var _i = array_length(_stash) - 1;
	repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		if(_stack.is_empty()) { array_delete(_stash, _i, 1); }
		--_i;
	}

}