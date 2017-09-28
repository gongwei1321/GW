//
//  ParkEntity.h
//  FreePark
//
//  Created by zhangwx on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkEntity : NSObject

@property (nonatomic, strong) NSString *mapLat;
@property (nonatomic, strong) NSString *mapLng;
@property (nonatomic, strong) NSString *parkName;
@property (nonatomic, strong) NSString *parkDescription;
@property (nonatomic, strong) NSString *parkStopprice;
@property (nonatomic, strong) NSString *parPriceTime;
@property (nonatomic, strong) NSString *parkId;
@property (nonatomic, strong) NSString *cityIndex;
@property (nonatomic, strong) NSNumber *hasCollected;

+ (instancetype)instanceFromDic:(NSDictionary *)dic;

@end
