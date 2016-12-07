//
//  FYPhotoBrowser.m
//  FYSDK
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYPhotoBrowser.h"
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface FYPhotoBrowser()

@property (nonatomic, strong) NSArray *photos;

@end

@implementation FYPhotoBrowser

- (void)presentFromViewController:(UIViewController *)viewControllerFrom originalView:(UIView *)originalView photoAssets:(NSArray *)photos initialIndex:(NSInteger)initialIndex showDeleteButton:(BOOL)showDeleteButton {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:photos.count];
    
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = YES;
    
    for (id photo in photos) {
        if ([photo isKindOfClass:[PHAsset class]]) {
            [[PHImageManager defaultManager] requestImageForAsset:photo targetSize:CGSizeMake(MAXFLOAT, MAXFLOAT) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [array addObject:[IDMPhoto photoWithImage:result]];
            }];
        } else {
            ALAsset *asset = photo;
            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage
                                                 scale:asset.defaultRepresentation.scale
                                           orientation:(UIImageOrientation)asset.defaultRepresentation.orientation];
            [array addObject:[IDMPhoto photoWithImage:image]];
        }
    }
    [self presentFromViewController:viewControllerFrom originalView:originalView Photos:[array copy] initialIndex:initialIndex showDeleteButton:showDeleteButton];
}

// 设计初始index、照片数组(含说明、占位图等)、
- (void)presentFromViewController:(UIViewController *)viewControllerFrom originalView:(UIView *)originalView Photos:(NSArray<IDMPhoto *> *)photos initialIndex:(NSInteger)initialIndex showDeleteButton:(BOOL)showDeleteButton {
    self.photos = photos;
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:originalView];
    browser.displayActionButton = NO;
    browser.autoHideInterface = NO;
    browser.displayDoneButton = NO;
    [browser setInitialPageIndex:initialIndex];
    
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:browser];
    [viewControllerFrom presentViewController:browser animated:YES completion:nil];
}

@end
