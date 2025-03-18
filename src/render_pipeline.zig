const shared = @import("shared.zig");
const shader = @import("shader.zig");
const layout = @import("pipeline_layout.zig");
const buffer = @import("buffer.zig");
const texture = @import("texture.zig");
const texture_view = @import("texture_view.zig");
const device = @import("device.zig");
const bind_group_layout = @import("bind_group_layout.zig");

pub const RenderPipeline = opaque {
    
    pub const getBindGroupLayout = wgpuRenderPipelineGetBindGroupLayout;

    pub const setLabel = wgpuRenderPipelineSetLabel;

    pub const reference = wgpuRenderPipelineReference;

    pub const release = wgpuRenderPipelineRelease;
};

pub const BlendFactor = enum(u32) {
    undefined,
    zero,
    one,
    src,
    one_minus_src,
    src_alpha,
    one_minus_src_alpha,
    dst,
    one_minus_dst,
    dst_alpha,
    one_minus_dst_alpha,
    src_alpha_saturated,
    constant,
    one_minus_constant,
    src1,
    one_minus_src1,
    src1_alpha,
    one_minus_src1_alpha,
};

pub const BlendOperation = enum(u32) {
    undefined,
    add,
    subtract,
    reverse_subtract,
    min,
    max
};

pub const CreateRenderPipelineAsyncCallback = fn (status: device.CreatePipelineAsyncStatus, pipeline: RenderPipeline,
    message: shared.StringView, userdata: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const CullMode = enum(u32) {
    undefined,
    none,
    front,
    back
};

pub const FrontFace = enum(u32) {
    undefined,
    counter_clockwise,
    clockwise
};

pub const PrimitiveTopology = enum(u32) {
    undefined,
    point_list,
    line_list,
    line_strip,
    triangle_list,
    triangle_strip
};

pub const StencilOperation = enum(u32) {
    undefined,
    keep,
    zero,
    replace,
    invert,
    increment_clamp,
    decrement_clamp,
    increment_wrap,
    decrement_wrap
};

pub const VertexFormat = enum(u32) {
    uint8,
    uint8x2,
    uint8x4,
    sint8,
    sint8x2,
    sint8x4,
    unorm8,
    unorm8x2,
    unorm8x4,
    snorm8,
    snorm8x2,
    snorm8x4,
    uint16,
    uint16x2,
    uint16x4,
    sint16,
    sint16x2,
    sint16x4,
    unorm16,
    unorm16x2,
    unorm16x4,
    snorm16,
    snorm16x2,
    snorm16x4,
    float16,
    float16x2,
    float16x4,
    float32,
    float32x2,
    float32x3,
    float32x4,
    uint32,
    uint32x2,
    uint32x3,
    uint32x4,
    sint32,
    sint32x2,
    sint32x3,
    sint32x4,
    unorm_10_10_2,
    unorm_8x4_bgra
};

pub const VertexStepMode = enum(u32) {
    vertex_buffer_not_used,
    undefined,
    vertex,
    instance
};

pub const ColorWriteMask = packed struct(u64) {
    red: bool = false,
    green: bool = false,
    blue: bool = false,
    alpha: bool = false,
    _padding: u60 = 0,

    pub const all = ColorWriteMask {
        .red = true,
        .green = true,
        .blue = true,
        .alpha = true
    };
};

pub const VertexAttribute = extern struct {
    format: VertexFormat,
    offset: u64,
    shader_location: u32
};

pub const VertexBufferLayout = extern struct {
    array_stride: u64,
    step_mode: VertexStepMode = .vertex,
    attribute_count: usize,
    attributes: [*]const VertexAttribute
};

pub const VertexState = extern struct {
    next: ?*const shared.ChainedStruct = null,
    module: *shader.ShaderModule,
    entry_point: [*:0]const u8,
    constant_count: usize,
    constants: ?[*]const shared.ConstantEntry,
    buffer_count: usize,
    buffers: ?[*]const VertexBufferLayout
};

pub const BlendComponent = extern struct {
    operation: BlendOperation = .add,
    src_factor: BlendFactor = .one,
    dst_factor: BlendFactor = .zero
};

pub const BlendState = extern struct {
    color: BlendComponent,
    alpha: BlendComponent
};

pub const ColorTargetState = extern struct {
    next: ?*const shared.ChainedStruct = null,
    format: texture.TextureFormat,
    blend: ?*const BlendState = null,
    write_mask: ColorWriteMask = ColorWriteMask.all
};

pub const FragmentState = extern struct {
    next: ?*const shared.ChainedStruct = null,
    module: *shader.ShaderModule,
    entry_point: [*:0]const u8,
    constant_count: usize,
    constants: ?[*]const shared.ConstantEntry,
    target_count: usize,
    targets: ?[*]const ColorTargetState
};

pub const PrimitiveState = extern struct {
    next: ?*const shared.ChainedStruct = null,
    topology: PrimitiveTopology,
    strip_index_format: buffer.IndexFormat = .undefined,
    front_face: FrontFace,
    cull_mode: CullMode
};

pub const StencilFaceState = extern struct {
    compare: shared.CompareFunction = .always,
    fail_operation: StencilOperation = .keep,
    depth_fail_operation: StencilOperation = .keep,
    pass_operation: StencilOperation = .keep
};

pub const DepthStencilState = extern struct {
    next: ?*const shared.ChainedStruct = null,
    format: texture.TextureFormat,
    depth_write_enabled: u32 = 1,
    depth_compare: shared.CompareFunction = .always,
    stencil_front: StencilFaceState = .{},
    stencil_back: StencilFaceState = .{},
    stencil_read_mask: u32 = shared.undefined_u32,
    stencil_write_mask: u32 = shared.undefined_u32,
    depth_bias: i32 = 0,
    depth_bias_slope_scale: f32 = 0.0,
    depth_bias_clamp: f32 = 0.0
};

pub const MultisampleState = extern struct {
    next: ?*const shared.ChainedStruct = null,
    count: u32 = 1,
    mask: u32 = shared.undefined_u32,
    alpha_to_coverage_enabled: bool = false
};

pub const RenderPipelineDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    layout: ?*layout.PipelineLayout,
    vertex: VertexState,
    primitive: PrimitiveState,
    depth_stencil: ?*const DepthStencilState,
    multisample: MultisampleState,
    fragment: ?*const FragmentState
};


extern fn wgpuRenderPipelineGetBindGroupLayout(pipeline: *RenderPipeline, index: u32) *bind_group_layout.BindGroupLayout;

extern fn wgpuRenderPipelineSetLabel(pipeline: *RenderPipeline, label: ?[*:0]const u8) void;

extern fn wgpuRenderPipelineReference(pipeline: *RenderPipeline) void;

extern fn wgpuRenderPipelineRelease(pipeline: *RenderPipeline) void;
