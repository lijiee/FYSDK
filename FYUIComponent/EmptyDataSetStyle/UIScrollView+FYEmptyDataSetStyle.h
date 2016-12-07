//
//  UIScrollView+FYEmptyDataSetStyle.h
//  FYEmptyDataSetStyle
//
//  Created by WorkHarder on 11/9/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (FYEmptyDataSetStyle)

#define FYEmptyButtonTitleKey           @"title"
#define FYEmptyButtonImageKey           @"image"
#define FYEmptyButtonBackgroundImageKey @"backgroundImage"

/**
 *  为 UITableView或UICollectionView 指定空白页样式的实例初始化方法
 *
 *  @param titleOrAttributedTitle             可以是 NSString 或 NSAttributedString
 *  @param descriptionOrAttributedDescription 可以是 NSString 或 NSAttributedString
 *  @param imageNameOrImage                   可以是 NSString 或 UIImage
 *  @param buttonConfiguration                可以是 NSString 或 NSAttributedString 或 NSDictionary
 *      NSDictionary的格式如下：
 *          @{@(UIControlStateNormal)   : @{@"title"            : NSAttributedString,
 *                                          @"image"            : NSString 或 UIImage,
 *                                          @"backgroundImage"  : NSString 或 UIImage,
 *                                          },
 *            @(UIControlStateSelected) : ...
 *            }
 *  @param didTapButtonBlock                  按钮被点击时的Action
 *  @param didTapViewBlock                    EmptyDataSet(size和scrollView一样)被点击时的Action
 *
 */
- (void)configureEmptyDataSetStyleWithtitle:(id)titleOrAttributedTitle
                                description:(id)descriptionOrAttributedDescription
                                      image:(id)imageNameOrImage
                        buttonConfiguration:(id)buttonConfiguration
                          didTapButtonBlock:(void(^)(UIScrollView *scrollView))didTapButtonBlock
                            didTapViewBlock:(void(^)(UIScrollView *scrollView))didTapViewBlock;

@end
