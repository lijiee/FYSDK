//
//  NSTimer+Block_fy.h
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block_fy)

+ (id)fy_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval tickBlock:(void (^)())tickBlock repeatBlock:(BOOL (^)())repeatBlock;

@end
