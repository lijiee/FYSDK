//
//  FYTPASupport.m
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYTPASupport.h"
#import <OpenShare/OpenShareHeader.h>
#import "OSMessage+DictionarySupport.h"

@implementation FYTPASupport

+ (BOOL)canHandleOpenURL:(NSURL *)url {
    return [OpenShare handleOpenURL:url];
}

+ (BOOL)isTPAInstalled:(FYTPAPlatform)platform {
    switch (platform) {
        case FYTPAWechat:
            return [OpenShare isWeixinInstalled];
        case FYTPAQQ:
            return [OpenShare isQQInstalled];
        case FYTPAXLWeibo:
            return [OpenShare isWeiboInstalled];
        case FYTPARenren:
            return [OpenShare isRenrenInstalled];
        case FYTPAAliPay:
            return [OpenShare canOpen:@"alipay://"];
    }
    
    NSAssert(NO, @"暂不支持 FYTPAPlatform 定义之外的平台");
    return NO;
}

+ (void)registerPlatformsWithConfiguration:(NSDictionary<NSNumber *,id> * _Nonnull (^)(void))configurationGenerator {
    
    NSDictionary *config = configurationGenerator();
    
    [config keysOfEntriesPassingTest:^BOOL(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        NSParameterAssert([key isKindOfClass:[NSNumber class]]);
        
        switch ([key integerValue]) {
            case FYTPAWechat: {
                NSParameterAssert([obj[FYTPAAppIdKey] isKindOfClass:[NSString class]]);
                [OpenShare connectWeixinWithAppId:obj[FYTPAAppIdKey]];
                break;
            }
                
            case FYTPAQQ: {
                NSParameterAssert([obj[FYTPAAppIdKey] isKindOfClass:[NSString class]]);
                [OpenShare connectQQWithAppId:obj[FYTPAAppIdKey]];
                break;
            }
                
            case FYTPAXLWeibo: {
                NSParameterAssert([obj[FYTPAAppSecretKey] isKindOfClass:[NSString class]]);
                [OpenShare connectWeiboWithAppKey:obj[FYTPAAppSecretKey]];
            }
                
            case FYTPAAliPay: {
                [OpenShare connectAlipay];
            }
                
            case FYTPARenren: {
                NSParameterAssert([obj[FYTPAAppIdKey] isKindOfClass:[NSString class]]);
                NSParameterAssert([obj[FYTPAAppSecretKey] isKindOfClass:[NSString class]]);
                [OpenShare connectRenrenWithAppId:obj[FYTPAAppIdKey] AndAppKey:obj[FYTPAAppSecretKey]];
            }
                
            default:
                NSAssert(NO, @"registerPlatformsWithConfiguration: => key(:%@) is not in FYTPAPlatform(defined in FYTPAConstants.h)", key);
                break;
        }

        return YES;
    }];
}

+ (void)beginAuth:(FYAuthPlatform)authPlatform ParametersGenerator:(NSDictionary<NSString *,id> * _Nonnull (^)(void))paramsGenerator Success:(AuthSuccess)success Fail:(AuthFail)fail {
    NSDictionary *params = paramsGenerator!=nil?paramsGenerator():nil;

    
    if (![self isTPAInstalled:(FYTPAPlatform)authPlatform]) {
        if (fail) {
            fail(nil, [NSError errorWithDomain:@"Local" code:400 userInfo:@{NSLocalizedDescriptionKey:@"设备未安装该应用"}]);
        }
        return;
    }
    
    switch (authPlatform) {
        case FYAuthWechat: {
            [OpenShare WeixinAuth:params[FYAuthScopeKey]?:FYAuthWechatScope Success:success Fail:fail];
            break;
        }
            
        case FYAuthQQ: {
            [OpenShare QQAuth:params[FYAuthScopeKey]?:FYAuthQQScope Success:success Fail:fail];
            break;
        }
            
        case FYAuthXLWeibo: {
            NSParameterAssert([params[FYAuthScopeKey] isKindOfClass:[NSString class]]);
            NSParameterAssert([params[FYAuthredirectURIKey] isKindOfClass:[NSString class]]);
            [OpenShare WeiboAuth:params[FYAuthScopeKey] redirectURI:params[FYAuthredirectURIKey] Success:success Fail:fail];
            break;
        }

    }
}

+ (void)beginShare:(FYShareTarget)targetPlatform MessageGenerator:(NSDictionary<NSString *,id> * _Nonnull (^)(void))msgGenerator Success:(ShareSuccess)success Fail:(ShareFail)fail {

    NSDictionary *msg = msgGenerator();

    void (^tmpSuccessBlock)(OSMessage *) = nil;
    void (^tmpFailureBlock)(OSMessage *, NSError *) = nil;
    
    tmpSuccessBlock = ^(OSMessage *message) {
        if (success) {
            success(msg);
        }
    };
    
    if (fail) {
        tmpFailureBlock = ^(OSMessage *message, NSError *error) {
            fail(msg, error);
        };
    }
    
    OSMessage *osMsg = [[OSMessage alloc] initWithDictionary:msg];
    switch (targetPlatform) {
        /* QQ */
        case FYShareQQFriend: {
            [OpenShare shareToQQFriends:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
        case FYShareQQTimeline: {
            [OpenShare shareToQQDataline:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
        case FYShareQQFavorite: {
            [OpenShare shareToQQFavorites:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
        case FYShareQQZone: {
            [OpenShare shareToQQZone:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
            
        /* 微信 */
        case FYShareWechatFriend: {
            [OpenShare shareToWeixinSession:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
        case FYShareWechatTimeline: {
            [OpenShare shareToWeixinTimeline:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
        case FYShareWechatFavorite: {
            [OpenShare shareToWeixinFavorite:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
          
        /* 微博 */
        case FYShareXLWeibo: {
            [OpenShare shareToWeibo:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
            
        /* 人人 */
        case FYShareRenrenFriend: {
            [OpenShare shareToRenrenSession:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
            
        case FYShareRenrenTimeline: {
            [OpenShare shareToRenrenTimeline:osMsg Success:tmpSuccessBlock Fail:tmpFailureBlock];
            break;
        }
    }
    
}


+ (void)beginPay:(FYPayMethod)platform ParametersGenerator:(NSDictionary<NSString *,id> * _Nonnull (^)(void))paramsGenerator Success:(AuthSuccess)success Fail:(AuthFail)fail {
    NSDictionary *params = paramsGenerator();

    NSAssert([params[FYPaymentLinkUrlKey] isKindOfClass:[NSString class]], @"params[FYPaymentLinkUrlKey] 不符合要求，请让服务器端直接给出拼好的url，不要再让多个客户端都做这种繁琐无意义的拼接了");
    
    switch (platform) {
        case FYPayWechat: {
            [OpenShare WeixinPay:params[FYPaymentLinkUrlKey] Success:success Fail:fail];
            break;
        }
            
        case FYPayAli: {
            [OpenShare AliPay:params[FYPaymentLinkUrlKey] Success:success Fail:fail];
            break;
        }
    }
}

@end
