//
//  FYPhotoBrowser.h
//  FYSDK
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYPhotoBrowser : NSObject

- (void)presentFromViewController:(UIViewController *)viewControllerFrom originalView:(UIView *)originalView photoAssets:(NSArray *)photos initialIndex:(NSInteger)initialIndex showDeleteButton:(BOOL)showDeleteButton;

@end
