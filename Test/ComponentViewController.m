//
//  ComponentViewController.m
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "ComponentViewController.h"
#import <JKCategories/JKCategories.h>
#import "UIView+Badge_fy.h"
#import "FYTableDataSourceDelegate.h"
#import "FYAlert.h"
#import "NSTimer+Block_fy.h"

@interface ComponentViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;

@end

@implementation ComponentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self jk_performAfter:1 block:^{
        [self.badgeImageView fy_showBadgeWithStyle:FYBadgeStyleNumber value:1 animationType:FYBadgeAnimTypeBounce];
    }];
    
    [self jk_performAfter:4 block:^{
        [self.badgeImageView fy_showBadgeWithStyle:FYBadgeStyleNumber value:2 animationType:FYBadgeAnimTypeBreathe];
    }];
    
//    FYTableDataSourceDelegate *fy = [FYTableDataSourceDelegate new];
//    [fy fy_registerCells:@"dsa", [UIViewController class], [UINib nibWithNibName:@"FYIconCell" bundle:nil], nil];
    
    [self.badgeImageView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [FYAlert showAlertWithTitle:@"fuck" content:@"something" style:FYShowViewStyleStyleAlert buttonTitles:@[@"你的", @"我的"] cancelButtonTitle:@"取消" destructiveButtonTitle:@"销毁" actionHandler:^(NSString *title, NSUInteger index) {
            NSLog(@"%@, %lu", title, (unsigned long)index);
        }];
        id<FYDismissable> alert = [FYAlert showProgressViewAndTitle:@"fuck" content:@"da" style:FYShowViewStyleStyleAlert progressLabelText:@"进度" buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:nil cancelHandler:nil destructiveHandler:nil animated:YES completionHandler:nil];
        
        __block NSInteger index = 0;
        [NSTimer fy_scheduledTimerWithTimeInterval:0.05 tickBlock:^{
            [alert fy_setProgress:(float)index/100 progressLabelText:nil];
            index++;
            NSLog(@"%ld", (long)index);
        } repeatBlock:^BOOL{
            BOOL result = index < 100;
            if (!result) {
                [alert fy_dismissAnimated:YES completionHandler:nil];
            }
            return result;
        }];
       
    }];
}

@end
