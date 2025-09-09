// Feather disable all

/// @param stash
/// @param item
/// @param quantity

function stash_remove(_stash, _item, _quantity) {

	if(is_undefined(_item) || _quantity <= 0) { return 0; }

	var _remaining = _quantity;
		
	var _i = array_length(_stash) - 1; 
	repeat(array_length(_stash)) {
		if(_remaining <= 0) { break; }
		
		var _stack = _stash[_i];
		var _removed = _stack.remove(_remaining, _item);
		
		if(_removed > 0) {
			_remaining -= _removed;
		}	
		--_i;
	}

	return _quantity - _remaining;

}