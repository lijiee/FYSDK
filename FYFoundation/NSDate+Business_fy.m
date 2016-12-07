//
//  NSDate+Business_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/1/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "NSDate+Business_fy.h"
#import <DateTools/DateTools.h>

@implementation NSDate (Business_fy)

- (NSString *)fy_timeAgoOrAccurateDateTime {
    NSDate *now = [NSDate date];
    
    NSDate *date = self;
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    long secsAgo = (long)[now secondsFrom:date];
    
    if ([date isToday]) {
        if (secsAgo < 30) {
            return @"刚刚";
        } else if (secsAgo < 60*60) {
            return [NSString stringWithFormat:@"%ld分钟前", secsAgo/60];
        } else if (secsAgo < 10*60*60) {
            return [NSString stringWithFormat:@"%ld小时前", secsAgo/(60*60)];
        } else {
            return [date formattedDateWithFormat:@"今天 HH:mm" timeZone:timeZone];
        }
    }
    if ([date isYesterday]) {
        return [date formattedDateWithFormat:@"昨天 HH:mm" timeZone:timeZone];
    }
    if ([date year] == [now year]) {
        return [date formattedDateWithFormat:@"MM月dd日 HH:mm" timeZone:timeZone];
    }
    
    return [date formattedDateWithFormat:@"yyyy-MM-dd HH:mm" timeZone:timeZone];
}

- (NSString *)fy_weekdayZH {
    NSArray *arr = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", ];
    return arr[[self weekday]];
}

#define FYTimeZoneDelta 8

+ (instancetype)fy_dateWithTimeIntervalSince1970WithTimeZone:(NSTimeInterval)secs {
    return [NSDate dateWithTimeIntervalSince1970:secs+FYTimeZoneDelta*3600];
}

- (NSTimeInterval)fy_timeIntervalSince1970WithTimeZone {
    return [self timeIntervalSince1970] - FYTimeZoneDelta * 3600;
}

@end
