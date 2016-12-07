//
//  UIButton+IBSupport.m
//  FYSDK
//
//  Created by WorkHarder on 11/22/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIButton+IBSupport.h"

IB_DESIGNABLE
@interface UIButton ()

@property (nonatomic, assign) IBInspectable CGFloat fy_numberOfLines;
@property (nonatomic, assign) IBInspectable NSTextAlignment fy_textAlignment;

@end

@implementation UIButton (IBSupport)

- (void)setFy_numberOfLines:(CGFloat)fy_numberOfLines {
    self.titleLabel.numberOfLines = fy_numberOfLines;
}

- (void)setFy_textAlignment:(CGFloat)fy_textAlignment {
    self.titleLabel.textAlignment = fy_textAlignment;
}


@end
