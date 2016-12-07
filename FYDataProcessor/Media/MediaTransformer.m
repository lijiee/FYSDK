//
//  MediaTransformer.m
//  FYSDK
//
//  Created by WorkHarder on 10/28/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "MediaTransformer.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MediaTransformer

- (UIImage *)transformToImageFrom:(id)mediaObject {
    __block UIImage *result;
    if ([mediaObject isKindOfClass:[PHAsset class]]) {
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.synchronous = YES;
        
        [[PHImageManager defaultManager] requestImageDataForAsset:mediaObject options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            result = [UIImage imageWithData:imageData];
        }];
    } else if ([mediaObject isKindOfClass:[ALAsset class]]) {
        ALAsset *asset = (ALAsset *)mediaObject;
        result = [UIImage imageWithCGImage: asset.defaultRepresentation.fullResolutionImage
                                     scale: asset.defaultRepresentation.scale
                               orientation: (UIImageOrientation)asset.defaultRepresentation.orientation];
    }
    
    return result;
}

@end
