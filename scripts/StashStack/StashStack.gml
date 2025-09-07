function StashStack(_item = undefined, _quantity = 1, _events = {}, _rules = {}) constructor {

	static __system	= __StashSystem();
	static __noop	= function() {};

	__rules		= {};
	__events	= { create: __noop, update: __noop };

	item		= undefined;
	quantity	= 0;

	#region Private
	
	static __bind_events = function(_events) {
		if(!is_struct(_events)) { __stash_error("Events should be a struct"); }
		
		var _event_names = struct_get_names(_events);
		var _i = 0; repeat(array_length(_event_names)) {
			var _event_name = _event_names[_i];
			var _event = _events[$ _event_name];
			
			if(is_callable(_event)) {
				on(_event_name, _event);
			}
			else if(is_struct(_event)) {
				on(_event_name, _event.fn, _event.context);
			}
			else {
				__stash_error("Invalid event");
			}
			
			++_i;
		}
	}
	
	static __bind_rules = function(_rules) {
		if(!is_struct(_rules)) { __stash_error("Rules should be a struct"); }
		
		var _rule_names = struct_get_names(_rules);
		var _i = 0; repeat(array_length(_rule_names)) {
			var _rule_name = _rule_names[_i];
			var _rule = _rules[$ _rule_name];
			
			if(is_callable(_rule)) {
				add_rule(_rule_name, _rule);
			}
			else if(is_struct(_rule)) {
				add_rule(_rule_name, _rule.fn, _rule.context);
			}
			else {
				__stash_error("Invalid rule");
			}
			++_i;
		}
	}
	
	#endregion

	#region	Public core
	
	static add = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { return 0; }
		
		if(!is_undefined(_item)) {
			if(!accepts(_item)) { return 0; }
			if(is_undefined(item) && allows(_item)) {
				item = __system.__adapter.clone(_item);
			}
		}
		
		if(is_undefined(item)) { return 0; }

		var _amount = max(0, min(_quantity, __system.__adapter.stack_size(item) - quantity));
		quantity += _amount;

		if(_amount > 0 ) { trigger("update"); }
		
		return _amount;
	}
	
	static clear = function() {
		var _was_empty = is_undefined(item);
		
		item = undefined;
		quantity = 0;
		
		if(!_was_empty) { trigger("update"); }
	}
	
	static remove = function(_quantity, _item = undefined) {
		if(_quantity <= 0 || is_undefined(item)) { return 0; }
		
		if(!is_undefined(_item) && !__system.__adapter.equals(item, _item)) {
			return 0;
		}
		
		var _amount = min(quantity, _quantity);
		quantity -= _amount;
		
		if(quantity <= 0) { clear(); }
		else { trigger("update"); }
		
		return _amount;
	}

	static set = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { 
			clear(); 
			return 0; 
		}
		
		if(!is_undefined(_item)) {
			if(!allows(_item)) { return 0; }
			item = __system.__adapter.clone(_item);
		}
		
		if(is_undefined(item)) { return 0; }
		
		trigger("update");
		
		quantity = min(_quantity, __system.__adapter.stack_size(item));
		return quantity;
	}
	
	#endregion
	
	#region Public helpers
	
	static add_rule = function(_name, _fn, _context) {
		__rules[$ _name] = is_undefined(_context) ? _fn : method(_context, _fn);
		return self;
	}
	
	static allows = function(_item) {
		var _rule_names = struct_get_names(__rules);
		var _i = 0; repeat(array_length(_rule_names)) {
			var _rule = __rules[$ _rule_names[_i]];
			if(!_rule(_item)) { return false; }
			++_i;
		}
		return true;
	}
	
	static accepts = function(_item) {
		if(is_undefined(_item)) { return false; }
		if(is_undefined(item)) { return true; }
		return __system.__adapter.stacks_with(item, _item);
	} 
	
	static clear_rules = function() {
		__rules = {};
	}
	
	static clone = function() {
		return new StashStack(
			is_undefined(item) ? undefined : __system.__adapter.clone(item), 
			quantity, __events, __rules
		);
	}
	
	static is_empty = function() {
		return is_undefined(item);
	}
	
	static is_full = function() {
		return quantity >= __system.__adapter.stack_size(item);
	}
	
	static item_stacks_with = function(_item) {
		if(is_undefined(item) || is_undefined(_item)) { return false; }
		return __system.__adapter.stacks_with(item, _item);
	}
	
	static item_equals = function(_item) {
		if(is_undefined(item) != is_undefined(_item)) { return false; }
		if(is_undefined(item) && is_undefined(_item)) { return true; }
		return __system.__adapter.equals(item, _item);
	}
	
	static on = function(_event, _fn, _context = undefined) {
		_fn = is_undefined(_context) ? _fn : method(_context, _fn);	
		__events[$ _event] = _fn;
		
		return self;
	}
	
	static remove_rule = function(_name) {
		if(struct_exists(__rules, _name)) {
			struct_remove(__rules, _name);
		}
	}
	
	static serialize = function() {
		return {
			item: is_undefined(item) ? undefined : __system.__adapter.serialize(item),
			quantity: quantity
		};
	}
	
	static trigger = function(_event) {
		if(struct_exists(__events, _event)) {
			__events[$ _event](self);
		}
	}

	#endregion
	
	#region Built in
	
	static toString = function() {
		return $"quantity: {quantity}, item: {item}, rules: {__rules}, events: {__events}";
	}
	
	#endregion

	#region Initialization

	__bind_rules(_rules);

	if(!is_undefined(_item)) {
		set(_item, _quantity);
	}
	
	__bind_events(_events);

	trigger("create");
	
	#endregion

}
