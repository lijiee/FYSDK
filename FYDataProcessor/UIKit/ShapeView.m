//
//  ShapeView.m
//  FYSDK
//
//  Created by WorkHarder on 10/29/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

+ (Class)layerClass {
    return CAShapeLayer.class;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize radii = CGSizeMake(30, 30);
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners:corners cornerRadii:radii];
    [(CAShapeLayer *)self.layer setPath:path.CGPath];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
    [(CAShapeLayer *)self.layer setFillColor:backgroundColor.CGColor];
}

@end
