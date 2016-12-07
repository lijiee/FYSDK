//
//  UIBarButtonItem+Badge_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIBarButtonItem+Badge_fy.h"
#import <WZLBadge/UIBarButtonItem+WZLBadge.h>

@implementation UIBarButtonItem (Badge_fy)

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
