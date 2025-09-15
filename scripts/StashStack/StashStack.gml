///	Constructor
///
///	@param {real}	[_quantity]
///	@param {any}	[_item]
///	@param {struct}	[_rules]
/// @param {struct}	[_events]
///
///	*** Public variables
/// 
///	item			READ ONLY! Item stored in the stack (undefined if empty)
/// quantity		READ ONLY! Amount (0 if empty)
///
///	*** Public methods
///	
/// add(quantity, [item])
/// accepts(item)
/// capacity()
/// clear()
/// clone([quantity], [item])
/// deserialize(serialized_stack)
/// empty()
/// full()
/// item_equals(item)
/// item_stacks_with(item)
/// remove(quantity, [item])
/// serialize()
/// set(quantity, [item])


function StashStack(_quantity = 0, _item = undefined, _rules = {}, _events = {}) constructor {

	static __system	= __StashSystem();
	
	rules		= new __StashRuleSet(self);
	events		= new __StashEventSet(self);

	item		= undefined;
	quantity	= 0;

	#region Private
	
	static __bind_callbacks = function(_callbacks, _function_set) {
		var _callback_names = struct_get_names(_callbacks);
		var _i = 0; repeat(array_length(_callback_names)) {
			var _callback_name = _callback_names[_i];
			var _callback = _callbacks[$ _callback_name];
			
			if(is_callable(_callback)) {
				_function_set.register(_callback_name, _callback);
			}
			else if(is_struct(_callback)) {
				_function_set.register(_callback_name, _callback.fn, _callback.context);
			}
			else {
				__stash_error("Invalid callback");
			}
			
			++_i;
		}
	}
	
	static __bind_events = function(_events) {
		if(!is_struct(_events)) { __stash_error("Events should be a struct"); }
		__bind_callbacks(_events, events);
	}
		
	static __bind_rules = function(_rules) {
		if(!is_struct(_rules)) { __stash_error("Rules should be a struct"); }
		__bind_callbacks(_rules, rules);
	}
	
	#endregion

	#region	Core methods
	
	static add = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { return 0; }
		
		// If an item is specified, insert or reject
		if(!is_undefined(_item)) {
			if(!accepts(_item)) { return 0; }
			if(is_undefined(item) && rules.allow(_item)) {
				item = __system.__adapter.clone(_item);
			}
		}
		
		// If item is still undefined, return
		if(is_undefined(item)) { return 0; }

		var _amount = max(0, min(_quantity, __system.__adapter.stack_size(item) - quantity));
		quantity += _amount;

		if(_amount > 0 ) { events.trigger("update"); }
		return _amount;
	}
	
	static clear = function() {
		var _was_empty = is_undefined(item);
		
		item = undefined;
		quantity = 0;
		
		if(!_was_empty) { events.trigger("clear"); }
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
		else { events.trigger("update"); }
		
		return _amount;
	}

	static set = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { 
			clear(); 
			return 0; 
		}
		
		if(!is_undefined(_item)) {
			if(!rules.allow(_item)) { return 0; }
			item = __system.__adapter.clone(_item);
		}
		
		if(is_undefined(item)) { return 0; }
		
		events.trigger("update");
		
		quantity = min(_quantity, __system.__adapter.stack_size(item));
		return quantity;
	}
	
	#endregion
	
	#region Utility methods
	
	static accepts = function(_item) {
		if(is_undefined(_item)) { return false; }
		if(is_undefined(item)) { return true; }
		return __system.__adapter.stacks_with(item, _item);
	} 
	
	static capacity = function() {
		if(is_undefined(item)) { return undefined; }
		return __system.__adapter.stack_size(item) - quantity;
	}
	
	static clone = function(_quantity = quantity, _item = item) {
		var _stack = new StashStack(_quantity, _item, rules.__functions, events.__functions);
		_stack.events.trigger("create");
		return _stack;
	}
	
	static deserialize = function(_data) {
		set(_data.quantity, __system.__adapter.deserialize(_data.item));
	}
	
	static empty = function() {
		return is_undefined(item);
	}
	
	static full = function() {
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
	
	static serialize = function() {
		return {
			item: is_undefined(item) ? undefined : __system.__adapter.serialize(item),
			quantity: quantity
		};
	}


	#endregion
	
	#region Built in
	
	static toString = function() {
		return $"quantity: {quantity}, item: {item}, rules: {rules.list()}, events: {events.list()}";
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
