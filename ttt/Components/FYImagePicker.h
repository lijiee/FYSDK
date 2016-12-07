//
//  FYImagePicker.h
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYImagePicker : NSObject

- (void)presentFromViewController:(UIViewController *)viewControllerFrom
                   selectedAssets:(NSArray *)assets
                       completion:(void(^)(NSArray<UIImage *> *images, NSArray *assets, BOOL isOriginalImage))completion
                     cancellation:(void(^)())cancellation;

@end
