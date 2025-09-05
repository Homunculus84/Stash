function StashStack(_item = undefined, _quantity = 1) constructor {

	static __system	= __StashSystem();

	item		= undefined;
	quantity	= 0;
	
	__rules		= [];
	__on_change = undefined;

	#region	Core
	
	static add = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { return 0; }
		
		if(!is_undefined(_item)) {
			if(!accepts(_item)) { return 0; }
			if(is_undefined(item) && allows(_item)) {
				item = __system.__item_adapter.clone(_item);
			}
		}
		
		if(is_undefined(item)) { return 0; }

		var _amount = max(0, min(_quantity, __system.__item_adapter.stack_size(item) - quantity));
		quantity += _amount;
		
		if(!is_undefined(__on_change) && _amount > 0 ) { __on_change(self); }
		
		return _amount;
	}
	
	static clear = function() {
		var _was_empty = is_undefined(item);
		
		item = undefined;
		quantity = 0;
		
		if(!is_undefined(__on_change) && !_was_empty ) { __on_change(self); }
	}
	
	static remove = function(_quantity, _item = undefined) {
		if(_quantity <= 0 || is_undefined(item)) { return 0; }
		
		if(!is_undefined(_item) && !__system.__item_adapter.equals(item, _item)) {
			return 0;
		}
		
		var _amount = min(quantity, _quantity);
		quantity -= _amount;
		
		if(quantity <= 0) { clear(); }
		else if(!is_undefined(__on_change)) { __on_change(self); }
		
		return _amount;
	}

	static set = function(_quantity, _item = undefined) {
		if(_quantity <= 0) { 
			clear(); 
			return 0; 
		}
		
		if(!is_undefined(_item)) {
			if(!allows(_item)) { return 0; }
			item = __system.__item_adapter.clone(_item);
		}
		
		if(is_undefined(item)) { return 0; }
		
		if(!is_undefined(__on_change)) { __on_change(self); }
		
		quantity = min(_quantity, __system.__item_adapter.stack_size(item));
		return quantity;
	}
	
	static take = function(_quantity = undefined) {
		_quantity ??= quantity;
		
		if(_quantity <= 0 || is_undefined(item)) {
			return new StashStack();
		}
		
		var _item = __system.__item_adapter.clone(item);
		var _amount = remove(_quantity);
		
		if(!is_undefined(__on_change)) { __on_change(self); }
		
		return new StashStack(_item, _amount);
	}
	
	static merge = function(_stack) {
		__stash_assert_is_stack(_stack);
		return add(_stack.quantity, _stack.item);
	} 
	
	#endregion
	
	#region Rules
	
	static add_rule = function(_id, _fn, _context) {
		var _index = array_get_index(__rules, _id);
		if(_index < 0) {
			__rules.push({
				id: _id,
				fn:	is_undefined(_context) ? _fn : method(_context, _fn)
			});
		}
		else {
			__rules[_index] = is_undefined(_context) ? _fn : method(_context, _fn);
		}
		
		return self;
	}
	
	static remove_rule = function(_id) {
		var _index = array_get_index(__rules, _id);
		if(_index >= 0) {
			array_delete(__rules, _index, 1);
		}
	}
	
	static clear_rules = function() {
		__rules = [];
	}
	
	#endregion
	
	#region Utility
	
	static allows = function(_item) {
		var _i = 0; repeat(array_length(__rules)) {
			if(!__rules[_i].fn(_item)) { return false; }
			++_i;
		}
		return true;
	}
	
	static accepts = function(_item) {
		if(is_undefined(_item)) { return false; }
		if(is_undefined(item)) { return true; }
		return __system.__item_adapter.stacks_with(item, _item);
	} 
	
	static clone = function() {
		var _stack;
		if(is_undefined(item)) {
			_stack = new StashStack();
		}
		else {
			_stack = new StashStack(__system.__item_adapter.clone(item), quantity);
		}
		
		_stack.__rules = variable_clone(__rules, 0);
		return _stack;
	}
	
	static is_empty = function() {
		return is_undefined(item);
	}
	
	static is_full = function() {
		return quantity >= __system.__item_adapter.stack_size(item);
	}
	
	static item_stacks_with = function(_item) {
		if(is_undefined(item) || is_undefined(_item)) { return false; }
		return __system.__item_adapter.stacks_with(item, _item);
	}
	
	static item_equals = function(_item) {
		if(is_undefined(item) != is_undefined(_item)) { return false; }
		if(is_undefined(item) && is_undefined(_item)) { return true; }
		return __system.__item_adapter.equals(item, _item);
	}
	
	static on_change = function(_fn, _context = undefined) {
		__on_change = is_undefined(_context) ? _fn : method(_context, _fn);
	}
	
	static toString = function() {
		return $"quantity: {quantity}, item: {item}";
	}
	
	#endregion

	if(!is_undefined(_item)) {
		set(_item, _quantity);
	}

}
