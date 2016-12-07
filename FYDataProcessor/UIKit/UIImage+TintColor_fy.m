//
//  UIImage+TintColor_fy.m
//  UIKitTools
//
//  Created by WorkHarder on 10/11/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIImage+TintColor_fy.h"

@implementation UIImage (TintColor_fy)

#define AppTintColor [UIColor redColor]

- (UIImage *) fy_imageWithApplicationTintColor
{
    return [self fy_imageWithTintColor:AppTintColor];
}

- (UIImage *) fy_imageWithGradientApplicationTintColor {
    return [self fy_imageWithGradientTintColor:AppTintColor];
}

- (UIImage *) fy_imageWithTintColor:(UIColor *)tintColor
{
    NSOrderedSet *set = [NSOrderedSet orderedSetWithObject:@(kCGBlendModeDestinationIn)];
    return [self fy_imageWithTintColor:tintColor blendModes:set];
}

- (UIImage *) fy_imageWithGradientTintColor:(UIColor *)tintColor
{
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:@[@(kCGBlendModeLuminosity), @(kCGBlendModeDestinationIn)]];
    return [self fy_imageWithTintColor:tintColor blendModes:set];
}

- (UIImage *) fy_imageWithTintColor:(UIColor *)tintColor blendModes:(NSOrderedSet *)blendModeSet
{
    // 取值 NO 保持原有透明度；取值 0.0f 是将scale factor设置为设备主屏幕的scale factor；
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    {
        [tintColor setFill];
        CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
        UIRectFill(bounds);
        
        // 可以多次绘制不同模式的图层并叠加起来，制造效果！！！
        for (NSNumber *num in blendModeSet) {
            // 注意：看似这里alpha取值为 1 是完全遮盖原来的图像，但实际图像本身可能有alpha通道，所以还是可能有像素合成的！！！
            [self drawInRect:bounds blendMode:(CGBlendMode)num.integerValue alpha:1.0f];
        }
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
