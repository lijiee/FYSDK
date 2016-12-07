//
//  FYAlert.h
//  FYSDK
//
//  Created by WorkHarder on 12/2/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYDismissableView.h"

/**
 *  目前只支持Alert和ActionSheet
 */
typedef NS_ENUM(NSUInteger, FYShowViewStyle)
{
    FYShowViewStyleStyleAlert                   = 0,
    FYShowViewStyleStyleActionSheet             = 1,
    FYShowViewStyleBottomToolBar,
    FYShowViewStylePopFromViewOrAlert,
    FYShowViewStylePopFromViewOrActionSheet,
    FYShowViewStylePopFromViewOrBottomToolBar,
};

@interface FYAlert : NSObject

#pragma mark - ----------- 基础的 title + content -----------

+ (void)showAlertWithTitle:(NSString *)title content:(NSString *)content
                     style:(FYShowViewStyle)style
              buttonTitles:(NSArray *)buttonTitles
         cancelButtonTitle:(NSString *)cancelButtonTitle
    destructiveButtonTitle:(NSString *)destructiveButtonTitle
             actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler;

+ (void)showAlertWithTitle:(NSString *)title content:(NSString *)content
                     style:(FYShowViewStyle)style
              buttonTitles:(NSArray *)buttonTitles
         cancelButtonTitle:(NSString *)cancelButtonTitle
    destructiveButtonTitle:(NSString *)destructiveButtonTitle
             actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler
             cancelHandler:(void(^)(void))cancelHandler
        destructiveHandler:(void(^)(void))destructiveHandler
                  animated:(BOOL)animated
         completionHandler:(void(^)())completionHandler;

#pragma mark - ----------- 自定义View -----------

+ (void)showViewAndTitle:(NSString *)title
                 content:(NSString *)content
                   style:(FYShowViewStyle)style
                    view:(FYDismissableView *)view
            buttonTitles:(NSArray *)buttonTitles
       cancelButtonTitle:(NSString *)cancelButtonTitle
  destructiveButtonTitle:(NSString *)destructiveButtonTitle
           actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler;

+ (void)showViewAndTitle:(NSString *)title
                 content:(NSString *)content
                   style:(FYShowViewStyle)style
                    view:(FYDismissableView *)view
            buttonTitles:(NSArray *)buttonTitles
       cancelButtonTitle:(NSString *)cancelButtonTitle
  destructiveButtonTitle:(NSString *)destructiveButtonTitle
           actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler
           cancelHandler:(void(^)())cancelHandler
      destructiveHandler:(void(^)())destructiveHandler
                animated:(BOOL)animated
       completionHandler:(void(^)())completionHandler;


#pragma mark - ----------- ActivityIndicator -----------

+ (void)showActivityIndicatorAndTitle:(NSString *)title
                              content:(NSString *)content
                                style:(FYShowViewStyle)style
               destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   destructiveHandler:(void(^)())destructiveHandler;

+ (void)showActivityIndicatorAndTitle:(NSString *)title
                              content:(NSString *)content
                                style:(FYShowViewStyle)style
                         buttonTitles:(NSArray *)buttonTitles
                    cancelButtonTitle:(NSString *)cancelButtonTitle
               destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler
                        cancelHandler:(void(^)())cancelHandler
                   destructiveHandler:(void(^)())destructiveHandler
                             animated:(BOOL)animated
                    completionHandler:(void(^)())completionHandler;

#pragma mark - ----------- progressBar -----------

+ (id<FYDismissable>)showProgressViewAndTitle:(NSString *)title
                                      content:(NSString *)content
                                        style:(FYShowViewStyle)style
                            progressLabelText:(NSString *)progressLabelText
                                 buttonTitles:(NSArray *)buttonTitles
                            cancelButtonTitle:(NSString *)cancelButtonTitle
                       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler
                                cancelHandler:(void(^)())cancelHandler
                           destructiveHandler:(void(^)())destructiveHandler
                                     animated:(BOOL)animated
                            completionHandler:(void(^)())completionHandler;

#pragma mark - ----------- textfields -----------

/**
 *  带输入框的弹出视图
 *
 *  @param style                  目前只支持FYShowViewStyleStyleAlert
 *  @param textFieldsSetupHandler 配置样式等
 */
+ (void)showTextFieldsAndTitle:(NSString *)title
                       content:(NSString *)content
                         style:(FYShowViewStyle)style
            numberOfTextFields:(NSUInteger)numberOfTextFields
        textFieldsSetupHandler:(void(^)(UITextField *textField, NSUInteger index))textFieldsSetupHandler
                  buttonTitles:(NSArray *)buttonTitles
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler
                 cancelHandler:(void(^)())cancelHandler
            destructiveHandler:(void(^)())destructiveHandler
                      animated:(BOOL)animated
             completionHandler:(void(^)())completionHandler;

@end
