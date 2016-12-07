//
//  UIImage+GradientColor_fy.m
//  UIKitTools
//
//  Created by WorkHarder on 10/16/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIImage+GradientColor_fy.h"

@implementation UIImage (GradientColor_fy)

+ (UIImage *)fy_gradientImageWithColors:(NSArray<UIColor *> *)colorsArray imageSize:(CGSize)size {

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsArray.count];
    for (UIColor *color in colorsArray) {
        [gradientColors addObject:(id)color.CGColor];
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)gradientColors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
