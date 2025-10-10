const shared = @import("shared.zig");
const texture = @import("texture.zig");

pub const Buffer = opaque {

    // `offset` has to be a multiple of 8 (otherwise `null` will be returned).
    // `@sizeOf(T) * len` has to be a multiple of 4 (otherwise `null` will be returned).
    pub fn getConstMappedRange(buffer: *Buffer, comptime T: type, offset: usize, len: usize) ?[]const T {
        
        if (len == 0) return null;

        const ptr = wgpuBufferGetConstMappedRange(buffer, offset, @sizeOf(T) * len);
        if (ptr == null) return null;

        return @as([*]const T, @ptrCast(@alignCast(ptr)))[0..len];
    }

    // `offset` has to be a multiple of 8 (otherwise `null` will be returned).
    // `@sizeOf(T) * len` has to be a multiple of 4 (otherwise `null` will be returned).
    pub fn getMappedRange(buffer: *Buffer, comptime T: type, offset: usize, len: usize) ?[]T {
        
        if (len == 0) return null;

        const ptr = wgpuBufferGetMappedRange(buffer, offset, @sizeOf(T) * len);
        if (ptr == null) return null;

        return @as([*]T, @ptrCast(@alignCast(ptr)))[0..len];
    }

    pub const getMapState = wgpuBufferGetMapState;

    pub const getUsage = wgpuBufferGetUsage;

    pub const size = wgpuBufferGetSize;

    // `offset` has to be a multiple of 8
    // `size` has to be a multiple of 4
    // `size == 0` will map entire range (from 'offset' to the end of the buffer)
    pub const mapAsync = wgpuBufferMapAsync;

    pub const setLabel = wgpuBufferSetLabel;

    pub const unmap = wgpuBufferUnmap;

    pub const addRef = wgpuBufferAddRef;

    pub const release = wgpuBufferRelease;

    pub const destroy = wgpuBufferDestroy;
};

pub const BufferDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
    usage: BufferUsage, size: u64,
    mapped_at_creation: u32 = 0
};

pub const MapAsyncStatus = enum(u32) {
    success = 1,
    instance_dropped,
    @"error",
    aborted,
    unknown
};

pub const BufferMapCallback = fn (status: MapAsyncStatus, message: shared.StringView, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.c) void;

pub const BufferMapCallbackInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    mode: shared.CallbackMode,
    callback: *const BufferMapCallback,
    userdata1: ?*shared.UserData,
    userdata2: ?*shared.UserData
};

pub const BufferMapState = enum(u32) {
    unmapped = 1,
    pending,
    mapped
};

pub const BufferUsage = packed struct(u64) {
    map_read: bool = false,
    map_write: bool = false,
    copy_src: bool = false,
    copy_dst: bool = false,
    index: bool = false,
    vertex: bool = false,
    uniform: bool = false,
    storage: bool = false,
    indirect: bool = false,
    query_resolve: bool = false,
    _padding: u54 = 0
};

pub const MapMode = packed struct(u64) {
    read: bool = false,
    write: bool = false,
    _padding: u62 = 0
};

pub const IndexFormat = enum(u32) {
    undefined,
    uint16,
    uint32
};


extern fn wgpuBufferMapAsync(buffer: *Buffer, mode: MapMode, offset: usize, size: usize, callback: BufferMapCallbackInfo) shared.Future;

extern fn wgpuBufferGetConstMappedRange(buffer: *Buffer, offset: usize, size: usize) ?*const anyopaque;

extern fn wgpuBufferGetMappedRange(buffer: *Buffer, offset: usize, size: usize) ?*anyopaque;

extern fn wgpuBufferGetMapState(buffer: *Buffer) BufferMapState;

extern fn wgpuBufferGetUsage(buffer: *Buffer) BufferUsage;

extern fn wgpuBufferGetSize(buffer: *Buffer) u64;

extern fn wgpuBufferSetLabel(buffer: *Buffer, label: shared.StringView) void;

extern fn wgpuBufferUnmap(buffer: *Buffer) void;

extern fn wgpuBufferAddRef(buffer: *Buffer) void;

extern fn wgpuBufferRelease(buffer: *Buffer) void;

extern fn wgpuBufferDestroy(buffer: *Buffer) void;
