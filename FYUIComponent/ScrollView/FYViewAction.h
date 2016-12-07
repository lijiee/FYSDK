//
//  FYViewAction.h
//  FYSDK
//
//  Created by WorkHarder on 12/2/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#ifndef FYViewAction_h
#define FYViewAction_h

typedef NS_ENUM(NSInteger, FYViewAction) {
    FYViewActionDefault,
    FYViewActionButtonClicked,
    FYViewActionCellSelected,
};

#define FYActionOriginalKey @"action_origin"
#define FYActionDataKey     @"action_data"

/**
 *  核心思想是基于target-action-params：
 *      target由view.actionDelegate来设定
 *      action通过didTrigger来定义(但是从一个view导出来的动作可能有多个，需要至少一个enum来表表征动作类型以方便外部通过switch来处理这个动作)
 *      params可提供任何执行动作需要的参数，基于常用情况做一部分预定义：
 *          1. FYActionOriginalKey：触发动作的view
 *          2. FYActionDataKey    : 导出外部处理逻辑需要的数据
 */
@protocol FYListViewActionDelegate <NSObject>

@optional

- (void)didTriggerAction:(NSInteger)actionEnum userInfo:(NSDictionary *)userInfo;

@end


@protocol FYListViewActionDataSource <NSObject>

@optional
@property (nonatomic, assign) BOOL isExecutingAsynchronousTasks;

- (void)fy_configureWithData:(id)data delegate:(id<FYListViewActionDelegate>)actionDelegate;

/**
 *  异步任务的操作；比如远程图像的加载等
 */
- (void)fy_startAsynchronousTasksForCall:(id)data;
- (void)fy_startAsynchronousTasksForImplement:(id)data;
- (void)fy_stopAsynchronousTasksForCall;
- (void)fy_stopAsynchronousTasksForImplement;

+ (CGFloat)fy_heightForData:(NSDictionary *)data;

@end


#endif /* FYViewAction_h */