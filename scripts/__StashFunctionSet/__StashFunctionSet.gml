function __StashFunctionSet() constructor {

	__functions = {};
	
	static clear = function() {
		__functions = {};
		return self;
	}
	
	static get = function(_name) {
		return __functions[$ _name];
	}
	
	static list = function() {
		return struct_get_names(__functions);
	}
	
	static register = function(_name, _fn, _context = undefined) {
		__functions[$ _name] = is_undefined(_context) ? _fn : method(_context, _fn);
		return self;
	}
	
	static remove = function(_name) {
		if(struct_exists(__functions, _name)) {
			struct_remove(__functions, _name);
		}
		return self;
	}
	
}