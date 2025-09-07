function stash_exists(_stash, _item) {

	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		if(_stack.item_equals(_item)) {
			return true;
		}
		++_i;
	}
		
	return false;

}