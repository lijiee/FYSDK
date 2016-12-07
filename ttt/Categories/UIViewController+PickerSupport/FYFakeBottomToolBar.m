//
//  FYFakeBottomToolBar.m
//  FYSDK
//
//  Created by WorkHarder on 10/27/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYFakeBottomToolBar.h"

@interface FYFakeBottomToolBar ()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *okButton;

@end

@implementation FYFakeBottomToolBar

#define kButtonWidth 50
#define kPadding 10

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1];
        
        [self initializeLayoutAndSubviews];
    }
    return self;
}



- (void)initializeLayoutAndSubviews {

    CGRect cancelFrame = CGRectMake(kPadding, 0.0, kButtonWidth, self.bounds.size.height);
    CGRect okFrame = CGRectMake(self.bounds.size.width-kButtonWidth-kPadding, 0.0, kButtonWidth, self.bounds.size.height);
    CGRect titleFrame = CGRectMake(CGRectGetMaxX(cancelFrame), 0, CGRectGetMinX(okFrame)-CGRectGetMaxX(cancelFrame), self.bounds.size.height);
    
    {
        UIButton *button = [[UIButton alloc] initWithFrame:cancelFrame];
        
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:self.tintColor forState:UIControlStateNormal];
        
        self.cancelButton = button;
    }

    
    {
        UIButton *button = [[UIButton alloc] initWithFrame:okFrame];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:self.tintColor forState:UIControlStateNormal];
        
        self.okButton = button;
    }
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:titleFrame];
        
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        
        self.titleLabel = label;
    }
    
    [self addSubview:self.cancelButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.okButton];
}


@end
