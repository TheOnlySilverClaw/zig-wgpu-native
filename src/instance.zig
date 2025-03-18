const shared = @import("shared.zig");
const adapter = @import("adapter.zig");
const surface = @import("surface.zig");
const support = @import("support.zig");

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
        message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void {

        // TODO figure out how to handle the message
        _ = message;
        _ = userdata2;

        if(status == .success and received != null and userdata1 != null) {
            const result = @as(**adapter.Adapter, @alignCast(@ptrCast(userdata1)));
            result.* = received.?;
        }
    }

    pub const reference = wgpuInstanceReference;

    pub const release = wgpuInstanceRelease;
};

pub const InstanceDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null
};

pub const RequestAdapterCallback = fn (status: RequestAdapterStatus, adapter: ?*adapter.Adapter,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const RequestAdapterOptions = extern struct {
    next: ?*const shared.ChainedStruct = null,
    feature_level: support.FeatureLevel,
    power_preference: adapter.PowerPreference,
    force_fallback_adapter: shared.Bool = 0,
    backend_type: adapter.BackendType = .undefined,
    compatible_surface: ?*surface.Surface,
};

pub const RequestAdapterResult = struct {
    adapter: ?*adapter.Adapter,
    message: shared.StringView,
    status: RequestAdapterStatus
};

pub const RequestAdapterStatus = enum(u32) {
    success,
    unavailable,
    failure,
    unknown
};

pub const WaitStatus = enum(u32) {
    success,
    timed_out,
    unsupported_timeout,
    unsupported_count,
    unsupported_mixed_sources
};

extern fn wgpuCreateInstance(descriptor: ?* const InstanceDescriptor) *Instance;

extern fn wgpuInstanceCreateSurface(instance: *Instance,
    descriptor: *const surface.SurfaceDescriptor) *surface.Surface;

extern fn wgpuInstanceRequestAdapter(instance: *Instance,
    options: *const RequestAdapterOptions, callback: *const RequestAdapterCallback, userdata: ?*shared.UserData) void;

extern fn wgpuInstanceReference(instance: *Instance) void;

extern fn wgpuInstanceRelease(instance: *Instance) void;
