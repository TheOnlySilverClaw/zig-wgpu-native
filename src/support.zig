const shared = @import("shared.zig");

const maxInt = @import("std").math.maxInt;

pub const FeatureLevel = enum(u32) {
    undefined,
    compatibility,
    core
};

pub const FeatureName = enum(u32) {
    depth_clip_control = 1,
    depth32_float_stencil8,
    timestamp_query,
    texture_compression_bc,
    texture_compression_bc_sliced_3d,
    texture_compression_etc2,
    texture_compression_astc,
    texture_compression_astc_sliced_3d,
    indirect_first_instance,
    shader_f16,
    rg11_b10_ufloat_renderable,
    bgra8_unorm_storage,
    float32_filterable,
    float32_blendable,
    clip_distances,
    dual_source_blending
};

pub const Limits = extern struct {
    max_texture_dimension_1d: u32 = maxInt(u32),
    max_texture_dimension_2d: u32 = maxInt(u32),
    max_texture_dimension_3d: u32 = maxInt(u32),
    max_texture_array_layers: u32 = maxInt(u32),
    max_bind_groups: u32 = maxInt(u32),
    max_bind_groups_plus_vertex_buffers: u32 = maxInt(u32),
    max_bindings_per_bind_group: u32 = maxInt(u32),
    max_dynamic_uniform_buffers_per_pipeline_layout: u32 = maxInt(u32),
    max_dynamic_storage_buffers_per_pipeline_layout: u32 = maxInt(u32),
    max_sampled_textures_per_shader_stage: u32 = maxInt(u32),
    max_samplers_per_shader_stage: u32 = maxInt(u32),
    max_storage_buffers_per_shader_stage: u32 = maxInt(u32),
    max_storage_textures_per_shader_stage: u32 = maxInt(u32),
    max_uniform_buffers_per_shader_stage: u32 = maxInt(u32),
    max_uniform_buffer_binding_size: u64 = maxInt(u64),
    max_storage_buffer_binding_size: u64 = maxInt(u64),
    min_uniform_buffer_offset_alignment: u32 = maxInt(u32),
    min_storage_buffer_offset_alignment: u32 = maxInt(u32),
    max_vertex_buffers: u32 = maxInt(u32),
    max_buffer_size: u64 = maxInt(u64),
    max_vertex_attributes: u32 = maxInt(u32),
    max_vertex_buffer_array_stride: u32 = maxInt(u32),
    max_inter_stage_shader_variables: u32 = maxInt(u32),
    max_color_attachments: u32 = maxInt(u32),
    max_color_attachment_bytes_per_sample: u32 = maxInt(u32),
    max_compute_workgroup_storage_size: u32 = maxInt(u32),
    max_compute_invocations_per_workgroup: u32 = maxInt(u32),
    max_compute_workgroup_size_x: u32 = maxInt(u32),
    max_compute_workgroup_size_y: u32 = maxInt(u32),
    max_compute_workgroup_size_z: u32 = maxInt(u32),
    max_compute_workgroups_per_dimension: u32 = maxInt(u32)
};


pub const RequiredLimits = extern struct {
    next: ?*const shared.ChainedStruct = null,
    limits: Limits = .{},
};

pub const SupportedFeatures = extern struct {
    next: ?*shared.ChainedStructOut = null,
    feature_count: usize,
    features: [*]FeatureName,

    pub const freeMemvers = wgpuSupportedFeaturesFreeMembers;
};

pub const SupportedWGSLLanguageFeatures = extern struct {
    next: ?*shared.ChainedStructOut = null,
    feature_count: usize,
    features: [*]WGSLLanguageFeatureName,

    pub const freeMembers = wgpuSupportedWGSLLanguageFeaturesFreeMembers;
};

pub const WGSLLanguageFeatureName = enum(u32) {
    readonly_and_readwrite_storage_textures = 1,
    packed_4x8_integer_dot_product,
    unrestricted_pointer_parameters,
    pointer_composite_access
};


extern fn wgpuSupportedFeaturesFreeMembers(features: SupportedFeatures) void;

extern fn wgpuSupportedWGSLLanguageFeaturesFreeMembers(features: SupportedWGSLLanguageFeatures) void;