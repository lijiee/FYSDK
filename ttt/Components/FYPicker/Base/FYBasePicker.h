//
//  FYBasePicker.h
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYPickerCell.h"
#import "FYPrivateHeader.h"

@class FYBasePicker;



@interface FYBasePicker : UIView

@property (weak, nonatomic, readonly) IBOutlet NSLayoutConstraint *itemNormalHeight;

//@property (nonatomic ,strong) NSString *title;
//@property (nonatomic ,strong) UIView *headerView;
@property (strong, nonatomic) UIColor *highLightColor;
//@property (copy,   nonatomic) FYActionDoneBlock doneBlock;
@property (copy,   nonatomic) FYActionDoneBlock monitorBlock;
//@property (copy,   nonatomic) FYActionCancelBlock cancelBlock;

/**
 *  初始化指定UICollectionView，包括注册cell、设置sectionInset等
 */
- (void)initializeCollectionView:(UICollectionView *)col;
- (FYPickerCell *)getCellForCollectionView:(UICollectionView *)col atIndexPath:(NSIndexPath *)indexPath;

@end
