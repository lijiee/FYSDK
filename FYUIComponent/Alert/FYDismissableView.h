//
//  FYDismissableView.h
//  FYSDK
//
//  Created by WorkHarder on 12/2/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYDismissable <NSObject>

- (void)fy_dismissAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;

@optional
- (void)fy_setProgress:(float)progress progressLabelText:(NSString *)progressLabelText;

@end


@interface FYDismissableView : UIView

@property (nonatomic, weak) id<FYDismissable> hostDismissable;

@end
