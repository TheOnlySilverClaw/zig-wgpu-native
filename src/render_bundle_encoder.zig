const shared = @import("shared.zig");
const texture = @import("texture.zig");
const bundle = @import("render_bundle.zig");
const buffer = @import("buffer.zig");
const bind_group = @import("bind_group.zig");
const render_pipeline = @import("render_pipeline.zig");


pub const RenderBundleEncoder = opaque {
    
    pub const draw = wgpuRenderBundleEncoderDraw;

    pub const drawIndexed = wgpuRenderBundleEncoderDrawIndexed;

    pub const drawIndexedIndirect = wgpuRenderBundleEncoderDrawIndexedIndirect;

    pub const drawIndirect = wgpuRenderBundleEncoderDrawIndirect;

    pub const finish = wgpuRenderBundleEncoderFinish;

    pub const insertDebugMarker = wgpuRenderBundleEncoderInsertDebugMarker;

    pub const popDebugGroup = wgpuRenderBundleEncoderPopDebugGroup;

    pub const pushDebugGroup = wgpuRenderBundleEncoderPushDebugGroup;

    pub fn setBindGroup(encoder: *RenderBundleEncoder,
        index: u32, group: bind_group.BindGroup, dynamic_offsets: ?[]const u32) void {
        
        wgpuRenderBundleEncoderSetBindGroup(encoder,
            index, group,
            if (dynamic_offsets) |offsets| @as(u32, @intCast(offsets.len)) else 0,
            if (dynamic_offsets) |offsets| offsets.ptr else null,
        );
    }

    pub const setIndexBuffer = wgpuRenderBundleEncoderSetIndexBuffer;

    pub const setLabel = wgpuRenderBundleEncoderSetLabel;

    pub const setPipeline = wgpuRenderBundleEncoderSetPipeline;

    pub const setVertexBuffer = wgpuRenderBundleEncoderSetVertexBuffer;

    pub const reference = wgpuRenderBundleEncoderReference;

    pub const release = wgpuRenderBundleEncoderRelease;
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
    color_formats_count: usize,
    color_formats: ?[*]const texture.TextureFormat,
    depth_stencil_format: texture.TextureFormat,
    sample_count: u32,
    depth_read_only: shared.Bool,
    stencil_read_only: shared.Bool,
};


extern fn wgpuRenderBundleEncoderDraw(encoder: *RenderBundleEncoder,
    vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void;

extern fn wgpuRenderBundleEncoderDrawIndexed(encoder: *RenderBundleEncoder,
    index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void;

extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(encoder: *RenderBundleEncoder,
    indirect_buffer: buffer.Buffer, indirect_offset: u64) void;

extern fn wgpuRenderBundleEncoderDrawIndirect(encoder: *RenderBundleEncoder,
    indirect_buffer: buffer.Buffer, indirect_offset: u64) void;

extern fn wgpuRenderBundleEncoderFinish(encoder: *RenderBundleEncoder,
    descriptor: *const bundle.RenderBundleDescriptor) bundle.RenderBundle;

extern fn wgpuRenderBundleEncoderInsertDebugMarker(encoder: *RenderBundleEncoder, label: [*:0]const u8) void;

extern fn wgpuRenderBundleEncoderPopDebugGroup(encoder: *RenderBundleEncoder) void;

extern fn wgpuRenderBundleEncoderPushDebugGroup(encoder: *RenderBundleEncoder, label: shared.StringView) void;

extern fn wgpuRenderBundleEncoderSetBindGroup(encoder: *RenderBundleEncoder,
    index: u32, group: bind_group.BindGroup,
    dynamic_offset_count: u32, dynamic_offsets: ?[*]const u32) void;

extern fn wgpuRenderBundleEncoderSetIndexBuffer(encoder: *RenderBundleEncoder,
    index_buffer: buffer.Buffer, format: buffer.IndexFormat, offset: u64, size: u64) void;

extern fn wgpuRenderBundleEncoderSetPipeline(encoder: *RenderBundleEncoder, pipeline: render_pipeline.RenderPipeline) void;

extern fn wgpuRenderBundleEncoderSetLabel(encoder: *RenderBundleEncoder, label: ?shared.StringView) void;

extern fn wgpuRenderBundleEncoderSetVertexBuffer(encoder: *RenderBundleEncoder,
    slot: u32, vertex_buffer: buffer.Buffer, offset: u64, size: u64) void;

extern fn wgpuRenderBundleEncoderReference(encoder: *RenderBundleEncoder) void;

extern fn wgpuRenderBundleEncoderRelease(encoder: *RenderBundleEncoder) void;
