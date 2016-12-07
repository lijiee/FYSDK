//
//  FYDatePicker.h
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYConstants.h"

@class FYDatePicker;
typedef void(^FYActionDateDoneBlock)(FYDatePicker *picker, id selectedDate, UIView *origin);
typedef void(^FYActionDateCancelBlock)(FYDatePicker *picker);

@interface FYDatePicker : NSObject

+ (instancetype)showPickerWithTitle:(NSString *)title
                       selectedDate:(NSDate *)selectedDate
                        minimumDate:(NSDate *)minimumDate
                        maximumDate:(NSDate *)maximumDate
                          doneBlock:(FYActionDateDoneBlock)doneBlock
                             origin:(UIView*)view;

+ (instancetype)showPickerWithTitle:(NSString *)title
                     datePickerMode:(UIDatePickerMode)datePickerMode
                        pickerStyle:(FYDatePickerStyle)style
                       selectedDate:(NSDate *)selectedDate
                        minimumDate:(NSDate *)minimumDate
                        maximumDate:(NSDate *)maximumDate
                          doneBlock:(FYActionDateDoneBlock)doneBlock
                        cancelBlock:(FYActionDateCancelBlock)cancelBlock
                             origin:(UIView*)view;

- (void)hidePickerWithCancelAction;

@end
