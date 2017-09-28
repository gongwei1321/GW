//
//  ZZParkHire.h
//  FreePark
//
//  Created by 龚伟 on 2017/8/20.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZParkHire : NSObject
@property (nonatomic,copy) NSString *parkhireId;//出租车位的id
@property (nonatomic,copy) NSString *parkHireName;//出租车位的名字
@property (nonatomic,copy) NSString *mapLng;//经度
@property (nonatomic,copy) NSString *mapLat;//纬度
@property (nonatomic,copy) NSString *parkHireType;//车位类型
@property (nonatomic,copy) NSString *price;//价格
@property (nonatomic,copy) NSString *contact;//对应租车位的联系方式
@property (nonatomic,copy) NSString *isEntireRent;//是否整租 0表示错时，1位整租
@property (nonatomic,copy) NSString *beginTime;//开始时间
@property (nonatomic,copy) NSString *endTime;//结束时间
@property (nonatomic,copy) NSString *parkHireRemarks;//备注
@property (nonatomic,copy) NSString *addtime;//添加时间
@property (nonatomic,copy) NSString *address;//城市地质
@property (nonatomic,copy) NSString *status;//审核状态
@property (nonatomic,copy) NSString *addTime;//发布时间
@property (nonatomic,copy) NSString *subName;//上传者名称

+ (ZZParkHire *)queryZZParkHireModelWithDic:(NSDictionary *)dic;
+ (ZZParkHire *)queryZZParkHireModelWithoutAddTimeWithDic:(NSDictionary *)dic;
+ (ZZParkHire *)queryZZParkHireModelWithoutIdWithDic:(NSDictionary *)dic;
@end
