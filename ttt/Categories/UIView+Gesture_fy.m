//
//  UIView+Gesture_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/1/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIView+Gesture_fy.h"
#import <JKCategories/JKCategories.h>

@implementation UIView (Gesture_fy)

- (void)fy_setTouchDownBackgroundColor:(UIColor *)bgColor actionBlock:(FYGestureActionBlock)block  {
    __weak typeof(self) weakSelf = self;
    [self jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        typeof(self) strongSelf = weakSelf;
        
        UIColor *originalBackgroundColor = strongSelf.backgroundColor;
        
        switch (gestureRecoginzer.state) {
            case UIGestureRecognizerStateBegan:
            {
                UIColor *newBackgroundColor = bgColor?:[UIColor lightGrayColor];
                strongSelf.backgroundColor = newBackgroundColor;
                for (UIView *view in strongSelf.subviews) {
                    [view setBackgroundColor:newBackgroundColor];
                }
                break;
            }
                
            case UIGestureRecognizerStateEnded:
            {
                if (block) {
                    block(gestureRecoginzer);
                }
                
                strongSelf.backgroundColor = originalBackgroundColor;
                for (UIView *view in strongSelf.subviews) {
                    [view setBackgroundColor:originalBackgroundColor];
                }
                break;
            }
                
            case UIGestureRecognizerStateCancelled:
            {
                strongSelf.backgroundColor = originalBackgroundColor;
                for (UIView *view in strongSelf.subviews) {
                    [view setBackgroundColor:originalBackgroundColor];
                }
                break;
            }   
        }
        
    }];
}

@end
