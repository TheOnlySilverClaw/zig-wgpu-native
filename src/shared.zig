const maxInt = @import("std").math.maxInt;

pub const size_max = maxInt(isize);

pub const undefined_u32 = maxInt(u32);
pub const undefined_u64 = maxInt(u64);

pub const Bool = u32;

pub const OptionalBool = enum(u32) {
    false,
    true,
    undefined
};

pub const UserData = *anyopaque;

pub const CallbackMode = enum (u32) {
    wait_only,
    allow_process_events,
    allow_spontaneous
};

pub const CompareFunction = enum(u32) {
    undefined,
    never,
    less,
    less_equal,
    greater,
    greater_equal,
    equal,
    not_equal,
    always
};

pub const ConstantEntry = extern struct {
    next: ?*const ChainedStruct = null,
    key: [*:0]const u8,
    value: f64,
};

pub const ChainedStruct = extern struct {
    next: ?*const ChainedStruct = null,
    type: SType,
};

pub const ChainedStructOut = extern struct {
    next: ?*ChainedStructOut,
    type: SType
};

pub const Color = extern struct {
    r: f64,
    g: f64,
    b: f64,
    a: f64,
};

pub const ErrorCallback = *const fn (
    type: ErrorType,
    message: ?[*:0]const u8,
    userdata: ?*anyopaque,
) callconv(.C) void;

pub const ErrorType = enum(u32) {
    no_error,
    validation,
    out_of_memory,
    internal,
    unknown
};

pub const Extent3D = extern struct {
    width: u32,
    height: u32,
    depth: u32 = 1
};

pub const Origin3D = extern struct {
    x: u32 = 0,
    y: u32 = 0,
    z: u32 = 0
};

pub const Status = enum (u32) {
    success,
    @"error"
};

pub const StringView = struct {
    data: ?[*]const u8,
    length: usize,

    pub const NULL = StringView {
        .data = null,
        .length = size_max
    };
};

pub const SType = enum(u32) {
    shader_source_spirv,
    shader_source_wgsl,
    render_pass_max_draw_count,
    surface_source_metal_layer,
    surface_source_windows_hwnd,
    surface_source_xlib_window,
    surface_source_wayland_surface,
    surface_source_android_native_window,
    surface_source_xcb_window
};

