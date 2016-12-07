//
//  FYDatePicker.m
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYDatePicker.h"
#import <DateTools/DateTools.h>

@interface FYDatePicker ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *yearCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *monthCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *dayCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *hourCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *minuteCollectionView;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSDictionary<NSNumber *, NSValue *> *> *calendarDictionary;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSValue *> *rangeMonthDictionary;
@property (nonatomic, assign) NSRange yearRange;

@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, assign) NSInteger selectedDay;
@property (nonatomic, assign) NSInteger selectedHour;
@property (nonatomic, assign) NSInteger selectedMinute;

@end


@implementation FYDatePicker

+ (instancetype)pickerWithFrame:(CGRect)frame datePickerMode:(FYDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate monitorBlock:(FYDateActionDoneBlock)monitorBlock
{
    FYDatePicker *picker;
    switch (datePickerMode) {
        case FYDatePickerModeDate:
            picker = [[[NSBundle mainBundle] loadNibNamed:@"FYDatePicker" owner:nil options:nil] lastObject];
            break;
        case FYDatePickerModeDateAndTime:
            picker = [[[NSBundle mainBundle] loadNibNamed:@"FYDateTimePicker" owner:nil options:nil] lastObject];
            break;
        case FYDatePickerModeYearMonth:
            picker = [[[NSBundle mainBundle] loadNibNamed:@"FYDatePickerYearMonth" owner:nil options:nil] lastObject];
            break;
        default:
            break;
    }
    picker.frame = frame;
    
    
    [picker initializeCollectionView:picker.yearCollectionView];
    [picker initializeCollectionView:picker.monthCollectionView];
    [picker initializeCollectionView:picker.dayCollectionView];
    [picker initializeCollectionView:picker.hourCollectionView];
    [picker initializeCollectionView:picker.minuteCollectionView];
    
    
    [picker setSelectedDate:selectedDate minimumDate:minimumDate maximumDate:maximumDate monitorBlock:monitorBlock];
    
    return picker;
    
}

- (void)setSelectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate monitorBlock:(FYActionDoneBlock)monitorBlock {
    
    NSDate *date1 = minimumDate ? : [NSDate dateWithYear:1960 month:1 day:1];
    NSDate *date2 = maximumDate ? : [NSDate date];
    if (selectedDate == nil) {
        selectedDate = date2;
    }
    
    NSInteger year1 = date1.year;
    NSInteger year2 = date2.year;
    NSInteger month1 = date1.month;
    NSInteger month2 = date2.month;
    NSInteger day1 = date1.day;
    NSInteger day2 = date2.day;
    
    self.calendarDictionary = [[NSMutableDictionary alloc] initWithCapacity:year2-year1+1];
    self.rangeMonthDictionary = [[NSMutableDictionary alloc] initWithCapacity:year2-year1+1];
    for (NSInteger year = year1; year <= year2; ++year) {
        
        NSMutableDictionary *monthDictionary = [[NSMutableDictionary alloc] initWithCapacity:12];
        
        
        NSInteger startMonth = (year == year1)? month1 : 1;
        NSInteger endMonth = (year == year2)? month2 : 12;
        self.rangeMonthDictionary[@(year)] = [NSValue valueWithRange:NSMakeRange(startMonth, endMonth-startMonth+1)];
        for (NSInteger month = startMonth; month <= endMonth; ++month) {
            NSDate *monthDate = [NSDate dateWithYear:year month:month day:1];
            
            NSInteger startDay = (year == year1 && month == month1)? day1 : 1;
            NSInteger endDay = (year == year2 && month == month2)? day2 :monthDate.daysInMonth;
            monthDictionary[@(month)] = [NSValue valueWithRange:NSMakeRange(startDay, endDay-startDay+1)];
        }
        
        self.calendarDictionary[@(year)] = monthDictionary;
    }
    
    self.yearRange = NSMakeRange(year1, year2-year1+1);
    
    self.selectedMonth = selectedDate.month;
    self.selectedDay = selectedDate.day;
    self.selectedHour = selectedDate.hour;
    self.selectedMinute = selectedDate.minute;
    self.selectedYear = selectedDate.year;
    [self updateSelect];

    self.monitorBlock = monitorBlock;
}

- (void)updateSelect {
    [CATransaction begin];
    [self.yearCollectionView reloadData];
    [self.monthCollectionView reloadData];
    [self.dayCollectionView reloadData];
    [self.hourCollectionView reloadData];
    [self.minuteCollectionView reloadData];
    
    [CATransaction setCompletionBlock:^{
        NSRange monthRange = self.rangeMonthDictionary[@(_selectedYear)].rangeValue;
        NSRange dayRange = self.calendarDictionary[@(_selectedYear)][@(_selectedMonth)].rangeValue;
        
        [self collectionView:self.dayCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedDay-dayRange.location inSection:0]];
        [self.yearCollectionView setContentOffset:CGPointMake(0, (_selectedYear-_yearRange.location)*self.itemNormalHeight.constant + self.yearCollectionView.contentInset.top)];
        [self.monthCollectionView setContentOffset:CGPointMake(0, (_selectedMonth-monthRange.location)*self.itemNormalHeight.constant + self.monthCollectionView.contentInset.top)];
        
        [self collectionView:self.hourCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedHour inSection:0]];
        [self collectionView:self.minuteCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedMinute inSection:0]];
    }];
    [CATransaction commit];
}


#pragma mark - Setters

- (void)setSelectedYear:(NSInteger)selectedYear {
    NSRange newMonthRange = self.rangeMonthDictionary[@(selectedYear)].rangeValue;
    NSRange oldMonthRange = self.rangeMonthDictionary[@(_selectedYear)].rangeValue;
    
    NSInteger oldYear = _selectedYear;
    NSInteger oldMonth = _selectedMonth;
    
    _selectedYear = selectedYear;
    if (!NSEqualRanges(oldMonthRange, newMonthRange)) {
        if (!NSLocationInRange(self.selectedMonth, newMonthRange)) {
            if (self.selectedMonth < newMonthRange.location) {
                _selectedMonth = newMonthRange.location;
            } else {
                _selectedMonth = NSMaxRange(newMonthRange)-1;
            }
        }
        // 月份可选范围变化了，但当前月份在可选范围内
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self.monthCollectionView reloadData];
        [self.monthCollectionView setContentOffset:CGPointMake(0, (_selectedMonth - newMonthRange.location)*self.itemNormalHeight.constant + self.monthCollectionView.contentInset.top)];
        [CATransaction commit];
    }
    
    NSRange newDayRange = self.calendarDictionary[@(_selectedYear)][@(_selectedMonth)].rangeValue;
    NSRange oldDayRange = self.calendarDictionary[@(oldYear)][@(oldMonth)].rangeValue;
    if (!NSEqualRanges(oldDayRange, newDayRange)) {
        if (!NSLocationInRange(self.selectedDay, newDayRange)) {
            if (_selectedDay < newDayRange.location) {
                _selectedDay = newDayRange.location;
            } else {
                _selectedDay = NSMaxRange(newDayRange)-1;
            }
            
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self.dayCollectionView reloadData];
        [self.dayCollectionView setContentOffset:CGPointMake(0, (_selectedDay - newDayRange.location)*self.itemNormalHeight.constant + self.dayCollectionView.contentInset.top)];
        [CATransaction commit];
        
        [self notifyObserver];
    } else {
        [self notifyObserver];
    }
}

- (void)setSelectedMonth:(NSInteger)selectedMonth {
    
    NSRange newDayRange = self.calendarDictionary[@(_selectedYear)][@(_selectedMonth)].rangeValue;
    NSRange oldDayRange = self.calendarDictionary[@(_selectedYear)][@(selectedMonth)].rangeValue;
    
    _selectedMonth = selectedMonth;
    if (!NSEqualRanges(oldDayRange, newDayRange)) {
        if (!NSLocationInRange(self.selectedDay, newDayRange)) {
            if (_selectedDay < newDayRange.location) {
                _selectedDay = newDayRange.location;
            } else {
                _selectedDay = NSMaxRange(newDayRange)-1;
            }
            
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self.dayCollectionView reloadData];
        [self.dayCollectionView setContentOffset:CGPointMake(0, (_selectedDay - newDayRange.location)*self.itemNormalHeight.constant + self.dayCollectionView.contentInset.top)];
        [CATransaction commit];
    }
    [self notifyObserver];
}

- (void)setSelectedDay:(NSInteger)selectedDay {
    _selectedDay = selectedDay;
    [self notifyObserver];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.yearCollectionView]) {
        // 年
        return self.calendarDictionary.count;
    } else if ([collectionView isEqual:self.monthCollectionView]) {
        // 月
        return self.calendarDictionary[@(_selectedYear)].count;
    } else if ([collectionView isEqual:self.dayCollectionView]) {
        // 日
        return [self.calendarDictionary[@(_selectedYear)][@(_selectedMonth)] rangeValue].length;
    } else if ([collectionView isEqual:self.hourCollectionView]) {
        // 时
        return 24;
    } else if ([collectionView isEqual:self.minuteCollectionView]) {
        // 分
        return 60;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FYPickerCell *cell = [super getCellForCollectionView:collectionView atIndexPath:indexPath];
    
    if ([collectionView isEqual:self.yearCollectionView]) {
        // 年
        cell.elementLabel.text = [[@(_yearRange.location+indexPath.row) stringValue] stringByAppendingString:@"年"];
        cell.selected = _selectedYear == _yearRange.location + indexPath.row;
    } else if ([collectionView isEqual:self.monthCollectionView]) {
        // 月
        NSRange monthRange = self.rangeMonthDictionary[@(_selectedYear)].rangeValue;
        cell.elementLabel.text = [[@(monthRange.location+indexPath.row) stringValue] stringByAppendingString:@"月"];
        cell.selected = _selectedMonth == monthRange.location + indexPath.row;
    } else if ([collectionView isEqual:self.dayCollectionView]) {
        // 日
        NSRange dayRange = self.calendarDictionary[@(_selectedYear)][@(_selectedMonth)].rangeValue;
        cell.elementLabel.text = [[@(dayRange.location + indexPath.row) stringValue] stringByAppendingString:@"日"];
        cell.selected = _selectedDay == dayRange.location + indexPath.row;
    } else if ([collectionView isEqual:self.hourCollectionView]) {
        // 时
        cell.elementLabel.text = [[@(indexPath.row) stringValue] stringByAppendingString:@"时"];
        cell.selected = _selectedHour == indexPath.row;
    } else if ([collectionView isEqual:self.minuteCollectionView]) {
        // 分
        cell.elementLabel.text = [[@(indexPath.row) stringValue] stringByAppendingString:@"分"];
        cell.selected = _selectedMinute == indexPath.row;
    }
    
    
    return cell;
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UICollectionView *)collectionView {
    for (FYPickerCell *cell in collectionView.visibleCells) {

        if (fabs(CGRectGetMidY(cell.frame) - (collectionView.contentOffset.y + self.itemNormalHeight.constant *2.5)) < self.itemNormalHeight.constant * 0.5) {
            
            if ([collectionView isEqual:self.yearCollectionView]) {
                self.selectedYear = [cell.elementLabel.text integerValue];
            } else if ([collectionView isEqual:self.monthCollectionView]) {
                self.selectedMonth = [cell.elementLabel.text integerValue];
            } else {
                self.selectedDay = [cell.elementLabel.text integerValue];
            }
            if ([collectionView isEqual:self.hourCollectionView]) {
                self.selectedHour = [cell.elementLabel.text integerValue];
            } else if ([collectionView isEqual:self.minuteCollectionView]) {
                self.selectedMinute = [cell.elementLabel.text integerValue];
            }
            cell.selected = YES;
        } else {
            cell.selected = NO;
        }
    }
}

- (void)notifyObserver {
    if (self.monitorBlock) {
        self.monitorBlock(self, self.selectedDate, nil);
    }
}

- (NSDate *)selectedDate {
    return [NSDate dateWithYear:self.selectedYear month:MAX(self.selectedMonth, 1) day:MAX(self.selectedDay, 1)
                           hour:self.selectedHour minute:self.selectedMinute second:0];
}

@end
