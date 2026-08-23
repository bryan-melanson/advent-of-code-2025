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
    const expected: u64 = 4174379265;

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
            if (isRepeatedSequence(n)) res += n;
        }
    }

    return res;
}

fn isRepeatedSequence(n: u64) bool {
    var buf: [20]u8 = undefined;
    const digits = toDigits(n, &buf);

    var period: usize = 1;
    while (period <= digits.len / 2) : (period += 1) {
        if (digits.len % period != 0) continue;
        if (hasPeriod(digits, period)) return true;
    }

    return false;
}

fn hasPeriod(digits: []const u8, period: usize) bool {
    var i: usize = period;
    while (i < digits.len) : (i += 1) {
        if (digits[i] != digits[i - period]) return false;
    }
    return true;
}

/// Writes the decimal digits of `n` into `buf` (least significant first) and
/// returns the filled slice. Digit order does not affect periodicity.
fn toDigits(n: u64, buf: []u8) []const u8 {
    var len: usize = 0;
    var rest = n;

    while (true) {
        buf[len] = @intCast(rest % 10);
        len += 1;
        rest /= 10;
        if (rest == 0) break;
    }

    return buf[0..len];
}
