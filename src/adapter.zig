const device = @import("device.zig");
const shared = @import("shared.zig");
const support = @import("support.zig");
const surface = @import("surface.zig");

pub const Error = error {
    Unavailable
};

pub const Adapter = opaque {

    pub const enumerateFeatures = wgpuAdapterEnumerateFeatures;

    pub const getLimits = wgpuAdapterGetLimits;

    pub const getInfo = wgpuAdapterGetInfo;

    pub const hasFeature = wgpuAdapterHasFeature;

    pub const requestDevice = wgpuAdapterRequestDevice;

    pub fn requestDeviceSync(adapter: *Adapter, descriptor: ?*const device.DeviceDescriptor) device.DeviceError!*device.Device {

        var result: ?*device.Device = null;
        wgpuAdapterRequestDevice(adapter, descriptor, deviceCallback, @ptrCast(&result), null);
        return result orelse device.DeviceError.Unavailable;
    }

    fn deviceCallback(status: RequestDeviceStatus, received: ?*device.Device,
        message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void {
        
        // TODO figure out how to handle the message
        _ = message;
        _ = userdata2;

        if(status == .success and received != null and userdata1 != null) {
            const result = @as(**device.Device, @alignCast(@ptrCast(userdata1)));
            result.* = received.?;
        }
    }

    pub const reference = wgpuAdapterReference;

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
};

pub const AdapterType = enum(u32) {
    discrete_gpu,
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
    undefined,
    low_power,
    high_performance
};

pub const RequestDeviceCallback = fn (status: RequestDeviceStatus, device: *device.Device,
    message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const RequestDeviceCallbackInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    mode: shared.CallbackMode,
    callback: *const RequestDeviceCallback,
    userdata1: ?*shared.UserData,
    userdata2: ?*shared.UserData
};

pub const RequestDeviceStatus = enum(u32) {
    success,
    instance_dropped,
    @"error",
    unknown
};


extern fn wgpuAdapterCreateDevice(adapter: *Adapter, descriptor: *const device.DeviceDescriptor) device.Device;

extern fn wgpuAdapterEnumerateFeatures(adapter: *Adapter, features: ?[*]support.FeatureName) usize;

extern fn wgpuAdapterGetLimits(adapter: *Adapter, limits: *support.SupportedLimits) bool;

extern fn wgpuAdapterGetInfo(adapter: *Adapter, properties: *AdapterInfo) void;

extern fn wgpuAdapterHasFeature(adapter: *Adapter, feature: support.FeatureName) bool;

extern fn wgpuAdapterRequestDevice(adapter: *Adapter, descriptor: ?*const device.DeviceDescriptor,
    callback: *const RequestDeviceCallback, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) void;

extern fn wgpuAdapterReference(adapter: *Adapter) void;

extern fn wgpuAdapterRelease(adapter: *Adapter) void;
