//
//  FYTableDataSourceDelegate.m
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYTableDataSourceDelegate.h"
#import "UIView+FYViewAction.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <objc/runtime.h>

@interface FYTableDataSourceDelegate ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL hasMultiSection;
@property (nonatomic, strong) NSArray *headerDataArray;
@property (nonatomic, strong) NSArray *footerDataArray;
@property (nonatomic, strong) NSArray *cellDataArray;

@property (nonatomic, copy) DidSelectCellBlock didSelectCellBlock;

@property (nonatomic, copy) GetCellResusableIdentifierBlock getCellIdentifierBlock;
@property (nonatomic, copy) GetHeaderFooterResusableIdentifierBlock getHeaderIdentifierBlock;
@property (nonatomic, copy) GetHeaderFooterResusableIdentifierBlock getFooterIdentifierBlock;

@property (nonatomic, weak) id tableDataSourceDelegate;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *footerIdentifier;

@end

@implementation FYTableDataSourceDelegate

+ (instancetype)dataSourceDelegateWithTableView:(UITableView *)tableView actionDelegate:(id)actionDelegate {
    FYTableDataSourceDelegate *instance = [FYTableDataSourceDelegate new];
    
    instance.tableView = tableView;
    instance.tableDataSourceDelegate = actionDelegate;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = instance;
    tableView.delegate = instance;
    
    return instance;
}

- (void)fy_configureCellData:(NSArray *)cellDataArray hasMultiSection:(BOOL)hasMultiSection {
    if (hasMultiSection) {
        for (NSArray *innerArray in cellDataArray) {
            NSParameterAssert([innerArray isKindOfClass:[NSArray class]]);
        }
    }
    
    self.hasMultiSection = hasMultiSection;
    self.cellDataArray = cellDataArray;
}

- (void)fy_configureHeaderData:(NSArray *)headerDataArray footerDataArray:(NSArray *)footerDataArray {
    if (headerDataArray.count != footerDataArray.count) {
        NSLog(@"Warning:  headerDataArray.count != footerDataArray.count");
    }
    
    self.headerDataArray = headerDataArray;
    self.footerDataArray = footerDataArray;
    self.hasMultiSection = YES;
}

- (void)fy_configureDidSelectCellBlock:(DidSelectCellBlock)block {
    self.didSelectCellBlock = block;
}

#pragma mark - Public Methods 之 Register

- (void)fy_registerCells:(id)nibOrClassNameForIdentifier,...;
{
    va_list argList;
    id arg;
    if (nibOrClassNameForIdentifier) {
        [self registerCell:nibOrClassNameForIdentifier];
        
        va_start(argList, nibOrClassNameForIdentifier);
        while ((arg = va_arg(argList, id))) {
            [self registerCell:arg];
        }
        va_end(argList);
    }
}

- (void)fy_registerHeaders:(id)nibOrClassNameForIdentifier, ...
{
    va_list argList;
    id arg;
    if (nibOrClassNameForIdentifier) {
        [self registerHeaderFooter:nibOrClassNameForIdentifier isHeader:YES];
        
        va_start(argList, nibOrClassNameForIdentifier);
        while ((arg = va_arg(argList, id))) {
            [self registerHeaderFooter:arg isHeader:YES];
        }
        va_end(argList);
    }
}

- (void)fy_registerFooters:(id)nibOrClassNameForIdentifier, ...
{
    va_list argList;
    id arg;
    if (nibOrClassNameForIdentifier) {
        [self registerHeaderFooter:nibOrClassNameForIdentifier isHeader:NO];
        
        va_start(argList, nibOrClassNameForIdentifier);
        while ((arg = va_arg(argList, id))) {
            [self registerHeaderFooter:arg isHeader:NO];
        }
        va_end(argList);
    }
}

- (void)fy_configureGetCellIdentifierBlock:(GetCellResusableIdentifierBlock)block {
    self.getCellIdentifierBlock = block;
}

- (void)fy_configureGetHeaderIdentifierBlock:(GetHeaderFooterResusableIdentifierBlock)block {
    self.getHeaderIdentifierBlock = block;
}

- (void)fy_configureGetFooterIdentifierBlock:(GetHeaderFooterResusableIdentifierBlock)block {
    self.getFooterIdentifierBlock = block;
}

#pragma mark - Public Methods 之 Reload

- (void)fy_reloadCellData:(NSArray *)data;
{
    self.cellDataArray = data;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)fy_reloadCellData:(NSArray *)data headerData:(NSArray *)headerData footerData:(NSArray *)footerData;
{
    NSParameterAssert(data.count == headerData.count);      // 没有对应数据，也应用[NSNull null]来填充
    NSParameterAssert(headerData.count == footerData.count);
    
    self.cellDataArray = data;
    self.headerDataArray = headerData;
    self.footerDataArray = footerData;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)fy_reloadMoreCellData:(NSArray *)data;
{
    _cellDataArray = (_cellDataArray == nil) ? data : [_cellDataArray arrayByAddingObjectsFromArray:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)fy_reloadMoreCellData:(NSArray *)data headerData:(NSArray *)headerData footerData:(NSArray *)footerData;
{
    NSParameterAssert(data.count == headerData.count);      // 没有对应数据，也应用[NSNull null]来填充
    NSParameterAssert(headerData.count == footerData.count);
    
    if (_cellDataArray == nil) {
        self.cellDataArray = data;
        self.headerDataArray = headerData;
        self.footerDataArray = footerData;
    }
    else {
        self.cellDataArray = [self.cellDataArray arrayByAddingObjectsFromArray:data];
        self.headerDataArray = [self.headerDataArray arrayByAddingObjectsFromArray:headerData];
        self.footerDataArray = [self.footerDataArray arrayByAddingObjectsFromArray:footerData];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hasMultiSection) {
        return self.cellDataArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.hasMultiSection) {
        return [[self.cellDataArray objectAtIndex:section] count];
    } else {
        return self.cellDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self dataForIndexPath:indexPath];
    NSString *identifier = [self cellIdentifierWithItemData:data atIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell fy_configureWithData:data delegate:self.tableDataSourceDelegate];
    
    return cell;
}



#pragma mark - UITableViewDelegate 之 height

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id data = [self dataForIndexPath:indexPath];
    NSString *identifier = [self cellIdentifierWithItemData:data atIndexPath:indexPath];
    
    Class cellClass = [self.tableView dequeueReusableCellWithIdentifier:identifier].class;
    if ([cellClass respondsToSelector:@selector(fy_heightForData:)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIView methodSignatureForSelector:@selector(fy_heightForData:)]];
        invocation.target = cellClass;
        invocation.selector = @selector(fy_heightForData:);
        [invocation setArgument:&data atIndex:2];
        [invocation invoke];
        CGFloat result;
        [invocation getReturnValue:&result];
        return result;
    }
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell fy_configureWithData:data delegate:nil];
    }];
    return height < 1 ? 44 : height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectCellBlock != nil) {
        self.didSelectCellBlock([self dataForIndexPath:indexPath], indexPath);
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    NSDictionary *data = self.headerDataArray[section];
    
    if (data) {
        UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self headerIdentifierWithItemData:data atSection:section]];
        [view fy_configureWithData:data delegate:self.tableDataSourceDelegate];
        
        return view;
    }
    
    return nil;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    NSDictionary *data = self.footerDataArray[section];
    
    if (data) {
        UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self footerIdentifierWithItemData:data atSection:section]];
        [view fy_configureWithData:data delegate:self.tableDataSourceDelegate];
        
        return view;
    }
    
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 开始耗时操作：比如加载网络资源
    [self startAsynchronousTasksForVisibleCells];
}

- (void)startAsynchronousTasksForVisibleCells {
    if (!self.tableView.isDragging && !self.tableView.isDecelerating) {
        for (NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([cell respondsToSelector:@selector(fy_startAsynchronousTasksForCall:)]) {
                [cell fy_startAsynchronousTasksForCall:[self dataForIndexPath:indexPath]];
            }
        }
    }
}

#pragma mark - Private Utils

- (void)registerCell:(id)name {
    
    NSParameterAssert([name isKindOfClass:[NSString class]]);

    id nib = [UINib nibWithNibName:name bundle:nil];
    if (nib) {
        [self.tableView registerNib:nib forCellReuseIdentifier:name];
        self.cellIdentifier = name;
        return;
    }
    
    id cellClass = NSClassFromString(name);
    if (cellClass) {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:name];
        self.cellIdentifier = name;
        return;
    }
}

- (void)registerHeaderFooter:(id)name isHeader:(BOOL)isHeader {
    
    NSParameterAssert([name isKindOfClass:[NSString class]]);
    
    id nib = [UINib nibWithNibName:name bundle:nil];
    if (nib) {
        [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:name];
        return;
    }
    
    id cellClass = NSClassFromString(name);
    if (cellClass) {
        [self.tableView registerClass:cellClass forHeaderFooterViewReuseIdentifier:name];
        return;
    }
}

#pragma mark - Private Utils 之 Identifier

- (NSString *)cellIdentifierWithItemData:(id)itemData atIndexPath:(NSIndexPath *)indexPath {
    if (self.getCellIdentifierBlock) {
        return self.getCellIdentifierBlock(itemData, indexPath);
    } else if(self.cellIdentifier) {
        return self.cellIdentifier;
    }
    
    NSAssert(self.cellIdentifier, @"cellIdentifier和getCellIdentifierBlock不能同时为空，否则无法重用cell");
    return nil;
}

- (NSString *)headerIdentifierWithItemData:(id)itemData atSection:(NSInteger)section {
    if (self.getHeaderIdentifierBlock) {
        return self.getHeaderIdentifierBlock(itemData, section);
    } else if(self.headerIdentifier) {
        return self.headerIdentifier;
    }
    
    NSAssert(NO, @"headerIdentifier和getHeaderIdentifierBlock不能同时为空，否则无法重用cell");
    return nil;
}

- (NSString *)footerIdentifierWithItemData:(id)itemData atSection:(NSInteger)section {
    if (self.getFooterIdentifierBlock) {
        return self.getFooterIdentifierBlock(itemData, section);
    } else if(self.footerIdentifier) {
        return self.footerIdentifier;
    }
    
    NSAssert(NO, @"footerIdentifier和getFooterIdentifierBlock不能同时为空，否则无法重用cell");
    return nil;
}

- (id)dataForIndexPath:(NSIndexPath *)indexPath {
    return (self.hasMultiSection) ? self.cellDataArray[indexPath.section][indexPath.row] : self.cellDataArray[indexPath.row];
}

@end