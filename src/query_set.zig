const shared = @import("shared.zig");

pub const QuerySet = opaque {
    
    pub const destroy = wgpuQuerySetDestroy;

    pub const getCount = wgpuQuerySetGetCount;

    pub const getType = wgpuQuerySetGetType;

    pub const setLabel = wgpuQuerySetSetLabel;

    pub const addRef = wgpuQuerySetGetCount;

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
    type: QueryType,
    count: u32
};


extern fn wgpuQuerySetDestroy(query_set: *QuerySet) void;

extern fn wgpuQuerySetGetType(query_set: *QuerySet) QueryType;

extern fn wgpuQuerySetSetLabel(query_set: *QuerySet, label: ?shared.StringView) void;

extern fn wgpuQuerySetGetCount(query_set: *QuerySet) void;

extern fn wgpuQuerySetRelease(query_set: *QuerySet) void;
