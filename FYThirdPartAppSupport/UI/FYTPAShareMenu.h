//
//  FYTPAShareMenu.h
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYTPASupport.h"

typedef NS_ENUM(NSInteger, FYShareTargetPadding) {
    FYShareQQFriendCopyLink = 51,
};

@interface FYTPAShareMenu : NSObject

/**
 *  @param itemArrays   NSNumber 可以是 FYShareTarget 或 FYShareTargetPadding
 */
- (_Nonnull instancetype)initWithItemRows:(NSArray<NSArray<NSNumber *> *> *_Nonnull)itemArrays
                      messageConfigurator:(void(^_Nonnull)(NSMutableDictionary *_Nonnull))msgConfigurator
                                  success:(void(^_Nonnull)(NSDictionary *_Nullable msg))completion
                                  failure:(void(^_Nonnull)(NSDictionary *_Nullable msg, NSError *_Nonnull error))completion;

- (void)show;
- (void)hide;

@end
