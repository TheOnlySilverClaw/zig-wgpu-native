const shared = @import("shared.zig");

pub const CommandBuffer = opaque {
    
    pub const setLabel = wgpuCommandBufferSetLabel;

    pub const addRef = wgpuCommandBufferAddRef;

    pub const release = wgpuCommandBufferRelease;
};

pub const CommandBufferDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{}
};


extern fn wgpuCommandBufferSetLabel(command_buffer: *CommandBuffer, label: shared.StringView) void;

extern fn wgpuCommandBufferAddRef(command_buffer: *CommandBuffer) void;

extern fn wgpuCommandBufferRelease(command_buffer: *CommandBuffer) void;
