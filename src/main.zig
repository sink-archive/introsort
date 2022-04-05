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

fn quicksort(arr: []f64, lo: u32, hi: u32) void {
    if (lo >= 0 and hi >= 0 and lo < hi) {
        const p = partition(arr, lo, hi);
    
        quicksort(arr, lo, p);
        quicksort(arr, p + 1, hi);
    }
}

pub fn main() anyerror!void {
    var array = [_]f64{ 1, 6, 4, 8, 9, 1, 34, 6, 8 };
    quicksort(array[0..], 0, array.len - 1);

    for (array) |value| {
        std.log.info("{d}", .{value});
    }
}