const shared = @import("shared.zig");
const adapter = @import("adapter.zig");
const surface = @import("surface.zig");

pub const createInstance = wgpuCreateInstance;

pub const Instance = opaque {

    pub const create = wgpuCreateInstance;

    pub const createSurface = wgpuInstanceCreateSurface;

    pub const requestAdapterAsync = wgpuInstanceRequestAdapter;

    pub fn requestAdapterSync(instance: *Instance, options: *const RequestAdapterOptions) !*adapter.Adapter {

        var result: ?*adapter.Adapter = null;
        wgpuInstanceRequestAdapter(instance, options, adapterCallback, @ptrCast(&result));
        return result orelse adapter.Error.Unavailable;
    }

    fn adapterCallback(status: RequestAdapterStatus, received: ?*adapter.Adapter,
        message: ?[*:0]const u8, userdata: ?shared.UserData) callconv(.C) void {
        
        // TODO figure out how to handle the message
        _ = message;

        if(status == .success and received != null and userdata != null) {
            const result = @as(**adapter.Adapter, @alignCast(@ptrCast(userdata)));
            result.* = received.?;
        }
    }

    pub const reference = wgpuInstanceReference;

    pub const release = wgpuInstanceRelease;
};

pub const InstanceDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null
};

pub const RequestAdapterCallback = *const fn (
    status: RequestAdapterStatus,
    adapter: ?*adapter.Adapter,
    message: ?[*:0]const u8,
    userdata: ?*anyopaque
) callconv(.C) void;

pub const RequestAdapterOptions = extern struct {
    next: ?*const shared.ChainedStruct = null,
    compatible_surface: ?*surface.Surface,
    power_preference: adapter.PowerPreference,
    backend_type: adapter.BackendType = .undefined,
    force_fallback_adapter: bool = false,
};

pub const RequestAdapterResult = struct {
    adapter: ?*adapter.Adapter,
    message: ?[*:0]const u8,
    status: RequestAdapterStatus
};

pub const RequestAdapterStatus = enum(u32) {
    success,
    unavailable,
    failure,
    unknown
};

extern fn wgpuCreateInstance(descriptor: ?* const InstanceDescriptor) *Instance;

extern fn wgpuInstanceCreateSurface(instance: *Instance,
    descriptor: *const surface.SurfaceDescriptor) *surface.Surface;

extern fn wgpuInstanceRequestAdapter(instance: *Instance,
    options: *const RequestAdapterOptions, callback: RequestAdapterCallback, userdata: ?shared.UserData) void;

extern fn wgpuInstanceReference(instance: *Instance) void;

extern fn wgpuInstanceRelease(instance: *Instance) void;