const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var da = std.heap.DebugAllocator(.{}){};
    defer _ = da.deinit();
    const allocator = da.allocator();

    var res: i32 = 50;
    const expected: i32 = 3;

    const test_data = try std.Io.Dir.cwd().readFileAlloc(
        io,
        "data/input",
        allocator,
        .unlimited,
    );
    defer allocator.free(test_data);

    var it = std.mem.splitScalar(u8, test_data, '\n');

    while (it.next()) |line| {
        const dir = line[0];
        const num = line[1..];
        std.debug.print("{s} {d}\n", .{ dir, num });
    }

    res = 0;

    if (res == expected) {
        const data = try std.Io.Dir.cwd().readFileAlloc(
            io,
            "data/test1",
            allocator,
            .unlimited,
        );
        defer allocator.free(data);
    } else {
        std.debug.print("Invalid result: {d} should be {d}\n", .{ res, expected });
    }
}
