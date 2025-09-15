function stash_adapter() {
	static _system = __StashSystem();
	return _system.__adapter;
}