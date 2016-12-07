//
//  FYConstants.h
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#ifndef FYConstants_h
#define FYConstants_h

#pragma mark - Picker

typedef NS_ENUM(NSInteger, FYPickerStyle) {
    FYPickerAlert,
    FYPickerActionSheet,
    FYPickerBottomToolBar,
    FYPickerPopFromViewOrAlert,
    FYPickerPopFromViewOrActionSheet,
    FYPickerPopFromViewOrBottomToolBar,
};

typedef NS_ENUM(NSInteger, FYDatePickerMode) {
    FYDatePickerModeTime,
    FYDatePickerModeTimeAPM,
    FYDatePickerModeDate,
    FYDatePickerModeYearMonth,
    FYDatePickerModeDateAndTime,
    FYDatePickerModeDateAndTimeAPM,
};

#endif /* FYConstants_h */
