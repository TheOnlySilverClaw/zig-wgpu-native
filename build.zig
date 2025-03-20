const std = @import("std");

pub fn build(b: *std.Build) void {

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    var module = b.addModule("webgpu", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const wgpu = b.lazyDependency("wgpu_native", .{}).?;
    module.addObjectFile(wgpu.path("lib/libwgpu_native.a"));
}
