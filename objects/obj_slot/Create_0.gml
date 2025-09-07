inventory	= undefined;
position	= undefined;
stack		= undefined;

show_label	= false;

clear = function() {
	if(!is_undefined(stack)) { return; }
	stack.clear();
} 

remove = function(_amount = 1) {
	if(!is_undefined(stack)) { return; }
	return stack.remove(_amount);
}

