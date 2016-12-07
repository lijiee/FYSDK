//
//  FYAlert.m
//  FYSDK
//
//  Created by WorkHarder on 12/2/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYAlert.h"
#import "LGAlertView+Dismissable_Private_fy.h"

@implementation FYAlert

#pragma mark - ----------- 基础的 title + content -----------

+ (void)showAlertWithTitle:(NSString *)title content:(NSString *)content
                     style:(FYShowViewStyle)style
              buttonTitles:(NSArray *)buttonTitles
         cancelButtonTitle:(NSString *)cancelButtonTitle
    destructiveButtonTitle:(NSString *)destructiveButtonTitle
             actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler;
{
    [self showAlertWithTitle:title content:content
                       style:style buttonTitles:buttonTitles
           cancelButtonTitle:cancelButtonTitle
      destructiveButtonTitle:destructiveButtonTitle
               actionHandler:actionHandler cancelHandler:nil destructiveHandler:nil
                    animated:YES completionHandler:nil];
}

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
{
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:title message:content
                                                       style:(NSUInteger)style
                                                buttonTitles:buttonTitles
                                           cancelButtonTitle:cancelButtonTitle
                                      destructiveButtonTitle:destructiveButtonTitle
                                               actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                   if (actionHandler) {
                                                       actionHandler(title, index);
                                                   }
                                               } cancelHandler:^(LGAlertView *alertView) {
                                                   if (cancelHandler) {
                                                       cancelHandler();
                                                   }
                                               }
                                          destructiveHandler:^(LGAlertView *alertView) {
                                              if (destructiveHandler) {
                                                  destructiveHandler();
                                              }
                                          }];
    [alertView showAnimated:animated completionHandler:completionHandler];
}

#pragma mark - ----------- 自定义View -----------

+ (void)showViewAndTitle:(NSString *)title
                 content:(NSString *)content
                   style:(FYShowViewStyle)style
                    view:(FYDismissableView *)view
            buttonTitles:(NSArray *)buttonTitles
       cancelButtonTitle:(NSString *)cancelButtonTitle
  destructiveButtonTitle:(NSString *)destructiveButtonTitle
           actionHandler:(void(^)(NSString *title, NSUInteger index))actionHandler;
{
    [self showViewAndTitle:title content:content style:style view:view buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle actionHandler:actionHandler cancelHandler:nil destructiveHandler:nil animated:YES completionHandler:nil];
}


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
{
    LGAlertView *alertView = [LGAlertView alertViewWithViewAndTitle:title message:content
                                                              style:(NSUInteger)style
                                                               view:view
                                                       buttonTitles:buttonTitles
                                                  cancelButtonTitle:cancelButtonTitle
                                             destructiveButtonTitle:destructiveButtonTitle
                                                      actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                          if (actionHandler) {
                                                              actionHandler(title, index);
                                                          }
                                                      } cancelHandler:^(LGAlertView *alertView) {
                                                          if (cancelHandler) {
                                                              cancelHandler();
                                                          }
                                                      }
                                                 destructiveHandler:^(LGAlertView *alertView) {
                                                     if (destructiveHandler) {
                                                         destructiveHandler();
                                                     }
                                                 }];
    view.hostDismissable   = alertView;
    [alertView showAnimated:animated completionHandler:completionHandler];
}

#pragma mark - ----------- ActivityIndicator -----------

+ (void)showActivityIndicatorAndTitle:(NSString *)title content:(NSString *)content style:(FYShowViewStyle)style destructiveButtonTitle:(NSString *)destructiveButtonTitle destructiveHandler:(void (^)())destructiveHandler
{
    [self showActivityIndicatorAndTitle:title content:content
                                  style:style
                           buttonTitles:nil cancelButtonTitle:nil
                 destructiveButtonTitle:destructiveButtonTitle
                          actionHandler:nil cancelHandler:nil
                     destructiveHandler:destructiveHandler
                               animated:YES completionHandler:nil];
}

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
{
    LGAlertView *alertView = [LGAlertView alertViewWithActivityIndicatorAndTitle:title message:content
                                                                           style:(NSUInteger)style
                                                                    buttonTitles:buttonTitles
                                                               cancelButtonTitle:cancelButtonTitle
                                                          destructiveButtonTitle:destructiveButtonTitle
                                                                   actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                                       if (actionHandler) {
                                                                           actionHandler(title, index);
                                                                       }
                                                                   } cancelHandler:^(LGAlertView *alertView) {
                                                                       if (cancelHandler) {
                                                                           cancelHandler();
                                                                       }
                                                                   }
                                                              destructiveHandler:^(LGAlertView *alertView) {
                                                                  if (destructiveHandler) {
                                                                      destructiveHandler();
                                                                  }
                                                              }];
    [alertView showAnimated:animated completionHandler:completionHandler];
}

#pragma mark - ----------- Progress -----------

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
{
    LGAlertView *alertView = [LGAlertView alertViewWithProgressViewAndTitle:title message:content
                                                                      style:(NSUInteger)style
                                                          progressLabelText:progressLabelText
                                                               buttonTitles:buttonTitles
                                                          cancelButtonTitle:cancelButtonTitle
                                                     destructiveButtonTitle:destructiveButtonTitle
                                                              actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                                  if (actionHandler) {
                                                                      actionHandler(title, index);
                                                                  }
                                                              } cancelHandler:^(LGAlertView *alertView) {
                                                                  if (cancelHandler) {
                                                                      cancelHandler();
                                                                  }
                                                              }
                                                         destructiveHandler:^(LGAlertView *alertView) {
                                                             if (destructiveHandler) {
                                                                 destructiveHandler();
                                                             }
                                                         }];
    [alertView showAnimated:animated completionHandler:completionHandler];
    return alertView;
}



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
{
    LGAlertView *alertView = [LGAlertView alertViewWithTextFieldsAndTitle:title message:content
                                                       numberOfTextFields:numberOfTextFields
                                                   textFieldsSetupHandler:textFieldsSetupHandler
                                                             buttonTitles:buttonTitles
                                                        cancelButtonTitle:cancelButtonTitle
                                                   destructiveButtonTitle:destructiveButtonTitle
                                                            actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                                if (actionHandler) {
                                                                    actionHandler(title, index);
                                                                }
                                                            } cancelHandler:^(LGAlertView *alertView) {
                                                                if (cancelHandler) {
                                                                    cancelHandler();
                                                                }
                                                            }
                                                       destructiveHandler:^(LGAlertView *alertView) {
                                                           if (destructiveHandler) {
                                                               destructiveHandler();
                                                           }
                                                       }];
    [alertView showAnimated:animated completionHandler:completionHandler];
}

@end
