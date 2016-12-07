//
//  FYDatePicker.m
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYDatePicker.h"
#import <ActionSheetPicker_3_0/ActionSheetPicker.h>

@interface FYDatePicker ()

@property (nonatomic, strong) ActionSheetDatePicker *innerDatePicker;

@end

@implementation FYDatePicker

+ (instancetype)showPickerWithTitle:(NSString *)title
                       selectedDate:(NSDate *)selectedDate
                        minimumDate:(NSDate *)minimumDate
                        maximumDate:(NSDate *)maximumDate
                          doneBlock:(FYActionDateDoneBlock)doneBlock
                             origin:(UIView*)view
{
    return [self showPickerWithTitle:title datePickerMode:UIDatePickerModeDate pickerStyle:FYPickerActionSheet selectedDate:selectedDate minimumDate:minimumDate maximumDate:maximumDate doneBlock:doneBlock cancelBlock:nil origin:view];
}

+ (instancetype)showPickerWithTitle:(NSString *)title
                     datePickerMode:(UIDatePickerMode)datePickerMode
                        pickerStyle:(FYDatePickerStyle)style
                       selectedDate:(NSDate *)selectedDate
                        minimumDate:(NSDate *)minimumDate
                        maximumDate:(NSDate *)maximumDate
                          doneBlock:(FYActionDateDoneBlock)doneBlock
                        cancelBlock:(FYActionDateCancelBlock)cancelBlock
                             origin:(UIView*)view
{
    FYDatePicker *picker = [FYDatePicker new];
    picker.innerDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate minimumDate:minimumDate maximumDate:maximumDate target:nil action:nil origin:view];
    
    __weak FYDatePicker *weakPicker = picker;
    if (doneBlock) {
        [picker.innerDatePicker setOnActionSheetDone:^(ActionSheetDatePicker *dp, id date, id origin){
            doneBlock(weakPicker, date, origin);
        }];
    }
    
    if (cancelBlock) {
        [picker.innerDatePicker setOnActionSheetCancel:^(ActionSheetDatePicker *dp){
            cancelBlock(weakPicker);
        }];
    }
    
    return picker;
}

- (void)hidePickerWithCancelAction {
    [self.innerDatePicker hidePickerWithCancelAction];
}

@end
