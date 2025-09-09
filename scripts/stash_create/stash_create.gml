// Feather disable all

/// @param size
/// @param [template]

function stash_create(_size, _template = new StashStack()) {
	__stash_assert_is_stack(_template);
	
	var _stash = array_create(_size);
	var _i = 0; repeat(_size) {
		var _stack = _template.clone();
		_stash[_i] = _stack;
		_stack.trigger("create");
		++_i;
	}

	return _stash;
	
}