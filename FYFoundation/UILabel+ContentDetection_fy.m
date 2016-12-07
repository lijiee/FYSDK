//
//  UILabel+ContentDetection_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UILabel+ContentDetection_fy.h"
#import "NSDate+Business_fy.h"

@implementation UILabel (ContentDetection_fy)

- (void)fy_setContent:(id)stringOrAttributedString {
    if ([stringOrAttributedString isKindOfClass:[NSAttributedString class]]) {
        self.attributedText = stringOrAttributedString;
    }
    else if ([stringOrAttributedString isKindOfClass:[NSDate class]]) {
        self.text = [stringOrAttributedString fy_timeAgoOrAccurateDateTime];
    }
    else {
        NSParameterAssert([stringOrAttributedString isKindOfClass:[NSString class]] || stringOrAttributedString == nil);
        self.text = stringOrAttributedString;
    }
}

@end
