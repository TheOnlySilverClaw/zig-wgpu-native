const shared = @import("shared.zig");
const Buffer = @import("buffer.zig").Buffer;
const Texture = @import("texture.zig").Texture;
const TextureAspect = @import("texture.zig").TextureAspect;


pub const TexelCopyTextureInfo  = extern struct {
    texture: *Texture,
    mip_level: u32,
    origin: shared.Origin3D,
    aspect: TextureAspect
};

pub const TexelCopyBufferLayout = extern struct {
    offset: u64 = 0,
    bytes_per_row: u32,
    rows_per_image: u32
};

pub const TexelCopyBufferInfo = extern struct {
    layout: TexelCopyBufferLayout,
    buffer: *Buffer,
};
