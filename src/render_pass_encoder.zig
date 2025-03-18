const maxInt = @import("std").math.maxInt;

const shared = @import("shared.zig");
const texture = @import("texture.zig");
const bundle = @import("render_bundle.zig");
const buffer = @import("buffer.zig");
const bind_group = @import("bind_group.zig");
const render_pipeline = @import("render_pipeline.zig");
const query = @import("query_set.zig");
const render_bundle = @import("render_bundle.zig");
const texture_view = @import("texture_view.zig");


pub const RenderPassEncoder = opaque {
    
    pub const beginOcclusionQuery = wgpuRenderPassEncoderBeginOcclusionQuery;

    pub const draw = wgpuRenderPassEncoderDraw;

    pub const drawIndexed = wgpuRenderPassEncoderDrawIndexed;

    pub const drawIndexedIndirect = wgpuRenderPassEncoderDrawIndexedIndirect;

    pub const drawIndirect = wgpuRenderPassEncoderDrawIndirect;

    pub const end = wgpuRenderPassEncoderEnd;

    pub const endOcclusionQuery = wgpuRenderPassEncoderEndOcclusionQuery;

    pub const executeBundles = wgpuRenderPassEncoderExecuteBundles;

    pub const setBlendConstant = wgpuRenderPassEncoderSetBlendConstant;

    pub const insertDebugMarker = wgpuRenderPassEncoderInsertDebugMarker;

    pub const popDebugGroup = wgpuRenderPassEncoderPopDebugGroup;

    pub const pushDebugGroup = wgpuRenderPassEncoderPushDebugGroup;

    pub fn setBindGroup(encoder: *RenderPassEncoder,
        index: u32, group: *bind_group.BindGroup, dynamic_offsets: ?[]const u32) void {
        
        wgpuRenderPassEncoderSetBindGroup(encoder,
            index, group,
            if (dynamic_offsets) |offsets| @as(u32, @intCast(offsets.len)) else 0,
            if (dynamic_offsets) |offsets| offsets.ptr else null,
        );
    }

    pub const setScissorRect = wgpuRenderPassEncoderSetScissorRect;

    pub const setStencilReference = wgpuRenderPassEncoderSetStencilReference;

    pub const setViewport = wgpuRenderPassEncoderSetViewport;

    pub const setIndexBuffer = wgpuRenderPassEncoderSetIndexBuffer;

    pub const setLabel = wgpuRenderPassEncoderSetLabel;

    pub const setPipeline = wgpuRenderPassEncoderSetPipeline;

    pub const setVertexBuffer = wgpuRenderPassEncoderSetVertexBuffer;

    pub const reference = wgpuRenderPassEncoderReference;

    pub const release = wgpuRenderPassEncoderRelease;
};

pub const LoadOp = enum(u32) {
    undefined,
    load,
    clear
};

pub const RenderPassColorAttachment = extern struct {
    next: ?*const shared.ChainedStruct = null,
    view: ?*texture_view.TextureView,
    depth_slice: u32 = maxInt(u32),
    resolve_target: ?*texture_view.TextureView = null,
    load_op: LoadOp,
    store_op: StoreOp,
    clear_value: shared.Color
};

pub const RenderPassDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    color_attachment_count: usize,
    color_attachments: ?[*]const RenderPassColorAttachment,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment = null,
    occlusion_query_set: ?*query.QuerySet = null,
    timestamp_write_count: usize = 0,
    timestamp_writes: ?[*]const RenderPassTimestampWrite = null,
};

pub const RenderPassDepthStencilAttachment = extern struct {
    view: *texture_view.TextureView,
    depth_load_op: LoadOp = .undefined,
    depth_store_op: StoreOp = .undefined,
    depth_clear_value: f32 = 0.0,
    depth_read_only: bool = false,
    stencil_load_op: LoadOp = .undefined,
    stencil_store_op: StoreOp = .undefined,
    stencil_clear_value: u32 = 0,
    stencil_read_only: bool = false,
};

pub const RenderPassTimestampWrite = extern struct {
    query_set: *query.QuerySet,
    start: u32,
    end: u32,
};

pub const StoreOp = enum(u32) {
    undefined,
    store,
    discard
};


extern fn wgpuRenderPassEncoderBeginOcclusionQuery(encoder: *RenderPassEncoder, index: u32) void;

extern fn wgpuRenderPassEncoderDraw(encoder: *RenderPassEncoder,
    vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void;

extern fn wgpuRenderPassEncoderDrawIndexed(encoder: *RenderPassEncoder,
    index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void;

extern fn wgpuRenderPassEncoderDrawIndexedIndirect(encoder: *RenderPassEncoder,
    indirect_buffer: buffer.Buffer, indirect_offset: u64) void;

extern fn wgpuRenderPassEncoderDrawIndirect(encoder: *RenderPassEncoder,
    indirect_buffer: buffer.Buffer, indirect_offset: u64) void;

extern fn wgpuRenderPassEncoderEnd(encoder: *RenderPassEncoder) void;

extern fn wgpuRenderPassEncoderEndOcclusionQuery(encoder: *RenderPassEncoder) void;

extern fn wgpuRenderPassEncoderExecuteBundles(encoder: *RenderPassEncoder,
    count: u32, bundles: [*]const render_bundle.RenderBundle) void;

extern fn wgpuRenderPassEncoderSetScissorRect(encoder: *RenderPassEncoder,
    x: u32, y: u32, width: u32, height: u32) void;

extern fn wgpuRenderPassEncoderSetStencilReference(encoder: *RenderPassEncoder, ref: u32) void;
  
extern fn wgpuRenderPassEncoderSetBlendConstant(encoder: *RenderPassEncoder, color: *const shared.Color) void;

extern fn wgpuRenderPassEncoderInsertDebugMarker(encoder: *RenderPassEncoder, label: [*:0]const u8) void;

extern fn wgpuRenderPassEncoderPopDebugGroup(encoder: *RenderPassEncoder) void;

extern fn wgpuRenderPassEncoderPushDebugGroup(encoder: *RenderPassEncoder, label: [*:0]const u8) void;

extern fn wgpuRenderPassEncoderSetBindGroup(encoder: *RenderPassEncoder,
    index: u32, group: *bind_group.BindGroup,
    dynamic_offset_count: u32, dynamic_offsets: ?[*]const u32) void;

extern fn wgpuRenderPassEncoderSetIndexBuffer(encoder: *RenderPassEncoder,
    index_buffer: *buffer.Buffer, format: buffer.IndexFormat, offset: u64, size: u64) void;

extern fn wgpuRenderPassEncoderSetPipeline(encoder: *RenderPassEncoder, pipeline: *render_pipeline.RenderPipeline) void;

extern fn wgpuRenderPassEncoderSetLabel(encoder: *RenderPassEncoder, label: ?[*:0]const u8) void;

extern fn wgpuRenderPassEncoderSetVertexBuffer(encoder: *RenderPassEncoder,
    slot: u32, vertex_buffer: *buffer.Buffer, offset: u64, size: u64) void;

extern fn wgpuRenderPassEncoderSetViewport(encoder: *RenderPassEncoder,
    x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) void;

extern fn wgpuRenderPassEncoderReference(encoder: *RenderPassEncoder) void;

extern fn wgpuRenderPassEncoderRelease(encoder: *RenderPassEncoder) void;
