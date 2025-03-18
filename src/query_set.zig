const shared = @import("shared.zig");

pub const QuerySet = opaque {
    
    pub const destroy = wgpuQuerySetDestroy;

    pub const setLabel = wgpuQuerySetSetLabel;

    pub const reference = wgpuQuerySetReference;

    pub const release = wgpuQuerySetRelease;
};

pub const PipelineStatisticName = enum(u32) {
    vertex_shader_invocations,
    clipper_invocations,
    clipper_primitives_out,
    fragment_shader_invocations,
    compute_shader_invocations,
};

pub const QueryType = enum(u32) {
    occlusion,
    timestamp
};

pub const QuerySetDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
    query_type: QueryType,
    count: u32,
    pipeline_statistics: ?[*]const PipelineStatisticName,
    pipeline_statistics_count: usize,
};

extern fn wgpuQuerySetDestroy(query_set: *QuerySet) void;

extern fn wgpuQuerySetSetLabel(query_set: *QuerySet, label: ?shared.StringView) void;

extern fn wgpuQuerySetReference(query_set: *QuerySet) void;

extern fn wgpuQuerySetRelease(query_set: *QuerySet) void;
