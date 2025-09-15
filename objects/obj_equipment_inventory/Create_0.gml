// Inherit parent event
event_inherited();

#region Init

stash	= stash_create(3);

// Add rules to each stack, based on item type 
stash[0].rules.register("only_shields", function(_item) { return _item.type == "shield" });
stash[1].rules.register("only_weapons_and_tools", function(_item) { return _item.type == "weapon" || _item.type == "tool" });
stash[2].rules.register("only_ammo", function(_item) { return _item.type == "ammo" });

build();

#endregion