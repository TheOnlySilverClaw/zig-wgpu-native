const device = @import("device.zig");
const shared = @import("shared.zig");
const support = @import("support.zig");
const surface = @import("surface.zig");


pub const Adapter = opaque {

    pub const enumerateFeatures = wgpuAdapterEnumerateFeatures;

    pub const getFeatures = wgpuAdapterGetFeatures;

    pub const getLimits = wgpuAdapterGetLimits;

    pub const getInfo = wgpuAdapterGetInfo;

    pub const hasFeature = wgpuAdapterHasFeature;

    pub const requestDevice = wgpuAdapterRequestDevice;

    pub fn awaitDevice(adapter: *Adapter, descriptor: ?*const device.DeviceDescriptor) error{DeviceUnavailable}!*device.Device {

        var result: ?*device.Device = null;
        const callback_info = RequestDeviceCallbackInfo {
            .mode = .wait_any_only,
            .callback = deviceCallback,
            .userdata1 = @ptrCast(&result),
            .userdata2 = null
        };
        // ignore the future, I guess?
        _ = wgpuAdapterRequestDevice(adapter, descriptor, callback_info);
        
        return result orelse error.DeviceUnavailable;
    }

    fn deviceCallback(status: RequestDeviceStatus, received: ?*device.Device,
        message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.c) void {
        
        // TODO figure out how to handle the message
        if(message.data) |d| {
            @import("std").log.info("device callback message: {s}", .{ d[0..message.length ] });
        }

        _ = userdata2;

        if(status == .success and received != null and userdata1 != null) {
            const result = @as(**device.Device, @alignCast(@ptrCast(userdata1)));
            result.* = received.?;
        }
    }

    pub const addRef = wgpuAdapterAddRef;

    pub const release = wgpuAdapterRelease;
};

pub const AdapterInfo = extern struct {
    next: ?*shared.ChainedStructOut = null,
    vendor: shared.StringView,
    architecture: shared.StringView,
    device: shared.StringView,
    description: shared.StringView,
    backend_type: BackendType,
    adapter_type: AdapterType,
    vendor_id: u32,
    device_id: u32,

    pub const freeMembers = wgpuAdapterInfoFreeMembers;
};

pub const AdapterType = enum(u32) {
    discrete_gpu = 1,
    integrated_gpu,
    cpu,
    unknown,
};

pub const BackendType = enum(u32) {
    undefined,
    null,
    webgpu,
    d3d11,
    d3d12,
    metal,
    vulkan,
    opengl,
    opengles,
};

pub const PowerPreference = enum(u32) {
    none,
    low_power,
    high_performance
};

pub const RequestDeviceCallback = fn (status: RequestDeviceStatus, device: ?*device.Device,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.c) void;

pub const RequestDeviceCallbackInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    mode: shared.CallbackMode,
    callback: *const RequestDeviceCallback,
    userdata1: ?*shared.UserData,
    userdata2: ?*shared.UserData
};

pub const RequestDeviceStatus = enum(u32) {
    success = 1,
    instance_dropped,
    @"error",
    unknown
};


extern fn wgpuAdapterGetFeatures(adapter: *Adapter, features: *support.SupportedFeatures) void;

extern fn wgpuAdapterCreateDevice(adapter: *Adapter, descriptor: *const device.DeviceDescriptor) device.Device;

extern fn wgpuAdapterEnumerateFeatures(adapter: *Adapter, features: ?[*]support.FeatureName) usize;

extern fn wgpuAdapterGetLimits(adapter: *Adapter, limits: *support.Limits) shared.Bool;

extern fn wgpuAdapterGetInfo(adapter: *Adapter, properties: *AdapterInfo) void;

extern fn wgpuAdapterHasFeature(adapter: *Adapter, feature: support.FeatureName) shared.Bool;

extern fn wgpuAdapterRequestDevice(adapter: *Adapter, descriptor: ?*const device.DeviceDescriptor, callback_info: RequestDeviceCallbackInfo) shared.Future;

extern fn wgpuAdapterAddRef(adapter: *Adapter) void;

extern fn wgpuAdapterRelease(adapter: *Adapter) void;

extern fn wgpuAdapterInfoFreeMembers(adapter_info: *AdapterInfo) void;
