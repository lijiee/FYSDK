//
//  FYTypeAlias.h
//  FYSDK
//
//  Created by WorkHarder on 10/27/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#ifndef FYTypeAlias_h
#define FYTypeAlias_h

@class FYBasePicker;
typedef void(^FYActionDoneBlock)(FYBasePicker *picker, id selectedValues, id origin);
typedef void(^FYDateActionDoneBlock)(FYBasePicker *picker, NSDate *date, id origin);
typedef void(^FYActionCancelBlock)(FYBasePicker *picker);

#endif /* FYTypeAlias_h */
