//
//  FYTPAConstants.m
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYTPAConstants.h"

#pragma mark - ****************** 公共 ******************

NSString *const FYTPAAppIdKey       = @"appId";
NSString *const FYTPAAppSecretKey   = @"appSecret";


#pragma mark - ****************** 登录 ******************

/**
 *  QQ scope：
 *       get_user_info,get_simple_userinfo,add_album,add_idol,add_one_blog,add_pic_t,add_share,add_topic,check_page_fans,
 *       del_idol,del_t,get_fanslist,get_idollist,get_info,get_other_info,get_repost_list,list_album,upload_pic,
 *       get_vip_info,get_vip_rich_info,get_intimate_friends_weibo,match_nick_tips_weibo"
 */

NSString *const FYAuthScopeKey                          = @"scope";
NSString *const FYAuthredirectURIKey                    = @"redirectURI";

#pragma mark - ****************** 分享 ******************

NSString *const FYShareContentTitleKey                  = @"title";
NSString *const FYShareContentDescriptionKey            = @"desc";
NSString *const FYShareContentThumbnailKey              = @"thumbnail";
NSString *const FYShareContentImageKey                  = @"image";
NSString *const FYShareContentLinkUrlKey                = @"link";
NSString *const FYShareContentMultimediaTypeKey         = @"multimediaType";

NSString *const FYShareContentWechatExtInfoKey          = @"extInfo";
NSString *const FYShareContentWechatMediaDataUrlKey     = @"mediaDataUrl";
NSString *const FYShareContentWechatFileExtKey          = @"fileExt";


#pragma mark - ****************** 支付 ******************

NSString *const FYPaymentLinkUrlKey                     = @"paylink";