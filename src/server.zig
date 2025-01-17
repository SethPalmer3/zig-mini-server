const std = @import("std");
const net = std.net;

pub fn MiniServer() type {
    return struct {
        const This = @This();
        address: net.Address,
        pub fn init(address: net.Address) This {
            return This{
                .address = address,
            };
        }

        pub fn start(self: This, allocator: std.mem.Allocator, listen_options: net.Address.ListenOptions) !void {
            var server = try self.address.listen(listen_options);

            var client = try net.Server.accept(&server);
            defer client.stream.close();

            var client_reader = client.stream.reader();
            var client_writer = client.stream.writer();
            while (true) {
                const msg = try client_reader.readUntilDelimiterAlloc(allocator, '\n', 1024);
                defer allocator.free(msg);

                std.log.info("Received {}", .{std.zig.fmtEscapes(msg)});
                try client_writer.writeAll(msg);
            }
        }
    };
}
