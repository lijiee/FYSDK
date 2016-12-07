//
//  NSObject+GCD_fy.m
//  FoundationTools
//
//  Created by WorkHarder on 10/10/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "NSObject+GCD_fy.h"

@implementation NSObject (GCD_fy)

+ (void)fy_dispatch_async_defaultGlobalQueue:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

+ (void)fy_dispatch_async_mainQueue:(void (^)(void))mainBlock {
    dispatch_async(dispatch_get_main_queue(), mainBlock);
}

+ (void)fy_dispatch_async_defaultGlobalQueue:(void (^)(void))block mainQueue:(void (^)(void))mainBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (block) {
            block();
        }
        dispatch_async(dispatch_get_main_queue(), mainBlock);
    });
}

- (void)fy_dispatch_async_defaultGlobalQueue:(void (^)(void))block {
    [self.class fy_dispatch_async_defaultGlobalQueue:block];
}

- (void)fy_dispatch_async_mainQueue:(void (^)(void))mainBlock {
    [self.class fy_dispatch_async_mainQueue:mainBlock];
}

- (void)fy_dispatch_async_defaultGlobalQueue:(void (^)(void))block mainQueue:(void (^)(void))mainBlock {
    [self.class fy_dispatch_async_defaultGlobalQueue:block mainQueue:mainBlock];
}

@end
