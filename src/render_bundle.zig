const shared = @import("shared.zig");

pub const RenderBundle = opaque {
    
    pub const setLabel = wgpuRenderBundleSetLabel;

    pub const reference = wgpuRenderBundleReference;

    pub const release = wgpuRenderBundleRelease;
};

pub const RenderBundleDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView
};


extern fn wgpuRenderBundleSetLabel(bundle: *RenderBundle, label: ?[*:0]const u8) void;

extern fn wgpuRenderBundleReference(bundle: *RenderBundle) void;

extern fn wgpuRenderBundleRelease(bundle: *RenderBundle) void;
