//
//  FYTPASupport.h
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYTPAConstants.h"

/**
 *  TPA：Third Party Application
 */
@interface FYTPASupport : NSObject

/**
 *  使用方法：插入到AppDelegate中的application:openURL:sourceApplication:annotation:
 *
 *  if ([FYTPASupport canHandleOpenURL:url]) {
 *      return YES;
 *  }
 *
 */
+ (BOOL)canHandleOpenURL:(NSURL*_Nullable)url;

/**
 *  检查手机是否安装了某个第三方App
 */
+ (BOOL)isTPAInstalled:(FYTPAPlatform)platform;

/**
 *  FYTPAWechat  -> FYTPAAppIdKey
 *  FYTPAQQ      -> FYTPAAppIdKey
 *  FYTPARenren  -> FYTPAAppIdKey、FYTPAAppSecretKey
 *  FYTPAAliPay  -> @{}                                 // 支付宝支付参数都是从服务器获得的，所以不需要注册key。但是还是需要先connect向OpenShare注册，以便回调。
 *  FYTPAXLWeibo -> FYTPAAppSecretKey
 */
+ (void)registerPlatformsWithConfiguration:(NSDictionary<NSNumber *,id> *_Nonnull (^_Nonnull)(void))configurationGenerator;


+ (void)beginShare:(FYShareTarget)targetPlatform messageConfigurator:(void(^_Nonnull)(NSMutableDictionary *_Nonnull shareMsg))msgConfigurator
           success:(_Nullable ShareSuccess)success
              fail:(_Nullable ShareFail)fail;


+ (void)beginAuth:(FYAuthPlatform)platform parametersConfigurator:(void(^_Nonnull)(NSMutableDictionary *_Nonnull params))paramsConfigurator
          success:(_Nullable AuthSuccess)success
             fail:(_Nullable AuthFail)fail;



/**
 *  详情连接：
 *     微信   - https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12
 *     支付宝 - https://doc.open.alipay.com/doc2/apiList?docType=4
 */
+ (void)beginPay:(FYPayMethod)platform parametersConfigurator:(void(^_Nonnull)(NSMutableDictionary *_Nonnull params))paramsConfigurator
         success:(_Nullable AuthSuccess)success
            fail:(_Nullable AuthFail)fail;




@end
