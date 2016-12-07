//
//  FYEventCell.m
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYEventCell.h"
#import "UIView+FYViewAction.h"
#import "UILabel+ContentDetection_fy.h"
#import "UIView+Badge_fy.h"


@interface FYEventCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *badgeView;

@end

@implementation FYEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectedBackgroundView = [UIView new];
    self.selectedBackgroundView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
}

- (void)fy_configureWithData:(id)data delegate:(id<FYListViewActionDelegate>)actionDelegate {
    [super fy_configureWithData:data delegate:actionDelegate];

    [self.titleLabel fy_setContent:data[@"title"]];
    [self.contentLabel fy_setContent:data[@"content"]];
    [self.timeLabel fy_setContent:data[@"time"]];
    [self.badgeView fy_showBadgeWithStyle:FYBadgeStyleNumber value:[data[@"badge"] integerValue] animationType:FYBadgeAnimTypeNone];
}

- (void)fy_startAsynchronousTasksForImplement:(id)data {
    // TODO: 下载图片
}

- (void)fy_stopAsynchronousTasksForImplement {
    // TODO: 停止下载
    
}

+ (CGFloat)fy_heightForData:(NSDictionary *)data {
    return 100;
}

@end
