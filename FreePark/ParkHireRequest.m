//
//  ParkHireRequest.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/20.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ParkHireRequest.h"
#import "WDHTTPTool.h"
#import "DataManager.h"

@implementation ParkHireRequest
+ (void)requsetParkHireDetail:(NSString *)cityIndex andid:(NSString *)sid complete:(void (^)(BOOL, NSString *, NSArray *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkHire/app/getParkHireDetail.php",  [DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityIndex"] = [NSString stringWithFormat:@"%@", cityIndex];
    params[@"id"] = [NSString stringWithFormat:@"%@", sid];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            NSMutableArray * mutableArrayData = [NSMutableArray array];
            NSDictionary *tempdic = dic[@"result"];
            ZZParkHire *model = [ZZParkHire queryZZParkHireModelWithoutAddTimeWithDic:tempdic];
            [mutableArrayData addObject:model];
            
            
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"getParkHireDetailTag"]],mutableArrayData);
        }
        else
        {
            complete(NO,nil,nil);
        }
        
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil);
    }];
    
}
+ (void)requsetNearParkHire:(NSString *)lat andlng:(NSString *)lng andisEntireRent:(NSString *)isEntireRent complete:(void (^)(BOOL, NSString *, NSString *, NSString *, NSArray *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkHire/app/getNearParkHire.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mapLat"] = [NSString stringWithFormat:@"%@", lat];
    params[@"mapLng"] = [NSString stringWithFormat:@"%@", lng];
//    params[@"isEntireRent"] = [NSString stringWithFormat:@"%@", isEntireRent];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            NSMutableArray * mutableArrayData = [NSMutableArray array];
            NSArray *resultlist = dic[@"resultlist"];
            for (NSDictionary *tempdic in resultlist) {
                ZZParkHire *model = [ZZParkHire queryZZParkHireModelWithoutAddTimeWithDic:tempdic];
                NSString *cityIndex = [NSString stringWithFormat:@"%@",dic[@"cityIndex"]];
                if([cityIndex  isEqual: @"0"])
                {
                    model.address = @"北京";
                }
                else if([cityIndex  isEqual: @"1"])
                {
                    model.address = @"上海";
                }
                else if([cityIndex  isEqual: @"2"])
                {
                    model.address = @"广州";
                }
                else if([cityIndex  isEqual: @"3"])
                {
                    model.address = @"深圳";
                }
                    
                [mutableArrayData addObject:model];
            }
            
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"getPointParkHireTag"]],[NSString stringWithFormat:@"%@",dic[@"cityIndex"]],[NSString stringWithFormat:@"%@",dic[@"totalSize"]],mutableArrayData);
        }
        else
        {
            complete(NO,nil,nil,nil,nil);
        }
        
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil,nil,nil);
    }];
    
}
+ (void)requestMyParkHireByName:(NSString *)userName complete:(void (^)(BOOL, NSString *, NSArray *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkHire/app/getAllUserParkHire.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [NSString stringWithFormat:@"%@", userName];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            NSMutableArray * mutableArrayData = [NSMutableArray array];
            NSArray *beijingList = dic[@"resultBeiJinglist"];
            for (NSDictionary *tempdic in beijingList) {
                ZZParkHire *model = [ZZParkHire queryZZParkHireModelWithDic:tempdic];
                model.address = @"北京";
                [mutableArrayData addObject:model];
            }
            
            NSArray *shanghaiList = dic[@"resultShangHailist"];
            for (NSDictionary *tempdic in shanghaiList) {
                ZZParkHire *model = [ZZParkHire queryZZParkHireModelWithDic:tempdic];
                model.address = @"上海";
                [mutableArrayData addObject:model];
                
            }
            
            NSArray *shenzhenList = dic[@"resultShenZhenlist"];
            for (NSDictionary *tempdic in shenzhenList) {
                ZZParkHire *model = [ZZParkHire queryZZParkHireModelWithDic:tempdic];
                model.address = @"深圳";
                [mutableArrayData addObject:model];            }
            
            NSArray *guangzhouList = dic[@"resultGuangZhoulist"];
            for (NSDictionary *tempdic in guangzhouList) {
                ZZParkHire *model = [ZZParkHire queryZZParkHireModelWithDic:tempdic];
                model.address = @"广州";
                [mutableArrayData addObject:model];
            }
            
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"getAllUserParkHireTag"]],mutableArrayData);
        }
        else
        {
            complete(NO,nil,nil);
        }
        
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil);
    }];
    
}

+(void)requestAddPackHire:(NSString *)location andlat:(NSString *)lat andlng:(NSString *)lng andparkHireType:(NSString *)parkHireType andisEntireRent:(NSString *)isEntireRent andbeginTime:(NSString *)beginTime andendTime:(NSString *)endTime andprice:(NSString *)price andcontact:(NSString *)contact andparkHireRemarks:(NSString *)parkHireRemarks andcommitUserName:(NSString *)commitUserName complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkHire/app/addParkHire.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = location;
    params[@"mapLat"] = lat;
    params[@"mapLng"] = lng;
    params[@"parkHireType"] = parkHireType;
    params[@"isEntireRent"] = isEntireRent;
    params[@"beginTime"] = beginTime;
    params[@"endTime"] = endTime;
    params[@"price"] = price;
    params[@"contact"] = contact;
    params[@"parkHireRemarks"] = parkHireRemarks;
    params[@"commitUserName"] = commitUserName;
    
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            //所对应的返回值
            //define('PARK_HIRE_ADD_SUCCESS',130020);
            //define('PARK_HIRE_ADD_FAILED',130021);
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"addParkTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];
    
}
+(void)requestDelParkHire:(NSString *)cityIndex andid:(NSString *)sid complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkHire/app/delParkHire.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityIndex"] = cityIndex;
    params[@"id"] = sid;
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            //所对应的返回值
            //define('PARK_HIRE_DEL_SUCCESS',130070);
            //define('PARK_HIRE_DEL_FAILED',130071);
            //define('PARK_HIRE_DEL_FAILED_NO_DATA',130072);
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"delParkTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];
    
}
+(void)requestModifyParkHire:(NSString *)parkHireId andlocation:(NSString *)location andlat:(NSString *)lat andlng:(NSString *)lng andparkHireType:(NSString *)parkHireType andisEntireRent:(NSString *)isEntireRent andbeginTime:(NSString *)beginTime andendTime:(NSString *)endTime andprice:(NSString *)price andcontact:(NSString *)contact andparkHireRemarks:(NSString *)parkHireRemarks andcommitUserName:(NSString *)commitUserName complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkHire/app/modifyParkHire.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parkHireId"] = parkHireId;
    params[@"location"] = location;
    params[@"mapLat"] = lat;
    params[@"mapLng"] = lng;
    params[@"parkHireType"] = parkHireType;
    params[@"isEntireRent"] = isEntireRent;
    params[@"beginTime"] = beginTime;
    params[@"endTime"] = endTime;
    params[@"price"] = price;
    params[@"contact"] = contact;
    params[@"parkHireRemarks"] = parkHireRemarks;
    params[@"commitUserName"] = commitUserName;
    
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            //所对应的返回值
            //define('PARK_HIRE_MODIFY_SUCCESS',130030);
            //define('PARK_HIRE_MODIFY_FAILED',130031);
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"modifyParkHireTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];
}

@end
