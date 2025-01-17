const std = @import("std");
const net = std.net;

pub fn Server() type {
    return struct {
        const This = @This();
        port: u16,
        address: net.Address,
        options: net.Stream,
        pub fn init(port: u16, address: net.Address) This {
            return This{
                .port = port,
                .address = address,
            };
        }
    };
}
