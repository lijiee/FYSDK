//
//  UIViewController+Picker_fy.h
//  FYSDK
//
//  Created by WorkHarder on 10/27/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYPrivateHeader.h"


@interface UIViewController (Picker_fy)

- (void)showDatePickerWithTitle:(NSString *)title
                           mode:(FYDatePickerMode)datePickerMode
                          style:(FYPickerStyle)pickerStyle
                   selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate
                        monitor:(FYDateActionDoneBlock)monitorBlock
                     completion:(FYDateActionDoneBlock)doneBlock
                   cancellation:(FYActionCancelBlock)cancelBlock
                         origin:(UIControl *)origin;

@end
