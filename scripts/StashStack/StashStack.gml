///	Constructor that creates a new instance of a Binder
///
///	@param {real}	[_quantity]
///	@param {any}	[_item]
///	@param {struct}	[_rules]
/// @param {struct}	[_events]
///
///	*** Public variables
/// 
///	item									READ ONLY! Item stored in the stack (undefined if stack is empty)
/// quantity								READ ONLY! Amount (0 if stack is empty)
///
///	*** Public methods
///	
///	add(quantity, [item])
/// add_rule(name, fn, [context])
/// accepts(item)
/// allows(item)
/// capacity()
/// clear()
/// clear_rules()
/// clone([quantity], [item])
/// is_empty()
/// is_full()
/// item_equals(item)
/// item_stacks_with(item)
/// on(event, fn, [context])
/// remove(quantity, [item])
/// remove_rule(name)
/// set(quantity, [item])
/// trigger(event)


function StashStack(_quantity = 0, _item = undefined, _rules = {}, _events = {}) constructor {

	static __system	= __StashSystem();
	static __noop	= function() {};
	
	__rules		= {};
	__events	= { create: __noop, update: __noop, clear: __noop };

	item		= undefined;
	quantity	= 0;

	#region Private
	
	static __bind_callbacks = function(_callbacks, _fn) {
		var _callback_names = struct_get_names(_callbacks);
		var _i = 0; repeat(array_length(_callback_names)) {
			var _callback_name = _callback_names[_i];
			var _callback = _callbacks[$ _callback_name];
			
			if(is_callable(_callback)) {
				_fn(_callback_name, _callback);
			}
			else if(is_struct(_callback)) {
				_fn(_callback_name, _callback.fn, _callback.context);
			}
			else {
				__stash_error("Invalid callback");
			}
			
			++_i;
		}
	}
	
	static __bind_events = function(_events) {
		if(!is_struct(_events)) { __stash_error("Events should be a struct"); }
		__bind_callbacks(_events, on);
	}
		
	static __bind_rules = function(_rules) {
		if(!is_struct(_rules)) { __stash_error("Rules should be a struct"); }
		__bind_callbacks(_rules, add_rule);
	}
	
	#endregion

	#region	Core methods
	
	static add = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { return 0; }
		
		// If an item is specified, insert or reject
		if(!is_undefined(_item)) {
			if(!accepts(_item)) { return 0; }
			if(is_undefined(item) && allows(_item)) {
				item = __system.__adapter.clone(_item);
			}
		}
		
		// If item is still undefined, return
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
		
		if(!_was_empty) { trigger("clear"); }
	}
	
	static remove = function(_quantity, _item = undefined) {
		if(_quantity <= 0 || is_undefined(item)) { return 0; }
		
		// Slot contains a different item than provided
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
	
	#region Utility methods
	
	static add_rule = function(_name, _fn, _context) {
		__rules[$ _name] = is_undefined(_context) ? _fn : method(_context, _fn);
		return self;
	}
	
	static accepts = function(_item) {
		if(is_undefined(_item)) { return false; }
		if(is_undefined(item)) { return true; }
		return __system.__adapter.stacks_with(item, _item);
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
	
	static capacity = function() {
		if(is_undefined(item)) { return undefined; }
		return __system.__adapter.stack_size(item) - quantity;
	}
	
	static clear_rules = function() {
		__rules = {};
	}
	
	static clone = function(_quantity = quantity, _item = item) {
		return new StashStack(_quantity, _item, __rules, __events);
	}
	
	static is_empty = function() {
		return is_undefined(item);
	}
	
	static is_full = function() {
		return !is_undefined(item) && quantity >= __system.__adapter.stack_size(item);
	}
	
	static item_equals = function(_item) {
		if(is_undefined(item) != is_undefined(_item)) { return false; }
		if(is_undefined(item) && is_undefined(_item)) { return true; }
		return __system.__adapter.equals(item, _item);
	}
	
	static item_stacks_with = function(_item) {
		if(is_undefined(item) || is_undefined(_item)) { return false; }
		return __system.__adapter.stacks_with(item, _item);
	}
	
	static on = function(_event, _fn, _context = undefined) {
		__events[$ _event] = is_undefined(_context) ? _fn : method(_context, _fn);
		return self;
	}
	
	static remove_rule = function(_name) {
		if(struct_exists(__rules, _name)) {
			struct_remove(__rules, _name);
		}
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
		set(_quantity, _item);
	}
	
	__bind_events(_events);
	
	#endregion

}
