//
//  ParkEntity.m
//  FreePark
//
//  Created by zhangwx on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkEntity.h"

@implementation ParkEntity

+ (instancetype)instanceFromDic:(NSDictionary *)dic
{
    ParkEntity *entity = [[ParkEntity alloc] init];
    entity.mapLat = dic[@"mapLat"];
    entity.mapLng = dic[@"mapLng"];
    entity.parkName = dic[@"parkName"];
    entity.parkDescription = dic[@"parkDescription"];
    entity.parkStopprice = dic[@"parkStopprice"];
    entity.parPriceTime = dic[@"parPriceTime"];
    entity.parkId = dic[@"id"];
    entity.cityIndex = dic[@"cityIndex"];
    return entity;
}

@end
