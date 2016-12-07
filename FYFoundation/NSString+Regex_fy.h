//
//  NSString+Regex_fy.h
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex_fy)

+ (NSString *)fy_regex_Username;
+ (NSString *)fy_regex_Password;
+ (NSString *)fy_regex_HexValue;
+ (NSString *)fy_regex_Email;
+ (NSString *)fy_regex_URL;
+ (NSString *)fy_regex_ipv4Address;
+ (NSString *)fy_regex_HTMLTag;
+ (NSString *)fy_regex_Number;
+ (NSString *)fy_regex_IDCardNumber;
+ (NSString *)fy_regex_CarNumber;

@end
