const shared = @import("shared.zig");
const texture = @import("texture.zig");
const buffer = @import("buffer.zig");
const compute_pass = @import("compute_pass.zig");
const render_pass_encoder = @import("render_pass_encoder.zig");
const query = @import("query_set.zig");
const command_buffer = @import("command_buffer.zig");


pub const CommandEncoder = opaque {
    
    pub const beginComputePass = wgpuCommandEncoderBeginComputePass;

    pub const beginRenderPass = wgpuCommandEncoderBeginRenderPass;

    pub const clearBuffer = wgpuCommandEncoderClearBuffer;

    pub const copyBufferToBuffer = wgpuCommandEncoderCopyBufferToBuffer;

    pub const copyBufferToTexture = wgpuCommandEncoderCopyBufferToTexture;

    pub const copyTextureToBuffer = wgpuCommandEncoderCopyTextureToBuffer;

    pub const copyTextureToTexture = wgpuCommandEncoderCopyTextureToTexture;

    pub const finish = wgpuCommandEncoderFinish;

    pub const insertDebugMarker = wgpuCommandEncoderInsertDebugMarker;

    pub const popDebugGroup = wgpuCommandEncoderPopDebugGroup;

    pub const pushDebugGroup = wgpuCommandEncoderPushDebugGroup;

    pub const resolveQuerySet = wgpuCommandEncoderResolveQuerySet;

    pub const setLabel = wgpuCommandEncoderSetLabel;

    pub const writeTimestamp = wgpuCommandEncoderWriteTimestamp;

    pub const addRef = wgpuCommandEncoderWriteBuffer;

    pub const release = wgpuCommandEncoderRelease;
};

pub const CommandEncoderDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{}
};


extern fn wgpuCommandEncoderBeginComputePass(encoder: *CommandEncoder, descriptor: ?*const compute_pass.ComputePassDescriptor) *compute_pass.ComputePassEncoder;

extern fn wgpuCommandEncoderBeginRenderPass(encoder: *CommandEncoder, descriptor: *const render_pass_encoder.RenderPassDescriptor) *render_pass_encoder.RenderPassEncoder;

extern fn wgpuCommandEncoderClearBuffer(encoder: *CommandEncoder, buffer: *buffer.Buffer, offset: usize, size: usize) void;

extern fn wgpuCommandEncoderCopyBufferToBuffer(encoder: *CommandEncoder, source: buffer.Buffer, source_offset: u64, destination: buffer.Buffer, destination_offset: u64, size: usize) void;

extern fn wgpuCommandEncoderCopyBufferToTexture(encoder: *CommandEncoder, source: *const buffer.ImageCopyBuffer, destination: *const texture.TexelCopyTextureInfo, copy_size: *const shared.Extent3D) void;

extern fn wgpuCommandEncoderCopyTextureToBuffer(encoder: *CommandEncoder, source: *const texture.TexelCopyTextureInfo, destination: *const buffer.ImageCopyBuffer, copy_size: *const shared.Extent3D) void;

extern fn wgpuCommandEncoderCopyTextureToTexture(encoder: *CommandEncoder, source: *const texture.TexelCopyTextureInfo, destination: *const texture.TexelCopyTextureInfo, copy_size: *const shared.Extent3D) void;

extern fn wgpuCommandEncoderFinish(encoder: *CommandEncoder, descriptor: ?*const command_buffer.CommandBufferDescriptor) *command_buffer.CommandBuffer;

extern fn wgpuCommandEncoderInsertDebugMarker(encoder: *CommandEncoder, label: shared.StringView) void;

extern fn wgpuCommandEncoderPopDebugGroup(encoder: *CommandEncoder) void;

extern fn wgpuCommandEncoderPushDebugGroup(encoder: *CommandEncoder, group_label: shared.StringView) void;

extern fn wgpuCommandEncoderResolveQuerySet(encoder: *CommandEncoder, query_set: query.QuerySet, first_query: u32, query_count: u32, destination: buffer.Buffer, destination_offset: u64) void;

extern fn wgpuCommandEncoderWriteTimestamp(encoder: *CommandEncoder, query_set: query.QuerySet, index: u32) void;

extern fn wgpuCommandEncoderSetLabel(encoder: *CommandEncoder, label: shared.StringView) void;

extern fn wgpuCommandEncoderWriteBuffer(encoder: *CommandEncoder) void;

extern fn wgpuCommandEncoderRelease(encoder: *CommandEncoder) void;
