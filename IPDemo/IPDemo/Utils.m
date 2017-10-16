//
//  Utils.m
//  IPDemo
//
//  Created by dev on 2017/10/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "Utils.h"

#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation Utils

+ (NSString *)localIPAddress{

    NSString *ip = @"Error";
    struct ifaddrs *interfaces = nil;
    struct ifaddrs *temp_addr = nil;
    
    int success = getifaddrs(&interfaces);
    //获取地址成功
    if (!success)
    {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                NSString *ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                if ([ifaName isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    ip = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return ip;
}

@end
