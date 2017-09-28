//
//  ParkHireRequest.h
//  FreePark
//
//  Created by 龚伟 on 2017/8/20.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZParkHire.h"
@interface ParkHireRequest : NSObject
/*获取我发布的租车信息*/
+ (void) requestMyParkHireByName:(NSString *)userName complete:(void (^)(BOOL issuccess, NSString *ret,NSArray *resultlist)) complete;

/*新增租车位接口*/
+ (void) requestAddPackHire:(NSString *)location andlat:(NSString *)lat andlng:(NSString *)lng andparkHireType:(NSString *)parkHireType andisEntireRent:(NSString *)isEntireRent andbeginTime:(NSString *)beginTime andendTime:(NSString *)endTime andprice:(NSString *)price andcontact:(NSString *)contact andparkHireRemarks:(NSString *)parkHireRemarks andcommitUserName:(NSString *)commitUserName complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*修改租车位*/
+ (void) requestModifyParkHire:(NSString *)parkHireId andlocation:(NSString *)location andlat:(NSString *)lat andlng:(NSString *)lng andparkHireType:(NSString *)parkHireType andisEntireRent:(NSString *)isEntireRent andbeginTime:(NSString *)beginTime andendTime:(NSString *)endTime andprice:(NSString *)price andcontact:(NSString *)contact andparkHireRemarks:(NSString *)parkHireRemarks andcommitUserName:(NSString *)commitUserName complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*删除租车位*/
+(void)requestDelParkHire:(NSString *)cityIndex andid:(NSString *)sid complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*查询附近的租车位*/
+(void)requsetNearParkHire:(NSString *)lat andlng:(NSString *)lng andisEntireRent:(NSString *)isEntireRent complete:(void (^)(BOOL issuccess, NSString *ret,NSString *cityIndex,NSString *totalSize,NSArray *resultlist)) complete;

/*获取租车位详情*/
+(void)requsetParkHireDetail:(NSString *)cityIndex andid:(NSString *)sid complete:(void (^)(BOOL issuccess, NSString *ret,NSArray *resultlist)) complete;
@end
