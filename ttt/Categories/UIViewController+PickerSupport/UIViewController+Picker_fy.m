//
//  UIViewController+Picker_fy.m
//  FYSDK
//
//  Created by WorkHarder on 10/27/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIViewController+Picker_fy.h"
#import "FYFakeBottomToolBar.h"
#import "FYDatePicker.h"
#import <JKCategories/JKCategories.h>

@interface UIViewController ()

@property (nonatomic, strong) UIView *mongoliaView;

@end

@implementation UIViewController (Picker_fy)

- (void)showDatePickerWithTitle:(NSString *)title
                           mode:(FYDatePickerMode)datePickerMode
                          style:(FYPickerStyle)pickerStyle
                   selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate
                        monitor:(FYDateActionDoneBlock)monitorBlock
                     completion:(FYDateActionDoneBlock)doneBlock
                   cancellation:(FYActionCancelBlock)cancelBlock
                         origin:(UIControl *)origin
{
    CGRect backgroundFrame = self.view.bounds;
    CGRect dismissFrame = CGRectMake(0, 0, Main_Screen_Width, CGRectGetHeight(backgroundFrame)-244);
    CGRect panelFrame = CGRectMake(0, CGRectGetHeight(backgroundFrame), Main_Screen_Width, 244);
    CGRect pickerFrame = CGRectMake(0, 44, Main_Screen_Width, 200);
    CGRect headerFrame = CGRectMake(0, 0, Main_Screen_Width, 44);
    
    UIView *mongoliaView = [[UIView alloc] initWithFrame:backgroundFrame];
    mongoliaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    UIView *dismissView = [[UIView alloc] initWithFrame:dismissFrame];
    dismissView.backgroundColor = [UIColor clearColor];
    [mongoliaView addSubview:dismissView];
    
    UIView *panelView = [[UIView alloc] initWithFrame:panelFrame];
    [mongoliaView addSubview:panelView];
    
    FYFakeBottomToolBar *headerView = [[FYFakeBottomToolBar alloc] initWithFrame:headerFrame];
    [panelView addSubview:headerView];
    
    FYDatePicker *picker = [FYDatePicker pickerWithFrame:pickerFrame datePickerMode:datePickerMode selectedDate:selectedDate minimumDate:minimumDate maximumDate:maximumDate monitorBlock:monitorBlock];
    [panelView addSubview:picker];
    
    headerView.titleLabel.text = title;
    [self.view addSubview:mongoliaView];
    [UIView animateWithDuration:0.4 animations:^{
        mongoliaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        panelView.frame = CGRectMake(0, CGRectGetHeight(backgroundFrame)-244, Main_Screen_Width, 244);
    }];
    
    [headerView.cancelButton jk_addActionHandler:^(NSInteger tag) {
        [UIView animateWithDuration:0.4 animations:^{
            mongoliaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            panelView.frame = CGRectMake(0, CGRectGetHeight(backgroundFrame), Main_Screen_Width, 244);
        } completion:^(BOOL finished) {
            [mongoliaView removeFromSuperview];
            if (cancelBlock) {
                cancelBlock(picker);
            }
        }];
    }];
    
    [headerView.okButton jk_addActionHandler:^(NSInteger tag) {
        [UIView animateWithDuration:0.4 animations:^{
            mongoliaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            panelView.frame = CGRectMake(0, CGRectGetHeight(backgroundFrame), Main_Screen_Width, 244);
        } completion:^(BOOL finished) {
            [mongoliaView removeFromSuperview];
            if (doneBlock) {
                doneBlock(picker, picker.selectedDate, origin);
            }
        }];
    }];
    
    [dismissView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (gestureRecoginzer.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.4 animations:^{
                mongoliaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                panelView.frame = CGRectMake(0, CGRectGetHeight(backgroundFrame), Main_Screen_Width, 244);
            } completion:^(BOOL finished) {
                [mongoliaView removeFromSuperview];
            }];
        }
    }];
}

#pragma mark - Associated Objects



@end
