//
//  FYTableDataSourceDelegate.h
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  提高性能的懒加载思想，主要涉及UIScrollViewDelegate、Cell复用
 *  开始加载的时机
 *      1. 滚动停止时检测visibleCells，开始加载
 *      2. 在cellForIndexPath或will方法中用tableView.dragging == NO && tableView.decelerating == NO来决定是否要开启
 *
 *  停止加载的时机
 *      1. 如果使用SDWebImage，那么只需要在prepareForReuse中重置需要重新加载的资源，防止造成错乱
 *
 */

typedef NSString * (^GetCellResusableIdentifierBlock)(id itemData, NSIndexPath *indexPath);
typedef NSString * (^GetHeaderFooterResusableIdentifierBlock)(id itemData, NSInteger section);
typedef void (^DidSelectCellBlock)(id itemData, NSIndexPath *indexPath);

@interface FYTableDataSourceDelegate : NSObject

#pragma mark - ---------- Initialization ----------

+ (instancetype)dataSourceDelegateWithTableView:(UITableView *)tableView actionDelegate:(id)actionDelegate;


#pragma mark - ---------- Register Cell、Header、Footer ----------

- (void)fy_registerCells:(id)nibOrClassNameForIdentifier,...;
- (void)fy_registerHeaders:(id)nibOrClassNameForIdentifier,...;
- (void)fy_registerFooters:(id)nibOrClassNameForIdentifier,...;

- (void)fy_configureGetCellIdentifierBlock:(GetCellResusableIdentifierBlock)block;
- (void)fy_configureGetHeaderIdentifierBlock:(GetHeaderFooterResusableIdentifierBlock)block;
- (void)fy_configureGetFooterIdentifierBlock:(GetHeaderFooterResusableIdentifierBlock)block;


#pragma mark - ---------- Configuration ----------

- (void)fy_configureCellData:(NSArray *)cellDataArray hasMultiSection:(BOOL)hasMultiSection;
- (void)fy_configureHeaderData:(NSArray *)headerDataArray footerDataArray:(NSArray *)footerDataArray;
- (void)fy_configureDidSelectCellBlock:(DidSelectCellBlock)block;


#pragma mark - ---------- Reload Data ----------

- (void)fy_reloadCellData:(NSArray *)data;
- (void)fy_reloadCellData:(NSArray *)data headerData:(NSArray *)headerData footerData:(NSArray *)footerData;
- (void)fy_reloadMoreCellData:(NSArray *)data;
- (void)fy_reloadMoreCellData:(NSArray *)data headerData:(NSArray *)headerData footerData:(NSArray *)footerData;

@end
