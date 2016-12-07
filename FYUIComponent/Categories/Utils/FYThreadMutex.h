//
//  FYThreadMutex.h
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYThreadMutex : NSObject

- (void)fy_executeMutexBlock:(void(^ __nonnull)())block;

@end
