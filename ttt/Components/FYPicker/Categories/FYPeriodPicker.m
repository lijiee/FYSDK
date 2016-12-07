//
//  FYPeriodPicker.m
//  FYDatePicker
//
//  Created by WorkHarder on 10/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYPeriodPicker.h"
#import "FYDatePicker.h"
#import <JKCategories/JKCategories.h>

@interface FYPeriodPicker ()

@property (nonatomic, weak) IBOutlet UIView *startView;
@property (nonatomic, weak) IBOutlet UIView *endView;
@property (nonatomic, weak) IBOutlet UITextField *startDateTextfield;
@property (nonatomic, weak) IBOutlet UITextField *endDateTextfield;
@property (nonatomic, weak) IBOutlet UIButton *endDateClearButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *endDateTextfieldMargin;

@property (nonatomic, strong) UIColor *dateTintColor;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) FYDatePicker *innerDatePicker;

@end

@implementation FYPeriodPicker

+ (instancetype)pickerWithFrame:(CGRect)frame selectedStartDate:(NSDate *)startDate selectedEndDate:(NSDate *)endDate triggerByStartDate:(BOOL)isStart {
    FYPeriodPicker *picker = [[[NSBundle mainBundle] loadNibNamed:@"FYPeriodPicker" owner:nil options:nil] lastObject];
    frame.size.height = 300;
    picker.frame = frame;
    
    CGRect datePickerFrame = frame;
    datePickerFrame.origin = CGPointMake(12, 72 + 14);
    datePickerFrame.size = CGSizeMake(CGRectGetWidth(frame) - 12*2, 200);
    
    
    picker.isStart = isStart;
    picker.startDate = startDate;
    picker.endDate = endDate;
    
    if (isStart) {
        picker.innerDatePicker = [FYDatePicker pickerWithFrame:datePickerFrame datePickerMode:FYDatePickerModeDate
                                           selectedDate:picker.startDate minimumDate:nil maximumDate:endDate
                                           monitorBlock:picker.monitorBlock];
    } else {
        picker.innerDatePicker = [FYDatePicker pickerWithFrame:datePickerFrame datePickerMode:FYDatePickerModeDate
                                           selectedDate:endDate minimumDate:picker.startDate maximumDate:nil
                                           monitorBlock:picker.monitorBlock];
    }
    [picker addSubview:picker.innerDatePicker];
    

    
    return picker;
}

#pragma mark - Actions


- (IBAction)selectStartDate:(id)sender {
    self.isStart = YES;
    [self.innerDatePicker setSelectedDate:self.startDate
                                minimumDate:nil maximumDate:self.endDate monitorBlock:self.monitorBlock];
}

- (IBAction)selectEndDate:(id)sender {
    self.isStart = NO;
    [self.innerDatePicker setSelectedDate:self.endDate ? : [NSDate date]
                                minimumDate:self.startDate maximumDate:nil monitorBlock:self.monitorBlock];
}

- (IBAction)clearEndDate:(id)sender {
    self.endDate = nil;
}

- (FYActionDoneBlock)monitorBlock {
    return ^(FYBasePicker *datepicker, id selectedDate, id origin) {
        if (self.isStart) {
            self.startDate = selectedDate;
        } else {
            self.endDate = selectedDate;
        }
    };
}

#pragma mark - Setters & Getters

- (UIColor *)dateTintColor {
    return _dateTintColor ? : [UIColor blueColor];
}

- (void)setIsStart:(BOOL)isStart {
    _isStart = isStart;
    self.startDateTextfield.textColor = isStart ? [UIColor redColor] : self.tintColor;
    self.endDateTextfield.textColor = !isStart ? [UIColor redColor] : self.tintColor;
}

- (void)setStartDate:(NSDate *)startDate {
    if (startDate == nil) {
        startDate = [[NSDate date] jk_dateBySubtractingMonths:3];
    }
    _startDate = startDate;
    self.startDateTextfield.text = [startDate jk_stringWithFormat:@"yyyy-MM-dd"];
}

- (void)setEndDate:(NSDate *)endDate {
    if (endDate == nil) {
        self.endDateClearButton.hidden = YES;
        self.endDateTextfield.clearButtonMode = UITextFieldViewModeNever;
        self.endDateTextfield.text = @"至今";
        self.endDateTextfieldMargin.constant = 0;
    } else {
        self.endDateClearButton.hidden = NO;
        self.endDateTextfield.clearButtonMode = UITextFieldViewModeAlways;
        self.endDateTextfield.text = [endDate jk_stringWithFormat:@"yyyy-MM-dd"];
        self.endDateTextfieldMargin.constant = 6;
    }
    _endDate = endDate;
}

@end
