const shared = @import("shared.zig");
const texture = @import("texture.zig");
const texture_view = @import("texture_view.zig");

pub const BindGroupLayout = opaque {

    pub const setLabel = wgpuBindGroupLayoutSetLabel;

    pub const reference = wgpuBindGroupLayoutReference;

    pub const release = wgpuBindGroupLayoutRelease;
};

pub const BindGroupLayoutDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    entry_count: usize,
    entries: ?[*]const BindGroupLayoutEntry,
};

pub const BindGroupLayoutEntry = extern struct {
    next: ?*const shared.ChainedStruct = null,
    binding: u32,
    visibility: ShaderStage,
    buffer: BufferBindingLayout = .{ .type = .binding_not_used },
    sampler: SamplerBindingLayout = .{ .type = .binding_not_used },
    texture: TextureBindingLayout = .{
        .type = .undefined,
        .view_dimension = .@"2d",
        .multisampled = false
    },
    storage_texture: StorageTextureBindingLayout = .{
        .access = .binding_not_used,
        .format = .undefined,
        .view_dimension = .@"2d"
    }
};

pub const BufferBindingLayout = extern struct {
    next: ?*const shared.ChainedStruct = null,
    type: BufferBindingType = .uniform,
    has_dynamic_offset: bool = false,
    min_binding_size: u64 = 0,
};

pub const BufferBindingType = enum(u32) {
    binding_not_used,
    undefined,
    uniform,
    storage,
    read_only_storage
};

pub const SamplerBindingType = enum(u32) {
    binding_not_used,
    undefined,
    filtering,
    non_filtering,
    comparison
};

pub const ShaderStage = packed struct(u64) {
    vertex: bool = false,
    fragment: bool = false,
    compute: bool = false,
    _padding: u61 = 0,
};

pub const StorageTextureAccess = enum(u32) {
    binding_not_used,
    undefined,
    write_only,
    read_only,
    read_write
};

pub const StorageTextureBindingLayout = extern struct {
    next: ?*const shared.ChainedStruct = null,
    access: StorageTextureAccess,
    format: texture.TextureFormat,
    view_dimension: texture_view.TextureViewDimension
};

pub const TextureSampleType = enum(u32) {
    binding_not_used,
    undefined,
    float,
    unfilterable_float,
    depth,
    sint,
    uint
};

pub const SamplerBindingLayout = extern struct {
    next: ?*const shared.ChainedStruct = null,
    type: SamplerBindingType = .filtering
};

pub const TextureBindingLayout = extern struct {
    next: ?*const shared.ChainedStruct = null,
    type: TextureSampleType,
    view_dimension: texture_view.TextureViewDimension,
    multisampled: bool
};


extern fn wgpuBindGroupLayoutSetLabel(layout: *BindGroupLayout, label: ?[*:0]const u8) void;

extern fn wgpuBindGroupLayoutReference(layout: *BindGroupLayout) void;

extern fn wgpuBindGroupLayoutRelease(layout: *BindGroupLayout) void;
