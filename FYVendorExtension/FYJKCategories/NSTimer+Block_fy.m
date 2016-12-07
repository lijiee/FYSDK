
//
//  NSTimer+Block_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "NSTimer+Block_fy.h"
#import <JKCategories/JKCategories.h>

@implementation NSTimer (Block_fy)


+(id)fy_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval tickBlock:(void (^)())tickBlock repeatBlock:(BOOL (^)())repeatBlock {
    BOOL repeat = repeatBlock();
    __block NSTimer *timer = [self jk_scheduledTimerWithTimeInterval:inTimeInterval block:^{
        tickBlock();
        if (!(repeatBlock())) {
            [timer invalidate];
        }
    } repeats:repeat];
    return timer;
}

@end
