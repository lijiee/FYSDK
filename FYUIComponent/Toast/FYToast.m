//
//  FYToast.m
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYToast.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation FYToast

static BOOL canDismiss = YES;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
    });
}

+ (void)showWithStatus:(NSString *)status {
    canDismiss = YES;
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD showWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString *)status{
    canDismiss = NO;
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD showSuccessWithStatus:status];
}

#pragma mark - ----------- Info -----------

+ (void)showInfoWithStatus:(NSString *)status;
{
    canDismiss = NO;
    
    [SVProgressHUD setBackgroundColor:[UIColor blueColor]];
    [SVProgressHUD showInfoWithStatus:status];
}


+ (void)showInfoWithError:(NSError *)error;
{
    [self showInfoWithStatus:error.localizedDescription];
}

#pragma mark - ----------- Error -----------

+ (void)showErrorWithStatus:(NSString *)status{
    canDismiss = NO;
    
    [SVProgressHUD setBackgroundColor:[UIColor redColor]];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)showError:(NSError *)error {
    [self showErrorWithStatus:error.localizedDescription];
}

+ (void)dismiss{
    if (canDismiss) {
        [SVProgressHUD dismiss];
    }
}

@end
