const shared = @import("shared.zig");


pub const ShaderModule = opaque {
    
    pub const getCompilationInfo = wgpuShaderModuleGetCompilationInfo;

    pub const setLabel = wgpuShaderModuleSetLabel;

    pub const addRef = wgpuShaderModuleAddRef;

    pub const release = wgpuShaderModuleRelease;
};

pub const CompilationInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    message_count: usize,
    messages: ?[*]const CompilationMessage
};

pub const CompilationInfoCallback = fn (status: CompilationInfoRequestStatus, compilation_info: *const CompilationInfo, userdata1: ?*shared.UserData, userdata2: ?*shared.UserData) callconv(.C) void;

pub const CompilationInfoCallbackInfo = extern struct {
    next: ?*const shared.ChainedStruct = null,
    mode: shared.CallbackMode,
    callback: *const CompilationInfoCallback,
    userdata1: ?*shared.UserData,
    userdata2: ?*shared.UserData
};

pub const CompilationInfoRequestStatus = enum(u32) {
    success = 1,
    instance_dropped,
    @"error",
    unknown
};

pub const CompilationMessage = extern struct {
    next: ?*const shared.ChainedStruct = null,
    message: shared.StringView = .{},
    type: CompilationMessageType,
    line_num: u64,
    line_pos: u64,
    offset: u64,
    length: u64,
};

pub const CompilationMessageType = enum(u32) {
    @"error",
    warning,
    info
};

pub const ShaderModuleDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView
};

pub const ShaderSourceSPIRV = extern struct {
    chain: shared.ChainedStruct,
    code_size: u32,
    code: [*]const u32
};

pub const ShaderSourceWGSL = extern struct {
    chain: shared.ChainedStruct,
    code:  shared.StringView
};


extern fn wgpuShaderModuleGetCompilationInfo(module: *ShaderModule, callback_info: CompilationInfoCallbackInfo) shared.Future;

extern fn wgpuShaderModuleSetLabel(module: *ShaderModule, label: ?[*:0]const u8) void;

extern fn wgpuShaderModuleAddRef(module: *ShaderModule) void;

extern fn wgpuShaderModuleRelease(module: *ShaderModule) void;
