//
//  FYPeriodPicker.h
//  FYDatePicker
//
//  Created by WorkHarder on 10/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYPeriodPicker : UIView

+ (instancetype)pickerWithFrame:(CGRect)frame selectedStartDate:(NSDate *)startDate selectedEndDate:(NSDate *)endDate triggerByStartDate:(BOOL)isStart;

@end
