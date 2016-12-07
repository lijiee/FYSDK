//
//  UIView+Badge_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIView+Badge_fy.h"
#import <WZLBadge/UIView+WZLBadge.h>
#import <Aspects/Aspects.h>

@interface UIView ()

@end

@implementation UIView (Badge_fy)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        [UIView aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
            UIView *view = [info instance];
            CGFloat delta = (1-1/sqrt(2))*(view.layer.cornerRadius);
            view.badgeCenterOffset = CGPointMake(-delta, delta);
        } error:&error];
        NSAssert(error==nil, @"swizzling layoutSubviews in UIView+Badge_fy.m is failed: %@", error);
    });
}

- (void)fy_showBadge {
    [self showBadge];
}

- (void)fy_showBadgeWithStyle:(FYBadgeStyle)style value:(NSInteger)value animationType:(FYBadgeAnimType)aniType {
    self.badgeMaximumBadgeNumber = 99;
    
    [self showBadgeWithStyle:(NSUInteger)style value:value animationType:(NSUInteger)aniType];
}

- (void)fy_clearBadge {
    [self clearBadge];
}

- (void)fy_resumeBadge {
    [self resumeBadge];
}

@end
