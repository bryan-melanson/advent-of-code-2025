const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const part1 = b.addExecutable(.{
        .name = "part1",
        .root_module = b.createModule(.{
            .root_source_file = b.path("part1.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const part2 = b.addExecutable(.{
        .name = "part2",
        .root_module = b.createModule(.{
            .root_source_file = b.path("part2.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(part1);
    b.installArtifact(part2);

    addRunStep(b, part1, "run-part1", "Run part1.zig");
    addRunStep(b, part2, "run-part2", "Run part2.zig");
}

fn addRunStep(
    b: *std.Build,
    exe: *std.Build.Step.Compile,
    name: []const u8,
    description: []const u8,
) void {
    const run_cmd = b.addRunArtifact(exe);

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(name, description);
    run_step.dependOn(&run_cmd.step);
}
