//
//  FYImagePicker.m
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYImagePicker.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface FYImagePicker ()<TZImagePickerControllerDelegate>

@end

@implementation FYImagePicker

- (void)presentFromViewController:(UIViewController *)viewControllerFrom
                   selectedAssets:(NSArray *)assets
                       completion:(void(^)(NSArray<UIImage *> *images, NSArray *assets, BOOL isOriginalImage))completion
                     cancellation:(void(^)())cancellation
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    
    imagePickerVc.sortAscendingByModificationDate = NO;
    //[imagePickerVc.navigationBar setBarTintColor:[UIColor redColor]];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor redColor];
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.selectedAssets = [NSMutableArray arrayWithArray:assets];
    
//    imagePickerVc.photoSelImageName = @"photo_sel_photoPickerVc_custom";
//    imagePickerVc.photoNumberIconImageName = @"photo_number_icon_custom";
//    imagePickerVc.photoPreviewOriginDefImageName = @"preview_original_def_custom";
//    imagePickerVc.photoOriginSelImageName = @"photo_original_sel_custom";
    
    [imagePickerVc setDidFinishPickingPhotosHandle:completion];
    [imagePickerVc setImagePickerControllerDidCancelHandle:cancellation];
    
    [viewControllerFrom presentViewController:imagePickerVc animated:YES completion:nil];
}



//- (TZImagePickerController *)generateInnerPickerWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber pushPhotoPickerVc:(BOOL)pushPhotoPickerVc {
//    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount columnNumber:columnNumber delegate:nil pushPhotoPickerVc:pushPhotoPickerVc];
//    
//    return picker;
//}

@end
