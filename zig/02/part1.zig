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

    const test_result = try solve(test_data);
    const expected: u64 = 1227775554;

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

    const result = try solve(data);
    std.debug.print("Solution: {d}\n", .{result});
}

fn solve(data: []const u8) !u64 {
    var res: u64 = 0;

    var it = std.mem.splitScalar(u8, data, ',');

    while (it.next()) |range| {
        const trimmed = std.mem.trim(u8, range, " \r\n\t");
        if (trimmed.len == 0) continue;

        var nums = std.mem.splitScalar(u8, trimmed, '-');

        const low_text = nums.next() orelse return error.InvalidRange;
        const high_text = nums.next() orelse return error.InvalidRange;

        const low = try std.fmt.parseInt(u64, low_text, 10);
        const high = try std.fmt.parseInt(u64, high_text, 10);

        var n = low;
        while (n <= high) : (n += 1) {
            if (isRepeatedTwice(n)) res += n;
        }
    }

    return res;
}

fn isRepeatedTwice(n: u64) bool {
    const digits = countDigits(n);
    if (digits % 2 != 0) return false;

    const split = std.math.pow(u64, 10, digits / 2);
    return n / split == n % split;
}

fn countDigits(n: u64) u64 {
    var digits: u64 = 1;
    var rest = n / 10;
    while (rest > 0) : (rest /= 10) digits += 1;
    return digits;
}
