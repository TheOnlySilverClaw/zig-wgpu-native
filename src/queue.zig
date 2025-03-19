const shared = @import("shared.zig");
const texture = @import("texture.zig");
const buffer = @import("buffer.zig");
const command_buffer = @import("command_buffer.zig");

pub const Queue = opaque {

    pub const onSubmittedWorkDone = wgpuQueueOnSubmittedWorkDone;

    pub const setLabel = wgpuQueueSetLabel;

    pub fn submit(queue: *Queue, commands: []const *command_buffer.CommandBuffer) void {
        wgpuQueueSubmit(queue, commands.len, commands.ptr);
    }

    // TODO infer element size?
    pub fn writeBuffer(queue: *Queue,
        target: *buffer.Buffer, comptime T: type, data: []const T, offset: u64) void {
        wgpuQueueWriteBuffer(queue, target, offset, data.ptr, data.len * @sizeOf(T));
    }

    // TODO maybe change as soon as casting between slices works
    pub const writeTexture = wgpuQueueWriteTexture;

    pub const addRef = wgpuQueueAddRef;

    pub const release = wgpuQueueRelease;
};

pub const QueueDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
};

pub const QueueWorkDoneCallback = fn (status: QueueWorkDoneStatus, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const QueueWorkDoneCallbackInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    mode: shared.CallbackMode, callback:
    *const QueueWorkDoneCallback,
    userdata1: ?*shared.UserData,
    userdata2: ?*shared.UserData
};

pub const QueueWorkDoneStatus = enum(u32) {
    success,
    instance_dropped,
    @"error",
    unknown
};


extern fn wgpuQueueOnSubmittedWorkDone(queue: Queue, signal_value: u64, callback_info: QueueWorkDoneCallbackInfo) shared.Future;

extern fn wgpuQueueSetLabel(queue: *Queue, label: ?shared.StringView) void;

extern fn wgpuQueueSubmit(queue: *Queue, command_count: usize, commands: [*]const *command_buffer.CommandBuffer) void;

extern fn wgpuQueueWriteBuffer(queue: *Queue, target: *buffer.Buffer, offset: u64, data: *const anyopaque, size: usize) void;

extern fn wgpuQueueWriteTexture(queue: *Queue, destination: *const texture.TexelCopyTextureInfo, data: *const anyopaque, size: usize, data_layout: *const texture.TexelCopyBufferLayout, write_size: *const shared.Extent3D) void;

extern fn wgpuQueueAddRef(queue: *Queue) void;

extern fn wgpuQueueRelease(queue: *Queue) void;
