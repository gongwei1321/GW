//
//  ZZPublicity.m
//  FreePark
//
//  Created by 龚伟 on 15/12/27.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ZZPublicity.h"
@implementation ZZPublicity
+ (ZZPublicity *)queryPublicityModelWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZPublicity *model = [[ZZPublicity alloc]init];
        model.getPublicityTag = [dic objectForKey:@"getPublicityTag"];
        model.cityIndex = [dic objectForKey:@"cityIndex"];
        NSArray *array = [dic objectForKey:@"resultlist"];
        
        __block NSMutableArray *result = [NSMutableArray array];
        
        if (array && [array count] != 0) {
            
            [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
                PublicityModel *model = [PublicityModel publicityModelWithDic:obj];
                
                if (model)  [result addObject:model];
            }];
        }
        
        model.resultlist = result;
        return model;
    }
    return nil;

}
@end
@implementation PublicityModel

+ (PublicityModel *)publicityModelWithDic:(NSDictionary *)dic
{
    if (dic) {
        PublicityModel *model = [[PublicityModel alloc]init];
        model.date = [dic objectForKey:@"date"];
        model.name = [dic objectForKey:@"name"];
        model.creator = [dic objectForKey:@"creator"];
        model.sid = [dic objectForKey:@"id"];
        model.price = [dic objectForKey:@"price"];
        return model;
    }
    return nil;
}

@end