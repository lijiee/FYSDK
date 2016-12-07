//
//  NSDate+Business_fy.h
//  FYSDK
//
//  Created by WorkHarder on 12/1/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Business_fy)

/**
 *  常用于发帖时间、信息发送/接收时间等需要根据时间点决定日期格式的封装
 */
- (NSString *)fy_timeAgoOrAccurateDateTime;
- (NSString *)fy_weekdayZH;


#pragma mark - 时间戳

+ (instancetype)fy_dateWithTimeIntervalSince1970WithTimeZone:(NSTimeInterval)secs;
- (NSTimeInterval)fy_timeIntervalSince1970WithTimeZone;

@end
