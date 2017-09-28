//
//  ZZUserCollect.h
//  FreePark
//
//  Created by 龚伟 on 2017/3/6.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUserCollect : NSObject
@property (nonatomic,copy) NSString *collectParkId;//id
@property (nonatomic,copy) NSString *parkName;//停车场名字
@property (nonatomic,copy) NSString *collectAddTime;//添加日期
@property (nonatomic,copy) NSString *address;//地点
@property (nonatomic,copy) NSString *isHaveNewComment;//是否有新的评论

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (ZZUserCollect *)queryZZUserCollectModelWithDic:(NSDictionary *)dic;
@end
