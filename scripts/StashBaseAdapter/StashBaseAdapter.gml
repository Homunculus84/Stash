/*
    Basic adapter for items represented as strings or numeric IDs.

    This class defines the "interface" for how items are managed inside the Stash inventory system.
    Its purpose is to abstract item operations so that the inventory system can handle
    any kind of item, whether it's a simple string, number, immutable struct, or a more
    complex mutable struct.

    This base adapter provides the minimal functionality needed for stacks to operate. 
    Adapting this based on your specific setup is MANDATORY for the correct behavior of the inventory system.
*/

function StashBaseAdapter() constructor {

    /*
        Creates and returns a copy of the given item.

        If your items are simple strings, numbers, or static references to a struct database,
        you can just return the item itself. For mutable structs, create a deep copy if needed.
    */
    clone = function(_item) {
        return _item;
    }

    /*
        Determines if two items are considered identical for equality purposes.

        If your items are simple strings, numbers, or static references to a struct database,
        a simple == comparison is usually enough.
    */
    equals = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }
    
    /*
        Returns the maximum number of items that can be held in a single stack.

        If your game has a global stacking rule for all items, you can return a hardcoded value.

        Examples:
            return 1;                  // Items don't stack
            return infinity;           // No limit to stack size
            return _item.stack_size;   // Use a property of the item
    */
    stack_size = function(_item) {
        return 99;
    }

    /*
        Determines if two items can occupy the same stack.

        This may differ from equals if your items have independent mutable attributes
        (like durability or enchantments) that prevent them from stacking together.
        Otherwise, a simple == comparison is usually enough.
    */
    stacks_with = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }

    /*
        Serializes the given item into a form that can be saved (string, number, struct, etc.).

        By default, returns the item as-is. You may override this to return a stable, save-friendly
        representation (for example: item.id, or a lightweight struct).
    */
    serialize = function(_item) {
        return _item;
    }

    /*
        Deserializes saved data back into an item.

        This is the inverse of serialize(). If you return IDs or lightweight data in serialize(),
        you should reconstruct or look up the full item here. By default, returns the value as-is.
    */
    deserialize = function(_data) {
        return _data;
    }

}
