//
//  CityViewController.h
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/1.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYCityPickerViewController;
@protocol FYCityPickerDelegate <NSObject>

- (void)cityPickerController:(FYCityPickerViewController *)picker didFinishPickingCity:(NSString *)cityName;

@optional
- (void)cityPickerControllerDidCancel:(FYCityPickerViewController *)picker;
- (void)cityPickerController:(FYCityPickerViewController *)picker didFailedWithError:(NSError *)error;

@end

@interface FYCityPickerViewController : UINavigationController

- (instancetype)initWithDelegate:(id<FYCityPickerDelegate>)delegate;
- (instancetype)initWithCompletion:(void(^)(NSString *cityName))completion
                      cancellation:(void(^)())cancellation
                           failure:(void(^)(NSError *error))failure;

@end
