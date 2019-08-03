public enum Sorter {
        MERGE("Merge Sort"),
        INSERTION("Insertion Sort"),
        QUICK("Quick Sort"),
        HEAP("Heap Sort"),
        BOGO("Bogo Sort"),
        BUBBLE("Bubble Sort"),
        SLOW("Slow Sort"),
        COMB("Comb Sort"),
        COCKTAIL("Shaker/Cocktail Sort"),
        STOOGE("Stooge Sort"),
        SMOOTH("Smooth Sort");

        public String name;

        Sorter(String name) {
                this.name = name;
        }
}

<T> void swap(T[] A, int l, int r) {
        T el = A[l];
        A[l] = A[r];
        A[r] = el;
}

int partition(Integer[] A, int l, int r) {
        int pivot = A[r];
        int i = 0;
        int j;
        for (j = 0; j <= r - 1; j++) {
                if (A[j] <= pivot) {
                        swap(A, i, j);
                        if (i != j)
                                arrayChanges.add(new ArrayChange(i, j));
                        i++;
                }
        }
        swap(A, i, j);
        if (i != j)
                arrayChanges.add(new ArrayChange(i, j));
        return i;
}

void quicksort() {
        quicksort(arr, 0, arr.length - 1);
}

void quicksort(Integer[] A, int l, int r) {
        if (l < r) {
                int m = partition(A, l, r);
                quicksort(A, l, m-1);
                quicksort(A, m+1, r);
        }
}

void insertionsort() {
        for (int j = 1; j < arr.length; j++) {
                int key = arr[j];
                int i = j - 1;
                while (i >= 0 && arr[i] > key) {
                        arr[i + 1] = arr[i];
                        arrayChanges.add(new ArrayChange(i+1, i));
                        i--;
                }
                arr[i+1] = key;
                arrayChanges.add(new ArrayChange(i+1, key, false));
        }
}

void mergeSort() {
        mergeSort(arr, 0, arr.length - 1);
}

void mergeSort(Integer[] A, int l, int r) {
        if (l < r) {
                int m = (l + r) / 2;
                mergeSort(A, l, m);
                mergeSort(A, m + 1, r);
                merge(A, l, m, r);
        }
}

void merge(Integer[] A, int l, int m, int r) {
        int n1 = m - l + 1;
        int n2 = r - m;
        Integer[] L = new Integer[n1 + 1];
        Integer[] R = new Integer[n2 + 1];
        for (int i = 0; i < n1; i++) {
                L[i] = A[l + i];
        }
        for (int i = 0; i < n2; i++) {
                R[i] = A[m + 1 + i];
        }
        L[n1] = Integer.MAX_VALUE;
        R[n2] = Integer.MAX_VALUE;
        int i = 0;
        int j = 0;
        for (int k = l; k <= r; k++) {
                if (L[i] <= R[j]) {
                        A[k] = L[i++];
                        arrayChanges.add(new ArrayChange(k, L[i-1], false));
                } else {
                        A[k] = R[j++];
                        arrayChanges.add(new ArrayChange(k, R[j-1], false));
                }
        }
}

void heapsort() {
        int n = arr.length;
        for (int i = n / 2 - 1; i >= 0; i--)
                maxheapify(arr, n, i);
        for (int i=n-1; i>=0; i--) {
                swap(arr, 0, i);
                arrayChanges.add(new ArrayChange(0, i));
                maxheapify(arr, i, 0);
        }
}

void maxheapify(Integer[] arr, int n, int i) {
        int largest = i;
        int l = 2*i + 1;
        int r = 2*i + 2;
        if (l < n && arr[l] > arr[largest])
                largest = l;
        if (r < n && arr[r] > arr[largest])
                largest = r;
        if (largest != i) {
                swap(arr, i, largest);
                arrayChanges.add(new ArrayChange(i, largest));
                maxheapify(arr, n, largest);
        }
}

void bubblesort() {
        for(int i=1; i<arr.length; i++) {
                for(int j=0; j<arr.length-i; j++) {
                        if(arr[j]>arr[j+1]) {
                                swap(arr, j, j+1);
                                arrayChanges.add(new ArrayChange(j, j+1));
                        }

                }
        }
}

void slowsort() {
        slowsort(arr, 0, arr.length-1);
}

void slowsort(Integer[] arr, int i, int j) {
        if (i >= j) return;
        int m = floor((i+j)/2f);
        slowsort(arr,i,m);
        slowsort(arr,m+1,j);
        if (arr[j] < arr[m]) {
                swap(arr, j, m);
                if (j != m)
                        arrayChanges.add(new ArrayChange(j, m));
        }
        slowsort(arr,i,j-1);
}

int getNextGap(int gap) {
        gap = (gap*10)/13;
        if (gap < 1)
                return 1;
        return gap;
}

void combsort() {
        int n = arr.length;
        int gap = n;
        boolean swapped = true;
        while (gap != 1 || swapped == true) {
                gap = getNextGap(gap);
                swapped = false;
                for (int i=0; i<n-gap; i++) {
                        if (arr[i] > arr[i+gap]) {
                                swap(arr, i, i+gap);
                                arrayChanges.add(new ArrayChange(i, i+gap));
                                swapped = true;
                        }
                }
        }
}

public void cocktailsort() {
        boolean swapped;
        do {
                swapped = false;
                for (int i =0; i<=  arr.length  - 2; i++) {
                        if (arr[ i ] > arr[ i + 1 ]) {
                                swap(arr, i, i+1);
                                arrayChanges.add(new ArrayChange(i, i+1));
                                swapped = true;
                        }
                }
                if (!swapped) {
                        break;
                }
                swapped = false;
                for (int i= arr.length - 2; i>=0; i--) {
                        if (arr[ i ] > arr[ i + 1 ]) {
                                swap(arr, i, i+1);
                                arrayChanges.add(new ArrayChange(i, i+1));
                                swapped = true;
                        }
                }
        } while (swapped);
}

void stoogesort() {
        stoogesort(arr, 0, arr.length);
}

void stoogesort(Integer[] a, int s, int e) {
        if(a[e-1]<a[s]) {
                swap(a, s, e-1);
                arrayChanges.add(new ArrayChange(s, e-1));
        }
        int len=e-s;
        if(len>2) {
                int third=len/3;
                stoogesort(a,s,e-third);
                stoogesort(a,s+third,e);
                stoogesort(a,s,e-third);
        }
}

static final int L[] = { 1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753,
                         1219, 1973, 3193, 5167, 8361, 13529, 21891, 35421, 57313, 92735, 150049,
                         242785, 392835, 635621, 1028457, 1664079, 2692537, 4356617, 7049155,
                         11405773, 18454929, 29860703, 48315633, 78176337, 126491971, 204668309,
                         331160281, 535828591, 866988873
};

void smoothsort() {

        int N = arr.length;
        int orders[] = new int[(int)(Math.log(N) / Math.log(2)) * 2];
        int trees = 0;

        for (int i = 0; i < N; i++) {
                if (trees > 1 && orders[trees-2] == orders[trees-1] + 1) {
                        trees--;
                        orders[trees-1]++;
                }
                else if (trees > 0 && orders[trees-1] == 1) {
                        orders[trees++] = 0;
                }
                else {
                        orders[trees++] = 1;
                }
                findAndSift(arr, i, trees-1, orders);
        }

        for (int i = N-1; i > 0; i--) {
                if (orders[trees-1] <= 1) {
                        trees--;
                }
                else {
                        int ri = i-1;
                        int li = ri - L[orders[trees-1] - 2];

                        trees++;
                        orders[trees-2]--;
                        orders[trees-1] = orders[trees-2]-1;

                        findAndSift(arr, li, trees-2, orders);
                        findAndSift(arr, ri, trees-1, orders);
                }
        }

}

void findAndSift(Integer[] a, int i, int tree, int[] orders) {
        int v = a[i];
        while (tree > 0) {
                int pi = i - L[orders[tree]];
                if (a[pi] <= v) {
                        break;
                }
                else if (orders[tree] > 1) {
                        int ri = i-1;
                        int li = ri - L[orders[tree]-2];
                        if (a[pi] <= a[li] || a[pi] <= a[ri]) {
                                break;
                        }
                }

                a[i] = a[pi];
                arrayChanges.add(new ArrayChange(i, a[pi], false));
                i = pi;
                tree--;
        }
        a[i] = v;
        arrayChanges.add(new ArrayChange(i, v, false));
        siftDown(a, i, orders[tree]);
}

void siftDown(Integer[] a, int i, int order) {
        int v = a[i];
        while (order > 1) {
                int ri = i-1;
                int li = ri - L[order-2];
                if (v >= a[li] && v >= a[ri]) {
                        break;
                }
                else if (a[li] <= a[ri]) {
                        a[i] = a[ri];
                        arrayChanges.add(new ArrayChange(i, a[ri], false));
                        i = ri;
                        order -= 2;
                }
                else {
                        a[i] = a[li];
                        arrayChanges.add(new ArrayChange(i, a[li], false));
                        i = li;
                        order -= 1;
                }
        }
        a[i] = v;
        arrayChanges.add(new ArrayChange(i, v, false));
}
