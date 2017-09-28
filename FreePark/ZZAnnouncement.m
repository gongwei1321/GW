//
//  ZZAnnouncement.m
//  FreePark
//
//  Created by 龚伟 on 15/12/27.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ZZAnnouncement.h"

@implementation ZZAnnouncement
+ (ZZAnnouncement *)queryAnnouncementModelWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZAnnouncement *model = [[ZZAnnouncement alloc]init];
        model.getAnnouncementTag = [dic objectForKey:@"getAnnouncement"];
        NSArray *array = [dic objectForKey:@"resultlist"];
        __block NSMutableArray *result = [NSMutableArray array];
        
        if (array && [array count] != 0) {
            
            [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
//                CoinStateModel *model = [CoinStateModel coinStateModelWithDic:obj];
                
                if (obj)  [result addObject:obj[@"content"]];
            }];
        }
        
        model.resultlist = result;
        return model;
    }
    return nil;
}
@end
