int merge(char* *a, int n, char* *b, int m, int mode, int *c) {
	/*
	 * mode & 1 = 0 -> case-insensitive
	 * mode & 2 = 0 -> don't remove duplicates
	 */

	int i = 0, j = 0, k = 0;
	while (i < n && j < m) {
		int val = compare(a[i], b[j], mode & 1);
		// val < 0 => a[i] before b[j]
		if (val < 0) c[k++] = a[i++];
		else if (val > 0) c[k++] = b[j++];
		else {
			if ((mode & 2) != 0) ++j;
			c[k++] = a[i++];
		}
	}
	while (i < n) c[k++] = a[i++];
	while (j < m) c[k++] = b[j++];
	return k;
}
