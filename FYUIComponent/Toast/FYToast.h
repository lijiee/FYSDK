//
//  FYToast.h
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FYToast : NSObject

+ (void)showWithStatus:(NSString *)status;
+ (void)showSuccessWithStatus:(NSString *)status;

#pragma mark - ----------- Info -----------

+ (void)showInfoWithStatus:(NSString *)status;

/**
 *  将显示error.localizedDescription
 */
+ (void)showInfoWithError:(NSError *)error;

#pragma mark - ----------- Error -----------

+ (void)showErrorWithStatus:(NSString *)status;

/**
 *  将显示error.localizedDescription
 */
+ (void)showError:(NSError *)error;


+ (void)dismiss;

@end
