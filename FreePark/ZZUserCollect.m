//
//  ZZUserCollect.m
//  FreePark
//
//  Created by 龚伟 on 2017/3/6.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ZZUserCollect.h"

@implementation ZZUserCollect

+(ZZUserCollect *)queryZZUserCollectModelWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZUserCollect *model = [[ZZUserCollect alloc]init];
        model.collectParkId = [dic objectForKey:@"collectParkId"];
        model.parkName = [dic objectForKey:@"parkName"];
        model.collectAddTime = [dic objectForKey:@"collectAddTime"];
        model.isHaveNewComment = [dic objectForKey:@"isHaveNewComment"];
 
//        @property (nonatomic,copy) NSString *address;//地点
        return model;
    }
    return nil;

}
@end
