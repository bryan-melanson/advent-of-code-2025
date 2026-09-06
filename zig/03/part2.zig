const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var da = std.heap.DebugAllocator(.{}){};
    defer _ = da.deinit();
    const allocator = da.allocator();

    // Read the test data
    const test_data = try std.Io.Dir.cwd().readFileAlloc(
        io,
        "data/test2",
        allocator,
        .unlimited,
    );
    // Free the memory when unused
    defer allocator.free(test_data);

    // Solve using the test data
    const test_result = try solve(test_data);
    // The answer expected in the problem
    const expected: usize = 3121910778619;

    // Is the test passing?
    if (test_result != expected) {
        std.debug.print("Invalid test result: {d} should be {d}\n", .{ test_result, expected });
        return;
    }

    std.debug.print("Test data passed!\n", .{});

    // Read the full problem input
    const data = try std.Io.Dir.cwd().readFileAlloc(
        io,
        "data/input",
        allocator,
        .unlimited,
    );
    defer allocator.free(data);

    // Solve the full problem
    const result = try solve(data);
    std.debug.print("Solution: {d}\n", .{result});
}

fn solve(data: []const u8) !u64 {
    var res: u64 = 0;
    var it = std.mem.splitScalar(u8, data, '\n');

    while (it.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, "\r");
        if (line.len == 0) continue;

        var start: usize = 0;
        var value: u64 = 0;

        for (0..12) |picked| {
            const remaining = 12 - picked;

            // Pick from start through the latest index that still leaves
            // enough digits after it to finish the 12-digit number.
            const end = line.len - remaining;

            var best_idx = start;
            var best_digit = line[start];

            var i = start + 1;
            while (i <= end) : (i += 1) {
                if (line[i] > best_digit) {
                    best_digit = line[i];
                    best_idx = i;
                }
            }

            value = (value * 10) + @as(u64, best_digit - '0');
            start = best_idx + 1;
        }

        res += value;
    }

    return res;
}
