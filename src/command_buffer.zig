const shared = @import("shared.zig");

pub const CommandBuffer = opaque {
    
    pub const setLabel = wgpuCommandBufferSetLabel;

    pub const reference = wgpuCommandBufferReference;

    pub const release = wgpuCommandBufferRelease;
};

pub const CommandBufferDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null
};


extern fn wgpuCommandBufferSetLabel(command_buffer: *CommandBuffer, label: ?[*:0]const u8) void;

extern fn wgpuCommandBufferReference(command_buffer: *CommandBuffer) void;

extern fn wgpuCommandBufferRelease(command_buffer: *CommandBuffer) void;
