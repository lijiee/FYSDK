//
//  FYPickerCell.h
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYPickerCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *elementLabel;

+ (void)setHighLightColor:(UIColor *)highLightColor;

@end
