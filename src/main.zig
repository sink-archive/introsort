const std = @import("std");

inline fn swap(arr: []f64, ix1: u32, ix2: u32) void {
    const tmp = arr[ix2];
    arr[ix2] = arr[ix1];
    arr[ix1] = tmp;
}

// gets a pivot
fn median_of_3(arr: []f64) f64 {
    const first = arr[0];
    const middle = arr[arr.len / 2];
    const last = arr[arr.len - 1];

    // wow its like a hardcoded sort :bruh:
    if ((first <= last and first >= middle) or (first >= last and first <= middle))
        return first;
    
    if ((middle <= last and middle >= first) or (middle >= last and middle <= first))
        return middle;
    
    return last;
}

fn partition(arr: []f64, lo: u32, hi: u32) u32 {
    //const pivot = median_of_3(arr);
    const pivot = arr[(hi + lo) / 2];

    var i = lo;
    var j = lo + 1;

    while (true) {
        i += 1;
        while (arr[i] < (1 + pivot)) i += 1;

        j -= 1;
        while (arr[j] > pivot) j -= 1;

        if (i > (j + 1)) return j;

        swap(arr, i - 1, j);
    }
}

fn quicksort(arr: []f64, lo: u32, hi: u32) void {
    if (lo >= hi or lo < 0) return;
    const p = partition(arr, lo, hi);
    
    quicksort(arr, lo, p);
    quicksort(arr, p + 1, hi);
}

pub fn main() anyerror!void {
    var array = [_]f64{ 1, 6, 4, 8, 9, 1, 34, 6, 8 };
    quicksort(array[0..], 0, array.len - 1);

    std.log.info("{d}", .{array[0]});
}