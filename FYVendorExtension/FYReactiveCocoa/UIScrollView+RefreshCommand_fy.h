//
//  UIScrollView+RefreshCommand_fy.h
//  FYSDK
//
//  Created by WorkHarder on 12/2/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FYPullOperationType){
    FYPullRefresh = 0,
    FYPullLoadMore
};

/**
 *  此类的任务在于设定滚动视图的上&下拉刷新命令；命令被触发后会execute，并去获取数据；
 *    1. execute的input只能从动作中获取是FYPullRefresh还是FYPullLoadMore；而命令真正从网络获取数据时一般还需要一些参数
 */
@interface UIScrollView (RefreshCommand_fy)

@end
