// Inherit parent events
event_inherited();

#region Init

stash	= stash_create(4 * 8);
cols	= 4;

serialized = undefined;

build();

#endregion