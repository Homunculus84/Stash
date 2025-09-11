// Feather disable all

/// @param serialized
/// @param [template]

function stash_deserialize(_serialized, _template = new StashStack()) {
	__stash_assert_is_stack(_template);

	if (!is_struct(_serialized) || !struct_exists(_serialized, "schema_version")) {
        __stash_error("Invalid stash data");
    }

	var _stash;
    switch (_serialized.schema_version) {
        case 1:
			_stash = __stash_deserialize_1(_serialized, _template);
            break;
        default:
			__stash_error("Unsupported schema version");
    }

	return _stash;

}

function __stash_deserialize_1(_serialized, _template) {
	var _slots = _serialized.slots;
	var _stash = stash_create(array_length(_slots), _template);
			
    var _i = 0; repeat(array_length(_slots)) {
		var _slot = _slots[_i];
		var _stack = _stash[_i];
		_stack.deserialize(_slot);
		++_i;
	}
	
	return _stash;
}

/*

// Possible deserialize implementation for StashStack

static deserialize = function(_data) {
	set(_data.quantity, __system.__adapter.deserialize(_data.item));
}

*/