const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var da = std.heap.DebugAllocator(.{}){};
    defer _ = da.deinit();
    const allocator = da.allocator();

    const test_data = try std.Io.Dir.cwd().readFileAlloc(
        io,
        "data/test2",
        allocator,
        .unlimited,
    );
    defer allocator.free(test_data);

    const test_result = try solve(test_data);
    const expected: i32 = 3;

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

fn solve(data: []const u8) !i32 {
    var res: i32 = 0;

    var it = std.mem.splitScalar(u8, data, '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue;
        res = 0;
        std.debug.print("{s}\n", .{line});
    }

    return res;
}
