function stash_tidy(_stash) {
	
	array_sort(_stash, function(_stack_a, _stack_b) {
		return _stack_a.is_empty() - _stack_b.is_empty();
	});
	
}