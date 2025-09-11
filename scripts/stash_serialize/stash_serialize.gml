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

/*

// Possible serialize implementation for StashStack

static serialize = function() {
	return {
		item: is_undefined(item) ? undefined : __system.__adapter.serialize(item),
		quantity: quantity
	};
}

*/