//
//  UIButton+CountDown_fy.m
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIButton+CountDown_fy.h"
#import <objc/runtime.h>
#import <JKCategories/JKCategories.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UIButton (CountDown_fy)

- (void)fy_startCountDownFrom:(NSUInteger)timeout in:(id)viewOrViewController tick:(void (^)(NSUInteger))tickBlock completion:(void (^)(BOOL))completion {
    [self fy_startCountDownFrom:timeout tick:tickBlock completion:completion];
    
    [[viewOrViewController rac_willDeallocSignal] subscribeNext:^(id x) {
        [self.timer invalidate];
    }];
}

- (void)fy_startCountDownFrom:(NSUInteger )timeout tick:(void(^)(NSUInteger remaining))tickBlock completion:(void(^)(BOOL finished))completion {
    
    if (self.timer != nil) {
        return;
    }
    
    __block NSInteger seconds = timeout; //倒计时时间
    
    __weak UIButton *weakSelf = self;
    self.enabled = NO;
    
    self.timer = [NSTimer jk_timerWithTimeInterval:1 block:^{
        NSLog(@"__count down__%@",@(seconds));
        
        UIButton *strongSelf = weakSelf;
        
        if (seconds < 0) {
            
            [strongSelf fy_stopCountDown];
            
            if (completion) {
                completion(YES);
            }
            return ;
            
        } else {
            
            if (tickBlock) {
                tickBlock(seconds);
            }
            seconds--;
        }
        
    } repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)fy_stopCountDown {
    [self.timer invalidate];
    self.timer = nil;
    self.enabled = YES;
}

#pragma mark - Associated Objects

#define timerKey @"fy_UIButton_timer"

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, timerKey);
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
