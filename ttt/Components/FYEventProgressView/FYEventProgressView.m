//
//  FYEventProgressView.m
//  FYSDK
//
//  Created by WorkHarder on 10/31/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYEventProgressView.h"
#import <Masonry/Masonry.h>

@interface FYEventProgressBar : UIView

@property (nonatomic, assign) CGFloat progress;

@end

@implementation FYEventProgressBar

+ (Class)layerClass {
    return CAShapeLayer.class;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialLayout];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialLayout];
    }
    return self;
}

- (void)initialLayout {
    CAShapeLayer *shape = (CAShapeLayer *)self.layer;
    shape.fillColor = [UIColor redColor].CGColor;
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"%@", [NSValue valueWithCGRect:self.bounds]);
    [self updateProgress:self.progress];
}

- (void)updateProgress:(CGFloat)progress {
    self.progress = progress;
    
    CAShapeLayer *shape = (CAShapeLayer *)self.layer;
    
    if (shape) {
        NSLog(@" => %@", [NSValue valueWithCGRect:shape.bounds]);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, shape.bounds.size.width * progress, shape.bounds.size.height)];
        shape.path =  path.CGPath;
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    CAShapeLayer *shape = (CAShapeLayer *)self.layer;
    shape.fillColor = tintColor.CGColor;
    self.layer.borderColor = tintColor.CGColor;
}

@end

IB_DESIGNABLE
@interface FYEventProgressView ()

@property (nonatomic, copy) IBInspectable NSString *title;
@property (nonatomic, assign) IBInspectable CGFloat totalUnit;
@property (nonatomic, assign) IBInspectable CGFloat currentUnit;
@property (nonatomic, copy) IBInspectable NSString *unitName;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) FYEventProgressBar *progressBar;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation FYEventProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self);
        }];
        self.titleLabel = label;
        
        FYEventProgressBar *bar = [[FYEventProgressBar alloc] init];
        [self addSubview:bar];
        [bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@12);
            make.top.equalTo(label.mas_bottom).offset(2);
        }];
        self.progressBar = bar;
        
        {
            UILabel *label2 = [[UILabel alloc] init];
            label2.font = [UIFont systemFontOfSize:12];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.textColor = [UIColor lightGrayColor];
            [self addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(self);
                make.top.equalTo(bar.mas_bottom).offset(2);
            }];
            self.detailLabel = label2;
        }
        
        self.progressBar.tintColor = self.tintColor;
        self.titleLabel.textColor = self.tintColor;
    }
    return self;
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    self.progressBar.tintColor = tintColor;
    self.titleLabel.textColor = tintColor;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)setCurrentUnit:(CGFloat)currentUnit {
    _currentUnit = currentUnit;
    if (_totalUnit > 0) {
        [self updateAppearence];
    }
}

- (void)setTotalUnit:(CGFloat)totalUnit {
    _totalUnit = totalUnit;
    [self updateAppearence];
}

- (void)setUnitName:(NSString *)unitName {
    _unitName = [unitName copy];
    [self updateAppearence];
}

- (void)updateAppearence {
    [self.progressBar updateProgress:_currentUnit/_totalUnit];
    self.detailLabel.text = [NSString stringWithFormat:@"%d%@/%d%@", (int)_currentUnit, self.unitName, (int)_totalUnit, self.unitName];
}

@end
