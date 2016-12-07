//
//  FYTPAShareMenu.m
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYTPAShareMenu.h"
#import "ZYShareView/ZYShareView.h"
#import "../FYTPASupport.h"

@interface FYTPAShareMenu ()

@property (nonatomic, strong) ZYShareView *internalShareView;

@end

@implementation FYTPAShareMenu

- (instancetype)initWithItemRows:(NSArray<NSArray<NSNumber *> *> *)itemArrays messageConfigurator:(void (^)(NSMutableDictionary * _Nonnull))msgGenerator success:(void (^)(NSDictionary * _Nullable))succ failure:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))fail {
    
    NSMutableDictionary *shareContent = [NSMutableDictionary dictionary];
    msgGenerator(shareContent);
    
    
    ZYShareItem *item = [ZYShareItem itemWithTitle:@"good" icon:@"fuck" handler:^{
        //[FYTPASupport beginShare:<#(FYShareTarget)#> messageConfigurator:msgGenerator success:succ fail:fail];
    }];
    return nil;
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.internalShareView show];
    });
}

- (void)hide {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.internalShareView hide];
    });
}

@end
