//
//  FYTPAConstants.h
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#ifndef FYThirdPartAppSupport_FYTPAConstants_h
#define FYThirdPartAppSupport_FYTPAConstants_h


#import <Foundation/Foundation.h>

#pragma mark - ****************** 公共 ******************

typedef NS_ENUM(NSInteger, FYTPAPlatform) {
    FYTPAWechat = 0,
    FYTPAQQ,
    FYTPAXLWeibo,
    FYTPARenren,
    FYTPAAliPay,
};

FOUNDATION_EXTERN NSString *const FYTPAAppIdKey;
FOUNDATION_EXTERN NSString *const FYTPAAppSecretKey;



#pragma mark - ****************** 分享 ******************

FOUNDATION_EXTERN NSString *const FYShareContentTitleKey;
FOUNDATION_EXTERN NSString *const FYShareContentDescriptionKey;
FOUNDATION_EXTERN NSString *const FYShareContentThumbnailKey;
FOUNDATION_EXTERN NSString *const FYShareContentImageKey;
FOUNDATION_EXTERN NSString *const FYShareContentLinkUrlKey;
FOUNDATION_EXTERN NSString *const FYShareContentMultimediaTypeKey;

FOUNDATION_EXTERN NSString *const FYShareContentWechatExtInfoKey;
FOUNDATION_EXTERN NSString *const FYShareContentWechatMediaDataUrlKey;
FOUNDATION_EXTERN NSString *const FYShareContentWechatFileExtKey;


typedef NS_ENUM(NSInteger, FYShareTarget) {
    FYShareQQFriend             = 1, // -> QQ好友
    FYShareQQTimeline,               // -> QQ时间轴？
    FYShareQQFavorite,              // -> QQ收藏
    FYShareQQZone,                  // -> QQ空间
    
    FYShareWechatFriend,            // -> 微信好友
    FYShareWechatTimeline,          // -> 微信朋友圈
    FYShareWechatFavorite,          // -> 微信收藏
    
    FYShareXLWeibo,                 // -> 发布新浪微博
    
    FYShareRenrenFriend,            // -> 人人好友
    FYShareRenrenTimeline,          // -> 人人时间轴
};

typedef void (^ShareSuccess)(NSDictionary * message);
typedef void (^ShareFail)(NSDictionary * message,NSError *error);





#pragma mark - **************** 登录/认证 ****************

#define FYAuthWechatScope       @"snsapi_userinfo"
#define FYAuthQQScope           @"get_user_info"

FOUNDATION_EXTERN NSString *const FYAuthScopeKey;
FOUNDATION_EXTERN NSString *const FYAuthredirectURIKey;

typedef NS_ENUM(NSInteger, FYAuthPlatform) {
    FYAuthWechat    = FYTPAWechat,
    FYAuthQQ        = FYTPAQQ,
    FYAuthXLWeibo   = FYTPAXLWeibo,
};

typedef void (^AuthSuccess)(NSDictionary * message);
typedef void (^AuthFail)(NSDictionary * message,NSError *error);



#pragma mark - ****************** 支付 ******************

FOUNDATION_EXTERN NSString *const FYPaymentLinkUrlKey;

typedef NS_ENUM(NSInteger, FYPayMethod) {
    FYPayWechat,                // 微信
    FYPayAli,                   // 支付宝
};

typedef void (^PaySuccess)(NSDictionary * message);
typedef void (^PayFail)(NSDictionary * message,NSError *error);




#endif
