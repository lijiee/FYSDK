//
//  FYTabPageViewController.h
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@class FYTabPageViewController;
@protocol FYTabPageControllerDataSource <NSObject>

@optional
- (NSInteger)numbersOfChildControllersInPageController:(FYTabPageViewController *)pageController;
- (__kindof UIViewController *)pageController:(FYTabPageViewController *)pageController viewControllerAtIndex:(NSInteger)index;
- (NSString *)pageController:(FYTabPageViewController *)pageController titleAtIndex:(NSInteger)index;

@end

@protocol FYTabPageControllerDelegate <NSObject>

@optional
- (void)pageController:(FYTabPageViewController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;
- (void)pageController:(FYTabPageViewController *)pageController willCachedViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;
- (void)pageController:(FYTabPageViewController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;
- (void)pageController:(FYTabPageViewController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;

@end

@interface FYTabPageViewController : WMPageController

@end
