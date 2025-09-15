function __StashRuleSet(_stack) : __StashFunctionSet() constructor {

	__stack = _stack;

	static allow = function(_item) {
		var _names = struct_get_names(__functions);
		var _i = 0; repeat(array_length(_names)) {
			var _rule = __functions[$ _names[_i]];
			if(!_rule(_item)) { return false; }
			++_i;
		}
		return true;
	}

}