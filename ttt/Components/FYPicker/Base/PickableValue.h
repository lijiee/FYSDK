//
//  PickableValue.h
//  FYDatePicker
//
//  Created by WorkHarder on 9/30/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PickableValue <NSObject>

- (NSString *)valueToPick;

@end

@interface NSString (Pickable)<PickableValue>

@end

@implementation NSString (Pickable)

- (NSString *)valueToPick {
    return self;
}

@end

