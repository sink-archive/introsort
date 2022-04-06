const std = @import("std");
const sort = @import("sort.zig");

pub fn main() anyerror!void {
    var array = [_]f64{ 1, 6, 4, 8, 9, 1, 34, 6, 8 };
    sort.heapsort(array[0..], array.len);

    for (array) |value| {
        std.log.info("{d}", .{value});
    }
}