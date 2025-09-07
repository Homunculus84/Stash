function stash_debug(_stash) {

	__stash_trace($"Size: {stash_size(stash)}, Total size: {array_length(stash)}, Items count: {stash_count(stash)}");

	var _i = 0; repeat(array_length(_stash)) {
		__stash_trace($"{_i}: {_stash[_i].serialize()}");
		++_i;
	}

}