// Feather disable all

/// @param stash
/// @param quantity
/// @param item
/// @param max_size
/// @param [template]

function stash_add_ext(_stash, _quantity, _item, _max_size, _template = new StashStack()) {
	__stash_assert_is_stack(_template);
	
	var _remaining = _quantity;
	_remaining -= stash_add(_stash, _quantity, _item);
	
	while(_remaining > 0 && array_length(_stash) < _max_size) {
		var _size	= array_length(_stash);
		
		if(_template.allows(_item)) {
			var _stack = _template.clone(_remaining, _item);
			_remaining -= _stack.quantity;
			_stash[_size] = _stack;
			_stack.trigger("create");
		}
		else {
			break;
		}
	}
	
	return _quantity - _remaining;
	
}