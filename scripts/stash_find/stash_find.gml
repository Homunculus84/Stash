// Feather disable all

/// @param stash
/// @param item

function stash_find(_stash, _item) {
	
	var _index = -1;
	
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		if(_stack.item_equals(_item)) {
			_index = _i;
			break;
		}
		++_i;
	}
		
	return _index;
	
}