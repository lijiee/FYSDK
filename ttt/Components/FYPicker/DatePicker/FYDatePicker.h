//
//  FYDatePicker.h
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYBasePicker.h"

@interface FYDatePicker : FYBasePicker

+ (instancetype)pickerWithFrame:(CGRect)frame datePickerMode:(FYDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate
                    minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate
                   monitorBlock:(FYDateActionDoneBlock)monitorBlock;


- (void)setSelectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate
           monitorBlock:(FYActionDoneBlock)monitorBlock;

- (NSDate *)selectedDate;

@end
