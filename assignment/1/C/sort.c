char** buffer;
int merge_sort(char** a, int len, int mode, char** res) { // return size of sorted list
	/*
	 * do i need to handle len = 0?
	 * ceil(len / 2) >= len / 2 >= 1 for len >= 2
	 * floor(len / 2) >= (len - 1) / 2 >= 1 / 2 > 0 for len >= 2
	 * so i don't
	 */

	if (len == 1) {
		res[0] = a[0];
		return 1;
	}

	int half = len >> 1;
	int L = merge_sort(a, half, mode, res);
	int R = merge_sort(a + half, len - half, mode, res + half);
	int new_len = merge(res, L, res + half, R, mode, buffer);
	for (int i = 0; i < new_len; ++i)
		res[i] = buffer[i];
	return new_len;
}
