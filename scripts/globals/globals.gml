#macro COLOR_LIGHT	#FCFFC0
#macro COLOR_DARK	#2F142F

global.items = {
    potion_health:	{ id: "potion_health",	image_index: 0,		name: "Health Potion",  weight: 1,		value: 10,	type: "consumable", stack_size: 16 },
    potion_mana:	{ id: "potion_mana",	image_index: 1,		name: "Mana Potion",    weight: 1,		value: 12,	type: "consumable", stack_size: 16 },
    shield_wooden:	{ id: "shield_wooden",	image_index: 2,		name: "Wooden Shield",  weight: 5,		value: 8,	type: "armor",      stack_size: 2 },
	shield_steel:	{ id: "shield_steel",	image_index: 3,		name: "Steel Shield",	weight: 10,		value: 12,	type: "armor",      stack_size: 2 },
	bow:			{ id: "bow",			image_index: 4,		name: "Bow",			weight: 5,		value: 12,	type: "weapon",     stack_size: 4 },
	sword:			{ id: "sword",			image_index: 5,		name: "Sword",			weight: 8,		value: 7,	type: "weapon",     stack_size: 4 },
	axe:			{ id: "axe",			image_index: 6,		name: "Axe",			weight: 12,		value: 10,	type: "weapon",     stack_size: 4 },
    pickaxe:		{ id: "pickaxe",		image_index: 7,		name: "Pickaxe",		weight: 6,		value: 3,	type: "tools",		stack_size: 8 },
    shovel:			{ id: "shovel",			image_index: 8,		name: "Shovel",			weight: 5,		value: 2,	type: "tools",		stack_size: 8 },
    arrow_wooden:	{ id: "arrow_wooden",	image_index: 9,		name: "Wooden Arrow",   weight: 0.1,	value: 1,	type: "ammo",       stack_size: 32 },
    arrow_iron:		{ id: "arrow_iron",		image_index: 10,	name: "Iron Arrow",     weight: 0.2,	value: 2,	type: "ammo",       stack_size: 32 },
	gold:			{ id: "gold",			image_index: 11,	name: "Gold",			weight: 0,		value: 1,	type: "gold",       stack_size: 999 }
};

global.item_ids = struct_get_names(global.items);
