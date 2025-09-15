#macro	STASH_VERSION			"1.1.0"
#macro	STASH_SCHEMA_VERSION	1

__StashSystem();

function __StashSystem() {
	static _system = undefined;
	if(!is_undefined(_system)) { return _system; }
	
	_system = {}
	with(_system) {
		__stash_trace($"Using Stash {STASH_VERSION} by Homunculus84");
		__adapter	= new STASH_ITEM_ADAPTER();
	}
	
	return _system;
}

#region Helper functions

function __stash_error(_error){
	show_error($"[Stash] {STASH_VERSION}: {_error}\n", true);
}

function __stash_trace(_message){
	show_debug_message($"[Stash] {_message}");
}

function __stash_is_stack(_value) {
	return is_struct(_value) && is_instanceof(_value, StashStack);
}

function __stash_assert_is_stack(_stack) {
	if(!__stash_is_stack(_stack)) { 
		__stash_error("Instance of StashStack expected");
	}
}

#endregion