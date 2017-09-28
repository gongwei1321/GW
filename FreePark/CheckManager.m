//
//  CheckManager.m
//  FreePark
//
//  Created by zhangwx on 16/4/16.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "CheckManager.h"

@implementation CheckManager

+(instancetype)shareInstance
{
    static CheckManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CheckManager alloc] init];
    });
    return manager;
}

@end
