//
//  ZZUserAddOrReview.h
//  FreePark
//
//  Created by 龚伟 on 16/4/12.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUserAddOrReview : NSObject
@property (nonatomic,copy) NSString *sid;//id
@property (nonatomic,copy) NSString *parkName;//停车场名字
@property (nonatomic,copy) NSString *reviewTime;//添加日期
@property (nonatomic,copy) NSString *isUpdate;//是否更新
@property (nonatomic,copy) NSString *posttime;//更新时间

+ (ZZUserAddOrReview *)queryZZUserAddOrReviewModelWithDic:(NSDictionary *)dic;
@end
