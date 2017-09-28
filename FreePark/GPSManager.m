//
//  GPSManager.m
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "GPSManager.h"
#import "DataManager.h"
#import "ParkRequests.h"
#define ShowSameCity  2
#define ShowCarmera  3
@interface GPSManager ()<UIAlertViewDelegate>
@property (nonatomic,assign) NSInteger tag;
@end

static GPSManager *gpsManager;

@implementation GPSManager

- (id)init {
    if ((self = [super init]) != nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 200;
    }
    
    return self;
}

+ (GPSManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ gpsManager = [[GPSManager alloc] init]; });
    return gpsManager;
}
+ (void)gpsTagSet:(NSInteger)tag
{
    [GPSManager sharedInstance].tag = tag;
}
+ (void)startUpdatingLocation {
    [[GPSManager sharedInstance] startUpdatingLocation];
}

- (void)startUpdatingLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager stopUpdatingLocation];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    
    // Save to user default
    [DataManager setLatitude:[[locations lastObject] coordinate].latitude];
    [DataManager setLongitude:[[locations lastObject] coordinate].longitude];
    
   
    [ParkRequests requestParksByPoint:[[locations lastObject] coordinate] complete:^(BOOL issuccess, NSMutableArray *retArr) {
        
    }];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
   
}


@end
