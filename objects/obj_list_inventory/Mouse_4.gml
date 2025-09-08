// Add the all currently held items to the inventory

var _mouse_stack = obj_mouse.stack;
if(_mouse_stack.is_empty()) { exit; }

var _added = add(_mouse_stack.item, _mouse_stack.quantity);
_mouse_stack.remove(_added);