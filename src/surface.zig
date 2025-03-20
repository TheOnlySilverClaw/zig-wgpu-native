const shared = @import("shared.zig");
const texture = @import("texture.zig");
const adapter = @import("adapter.zig");
const device = @import("device.zig");

pub const Surface = opaque {

    pub const configure = wgpuSurfaceConfigure;

    pub const getCapabilities = wgpuSurfaceGetCapabilities;

    pub const getCurrentTexture = wgpuSurfaceGetCurrentTexture;

    pub const present = wgpuSurfacePresent;

    pub const unconfigure = wgpuSurfaceUnconfigure;

    pub const setLabel = wgpuSurfaceSetLabel;

    pub const addRef = wgpuSurfaceAddRef;

    pub const release = wgpuSurfaceRelease;
};

pub const CompositeAlphaMode = enum(u32) {
    auto,
    opaque_,
    premultiplied,
    unpremultiplied,
    inherit
};

pub const PresentMode = enum(u32) {
    undefined,
    fifo,
    fifo_relaxed,
    immediate,
    mailbox
};

pub const SurfaceCapabilities = extern struct {
    next: ?*shared.ChainedStructOut = null,
    usages: texture.TextureUsage,
    format_count: usize,
    formats: [*]const texture.TextureFormat,
    present_mode_count: usize,
    present_modes: [*]const PresentMode,
    alpha_mode_count: usize,
    alpha_modes: [*]const CompositeAlphaMode,

    pub const freeMembers = wgpuSurfaceCapabilitiesFreeMembers;
};

pub const SurfaceConfiguration = extern struct {
    next: ?*const shared.ChainedStruct = null,
    device: *device.Device,
    format: texture.TextureFormat,
    usage: texture.TextureUsage,
    width: u32,
    height: u32,
    view_format_count: usize,
    view_formats: ?[*]const texture.TextureFormat,
    alpha_mode: CompositeAlphaMode,
    present_mode: PresentMode
};


pub const SurfaceDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null
};

pub const SurfaceGetCurrentTextureStatus = enum(u32) {
    success_optimal = 1,
    success_suboptimal,
    timeout,
    outdated,
    lost,
    out_of_memory,
    device_lost,
    @"error"
};

pub const SurfaceTexture = extern struct {
    next: ?*const shared.ChainedStruct = null,
    texture: *texture.Texture,
    status: SurfaceGetCurrentTextureStatus  
};


extern fn wgpuSurfaceConfigure(surface: *Surface, configuration: *const SurfaceConfiguration) void;

extern fn wgpuSurfaceGetCapabilities(surface: *Surface, surface_adapter: *adapter.Adapter, capabilities: *SurfaceCapabilities) shared.Status;

extern fn wgpuSurfaceGetCurrentTexture(surface: *Surface, surface_texture: *SurfaceTexture) void;

extern fn wgpuSurfacePresent(surface: *Surface) shared.Status;

extern fn wgpuSurfaceSetLabel(surface: *Surface, label: shared.StringView) void;

extern fn wgpuSurfaceUnconfigure(surface: *Surface) void;

extern fn wgpuSurfaceAddRef(surface: *Surface) void;

extern fn wgpuSurfaceRelease(surface: *Surface) void;

extern fn wgpuSurfaceCapabilitiesFreeMembers(capabilities: SurfaceCapabilities) void;