const shared = @import("shared.zig");
const layout = @import("pipeline_layout.zig");
const shader = @import("shader.zig");
const device = @import("device.zig");
const bind_group_layout = @import("bind_group_layout.zig");

pub const ComputePipeline = opaque {

    pub const getBindGroupLayout = wgpuComputePipelineGetBindGroupLayout;

    pub const setLabel = wgpuComputePipelineSetLabel;

    pub const reference = wgpuComputePipelineReference;

    pub const release = wgpuComputePipelineRelease;
};

pub const CreateComputePipelineAsyncCallback = fn (status: device.CreatePipelineAsyncStatus, pipeline: *ComputePipeline,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const ComputePipelineDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView,
    layout: ?layout.PipelineLayout = null,
    compute: ProgrammableStageDescriptor
};

pub const ProgrammableStageDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    module: shader.ShaderModule,
    entry_point: shared.StringView,
    constant_count: usize = 0,
    constants: ?[*]const shared.ConstantEntry = null
};


extern fn wgpuComputePipelineGetBindGroupLayout(pipeline: *ComputePipeline, index: u32) *bind_group_layout.BindGroupLayout;

extern fn wgpuComputePipelineSetLabel(pipeline: *ComputePipeline, label: ?shared.StringView) void;

extern fn wgpuComputePipelineReference(pipeline: *ComputePipeline) void;

extern fn wgpuComputePipelineRelease(pipeline: *ComputePipeline) void;
