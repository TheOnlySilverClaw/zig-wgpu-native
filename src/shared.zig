const maxInt = @import("std").math.maxInt;

pub const undefined_u32 = maxInt(u32);
pub const undefined_u64 = maxInt(u64);

pub const Bool = u32;

pub const OptionalBool = enum(u32) {
    false,
    true,
    undefined
};

pub const UserData = anyopaque;

pub const CallbackMode = enum (u32) {
    wait_any_only = 1,
    allow_process_events = 2,
    allow_spontaneous = 3
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
    key: StringView,
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
    depth_or_array_layers: u32 = 1
};

pub const Future = extern struct {
    id: u64
};

pub const FutureWaitInfo = extern struct {
    future: Future,
    completed: Bool = 0
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

pub const StringView = extern struct {
    data: ?[*]const u8 = null,
    length: usize = maxInt(usize),

    pub const empty = StringView{ .data = null, .length = 0 };

    pub fn sized(slice: []const u8) StringView {
        return .{ .data = slice.ptr, .length = slice.len };
    }

    pub fn terminated(pointer: StringView) StringView {
        return .{ .data = pointer, .length = maxInt(usize) };
    }
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

