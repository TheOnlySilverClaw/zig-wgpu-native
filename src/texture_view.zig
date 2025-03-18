const shared = @import("shared.zig");
const texture = @import("texture.zig");


pub const TextureView = opaque {
    
    pub const setLabel = wgpuTextureViewSetLabel;

    pub const reference = wgpuTextureViewReference;

    pub const release = wgpuTextureViewRelease;
};


pub const TextureViewDimension = enum(u32) {
    undefined,
    @"1d",
    @"2d",
    @"2d_array",
    cube,
    cube_array,
    @"3d"
};

pub const TextureViewDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView,
    format: texture.TextureFormat,
    dimension: TextureViewDimension,
    base_mip_level: u32 = 0,
    mip_level_count: u32 = 1,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = 1,
    aspect: texture.TextureAspect = .all,
    usage: texture.TextureUsage
};


extern fn wgpuTextureViewSetLabel(texture_view: *TextureView, label: ?shared.StringView) void;

extern fn wgpuTextureViewReference(texture_view: *TextureView) void;

extern fn wgpuTextureViewRelease(texture_view: *TextureView) void;
