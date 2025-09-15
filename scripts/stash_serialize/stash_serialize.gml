// Feather disable all

/// @param stash

function stash_serialize(_stash) {

	var _serialized = {
		schema_version: STASH_SCHEMA_VERSION,
		size: array_length(_stash)
	}

	var _slots = array_create(array_length(_stash));
	
	var _i = 0; repeat(array_length(_stash)) {
		var _stack = _stash[_i];
		_slots[_i] = _stack.serialize();
		++_i;
	}
	
	_serialized.slots = _slots;
	
	return _serialized;

}