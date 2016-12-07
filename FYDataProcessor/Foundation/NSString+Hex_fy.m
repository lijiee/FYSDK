//
//  NSString+Hex_fy.m
//  FoundationTools
//
//  Created by WorkHarder on 10/10/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "NSString+Hex_fy.h"

@implementation NSString (Hex_fy)

#define LowerCaseHex @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"a", @"b", @"c", @"d", @"e", @"f"]
#define UpperCaseHex @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", @"B", @"C", @"D", @"E", @"F"]

+ (NSString *)get32RandomHexUppercaseString {
    return [self getRandomHexStringWithLength:32 isUpperCase:YES];
}

+ (NSString *)get32RandomHexLowercaseString {
    return [self getRandomHexStringWithLength:32 isUpperCase:NO];
}

+ (NSString *)get16RandomHexUppercaseString {
    return [self getRandomHexStringWithLength:16 isUpperCase:YES];
}

+ (NSString *)get16RandomHexLowercaseString {
    return [self getRandomHexStringWithLength:16 isUpperCase:NO];
}

+ (NSString *)getRandomHexUppercaseStringWithLength:(NSInteger)length {
    return [self getRandomHexStringWithLength:length isUpperCase:YES];
}

+ (NSString *)getRandomHexLowercaseStringWithLength:(NSInteger)length {
    return [self getRandomHexStringWithLength:length isUpperCase:NO];
}

+ (NSString *)getRandomHexStringWithLength:(NSInteger)length isUpperCase:(BOOL)isUpper {
    NSMutableString *lowerCaseHexString = [NSMutableString string];
    
    NSArray *HEX = isUpper ? UpperCaseHex : LowerCaseHex;
    for (NSInteger index = 0; index < length; ++index) {
        [lowerCaseHexString appendString:HEX[arc4random_uniform(15)]];
    }
    
    return lowerCaseHexString;
}

@end
