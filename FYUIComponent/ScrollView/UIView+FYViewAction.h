//
//  UIView+FYViewAction.h
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYViewAction.h"

@interface UIView (FYViewAction)<FYListViewActionDataSource>

/**
 *  actionDelegate必须为View或ViewController
 */
@property (nonatomic, weak) id<FYListViewActionDelegate> actionDelegate;

@end
