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

    pub const reference = wgpuSurfaceReference;

    pub const release = wgpuSurfaceRelease;
};


pub const PresentMode = enum(u32) {
    immediate,
    mailbox,
    fifo,
};

pub const SurfaceCapabilities = extern struct {
    next: ?*const shared.ChainedStruct = null,
    usages: texture.TextureUsage,
    format_count: usize,
    formats: [*]const texture.TextureFormat,
    present_mode_count: usize,
    present_modes: [*]const PresentMode,
    alpha_mode_count: usize,
    alpha_modes: [*]const texture.AlphaMode
};

pub const SurfaceConfiguration = extern struct {
    next: ?*const shared.ChainedStruct = null,
    device: *device.Device,
    format: texture.TextureFormat,
    usage: texture.TextureUsage,
    view_format_count: usize,
    view_formats: ?[*]const texture.TextureFormat,
    alpha_mode: texture.AlphaMode,
    width: u32,
    height: u32,
    present_mode: PresentMode
};


pub const SurfaceDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null
};

pub const SurfaceGetCurrentTextureStatus = enum(u32) {
    success,
    timeout,
    outdated,
    lost,
    memory,
    device_lost
};

pub const SurfaceTexture = extern struct {
    texture: *texture.Texture,
    suboptimal: bool,
    status: SurfaceGetCurrentTextureStatus  
};


extern fn wgpuSurfaceConfigure(surface: *Surface, configuration: *const SurfaceConfiguration) void;

extern fn wgpuSurfaceGetCapabilities(surface: *Surface, surface_adapter: *adapter.Adapter, capabilities: *const SurfaceCapabilities) void;

extern fn wgpuSurfaceGetCurrentTexture(surface: *Surface, surface_texture: *const SurfaceTexture) void;

extern fn wgpuSurfacePresent(surface: *Surface) void;

extern fn wgpuSurfaceSetLabel(surface: *Surface, label: [*:0]const u8) void;

extern fn wgpuSurfaceUnconfigure(surface: *Surface) void;

extern fn wgpuSurfaceReference(surface: *Surface) void;

extern fn wgpuSurfaceRelease(surface: *Surface) void;