//
//  ZZParkHire.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/20.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ZZParkHire.h"


@implementation ZZParkHire

+ (ZZParkHire *)queryZZParkHireModelWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZParkHire *model = [[ZZParkHire alloc]init];
        model.parkhireId = [dic objectForKey:@"id"];
        model.parkHireName = [dic objectForKey:@"parkHireName"];
        model.mapLng = [dic objectForKey:@"mapLng"];
        model.mapLat = [dic objectForKey:@"mapLat"];
        model.parkHireType = [dic objectForKey:@"parkHireType"];
        model.price = [dic objectForKey:@"price"];
        model.contact = [dic objectForKey:@"contact"];
        model.isEntireRent = [dic objectForKey:@"isEntireRent"];
        model.beginTime = [dic objectForKey:@"beginTime"];
        model.endTime = [dic objectForKey:@"endTime"];
        model.parkHireRemarks = [dic objectForKey:@"parkHireRemarks"];
        if([model.parkHireRemarks isKindOfClass:[NSNull class]])
        {
            model.parkHireRemarks = @"";
        }
        model.addtime = [dic objectForKey:@"addtime"];
        model.status = [dic objectForKey:@"status"];
        //        @property (nonatomic,copy) NSString *address;//地点
        return model;
    }
    return nil;
}
+ (ZZParkHire *)queryZZParkHireModelWithoutAddTimeWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZParkHire *model = [[ZZParkHire alloc]init];
        model.parkhireId = [dic objectForKey:@"id"];
        model.parkHireName = [dic objectForKey:@"parkHireName"];
        model.mapLng = [dic objectForKey:@"mapLng"];
        model.mapLat = [dic objectForKey:@"mapLat"];
        model.parkHireType = [dic objectForKey:@"parkHireType"];
        model.price = [dic objectForKey:@"price"];
        model.contact = [dic objectForKey:@"contact"];
        model.isEntireRent = [dic objectForKey:@"isEntireRent"];
        model.beginTime = [dic objectForKey:@"beginTime"];
        model.endTime = [dic objectForKey:@"endTime"];
        model.parkHireRemarks = [dic objectForKey:@"parkHireRemarks"];
        if([model.parkHireRemarks isKindOfClass:[NSNull class]])
        {
            model.parkHireRemarks = @"";
        }
        model.status = [dic objectForKey:@"status"];
        model.addTime = [dic objectForKey:@"addTime"];
        model.subName = [dic objectForKey:@"subName"];
        
        
        //        @property (nonatomic,copy) NSString *address;//地点
        return model;
    }
    return nil;
}
+ (ZZParkHire *)queryZZParkHireModelWithoutIdWithDic:(NSDictionary *)dic
{
    if (dic) {
        ZZParkHire *model = [[ZZParkHire alloc]init];
        model.parkHireName = [dic objectForKey:@"parkHireName"];
        model.mapLng = [dic objectForKey:@"mapLng"];
        model.mapLat = [dic objectForKey:@"mapLat"];
        model.parkHireType = [dic objectForKey:@"parkHireType"];
        model.price = [dic objectForKey:@"price"];
        model.contact = [dic objectForKey:@"contact"];
        model.isEntireRent = [dic objectForKey:@"isEntireRent"];
        model.beginTime = [dic objectForKey:@"beginTime"];
        model.endTime = [dic objectForKey:@"endTime"];
        model.parkHireRemarks = [dic objectForKey:@"parkHireRemarks"];
        if([model.parkHireRemarks isKindOfClass:[NSNull class]])
        {
            model.parkHireRemarks = @"";
        }
        model.status = [dic objectForKey:@"status"];
        //        @property (nonatomic,copy) NSString *address;//地点
        return model;
    }
    return nil;

}
@end
