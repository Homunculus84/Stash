// Add a unit of the currently held item to the inventory

var _mouse_stack = obj_mouse.stack;
if(_mouse_stack.empty()) { exit; }

var _added = add(1, _mouse_stack.item);
_mouse_stack.remove(_added);