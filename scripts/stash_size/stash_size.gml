// Feather disable all

/// @param stash

function stash_size(_stash) {

	var _count = 0;
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		if(!_stack.empty()) { ++_count; }
		++_i;
	}
		
	return _count;
	
}