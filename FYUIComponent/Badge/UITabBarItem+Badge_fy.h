//
//  UITabBarItem+Badge_fy.h
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYBadge_ENUM.h"

@interface UITabBarItem (Badge_fy)

- (void)fy_showBadge;

/**
 *  @param style   红点、数字或new
 *  @param value   value 是否为0决定了badge的hidden与否
 *  @param aniType 动画类型
 */
- (void)fy_showBadgeWithStyle:(FYBadgeStyle)style
                        value:(NSInteger)value
                animationType:(FYBadgeAnimType)aniType;


/**
 *  clear & resume 分别设置hidden为 Yes & NO
 */
- (void)fy_clearBadge;
- (void)fy_resumeBadge;

@end
