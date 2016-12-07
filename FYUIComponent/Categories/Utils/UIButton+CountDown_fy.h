//
//  UIButton+CountDown_fy.h
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown_fy)

- (void)fy_startCountDownFrom:(NSUInteger)timeout in:(id)viewOrViewController tick:(void(^)(NSUInteger remaining))tickBlock completion:(void(^)(BOOL finished))completion;

/**
 *  需要在合适的时机自行调用fy_stopCountDown，这通常是
 *      1. 视图销毁
 *      2. VC销毁
 */
- (void)fy_startCountDownFrom:(NSUInteger)timeout tick:(void(^)(NSUInteger remaining))tickBlock completion:(void(^)(BOOL finished))completion;
- (void)fy_stopCountDown;

@end
