//
//  FYPickerCell.m
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYPickerCell.h"

@implementation FYPickerCell

#define kHighlightColor [UIColor colorWithRed:208/255.0 green:107/255.0 blue:0/255.0 alpha:1.0]
#define kNormalColor [UIColor lightGrayColor]

static UIColor *_highLightColor;

+ (void)setHighLightColor:(UIColor *)highLightColor {
    _highLightColor = highLightColor;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.elementLabel.textColor = _highLightColor ? : kHighlightColor;
        self.elementLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } else {
        self.elementLabel.textColor = kNormalColor;
        self.elementLabel.transform = CGAffineTransformIdentity;
    }
}

@end
