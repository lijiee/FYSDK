//
//  UIView+FYViewAction.m
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIView+FYViewAction.h"
#import <objc/runtime.h>
#import "FYThreadMutex.h"

@interface UIView ()

@property (nonatomic, assign) BOOL isExecutingAsynchronousTasks;
@property (nonatomic, strong, readonly) FYThreadMutex *mutex;

@end


@implementation UIView (FYViewAction)

- (void)fy_configureWithData:(id)data delegate:(id<FYListViewActionDelegate>)actionDelegate {
    self.actionDelegate = actionDelegate;
}

- (void)fy_startAsynchronousTasksForCall:(id)data {
    if ([self respondsToSelector:@selector(fy_startAsynchronousTasksForImplement:)]) {
        __weak typeof (self) weakSelf = self;
        [self.mutex fy_executeMutexBlock:^{
            typeof (self) strongSelf = weakSelf;
            if (strongSelf.isExecutingAsynchronousTasks) {
                return;
            }
            
            strongSelf.isExecutingAsynchronousTasks = YES;
            [strongSelf fy_startAsynchronousTasksForImplement:data];
        }];
    }
}

- (void)fy_stopAsynchronousTasksForCall {
    if ([self respondsToSelector:@selector(fy_stopAsynchronousTasksForImplement)]) {
        __weak typeof (self) weakSelf = self;
        [self.mutex fy_executeMutexBlock:^{
            typeof (self) strongSelf = weakSelf;
            if (!strongSelf.isExecutingAsynchronousTasks) {
                return;
            }
            
            strongSelf.isExecutingAsynchronousTasks = NO;
            [strongSelf fy_stopAsynchronousTasksForImplement];
        }];
    }
}


#define actionDelegateKey @"fy_UIView_actionDelegate"
#define isExecutingAsynchronousTasksKey @"fy_UIView_isExecutingAsynchronousTasks"
#define mutexKey @"fy_UIView_mutex"

- (void)setMutex:(FYThreadMutex *)mutex {
    objc_setAssociatedObject(self, mutexKey, mutex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FYThreadMutex *)mutex {
    return objc_getAssociatedObject(self, mutexKey);
}

- (id<FYListViewActionDelegate>)actionDelegate {
    return objc_getAssociatedObject(self, actionDelegateKey);
}

- (void)setActionDelegate:(id<FYListViewActionDelegate>)actionDelegate {
    objc_setAssociatedObject(self, actionDelegateKey, actionDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isExecutingAsynchronousTasks {
    return [objc_getAssociatedObject(self, isExecutingAsynchronousTasksKey) boolValue];
}

- (void)setIsExecutingAsynchronousTasks:(BOOL)isExecutingAsynchronousTasks {
    objc_setAssociatedObject(self, isExecutingAsynchronousTasksKey, @(isExecutingAsynchronousTasks), OBJC_ASSOCIATION_ASSIGN);
}

@end
