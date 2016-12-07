//
//  TableCellViewController.m
//  FYSDK
//
//  Created by WorkHarder on 12/4/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "TableCellViewController.h"
#import "FYTableDataSourceDelegate.h"

@interface TableCellViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FYTableDataSourceDelegate *dataSource;

@end

@implementation TableCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [FYTableDataSourceDelegate dataSourceDelegateWithTableView:self.tableView actionDelegate:self];
    [self.dataSource fy_registerCells:@"NotificationCell", nil];
    [self.dataSource fy_configureDidSelectCellBlock:^(id itemData, NSIndexPath *indexPath) {
        NSLog(@"%@, %@", itemData, indexPath);
    }];
    
    NSArray *arr = @[@{@"title":@"aaaaa",
                       @"content":@"bbbbb",
                       @"time":@"cccccc"
                      },
                     @{@"title":@"dddddd",
                       @"content":@"eeeeee",
                       @"time":[NSDate date]
                       },];
    [self.dataSource fy_reloadCellData:arr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
