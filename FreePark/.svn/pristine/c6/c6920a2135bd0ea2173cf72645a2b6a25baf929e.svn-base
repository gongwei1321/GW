//
//  ZZUserAddOrReview.m
//  FreePark
//
//  Created by 龚伟 on 16/4/12.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "ZZUserAddOrReview.h"

@implementation ZZUserAddOrReview
+ (ZZUserAddOrReview *)queryZZUserAddOrReviewModelWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZUserAddOrReview *model = [[ZZUserAddOrReview alloc]init];
        model.sid = [dic objectForKey:@"id"];
        model.parkName = [dic objectForKey:@"parkName"];
        model.reviewTime = [dic objectForKey:@"reviewTime"];
        if (model.reviewTime == nil) {
             model.reviewTime = [dic objectForKey:@"addDate"];
        }
        
        model.isUpdate = [dic objectForKey:@"isUpdate"];
        model.posttime = [dic objectForKey:@"posttime"];
        return model;
    }
    return nil;
}

@end
