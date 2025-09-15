/*
	Adapter for this demo. Defines how the inventory interacts with items (structs in this case).
    Please refer to Stash/config/BaseAdapter for more info.
*/

function DemoAdapter() constructor {

    static clone = function(_item) {
        return _item;
    }

    static equals = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }

    static stack_size = function(_item) {
        return _item.stack_size;
    }
	
	static stacks_with = function(_item_a, _item_b) {
        return _item_a == _item_b;
    }
	
	static serialize = function(_item) {
		return _item.id;
	}
	
	static deserialize = function(_item_id) {
		return global.items[$ _item_id];
	}


}

/*
	DEMO ONLY! Use Stash/config/stash_config to set the default adapter
*/
__StashSystem().__adapter = new DemoAdapter(); 