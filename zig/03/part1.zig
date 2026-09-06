const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var da = std.heap.DebugAllocator(.{}){};
    defer _ = da.deinit();
    const allocator = da.allocator();

    const test_data = try std.Io.Dir.cwd().readFileAlloc(
        io,
        "data/test1",
        allocator,
        .unlimited,
    );
    defer allocator.free(test_data);

    const test_result = try solve(allocator, test_data);
    const expected: usize = 357;

    if (test_result != expected) {
        std.debug.print("Invalid test result: {d} should be {d}\n", .{ test_result, expected });
        return;
    }

    std.debug.print("Test data passed!\n", .{});

    const data = try std.Io.Dir.cwd().readFileAlloc(
        io,
        "data/input",
        allocator,
        .unlimited,
    );
    defer allocator.free(data);

    const result = try solve(allocator, data);
    std.debug.print("Solution: {d}\n", .{result});
}

fn solve(allocator: std.mem.Allocator, data: []const u8) !usize {
    var res: usize = 0;

    var it = std.mem.splitScalar(u8, data, '\n');

    while (it.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, "\r");

        if (line.len == 0) continue;

        const len = line.len;

        var nums = try allocator.alloc(u8, line.len);
        defer allocator.free(nums);

        for (line, 0..) |c, i| {
            nums[i] = c - '0';
        }

        var n: usize = 0;
        var max1: usize = 0;
        var max_idx: usize = 0;

        // Find the highest digit in the range of 0:len-1
        while (n < len - 1) : (n += 1) {
            if (nums[n] > max1) {
                max1 = nums[n];
                max_idx = n;
            }
        }

        // Find the higest digit in the range of the prev:len
        n = max_idx + 1;
        var max2: usize = 0;
        while (n < len) : (n += 1) {
            if (nums[n] > max2) {
                max2 = nums[n];
            }
        }

        const max: usize = (max1 * 10) + max2;
        res += max;
    }

    return res;
}
