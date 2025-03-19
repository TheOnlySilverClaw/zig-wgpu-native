const shared = @import("shared.zig");
const buffer = @import("buffer.zig");
const bind_group = @import("bind_group.zig");
const query = @import("query_set.zig");
const compute_pipeline = @import("compute_pipeline.zig");


pub const ComputePassEncoder = opaque {
    
    pub const dispatchWorkgroups = wgpuComputePassEncoderDispatchWorkgroups;

    pub const dispatchWorkgroupsIndirect = wgpuComputePassEncoderDispatchWorkgroupsIndirect;

    pub const end = wgpuComputePassEncoderEnd;

    pub const insertDebugMarker = wgpuComputePassEncoderInsertDebugMarker;

    pub const popDebugGroup = wgpuComputePassEncoderPopDebugGroup;

    pub const pushDebugGroup = wgpuComputePassEncoderPushDebugGroup;

    pub fn setBindGroup(encoder: *ComputePassEncoder,
        index: u32, group: bind_group.BindGroup, dynamic_offsets: ?[]const u32) void {
        
        wgpuComputePassEncoderSetBindGroup(encoder,
            index, group,
            if (dynamic_offsets) |offsets| @as(u32, @intCast(offsets.len)) else 0,
            if (dynamic_offsets) |offsets| offsets.ptr else null,
        );
    }

    pub const setLabel = wgpuComputePassEncoderSetLabel;

    pub const setPipeline = wgpuComputePassEncoderSetPipeline;

    pub const writeTimestamp = wgpuComputePassEncoderWriteTimestamp;

    pub const addRef = wgpuComputePassEncoderAddRef;

    pub const release = wgpuComputePassEncoderRelease;
};

pub const ComputePassDescriptor = extern struct {
    next: ?*const shared.ChainedStruct = null,
    label: shared.StringView = .{},
    timestamp_write_count: usize,
    timestamp_writes: ?[*]const ComputePassTimestampWrites,
};

pub const ComputePassTimestampWrites= extern struct {
    query_set: query.QuerySet,
    beginning_of_pass_write_index: u32,
    end_of_pass_write_index: u32
};


extern fn wgpuComputePassEncoderDispatchWorkgroups(encoder: *ComputePassEncoder, count_x: u32, count_y: u32, count_z: u32) void;

extern fn wgpuComputePassEncoderDispatchWorkgroupsIndirect(encoder: *ComputePassEncoder, indirect_buffer: buffer.Buffer, offset: u64) void;

extern fn wgpuComputePassEncoderEnd(encoder: *ComputePassEncoder) void;

extern fn wgpuComputePassEncoderInsertDebugMarker(encoder: *ComputePassEncoder, label: shared.StringView) void;

extern fn wgpuComputePassEncoderPopDebugGroup(encoder: *ComputePassEncoder) void;

extern fn wgpuComputePassEncoderPushDebugGroup(encoder: *ComputePassEncoder, label: shared.StringView) void;

extern fn wgpuComputePassEncoderSetBindGroup(encoder: *ComputePassEncoder, index: u32, group: bind_group.BindGroup, dynamic_offset_count: u32, dynamic_offsets: ?[*]const u32) void;

extern fn wgpuComputePassEncoderSetLabel(encoder: *ComputePassEncoder, label: ?shared.StringView) void;

extern fn wgpuComputePassEncoderSetPipeline(encoder: *ComputePassEncoder, pipeline: compute_pipeline.ComputePipeline) void;

extern fn wgpuComputePassEncoderWriteTimestamp(encoder: *ComputePassEncoder, query_set: query.QuerySet, index: u32) void;

extern fn wgpuComputePassEncoderAddRef(encoder: *ComputePassEncoder) void;

extern fn wgpuComputePassEncoderRelease(encoder: *ComputePassEncoder) void;
