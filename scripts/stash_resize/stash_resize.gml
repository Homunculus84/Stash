// Feather disable all

/// @param stash
/// @param new_size
/// @param [template]

function stash_resize(_stash, _new_size, _template =  new StashStack()) {
	__stash_assert_is_stack(_template);

	var _old_size = array_length(_stash);
	
	array_resize(_stash, _new_size);

	if(_new_size > _old_size) {
		var _i = _old_size;
		repeat(_new_size - _old_size) {
			var _stack = _template.clone();
			_stash[_i] = _stack;
			++_i;
		}
	}

}