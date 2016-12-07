//
//  OSMessage+DictionarySupport.m
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "OSMessage+DictionarySupport.h"

@implementation OSMessage (DictionarySupport)

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary {
    OSMessage *msg = [OSMessage new];
    if (msg) {
        [otherDictionary keysOfEntriesPassingTest:^BOOL(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [msg setValue:otherDictionary[key] forKey:key];
            return YES;
        }];
    }
    return msg;
}


@end
