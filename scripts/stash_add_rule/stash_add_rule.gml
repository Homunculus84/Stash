// Feather disable all

/// @param stash
/// @param name
/// @param fn
/// @param [context]

function stash_add_rule(_stash, _name, _fn, _context = undefined) {
	
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		_stack.add_rule(_name, _fn, _context);
		++_i;
	}
	
}