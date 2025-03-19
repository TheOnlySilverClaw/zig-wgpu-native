const shared = @import("shared.zig");
const bind_group_layout = @import("bind_group_layout.zig");

pub const PipelineLayout = opaque {
    
    pub const setLabel = wgpuPipelineLayoutSetLabel;

    pub const addRef = wgpuPipelineLayoutAddRef;

    pub const release = wgpuPipelineLayoutRelease;
};

pub const PipelineLayoutDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
    bind_group_layout_count: usize,
    bind_group_layouts: ?[*]const *bind_group_layout.BindGroupLayout,
};


extern fn wgpuPipelineLayoutSetLabel(layout: *PipelineLayout, label: ?[*:0]const u8) void;

extern fn wgpuPipelineLayoutAddRef(layout: *PipelineLayout) void;

extern fn wgpuPipelineLayoutRelease(layout: *PipelineLayout) void;
