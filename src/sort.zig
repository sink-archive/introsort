const std = @import("std");

inline fn swap(arr: []f64, i: u32, j: u32) void {
    const tmp = arr[j];
    arr[j] = arr[i];
    arr[i] = tmp;
}

inline fn median_of_3(arr: []f64, lo: u32, hi: u32) f64 {
    const mid = (hi + lo) / 2;

    if (arr[mid] < arr[lo])
        swap(arr, lo, mid);
    if (arr[hi] < arr[lo])
        swap(arr, lo, hi);
    if (arr[mid] < arr[hi])
        swap(arr, mid, hi);

    return arr[hi];
}

fn partition(arr: []f64, lo: u32, hi: u32) u32 {
    const pivot = median_of_3(arr, lo, hi);

    // wrapping (%) logic to substitute for signed ints
    // for the one case where negative numbers are actually needed
    var i = lo -% 1;
    var j = hi + 1;

    while (true) {
        i +%= 1;
        while (arr[i] < pivot) i += 1;

        j -= 1;
        while (arr[j] > pivot) j -= 1;

        if (i >= j) return j;

        swap(arr, i, j);
    }
}

pub fn quicksort(arr: []f64, lo: u32, hi: u32) void {
    if (lo >= 0 and hi >= 0 and lo < hi) {
        const p = partition(arr, lo, hi);
    
        quicksort(arr, lo, p);
        quicksort(arr, p + 1, hi);
    }
}

// heapify from https://www.geeksforgeeks.org/cpp-program-for-heap-sort/
fn heapify(arr: []f64, n: u32, i: u32) void {
    var largest = i; // Initialize largest as root
    const l = (2 * i) + 1; // left = 2*i + 1
    const r = (2 * i) + 2; // right = 2*i + 2
  
    // If left child is larger than root
    if (l < n and arr[l] > arr[largest])
        largest = l;
  
    // If right child is larger than largest so far
    if (r < n and arr[r] > arr[largest])
        largest = r;
  
    // If largest is not root
    if (largest != i) {
        swap(arr, i, largest);
  
        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

pub fn heapsort(arr: []f64, n: u32) void {
    var i = (n / 2) - 1;
    while (i > 0): (i -= 1)
        heapify(arr, n, i);
    heapify(arr, n, i);
  
    var j = n - 1;
    while (j > 0): (j -= 1) {
        // Move current root to end
        swap(arr, 0, j);
  
        // call max heapify on the reduced heap
        heapify(arr, j, 0);
    }
}

pub fn insertionsort(arr: []f64, n: u32) void {
    var i: u32 = 1;
    while (i < n): (i += 1) {
        const key = arr[i];
        var j = i - 1;

        while (j >= 0 and arr[j] > key) {
            arr[j + 1] = arr[j];
            j = i - 1;
        }
        arr[j + 1] = key;
    }
}