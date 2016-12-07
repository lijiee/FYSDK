//
//  UITableViewCell+AsyncTask_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "UITableViewCell+AsyncTask_fy.h"
#import <Aspects/Aspects.h>

@implementation UITableViewCell (AsyncTask_fy)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        [UITableViewCell aspect_hookSelector:@selector(prepareForReuse) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
            UITableViewCell *cell = [info instance];
            [cell fy_stopAsynchronousTasksForCall];
        } error:&error];
        NSAssert(error==nil, @"swizzling prepareForReuse in UITableViewCell+AsyncTask_fy.m is failed: %@", error);
    });
}

@end
