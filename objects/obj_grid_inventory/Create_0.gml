// Inherit parent events
event_inherited();

#region Init

stash		= stash_create(4 * 8);
cols		= 4;
saved_state	= undefined;

build();

#endregion