//
//  LGAlertView+Dismissable_Private_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/2/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "LGAlertView+Dismissable_Private_fy.h"

@implementation LGAlertView (Dismissable_Private_fy)

- (void)fy_dismissAnimated:(BOOL)animated completionHandler:(void (^)())completionHandler {
    [self dismissAnimated:YES completionHandler:completionHandler];
}

- (void)fy_setProgress:(float)progress progressLabelText:(NSString *)progressLabelText {
    [self setProgress:progress progressLabelText:progressLabelText];
}

@end
