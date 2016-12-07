//
//  FYThreadMutex.m
//  FYSDK
//
//  Created by WorkHarder on 12/5/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYThreadMutex.h"
#import <pthread.h> 

@implementation FYThreadMutex {
    pthread_mutex_t _mutex;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_mutex, NULL);
    }
    return self;
}

- (void)fy_executeMutexBlock:(void(^)())block {
    pthread_mutex_lock(&_mutex);
    block();
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}

@end
