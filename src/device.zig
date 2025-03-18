const shared = @import("shared.zig");
const adapter = @import("adapter.zig");
const support = @import("support.zig");
const buffer = @import("buffer.zig");
const bind_group = @import("bind_group.zig");
const bind_group_layut = @import("bind_group_layout.zig");
const command_encoder = @import("command_encoder.zig");
const compute_pipeline = @import("compute_pipeline.zig");
const pipeline_layout = @import("pipeline_layout.zig");
const query = @import("query_set.zig");
const queue = @import("queue.zig");
const render_bundle = @import("render_bundle.zig");
const render_pipeline = @import("render_pipeline.zig");
const sampler = @import("sampler.zig");
const texture = @import("texture.zig");
const shader = @import("shader.zig");
const surface = @import("surface.zig");


pub const Device = opaque {
    
    pub const createBindGroup = wgpuDeviceCreateBindGroup;

    pub const createBindGroupLayout = wgpuDeviceCreateBindGroupLayout;

    pub const createBuffer = wgpuDeviceCreateBuffer;

    pub const createCommandEncoder = wgpuDeviceCreateCommandEncoder;

    pub const createComputePipeline = wgpuDeviceCreateComputePipeline;

    pub const createComputePipelineAsync = wgpuDeviceCreateComputePipelineAsync;

    pub const createPipelineLayout = wgpuDeviceCreatePipelineLayout;

    pub const createQuerySet = wgpuDeviceCreateQuerySet;

    pub const createRenderBundleEncoder = wgpuDeviceCreateRenderBundleEncoder;

    pub const createRenderPipeline = wgpuDeviceCreateRenderPipeline;

    pub const createRenderPipelineAsync = wgpuDeviceCreateRenderPipelineAsync;

    pub const createSampler = wgpuDeviceCreateSampler;

    pub const createShaderModule = wgpuDeviceCreateShaderModule;

    pub const createTexture = wgpuDeviceCreateTexture;

    pub const destroy = wgpuDeviceDestroy;

    pub const enumerateFeatures = wgpuDeviceEnumerateFeatures;

    pub const getLimits = wgpuDeviceGetLimits;

    pub const getQueue = wgpuDeviceGetQueue;

    pub const hasFeature = wgpuDeviceHasFeature;

    pub const getAdapter = wgpuDeviceGetAdapter;

    pub const popErrorScope = wgpuDevicePopErrorScope;

    pub const pushErrorScope = wgpuDevicePushErrorScope;

    pub const setDeviceLostCallback = wgpuDeviceSetDeviceLostCallback;

    pub const setLabel = wgpuDeviceSetLabel;

    pub const setUncapturedErrorCallback = wgpuDeviceSetUncapturedErrorCallback;

    pub const reference = wgpuDeviceReference;

    pub const release = wgpuDeviceRelease;
};

pub const CreatePipelineAsyncStatus = enum(u32) {
    success,
    instance_dropped,
    validation_error,
    internal_error,
    unknown
};

pub const DeviceDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
    required_features_count: usize = 0,
    required_features: ?[*]const support.FeatureName = null,
    required_limits: ?[*]const support.RequiredLimits = null,
    default_queue: queue.QueueDescriptor = .{},
    device_lost_callback: ?*const DeviceLostCallback = null,
    device_lost_user_data: ?*shared.UserData = null,
};

pub const DeviceError = error {
    Unavailable
};

pub const DeviceLostCallback = fn (*const Device, reason: DeviceLostReason,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const DeviceLostReason = enum(u32) {
    unknown,
    destroyed,
    instance_dropped,
    failed_creation
};

pub const ErrorFilter = enum(u32) {
    validation,
    out_of_memory,
    internal
};

pub const PopErrorScopeCallback = fn(status: PopErrorScopeStatus, type: shared.ErrorType,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const PopErrorScopeStatus = enum(u32) {
    success,
    instance_dropped,
    empty_stack
};

pub const UncapturedErrorCallback = fn (device: *const Device, type: shared.ErrorType,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;


extern fn wgpuDeviceCreateBindGroup(device: *Device,
    descriptor: *const bind_group.BindGroupDescriptor) *bind_group.BindGroup;

extern fn wgpuDeviceCreateBindGroupLayout(device: *Device,
    descriptor: *const bind_group_layut.BindGroupLayoutDescriptor) *bind_group_layut.BindGroupLayout;

extern fn wgpuDeviceCreateCommandEncoder(device: *Device,
    descriptor: ?*const command_encoder.CommandEncoderDescriptor) *command_encoder.CommandEncoder;

extern fn wgpuDeviceCreateBuffer(device: *Device,
    descriptor: *const buffer.BufferDescriptor) *buffer.Buffer;

extern fn wgpuDeviceCreateComputePipeline(device: *Device,
    descriptor: *const compute_pipeline.ComputePipelineDescriptor) *compute_pipeline.ComputePipeline;

extern fn wgpuDeviceCreateComputePipelineAsync(device: *Device,
    descriptor: *const compute_pipeline.ComputePipelineDescriptor,
    callback: *const compute_pipeline.CreateComputePipelineAsyncCallback,
    userdata: ?*shared.UserData) void;

extern fn wgpuDeviceCreatePipelineLayout(device: *Device,
    descriptor: *const pipeline_layout.PipelineLayoutDescriptor) *pipeline_layout.PipelineLayout;

extern fn wgpuDeviceCreateQuerySet(device: *Device,
    descriptor: *const query.QuerySetDescriptor) *query.QuerySet;

extern fn wgpuDeviceCreateRenderBundleEncoder(device: *Device,
    descriptor: *const render_bundle.RenderBundleEncoderDescriptor) *render_bundle.RenderBundle;

extern fn wgpuDeviceCreateRenderPipeline(device: *Device,
    descriptor: *const render_pipeline.RenderPipelineDescriptor) *render_pipeline.RenderPipeline;

extern fn wgpuDeviceCreateRenderPipelineAsync(device: *Device,
    descriptor: *const render_pipeline.RenderPipelineDescriptor,
    callback: render_pipeline.CreateRenderPipelineAsyncCallback,
    userdata: ?*shared.UserData) void;

extern fn wgpuDeviceCreateSampler(device: *Device,
    descriptor: *const sampler.SamplerDescriptor) *sampler.Sampler;

extern fn wgpuDeviceCreateShaderModule(device: *Device,
    descriptor: *const shader.ShaderModuleDescriptor) *shader.ShaderModule;

extern fn wgpuDeviceCreateTexture(device: *Device,
    descriptor: *const texture.TextureDescriptor) *texture.Texture;

extern fn wgpuDeviceDestroy(device: *Device) void;

extern fn wgpuDeviceEnumerateFeatures(device: *Device, features: ?[*]support.FeatureName) usize;

extern fn wgpuDeviceGetLimits(device: *Device, limits: *support.SupportedLimits) bool;

extern fn wgpuDeviceGetQueue(device: *Device) *queue.Queue;

extern fn wgpuDeviceHasFeature(device: *Device, feature: support.FeatureName) bool;

extern fn wgpuDeviceGetAdapter(device: *Device) *adapter.Adapter;

extern fn wgpuDevicePopErrorScope(device: *Device, callback: shared.ErrorCallback, userdata: ?*anyopaque) bool;

extern fn wgpuDevicePushErrorScope(device: *Device, filter: ErrorFilter) void;

extern fn wgpuDeviceSetDeviceLostCallback(device: *Device,
    callback: DeviceLostCallback, userdata: ?*shared.UserData) void;

extern fn wgpuDeviceSetLabel(device: *Device, label: ?shared.StringView) void;

extern fn wgpuDeviceSetUncapturedErrorCallback(device: *Device,
    callback: shared.ErrorCallback, userdata: ?*shared.UserData) void;

extern fn wgpuDeviceReference(device: *Device) void;

extern fn wgpuDeviceRelease(device: *Device) void;
