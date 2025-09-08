// Inherit parent event
event_inherited();

#region Init

stash	= stash_create(3);

// Add rules to each stack, based on item type 
stash[0].add_rule("only_shields", function(_item) { return _item.type == "shield" });
stash[1].add_rule("only_weapons_and_tools", function(_item) { return _item.type == "weapon" || _item.type == "tool" });
stash[2].add_rule("only_ammo", function(_item) { return _item.type == "ammo" });

build();

#endregion