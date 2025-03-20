const shared = @import("shared.zig");
const adapter = @import("adapter.zig");
const surface = @import("surface.zig");
const support = @import("support.zig");


pub const getInstanceCapabilities = wgpuGetInstanceCapabilities;

pub const Instance = opaque {

    pub const create = wgpuCreateInstance;

    pub const createSurface = wgpuInstanceCreateSurface;
    
    pub const getWGSLLanguageFeatures = wgpuInstanceGetWGSLLanguageFeatures;

    pub const hasWGSLLanguageFeature = wgpuInstanceHasWGSLLanguageFeature;

    pub const processEvents = wgpuInstanceProcessEvents;

    pub const requestAdapterAsync = wgpuInstanceRequestAdapter;

    pub fn awaitAdapter(instance: *Instance, options: ?*const RequestAdapterOptions) !*adapter.Adapter {

        var result: ?*adapter.Adapter = null;
        const callback_info = RequestAdapterCallbackInfo {
            .mode = .wait_any_only,
            .callback = adapterCallback,
            .userdata1 = @ptrCast(&result),
            .userdata2 = null
        };
        // ignore the future, I guess?
        _ = wgpuInstanceRequestAdapter(instance, options, callback_info);
        
        return result orelse adapter.Error.Unavailable;
    }

    fn adapterCallback(status: RequestAdapterStatus, received: ?*adapter.Adapter,
        message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void {

        // TODO figure out how to handle the message
        if(message.data) |d| {
            @import("std").log.info("adapter callback message: {s}", .{ d[0..message.length ] });
        }

        _ = userdata2;

        if(status == .success and received != null and userdata1 != null) {
            const result = @as(**adapter.Adapter, @alignCast(@ptrCast(userdata1)));
            result.* = received.?;
        }
    }

    pub const waitAny = wgpuInstanceWaitAny;
    
    pub const addRef = wgpuInstanceAddRef;

    pub const release = wgpuInstanceRelease;
};

pub const InstanceCapabilities = extern struct {
    next: ?*const shared.ChainedStruct = null,
    timed_wait_any_enabled: shared.Bool,
    timed_wait_any_max_count: usize
};

pub const InstanceDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    features: InstanceCapabilities
};

pub const RequestAdapterCallback = fn (status: RequestAdapterStatus, adapter: ?*adapter.Adapter,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const RequestAdapterCallbackInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    mode: shared.CallbackMode,
    callback: *const RequestAdapterCallback,
    userdata1: ?*shared.UserData,
    userdata2: ?*shared.UserData
};

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
    success = 1,
    unavailable,
    failure,
    unknown
};

pub const WaitStatus = enum(u32) {
    success = 1,
    timed_out,
    unsupported_timeout,
    unsupported_count,
    unsupported_mixed_sources
};


extern fn wgpuGetInstanceCapabilities(capabilities: *InstanceCapabilities) shared.Status;

extern fn wgpuCreateInstance(descriptor: ?*const InstanceDescriptor) *Instance;

extern fn wgpuInstanceCreateSurface(instance: *Instance, descriptor: *const surface.SurfaceDescriptor) *surface.Surface;

extern fn wgpuInstanceGetWGSLLanguageFeatures(instance: *Instance, features: *support.SupportedWGSLLanguageFeatures) shared.Status;

extern fn wgpuInstanceHasWGSLLanguageFeature(instance: *Instance, feature: support.WGSLLanguageFeatureName) shared.Bool;

extern fn wgpuInstanceProcessEvents(instance: *Instance) void;

extern fn wgpuInstanceRequestAdapter(instance: *Instance,
    options: ?*const RequestAdapterOptions,
    callback_info: RequestAdapterCallbackInfo) shared.Future;

extern fn wgpuInstanceWaitAny(instance: *Instance, future_count: usize, futures: ?[*]shared.FutureWaitInfo, timeout_ns: u64) WaitStatus;

extern fn wgpuInstanceAddRef(instance: *Instance) void;

extern fn wgpuInstanceRelease(instance: *Instance) void;
