// Add a unit of the currently held item to the inventory

var _mouse_stack = obj_mouse.stack;
if(_mouse_stack.is_empty()) { exit; }

var _added = add(_mouse_stack.item, 1);
_mouse_stack.remove(_added);