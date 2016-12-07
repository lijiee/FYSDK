
//
//  IDMPhotoBrowser+fixanimation.m
//  KidneyPatient
//
//  Created by WorkHarder on 9/15/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "IDMPhotoBrowser+fixanimation.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import <IDMPhotoBrowser/IDMZoomingScrollView.h>

@interface IDMPhotoBrowser ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation IDMPhotoBrowser (fixanimation)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [IDMPhotoBrowser aspect_hookSelector:@selector(initWithPhotos:animatedFromView:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
            IDMPhotoBrowser *browser = [info instance];
            
            NSString *imagePathInBundleForClass = [NSString stringWithFormat:@"%@/IDMPhotoBrowser.bundle/images/", [[NSBundle bundleForClass:[IDMPhotoBrowser class]] resourcePath] ];
            browser.leftArrowImage = [UIImage imageNamed:[imagePathInBundleForClass stringByAppendingString:@"IDMPhotoBrowser_arrowLeft"]];
            browser.rightArrowImage = [UIImage imageNamed:[imagePathInBundleForClass stringByAppendingString:@"IDMPhotoBrowser_arrowRight"]];
            browser.displayActionButton = NO;
            browser.displayCounterLabel = YES;
        } error:nil];
        
        [IDMPhotoBrowser aspect_hookSelector:NSSelectorFromString(@"performLayout") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
            IDMPhotoBrowser *browser = [info instance];
            
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 20, 44, 44);
                button.backgroundColor = [UIColor redColor];
                [browser.view addSubview:button];
                browser.backButton = button;
                [button addTarget:browser action:@selector(didPressBackButton:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44, 20, 44, 44);
                button.backgroundColor = [UIColor greenColor];
                [browser.view addSubview:button];
                browser.deleteButton = button;
                [button addTarget:browser action:@selector(didPressDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        } error:nil];
        
        [IDMPhotoBrowser aspect_hookSelector:NSSelectorFromString(@"setControlsHidden:animated:permanent:") withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info, BOOL hidden, BOOL animated, BOOL permanent){
            IDMPhotoBrowser *browser = [info instance];
            
            [browser performSelector:NSSelectorFromString(@"cancelControlHiding")];
            
            // Captions
            NSMutableSet *visiblePages = [browser valueForKey:@"visiblePages"];
            NSMutableSet *captionViews = [[NSMutableSet alloc] initWithCapacity:visiblePages.count];
            for (IDMZoomingScrollView *page in visiblePages) {
                if (page.captionView) [captionViews addObject:page.captionView];
            }
            
            // Hide/show bars
            [UIView animateWithDuration:(animated ? 0.1 : 0) animations:^(void) {
                CGFloat alpha = hidden ? 0 : 1;
                [browser.navigationController.navigationBar setAlpha:alpha];
                [[browser valueForKey:@"toolbar"] setAlpha:alpha];
                [[browser valueForKey:@"doneButton"] setAlpha:alpha];
                for (UIView *v in captionViews) v.alpha = alpha;
                
                [browser.backButton setAlpha:alpha];
                [browser.deleteButton setAlpha:alpha];
            } completion:^(BOOL finished) {}];
            
            // Control hiding timer
            // Will cancel existing timer but only begin hiding if they are visible
            if (!permanent) [browser performSelector:NSSelectorFromString(@"hideControlsAfterDelay")];
            
            [browser setNeedsStatusBarAppearanceUpdate];
        } error:nil];
    });
}

- (IBAction)didPressBackButton:(id)sender {
    [self performSelector:NSSelectorFromString(@"doneButtonPressed:") withObject:nil];
}

- (IBAction)didPressDeleteButton:(id)sender {
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0, deleteIndex = [[self valueForKey:@"_currentPageIndex"] integerValue];
    for (id obj in [self valueForKey:@"photos"]) {
        if (index != deleteIndex) {
             [array addObject:obj];
        }
       
        index++;
    }
    
    if (array.count == 0) {
        [self performSelector:NSSelectorFromString(@"doneButtonPressed:") withObject:nil];
    } else {
        if (deleteIndex == array.count) {
            [self setValue:@(deleteIndex-1) forKey:@"_currentPageIndex"];
        }
        [self setValue:array forKey:@"photos"];
        [self reloadData];
    }
}


#pragma mark - Associated Objects

#define BackButtonKey @"IDMPhotoBrowserBackButton"
#define DeleteButtonKey @"IDMPhotoBrowserDeleteButton"

- (UIButton *)backButton {
    return objc_getAssociatedObject(self, BackButtonKey);
}

- (void)setBackButton:(UIButton *)backButton {
    objc_setAssociatedObject(self, BackButtonKey, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)deleteButton {
    return objc_getAssociatedObject(self, DeleteButtonKey);
}

- (void)setDeleteButton:(UIButton *)deleteButton {
    objc_setAssociatedObject(self, DeleteButtonKey, deleteButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
