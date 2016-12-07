//
//  NSBundle+TZImagePickerFix_fy.m
//  FYUIComponent
//
//  Created by WorkHarder on 10/25/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "NSBundle+TZImagePickerFix_fy.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import "UIImage+TintColor_fy.h"

@implementation NSBundle (TZImagePickerFix_fy)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [objc_getMetaClass("NSBundle") aspect_hookSelector:NSSelectorFromString(@"tz_imagePickerBundle") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
//            NSBundle *bundle;
//            [[info originalInvocation] getReturnValue:&bundle];
//            
//            if (bundle == nil) {
//                NSBundle *parentBundle = [NSBundle bundleForClass:NSClassFromString(@"TZImagePickerController")];
//                NSString *path = [parentBundle pathForResource:@"TZImagePickerController" ofType:@"bundle"];
//                bundle = [NSBundle bundleWithPath:path];
//                [[info originalInvocation] setReturnValue:&bundle];
//            }
//        } error:nil];
//    });
//}

@end


@implementation UIImage (TZImagePickerFix_fy)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method original = class_getClassMethod(objc_getMetaClass("UIImage"), NSSelectorFromString(@"imageNamedFromMyBundle:"));
        Method replace = class_getClassMethod(objc_getMetaClass("UIImage"), @selector(imageNamedFromMyBundle_fy:));
        method_exchangeImplementations(original, replace);
    });
}

+ (UIImage *)imageNamedFromMyBundle_fy:(NSString *)name {
    UIImage *image = [self imageNamedFromMyBundle_fy:name];
    
    NSArray *arr = @[@"photo_sel_photoPickerVc.png", @"photo_number_icon.png", @"photo_sel_previewVc.png", @"preview_number_icon.png"];

    if ([arr containsObject:name]) {
        NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:@[@(kCGBlendModeLuminosity), @(kCGBlendModeDestinationIn)]];
        image = [image fy_imageWithTintColor:[UIColor blueColor] blendModes:set];
    } else {
        image = image;
    }
    return image;
}

@end
