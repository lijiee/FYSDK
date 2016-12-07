//
//  FYBasePicker.m
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYBasePicker.h"

@interface FYBasePicker ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemNormalHeight;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *divideLines;


@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation FYBasePicker

#define CellIdentifier @"FYPickerCell"

#pragma mark - Setters

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.itemNormalHeight.constant = CGRectGetHeight(frame)/5;
}

- (void)setHighLightColor:(UIColor *)highLightColor {
    _highLightColor = highLightColor;
    
    for (UIView *view in _divideLines) {
        [view setBackgroundColor:highLightColor];
    }
    
    [FYPickerCell setHighLightColor:highLightColor];
}

- (void)initializeCollectionView:(UICollectionView *)col {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)col.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(self.itemNormalHeight.constant *2, 0, self.itemNormalHeight.constant *2, 0);
    
    [col registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    col.dataSource = (id)self;
    col.delegate = (id)self;
    
    [col reloadData];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView setContentOffset:CGPointMake(0, collectionView.contentInset.top + (indexPath.row) * self.itemNormalHeight.constant) animated:YES];
}

#pragma mark - UICollectionViewDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), self.itemNormalHeight.constant);
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    NSInteger floorIndex = (NSInteger)(targetContentOffset->y/self.itemNormalHeight.constant);
    if (velocity.y > 1) {
        targetContentOffset->y = (floorIndex + 1) * self.itemNormalHeight.constant;
    } else if (velocity.y < - 1) {
        targetContentOffset->y = floorIndex * self.itemNormalHeight.constant;
    } else {
        if (targetContentOffset->y - floorIndex * self.itemNormalHeight.constant > self.itemNormalHeight.constant*0.5) {
            targetContentOffset->y = (floorIndex + 1) * self.itemNormalHeight.constant;
        } else {
            targetContentOffset->y = floorIndex * self.itemNormalHeight.constant;
        }
    }
}

- (FYPickerCell *)getCellForCollectionView:(UICollectionView *)col atIndexPath:(NSIndexPath *)indexPath {
    return (FYPickerCell *)[col dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
}

@end
