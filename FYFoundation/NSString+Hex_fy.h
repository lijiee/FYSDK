//
//  NSString+Hex_fy.h
//  FoundationTools
//
//  Created by WorkHarder on 10/10/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex_fy)

+ (NSString *)get16RandomHexUppercaseString;
+ (NSString *)get16RandomHexLowercaseString;
+ (NSString *)get32RandomHexUppercaseString;
+ (NSString *)get32RandomHexLowercaseString;

+ (NSString *)getRandomHexUppercaseStringWithLength:(NSInteger)length;
+ (NSString *)getRandomHexLowercaseStringWithLength:(NSInteger)length;

@end
