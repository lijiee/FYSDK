//
//  UIView+IBSupport.m
//  FYSDK
//
//  Created by WorkHarder on 11/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIView+IBSupport.h"

IB_DESIGNABLE
@interface UIView ()

@property (nonatomic, assign) IBInspectable CGFloat fy_cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat fy_borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *fy_borderColor;

@end

@implementation UIView (IBSupport)

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}


- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

@end
