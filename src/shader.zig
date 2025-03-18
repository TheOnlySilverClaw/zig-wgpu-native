const shared = @import("shared.zig");


pub const ShaderModule = opaque {
    
    pub const getCompilationInfo = wgpuShaderModuleGetCompilationInfo;

    pub const setLabel = wgpuShaderModuleSetLabel;

    pub const reference = wgpuShaderModuleReference;

    pub const release = wgpuShaderModuleRelease;
};

pub const CompilationInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    message_count: usize,
    messages: ?[*]const CompilationMessage
};

pub const CompilationInfoCallback = fn (status: CompilationInfoRequestStatus, compilation_info: *const CompilationInfo, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const CompilationInfoRequestStatus = enum(u32) {
    success,
    instance_dropped,
    @"error",
    unknown
};

pub const CompilationMessage = extern struct {
    next: ?*const shared.ChainedStruct = null,
    message: ?[*:0]const u8 = null,
    message_type: CompilationMessageType,
    line_num: u64,
    line_pos: u64,
    offset: u64,
    length: u64,
    utf16_line_pos: u64,
    utf16_offset: u64,
    utf16_length: u64
};

pub const CompilationMessageType = enum(u32) {
    @"error",
    warning,
    info
};

pub const ShaderModuleDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: ?[*:0]const u8 = null
};

pub const ShaderModuleWGSLDescriptor = extern struct {
    chain: shared.ChainedStruct,
    code: [*:0]const u8
};


extern fn wgpuShaderModuleGetCompilationInfo(module: *ShaderModule,
    callback: CompilationInfoCallback, userdata: ?*anyopaque) void;

extern fn wgpuShaderModuleSetLabel(module: *ShaderModule, label: ?[*:0]const u8) void;

extern fn wgpuShaderModuleReference(module: *ShaderModule) void;

extern fn wgpuShaderModuleRelease(module: *ShaderModule) void;
