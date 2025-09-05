function stash_create(_size, _template = undefined) {
	
	_template ??= new StashStack();
	__stash_assert_is_stack(_template);
	
	var _stash = array_create(_size);
	var _i = 0; repeat(_size) {
		_stash[_i] = _template.clone();
		++_i;
	}

	return _stash;
	
}