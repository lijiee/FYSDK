//
//  UIImage+TintColor_fy.h
//  UIKitTools
//
//  Created by WorkHarder on 10/11/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintColor_fy)

- (UIImage *) fy_imageWithApplicationTintColor;
- (UIImage *) fy_imageWithGradientApplicationTintColor;
- (UIImage *) fy_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) fy_imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *) fy_imageWithTintColor:(UIColor *)tintColor blendModes:(NSOrderedSet *)blendModeSet;

@end
