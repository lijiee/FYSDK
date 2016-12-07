//
//  FYStringPicker.h
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYBasePicker.h"
#import "PickableValue.h"

@interface FYStringPicker : FYBasePicker

+ (instancetype)pickerWithFrame:(CGRect)frame options:(NSArray *)options
                selectedStrings:(NSArray *)selecteds;

+ (instancetype)pickerWithFrame:(CGRect)frame options:(NSArray *)options withSectionWidth:(NSArray<NSNumber *> *)widths
                selectedStrings:(NSArray *)selecteds;

- (NSArray<id<PickableValue>> *)selectedObjects;

@end
