function __StashEventSet(_stack) : __StashFunctionSet() constructor {

	__stack			= _stack;

	static trigger = function(_event) {
		if(struct_exists(__functions, _event)) {
			__functions[$ _event](__stack);
		}
	}

}