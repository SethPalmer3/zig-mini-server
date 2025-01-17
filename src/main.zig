const std = @import("std");
const srvr = @import("./server.zig");
const net = std.net;

pub fn main() !void {
    var server = srvr.MiniServer().init(net.Address.initIp4(.{ 127, 0, 0, 1 }, 8080));
    try server.start(std.heap.page_allocator, .{});
}
