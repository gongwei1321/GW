//
//  DBDataManager.m
//  Wanda
//
//  Created by zhangwx on 15/8/2.
//  Copyright (c) 2015年 万达. All rights reserved.
//

#import "DBDataManager.h"

@interface DBDataManager ()

@end

@implementation DBDataManager

+ (instancetype)shareInstance
{
    static DBDataManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[DBDataManager alloc] init];
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"FPDatabase.sqlite"];
    });
    return shareInstance;
}

@end
