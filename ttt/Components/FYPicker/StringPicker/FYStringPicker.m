//
//  FYStringPicker.m
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYStringPicker.h"

typedef NS_ENUM(NSInteger, PickerType) {
    SingleValuePicker = 0,
    DoubleValuePicker,
};

@interface FYStringPicker ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *value1CollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *value2CollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *value1CollectionViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *value2CollectionViewWidth;

@property (nonatomic, copy) NSArray *options;

@property (nonatomic, assign) NSInteger selectedIndex1;
@property (nonatomic, assign) NSInteger selectedIndex2;

@property (nonatomic, assign) PickerType type;

@end

@implementation FYStringPicker

+ (instancetype)pickerWithFrame:(CGRect)frame options:(NSArray *)options selectedStrings:(NSArray *)selecteds {
    return [self pickerWithFrame:frame options:options withSectionWidth:nil selectedStrings:selecteds];
}

+ (instancetype)pickerWithFrame:(CGRect)frame options:(NSArray *)options withSectionWidth:(NSArray<NSNumber *> *)widths
                  selectedStrings:(NSArray *)selecteds
{
    FYStringPicker *picker;
    NSAssert(options.count > 0, @"options数组不能为空");
    
    if ([options[0] isKindOfClass:[NSDictionary<id<PickableValue>, NSArray<id<PickableValue>> *> class]]) {
        picker = [[[NSBundle mainBundle] loadNibNamed:@"FYStringDoublePicker" owner:nil options:nil] lastObject];
        picker.type = DoubleValuePicker;
    } else if ([options[0] conformsToProtocol:@protocol(PickableValue)]) {
        picker = [[[NSBundle mainBundle] loadNibNamed:@"FYStringSinglePicker" owner:nil options:nil] lastObject];
        picker.type = SingleValuePicker;
        
        if (selecteds.count > 0 && ![selecteds[0] isKindOfClass:[NSNull class]]) {
            NSInteger index = [options indexOfObject:selecteds[0]];
            if (index != NSNotFound) {
                [picker animateToIndexes:@[@(index)]];
            }
        }
        
    } else {
        NSAssert(NO, @"options数组不符合要求");
    }
    picker.frame = frame;

    picker.options = options;
    
    if (widths.count > 0) {
        picker.value1CollectionViewWidth.constant = [widths[0] doubleValue];
    }
    if (widths.count > 1) {
        picker.value2CollectionViewWidth.constant = [widths[1] doubleValue];
    }
    
    [picker initializeCollectionView:picker.value1CollectionView];
    [picker initializeCollectionView:picker.value2CollectionView];
    
    return picker;
}

- (void)animateToIndexes:(NSArray *)arr {
    self.selectedIndex1 = [arr[0] integerValue];
    
    [CATransaction begin];
    [self.value1CollectionView reloadData];
    [CATransaction setCompletionBlock:^{
        _selectedIndex1 = MIN(_selectedIndex1, [self collectionView:self.value1CollectionView numberOfItemsInSection:0]-1);
        [self.value1CollectionView setContentOffset:CGPointMake(0, _selectedIndex1*self.itemNormalHeight.constant + self.value1CollectionView.contentInset.top)];
    }];
    [CATransaction commit];
}

#pragma mark - 联动

- (void)setSelectedIndex1:(NSInteger)selectedIndex1 {
    _selectedIndex1 = selectedIndex1;
    
    if (self.value2CollectionView) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self.value2CollectionView reloadData];
        [CATransaction setCompletionBlock:^{
            _selectedIndex2 = MIN(_selectedIndex2, [self collectionView:self.value2CollectionView numberOfItemsInSection:0]-1);
            [self.value2CollectionView setContentOffset:CGPointMake(0, _selectedIndex2*self.itemNormalHeight.constant + self.value2CollectionView.contentInset.top)];
        }];
        [CATransaction commit];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.value1CollectionView]) {
        return self.options.count;
    } else {
        return [[self.options[_selectedIndex1] allValues][0] count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FYPickerCell *cell = [super getCellForCollectionView:collectionView atIndexPath:indexPath];
    
    if ([collectionView isEqual:self.value1CollectionView]) {
        if (self.type == SingleValuePicker) {
            cell.elementLabel.text = [self.options[indexPath.row] valueToPick];
        } else if (self.type == DoubleValuePicker) {
            cell.elementLabel.text = [[self.options[indexPath.row] allKeys][0] valueToPick];
        }
        cell.selected = self.selectedIndex1 == indexPath.row;
    } else {
        cell.elementLabel.text = [[self.options[_selectedIndex1] allValues][0][indexPath.row] valueToPick];
        cell.selected = self.selectedIndex2 == indexPath.row;
    }
    
    return cell;
}



#pragma mark - Scroll

- (void)scrollViewDidScroll:(UICollectionView *)collectionView {
    for (FYPickerCell *cell in collectionView.visibleCells) {

        if (fabs(CGRectGetMidY(cell.frame) - (collectionView.contentOffset.y + self.itemNormalHeight.constant *2.5)) < self.itemNormalHeight.constant * 0.5) {
            
            if ([collectionView isEqual:self.value1CollectionView]) {
                self.selectedIndex1 = [collectionView indexPathForCell:cell].row;
            } else {
                self.selectedIndex2 = [collectionView indexPathForCell:cell].row;
            }
            cell.selected = YES;
        } else {
            cell.selected = NO;
        }
    }
}

- (NSArray<id<PickableValue>> *)selectedObjects {
    if (self.type == SingleValuePicker) {
        return @[self.options[_selectedIndex1]];
    } else if (self.type == DoubleValuePicker) {
        return @[self.options[_selectedIndex1],
                 [self.options[_selectedIndex1] allValues][0][_selectedIndex2],
                 ];
    }
    
    return nil;
}

@end
