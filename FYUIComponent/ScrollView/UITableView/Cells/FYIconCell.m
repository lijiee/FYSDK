//
//  FYIconCell.m
//  FYSDK
//
//  Created by WorkHarder on 12/1/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYIconCell.h"
#import "UIView+FYViewAction.h"

@interface FYIconCell ()<FYListViewActionDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;


@end

@implementation FYIconCell

- (void)fy_configureWithData:(NSDictionary *)data delegate:(id<FYListViewActionDelegate>)actionDelegate {
    [super fy_configureWithData:data delegate:actionDelegate];
    
    if ([data[@"image"] isKindOfClass:[UIImage class]]) {
        [self.itemImageView setImage:data[@"image"]];
    }
    else if ([data[@"image"] isKindOfClass:[NSString class]]) {
        [self.itemImageView setImage:[UIImage imageNamed:data[@"image"]]];
    }
    else {
        self.itemImageView.image = nil;
    }
    
    self.itemNameLabel.text = data[@"name"];
}


@end
