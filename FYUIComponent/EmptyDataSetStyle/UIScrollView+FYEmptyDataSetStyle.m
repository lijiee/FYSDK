//
//  UIScrollView+FYEmptyDataSetStyle.m
//  FYEmptyDataSetStyle
//
//  Created by WorkHarder on 11/9/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UIScrollView+FYEmptyDataSetStyle.h"
#import <UIImage-Resize/UIImage+Resize.h>
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface FYEmptyDataSetStyle : NSObject <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, copy) id titleOrAttributedTitle;
@property (nonatomic, copy) id descriptionOrAttributedDescription;
@property (nonatomic, copy) id imageNameOrImage;

@property (nonatomic, copy) id buttonConfiguration;

@property (nonatomic, copy) void (^didTapButtonBlock)(UIScrollView *);
@property (nonatomic, copy) void (^didTapViewBlock)(UIScrollView *);

@end

@implementation FYEmptyDataSetStyle

#define ReachabilityTestDomain          @"www.baidu.com"
#define NetworkUnavailableImageName     @"network_unavailable"
#define NetworkUnavailableTitle         @"网络状态不佳"
#define NetworkUnavailableDescription   @"请检查您的网络连接设置"
#define ImageSize CGSizeMake(200, 200)

#pragma mark - NetworkReachabilityStatusMonitor

+ (AFNetworkReachabilityManager *)reachabilityManager {
    static AFNetworkReachabilityManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFNetworkReachabilityManager managerForDomain:ReachabilityTestDomain];
        [manager startMonitoring];
    });
    return manager;
}

- (BOOL)isNetworkUnreachable {
    AFNetworkReachabilityStatus status = [self.class reachabilityManager].networkReachabilityStatus;
    
    if (status == AFNetworkReachabilityStatusUnknown) {
        
        if ([[self.class reachabilityManager] valueForKey:@"networkReachabilityStatusBlock"] == nil) {
            __weak typeof (self) weakSelf = self;
            [[self.class reachabilityManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                [weakSelf.scrollView reloadEmptyDataSet];
                [[weakSelf.class reachabilityManager] setReachabilityStatusChangeBlock:nil];
            }];
        }
    }
    return status == AFNetworkReachabilityStatusNotReachable;
}

#pragma mark - Initialization

- (instancetype)initWithView:(UIScrollView *)scrollView
                       title:(id)titleOrAttributedTitle
                 description:(id)descriptionOrAttributedDescription
                       image:(id)imageNameOrImage
         buttonConfiguration:(id)buttonConfiguration
           didTapButtonBlock:(void(^)(UIScrollView *scrollView))didTapButtonBlock
             didTapViewBlock:(void(^)(UIScrollView *scrollView))didTapViewBlock
{
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        self.titleOrAttributedTitle = titleOrAttributedTitle;
        self.descriptionOrAttributedDescription = descriptionOrAttributedDescription;
        self.imageNameOrImage = imageNameOrImage;
        self.buttonConfiguration = buttonConfiguration;
        
        self.didTapButtonBlock = didTapButtonBlock;
        self.didTapViewBlock = didTapViewBlock;
        
        scrollView.emptyDataSetSource = self;
        scrollView.emptyDataSetDelegate = self;
        if ([scrollView isKindOfClass:[UITableView class]]) {
            [(UITableView *)scrollView setTableFooterView:[UIView new]];
        }
    }
    return self;
}

- (void)checkParams {
    if (self.titleOrAttributedTitle != nil
        && ![self.titleOrAttributedTitle isKindOfClass:[NSString class]]
        && ![self.titleOrAttributedTitle isKindOfClass:[NSAttributedString class]]) {
        NSAssert(NO, @"titleOrAttributedTitle属性应使用 NSString 或 NSAttributedString 来设置");
    }
    
    
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *image;
    if ([self isNetworkUnreachable]) {
        image = [UIImage imageNamed:NetworkUnavailableImageName];
    }
    else if ([self.imageNameOrImage isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:self.imageNameOrImage];
    }
    else {
        image = self.imageNameOrImage;
    }
    if (image.size.width * image.size.height > ImageSize.width * ImageSize.height) {
        image = [image resizedImageToSize:ImageSize];
    }
    return image;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    
    if ([self isNetworkUnreachable] || [self.titleOrAttributedTitle isKindOfClass:[NSString class]]) {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                     };
        
        if ([self isNetworkUnreachable]) {
            return [[NSAttributedString alloc] initWithString:NetworkUnavailableTitle attributes:attributes];
        }
        else {
            return [[NSAttributedString alloc] initWithString:self.titleOrAttributedTitle attributes:attributes];
        }
    }
    else {
        return self.titleOrAttributedTitle;
    }
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    if ([self isNetworkUnreachable]) {
        return nil;
    }
    else if ([self.descriptionOrAttributedDescription isKindOfClass:[NSString class]]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing = 4;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                     NSParagraphStyleAttributeName : paragraphStyle,
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     };
        return [[NSAttributedString alloc] initWithString:self.descriptionOrAttributedDescription attributes:attributes];
    }
    else {
        return self.descriptionOrAttributedDescription;
    }
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if ([self isNetworkUnreachable]) {
        return nil;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 4;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid),
                                 NSForegroundColorAttributeName: [UIColor redColor],
                                 };
    
    if ([self.buttonConfiguration isKindOfClass:[NSString class]]) {
        return [[NSAttributedString alloc] initWithString:self.buttonConfiguration attributes:attributes];
    } else if ([self.buttonConfiguration isKindOfClass:[NSDictionary class]]) {
        id title = self.buttonConfiguration[@(state)][FYEmptyButtonTitleKey];
        if ([title isKindOfClass:[NSString class]]) {
            return [[NSAttributedString alloc] initWithString:title attributes:attributes];
        } else {
            return title;
        }
    } else {
        return self.buttonConfiguration;
    }
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if ([self isNetworkUnreachable]) {
        return nil;
    }
    
    if ([self.buttonConfiguration isKindOfClass:[NSDictionary class]]) {
        id image = self.buttonConfiguration[@(state)][FYEmptyButtonImageKey];
        if ([image isKindOfClass:[NSString class]]) {
            return [UIImage imageNamed:image];
        } else {
            return image;
        }
    }
    
    return nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if ([self isNetworkUnreachable]) {
        return nil;
    }
    
    if ([self.buttonConfiguration isKindOfClass:[NSDictionary class]]) {
        id image = self.buttonConfiguration[@(state)][FYEmptyButtonBackgroundImageKey];
        if ([image isKindOfClass:[NSString class]]) {
            return [UIImage imageNamed:image];
        } else {
            return image;
        }
    }
    
    return nil;
}

- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor lightGrayColor];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

#pragma mark - DZNEmptyDataSetDelegate

/* Actions */

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.didTapButtonBlock) {
        self.didTapButtonBlock(scrollView);
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.didTapViewBlock) {
        self.didTapViewBlock(scrollView);
    }
}


#pragma mark - MJRefresh fix

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    scrollView.mj_footer.hidden = YES;
    
    // 如果你想隐藏 UITableView 的 tableHeaderView，也在此处处理(.hidden = YES)
}

- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView {
    scrollView.mj_footer.hidden = NO;
    
    // 如果你隐藏过 UITableView 的 tableHeaderView，需在此处显示它(.hidden = NO)
}

@end

#pragma mark - ********** Public API **********

@interface UIScrollView ()

@property (nonatomic, strong) FYEmptyDataSetStyle *emptyStyle;

@end

@implementation UIScrollView (FYEmptyDataSetStyle)


- (void)configureEmptyDataSetStyleWithtitle:(id)titleOrAttributedTitle
                                description:(id)descriptionOrAttributedDescription
                                      image:(id)imageNameOrImage
                        buttonConfiguration:(id)buttonConfiguration
                          didTapButtonBlock:(void(^)(UIScrollView *scrollView))didTapButtonBlock
                            didTapViewBlock:(void(^)(UIScrollView *scrollView))didTapViewBlock
{
    self.emptyStyle = [[FYEmptyDataSetStyle alloc] initWithView:self
                                                          title:titleOrAttributedTitle
                                                    description:descriptionOrAttributedDescription
                                                          image:imageNameOrImage
                                            buttonConfiguration:buttonConfiguration
                                              didTapButtonBlock:didTapButtonBlock
                                                didTapViewBlock:didTapViewBlock];
}

#pragma mark - AssociatedObject
static char const * const kFYEmptyDataSetSource =     "fyEmptyDataSetSource";

- (FYEmptyDataSetStyle *)emptyStyle {
    return objc_getAssociatedObject(self, kFYEmptyDataSetSource);
}

- (void)setEmptyStyle:(FYEmptyDataSetStyle *)emptyStyle {
    objc_setAssociatedObject(self, kFYEmptyDataSetSource, emptyStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


