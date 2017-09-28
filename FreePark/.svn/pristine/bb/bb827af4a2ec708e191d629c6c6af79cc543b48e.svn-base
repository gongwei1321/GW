//
//  ZZPublicity.h
//  FreePark
//
//  Created by 龚伟 on 15/12/27.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZPublicity : NSObject
@property (nonatomic,strong) NSNumber *getPublicityTag;//响应状态
@property (nonatomic,copy) NSString *cityIndex;//城市索引0为北京，1为上海，2为广州，3为深圳
@property (nonatomic,copy) NSArray *resultlist;//数据列表

+ (ZZPublicity *)queryPublicityModelWithDic:(NSDictionary *)dic;
@end


@interface PublicityModel : NSObject

@property (nonatomic,copy) NSString *date;//该条公示的日期
@property (nonatomic,copy) NSString *name;//该条公示停车位的名称
@property (nonatomic,copy) NSString *creator;//该条公示停车位的作者（可能为空）
@property (nonatomic,copy) NSString *sid;//该条公示停车位的sid
@property (nonatomic,copy) NSString *price;//该条公示停车位的价格

+ (PublicityModel *)publicityModelWithDic:(NSDictionary *)dic;
@end