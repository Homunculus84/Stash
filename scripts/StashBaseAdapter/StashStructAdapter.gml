/*
	Sample adapter for IMMUTABLE items stored as structs.

    This class defines the "interface" for how items are managed inside the Stash inventory system.
    Its purpose is to abstract item operations so that the inventory system can handle
    any kind of item, whether it's a simple string, number, immutable struct, or a more
    complex mutable struct.

    This provides the minimal functionality needed for stacks to operate, adapting this based on your
	specific setup is MANDATORY for the correct behavior of the inventory system.
*/

function StashItemAdapter() constructor {

    /*
        Determines if two (base) items are considered identical for equality purposes.
        In general, if your items are represented as strings, numbers, or immutable structs,
		you can generally leave it as is.
    */
    static equals = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }

    /*
        Determines if two items can occupy the same stack.
        This may differ from equals if your items have mutable attributes
		(think durability or enchantments) that prevents them to be stacked together.
		
		If your items are immutable, you can leave it as is.
    */
    static stacks_with = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }

    /*
        Given an item, returns the maximum number of items that can be held in a single stack.
		This doesn't need to be dependent on the item properties, if your game has a global stacking
		rule, you can return a hardcoded value. Examples:
		
		return 99;			// all items stack at 99
		return infinity;	// No limit to stack size
		return 1;			// No stacking at all
    */
    static stack_size = function(_item) {
        return _item.stack_size;
    }

    /*
        This should return a copy of the item.
        If your items are mutable references, you should provide a copy using, for example, variable_clone.
		Otherwise, you can safely return the item itself.
    */
    static clone = function(_item) {
        return _item;
    }

    /*
        Converts an item into a persistent format suitable for saving to disk or sending over
        a network. Typically returns a simple numeric / string identifier or a serializable struct.
    */
    static serialize = function(_item) {
        return _item.id;
    }

    /*
        Converts a persistent representation of an item (as result of serialize()) back into a live item object.
    */
    static deserialize = function(_data) {
        return global.items[$ _data];
    }

}
