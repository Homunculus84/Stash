/*
	Adapter for this demo. Defines how the inventory interacts with items (structs in this case).
    Please refer to Stash/config/BaseAdapter for more info.
*/

function DemoAdapter() constructor {

    static equals = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }

    static stacks_with = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }

    static stack_size = function(_item) {
        return _item.stack_size;
    }

    static clone = function(_item) {
        return _item;
    }


    static serialize = function(_item) {
        return _item.id;
    }

    static deserialize = function(_data) {
        return global.items[$ _data];
    }

}

/*
	DEMO ONLY! Use Stash/config/stash_config to set the default adapter
*/
__StashSystem().__adapter = new DemoAdapter(); 