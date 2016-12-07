//
//  FYLocationManager.m
//  FYSDK
//
//  Created by WorkHarder on 10/26/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface FYLocationManager ()<CLLocationManagerDelegate>

/** 获取城市位置代理*/
@property (nonatomic, weak) id<FYLocationManagerDelegate> delegate;
/** 位置管理*/
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation FYLocationManager

/** 获取当前城市*/

- (void)startLocationCityWithDelegate:(id<FYLocationManagerDelegate>)delegate {
    
    self.delegate = delegate;
    
    if(CLLocationManager.locationServicesEnabled){ //开启定位
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = 100;
        
        // self.location!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
    }else{
        //未开启定位
        NSError *error = [NSError errorWithDomain:@"GPS" code:400 userInfo:@{NSLocalizedDescriptionKey:@"未开启GPS"}];
        [self locationManager:self.locationManager didFailWithError:error];
        
        return;
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    
    if(self.delegate != nil){
        [self.delegate locationCity:nil error:error];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if(locations.count >= 1){
        CLLocation *
        location = locations[locations.count - 1];
        [self.locationManager stopUpdatingLocation];
        CLGeocoder *geocoder = [CLGeocoder new];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(placemarks != nil && placemarks.count >= 1){
                CLPlacemark *placemar = placemarks[0];
                NSString *city = placemar.locality;
                if(city == nil) { //当前城市为
                    city = placemar.administrativeArea;
                }
                if(self.delegate != nil){
                    [self.delegate locationCity:city error:nil];
                }
            }
        }];
    }
}

@end
