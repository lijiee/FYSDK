//
//  NSString+Regex_fy.m
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "NSString+Regex_fy.h"

@implementation NSString (Regex_fy)

+ (NSString *)fy_regex_Username;
{
    return @"/^[a-z0-9_-]{3,16}$/";
}

+ (NSString *)fy_regex_Password;
{
    return @"/^[a-z0-9_-]{6,18}$/";
}


+ (NSString *)fy_regex_HexValue;
{
    return @"/^#?([a-f0-9]{6}|[a-f0-9]{3})$/";
}


+ (NSString *)fy_regex_Email;
{
    return @"/^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$/";
}


+ (NSString *)fy_regex_URL;
{
    return @"/^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$/";
}


+ (NSString *)fy_regex_ipv4Address;
{
    return @"/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/";
}

+ (NSString *)fy_regex_HTMLTag;
{
    return @"/^<([a-z]+)([^<]+)*(?:>(.*)<\\/\\1>|\\s+\\/>)$/";
}

+ (NSString *)fy_regex_Number;
{
    return @"/^([-|+]?\\d+)(\\.)?(\\d+)?$/";
}


+ (NSString *)fy_regex_IDCardNumber;
{
    return @"/^(\\d{14}|\\d{17})(\\d|[xX])$/";
}

+ (NSString *)fy_regex_CarNumber;
{
    return @"/^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fff]$/";
}

@end
