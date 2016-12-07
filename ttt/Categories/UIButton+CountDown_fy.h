//
//  UIButton+CountDown_fy.h
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown_fy)

- (void)fy_startCountDownFrom:(NSUInteger )timeout tick:(void(^)(NSUInteger remaining))tickBlock completion:(void(^)(BOOL finished))completion;
- (void)fy_stopCountDown;

@end
