//
//  NSObject+GCD_fy.h
//  FoundationTools
//
//  Created by WorkHarder on 10/10/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCD_fy)

+ (void)fy_dispatch_async_defaultGlobalQueue:(void(^)(void))block;
+ (void)fy_dispatch_async_mainQueue:(void(^)(void))mainBlock;
+ (void)fy_dispatch_async_defaultGlobalQueue:(void(^)(void))block mainQueue:(void(^)(void))mainBlock;

- (void)fy_dispatch_async_defaultGlobalQueue:(void(^)(void))block;
- (void)fy_dispatch_async_mainQueue:(void(^)(void))mainBlock;
- (void)fy_dispatch_async_defaultGlobalQueue:(void(^)(void))block mainQueue:(void(^)(void))mainBlock;

@end
