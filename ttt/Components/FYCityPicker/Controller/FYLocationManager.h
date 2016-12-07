//
//  FYLocationManager.h
//  FYSDK
//
//  Created by WorkHarder on 10/26/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FYLocationManagerDelegate <NSObject>

- (void)locationCity:(NSString *)cityName error:(NSError *)error;

@end

@interface FYLocationManager : NSObject

- (void)startLocationCityWithDelegate:(id<FYLocationManagerDelegate>)delegate;

@end
