//
//  GPSManager.h
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPSManager : NSObject <CLLocationManagerDelegate>

@property(nonatomic, retain) CLLocationManager *locationManager;

+ (void)startUpdatingLocation;
+ (void)gpsTagSet:(NSInteger)tag;

@end

/**

apple longitude 114.393719 latitude 30.465293
baidu long 114.405781, lat 30.468801
      long 114.405582  lat 30.468028
*/