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
    var dial: i32 = 50;
    var res: i32 = 0;

    var it = std.mem.splitScalar(u8, data, '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue;

        dial = try parseMove(line, dial);

        if (dial == 0) {
            res += 1;
        }
    }

    return res;
}

fn parseMove(line: []const u8, dial: i32) !i32 {
    const dir = line[0];
    const num = try std.fmt.parseInt(i32, line[1..], 10);

    if (dir == 'R') {
        return @mod(dial + num, 100);
    } else {
        return @mod(dial - num, 100);
    }
}
