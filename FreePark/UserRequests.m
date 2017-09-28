//
//  UserRequests.m
//  FreePark
//
//  Created by 龚伟 on 15/12/24.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "UserRequests.h"
#import "WDHTTPTool.h"
#import "ZZAnnouncement.h"
#import "ZZPublicity.h"
#import "FPHonor.h"
#import "FPPublicity.h"
#import "GPSManager.h"
#import "CheckManager.h"
#import "ZZUserAddOrReview.h"
#import "FPUserReview.h"
#import "FPUserAdd.h"
#import "ZZUserCollect.h"
//#define BaseUrl @"http://www.122park.com/"
//#define BaseUrl @"http://www.gybyy.com/testServer/"
//#define BaseUrl  @"http://120.26.120.245/"


@implementation UserRequests

+ (void)requestServerIPComplete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = @"http://www.122park.com/api/app/get_server_addr.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [WDHTTPTool postWithURLResponseImage:url params:params success:^(id json) {
        NSString *result = [[NSString alloc] initWithData:json  encoding:NSUTF8StringEncoding];
        if(result.length != 0)
        {
            complete(YES, result);
        }
        else{
        complete(NO, @"");
        }
        
    } failure:^(NSError *error) {
        complete(NO, @"");
    }];
}
+ (void)requestRegisterSMSByVerificationCode:(NSString *)verificationCode andPhoneNumber:(NSString *)phoneNumber andSession_name:(NSString *)session_name andCaptcha:(NSString *)captcha complete:(void (^)(BOOL, NSString *))complete
{
    
    
    //    NSString *url = [NSString stringWithFormat:@"%@api/app/sms/registerSMS.php",BaseUrl];
    NSString *url = [NSString stringWithFormat:@"%@api/app/sms/registerSMS.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"verificationCode"] = [NSString stringWithFormat:@"%@", verificationCode];
    params[@"phoneNumber"] = [NSString stringWithFormat:@"%@", phoneNumber];
    params[@"session_name"] = [NSString stringWithFormat:@"%@", session_name];
    params[@"captcha"] = [NSString stringWithFormat:@"%@", captcha];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        NSString *checkresutl = dic[@"check_result"];
        if([checkresutl isEqualToString:@"False"])
        {
            complete(NO, nil);
        }
        else
        {
            if(dic)
            {
                complete(YES, [NSString stringWithFormat:@"%@",dic[@"errCode"]]);
            }
            else{
                complete(NO, nil);
            }
            
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}
+ (void)requestLoginByUserName:(NSString *)userName andUserPwd:(NSString *)userPwd complete:(void (^)(BOOL, NSString *, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/login.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [NSString stringWithFormat:@"%@", userName];
    params[@"passWord"] = [NSString stringWithFormat:@"%@", userPwd];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        //        NSArray *array = (NSArray *)json;
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            //            if (array.count == 2) {
            //                NSDictionary *dicLoginTag = array[0];
            //                NSDictionary *dicLoginUserName = array[1];
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"loginTag"]],[NSString stringWithFormat:@"%@",dic[@"loginUserName"]]);
            //            }
            //            else{
            //                NSDictionary *dicLoginTag = array[0];
            //                 complete(YES, [NSString stringWithFormat:@"%@",dic[@"loginTag"]],[NSString stringWithFormat:@"%@",@""]);
            //            }
            
            
        }
        else{
            complete(NO, nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil,nil);
    }];
    
}
+ (void)requestRegisterByUserName:(NSString *)userName andUserPwd:(NSString *)userPwd andphoneNumber:(NSString *)phoneNumber andMapLat:(NSString *)mapLat andMapLng:(NSString *)mapLng complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/register/register.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [NSString stringWithFormat:@"%@", userName];
    params[@"userPwd"] = [NSString stringWithFormat:@"%@", userPwd];
    params[@"phoneNumber"] = [NSString stringWithFormat:@"%@", phoneNumber];
    params[@"mapLat"] = [NSString stringWithFormat:@"%@", mapLat];
    params[@"mapLng"] = [NSString stringWithFormat:@"%@", mapLng];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"registerTag"]]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void) requestLoginByWebUserName:(NSString *)userName andUserPwd:(NSString *)userPwd cityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSString *loginTag, NSString *loginUserName)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/webUserLogin.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityIndex"] = cityIndex;//0表示北京，1表示上海，2表示广州，3表示深圳
    params[@"userName"] = [NSString stringWithFormat:@"%@", userName];
    params[@"passWord"] = [NSString stringWithFormat:@"%@", userPwd];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        //        NSArray *array = (NSArray *)json;
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            //            if (array.count == 2) {
            //                NSDictionary *dicLoginTag = array[0];
            //                NSDictionary *dicLoginUserName = array[1];
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"loginTag"]],[NSString stringWithFormat:@"%@",dic[@"loginUserName"]]);
            //            }
            //            else{
            //                NSDictionary *dicLoginTag = array[0];
            //                 complete(YES, [NSString stringWithFormat:@"%@",dic[@"loginTag"]],[NSString stringWithFormat:@"%@",@""]);
            //            }
            
            
        }
        else{
            complete(NO, nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil,nil);
    }];
}

+ (void) requestWebUserBindInfo:(NSString *)userName userPass:(NSString *)userPass phoneNumber:(NSString *)phoneNumber mapLat:(NSString *)mapLat mapLng:(NSString *)mapLng complete:(void (^)(BOOL issuccess, NSString *ret)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/webUserBindInfo.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [NSString stringWithFormat:@"%@", userName];
    params[@"userPwd"] = [NSString stringWithFormat:@"%@", userPass];
    params[@"phoneNumber"] = [NSString stringWithFormat:@"%@", phoneNumber];
    params[@"mapLat"] = [NSString stringWithFormat:@"%@", mapLat];
    params[@"mapLng"] = [NSString stringWithFormat:@"%@", mapLng];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"SettingTag"]]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestLoginByEmail:(NSString *)email userName:(NSString *)userName complete:(void (^)(BOOL issuccess, NSString *ret)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/mailValidate.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [NSString stringWithFormat:@"%@", userName];
    params[@"mail"] = [NSString stringWithFormat:@"%@", email];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"ValidateTag"]]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void) requestFindBackPassWord:(NSString *)phoneNum newPass:(NSString *)newPass complete:(void (^)(BOOL issuccess, NSString *modifyTag))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/modifyPassword/modifyPassword.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"passWord"] = [NSString stringWithFormat:@"%@", newPass];
    params[@"phoneNumber"] = [NSString stringWithFormat:@"%@", phoneNum];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"modifyTag"]]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestAppCountByIMEI:(NSString *)imei andAppType:(NSString *)appType andVersion:(NSString *)version complete:(void (^)(BOOL, NSString *))complete
{
    
    NSString *url = [NSString stringWithFormat:@"%@api/app/appCount/appCount.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"imei"] = [NSString stringWithFormat:@"%@", imei];
    params[@"appType"] = [NSString stringWithFormat:@"%@", appType];
    params[@"version"] = [NSString stringWithFormat:@"%@", version];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"appCountTag"]]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
    
}

+ (void)requestCheckUpdateDiscoveryByVersion:(NSString *)version complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/checkUpdate/checkUpdateDiscovery.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = [NSString stringWithFormat:@"%@", version];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if(dic)
        {
            complete(YES, [NSString stringWithFormat:@"%@",dic[@"updateTag"]]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestGetAnnouncementByLat:(NSString *)lat andLng:(NSString *)lng complete:(void (^)(BOOL, NSString *, NSArray *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getAnnouncement/getAnnouncement.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lat"] = [NSString stringWithFormat:@"%@", lat];
    params[@"lng"] = [NSString stringWithFormat:@"%@", lng];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            ZZAnnouncement *model = [ZZAnnouncement queryAnnouncementModelWithDic:(NSDictionary *)json];
            [FPHonor MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"self.content != ''"]];
            for (NSString *content in model.resultlist) {
                FPHonor *fphonor = [FPHonor MR_createEntity];
                fphonor.content = content;
               [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            complete(YES,[NSString stringWithFormat:@"%@",model.getAnnouncementTag],model.resultlist);
          
        }
        else
        {
            complete(NO,nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil);
    }];
    
}
+ (void)requestGetPublicityByBeginValue:(NSString *)beginValue andEndValue:(NSString *)endValue lat:(NSString *)lat lng:(NSString *)lng complete:(void (^)(BOOL, NSString *, NSArray *))complete
{
    
    NSString *url = [NSString stringWithFormat:@"%@api/app/getPublicity/getPublicity.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lat"] = [NSString stringWithFormat:@"%@", lat];
    params[@"lng"] = [NSString stringWithFormat:@"%@", lng];
    params[@"beginValue"] = [NSString stringWithFormat:@"%@", beginValue];
    params[@"endValue"] = [NSString stringWithFormat:@"%@", endValue];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            ZZPublicity *model = [ZZPublicity queryPublicityModelWithDic:(NSDictionary *)json];
            complete(YES,[NSString stringWithFormat:@"%@",model.getPublicityTag],model.resultlist);
            [FPPublicity MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"self.name != ''"]];
            for (PublicityModel *publicity in model.resultlist) {
                FPPublicity *fppublicity= [FPPublicity MR_createEntity];
                fppublicity.date = publicity.date;
                fppublicity.name = publicity.name;
                fppublicity.sid =publicity.sid;
                fppublicity.creator =publicity.creator;
                fppublicity.price =publicity.price;
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
        }
        else
        {
            complete(NO,nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil);
    }];
    
}

+ (void)requestAddParkByLocation:(NSString *)location andCoor:(CLLocationCoordinate2D)coor andPrice:(NSString *)price andDescription:(NSString *)description andEmail:(NSString *)email andPricetype:(NSString *)pricetype andShareReason:(NSString *)shareReason  andName:(NSString *)userName complete:(void (^)(BOOL, NSString *))complete
{
    
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/addPark.php",[DataManager serverIp]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *lat,*lng;

    if (coor.latitude != 0) {
        lat = [NSString stringWithFormat:@"%.8f",coor.latitude];
    }
    else{
        lat = @"1";
    }
    if (coor.longitude != 0) {
        lng = [NSString stringWithFormat:@"%.8f",coor.longitude];
    }
    else{
        lng = @"1";
    }
    
    params[@"lat"] = lat;
    params[@"lng"] = lng;
    params[@"price"] = [NSString stringWithFormat:@"%@", price];
    params[@"location"] = [NSString stringWithFormat:@"%@", location];
    params[@"price"] = [NSString stringWithFormat:@"%@", price];
    params[@"description"] = [NSString stringWithFormat:@"%@", description];
    params[@"email"] = [NSString stringWithFormat:@"%@", email];
    params[@"pricetype"] = [NSString stringWithFormat:@"%@", pricetype];
    params[@"shareReason"] = [NSString stringWithFormat:@"%@", shareReason];
    params[@"name"] = [NSString stringWithFormat:@"%@", userName];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
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
+ (void)requestGetParkDetailById:(NSString *)sid andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL, NSString *, NSString *, NSString *, NSString *, NSString *, NSString *, NSString *, NSNumber *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getParkInfo/getParkDetail.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = [NSString stringWithFormat:@"%@", sid];
    params[@"cityIndex"] = [NSString stringWithFormat:@"%@", cityIndex];
    params[@"userName"] = [DataManager getUserName];
    NSString *name = [DataManager getUserName];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            NSDictionary *result = dic[@"result"];
            NSNumber *tag  = dic[@"getParkDetailTag"];
           
            if ( [[NSString stringWithFormat:@"%@",tag] isEqualToString:@"50010"])
            {
                complete(YES,result[@"name"],result[@"description"],result[@"stopPrice"],result[@"priceTime"],result[@"sid"],result[@"lastModifyTime"],result[@"creator"],result[@"alreadyCollect"]);
            }
            else{
                 complete(NO,nil,nil,nil,nil,nil,nil,nil,@(NO));
            }
          
        }
        else
        {
            complete(NO,nil,nil,nil,nil,nil,nil,nil,@(NO));
        }
        
    } failure:^(NSError *error) {
         complete(NO,nil,nil,nil,nil,nil,nil,nil,@(NO));
    }];
}

+ (void)requestGetParkDetailAndPositionById:(NSString *)sid andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL, NSString *, NSString *, NSString *, NSString *, NSString *, NSString *, NSString *, NSNumber *,NSString *,NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getParkInfo/getParkDetail.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = [NSString stringWithFormat:@"%@", sid];
    params[@"cityIndex"] = [NSString stringWithFormat:@"%@", cityIndex];
    params[@"userName"] = [DataManager getUserName];
    NSString *name = [DataManager getUserName];
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            NSDictionary *result = dic[@"result"];
            NSNumber *tag  = dic[@"getParkDetailTag"];
            
            if ( [[NSString stringWithFormat:@"%@",tag] isEqualToString:@"50010"])
            {
                complete(YES,result[@"name"],result[@"description"],result[@"stopPrice"],result[@"priceTime"],result[@"sid"],result[@"lastModifyTime"],result[@"creator"],result[@"alreadyCollect"],result[@"mapLat"],result[@"mapLng"]);
            }
            else{
                complete(NO,nil,nil,nil,nil,nil,nil,nil,@(NO),nil,nil);
            }
            
        }
        else
        {
            complete(NO,nil,nil,nil,nil,nil,nil,nil,@(NO),nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil,nil,nil,nil,nil,nil,@(NO),nil,nil);
    }];
}

+ (void)requestCheckUpdateDiscovery:(NSString *)guessModifyLastTime complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/guess/checkUpdateDiscovery.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"guessModifyLastTime"] = [NSString stringWithFormat:@"%@", guessModifyLastTime];
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
           
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"updateTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];
}

+ (void) requestJudgeAlreadyShare:(void(^)(BOOL hasShared)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/judgeAlreadyShare.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [DataManager getUserName];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        if (dic[@"IsAlreadyShareTag"]) {
            complete([dic[@"IsAlreadyShareTag"] integerValue] == 20030);
        }else{
            complete(NO);
        }
        
    } failure:^(NSError *error) {
        complete(NO);
    }];
}


+ (void) requestAlreadyShareInfo
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/postAlreadyShareInfo.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = [DataManager getUserName];
    params[@"shareTag"] = @(1);
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+ (void)requestCanUseAllCheckFunc
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/selectFunctionIsOpen.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"functionNumer"] = @"1";
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if (dic[@"FunctionIsOpenTag"]) {
            int flag = [[NSString stringWithFormat:@"%@", dic[@"FunctionIsOpenTag"]] intValue];
            [CheckManager shareInstance].donotCheckShare = flag;
        }else{
            [CheckManager shareInstance].donotCheckShare = NO;
        }
    } failure:^(NSError *error) {
        [CheckManager shareInstance].donotCheckShare = NO;
    }];
}

+ (void)requestShouldCheckShareForSearch
{
    if ([CheckManager shareInstance].donotCheckShare) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@api/app/login/selectFunctionIsOpen.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"functionNumer"] = @"2";
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if (dic[@"FunctionIsOpenTag"]) {
        //    int flag = dic[@"FunctionIsOpenTag"];
            int flag = [[NSString stringWithFormat:@"%@", dic[@"FunctionIsOpenTag"]] intValue];
            [CheckManager shareInstance].checkShareForSearch = flag;
        }else{
            [CheckManager shareInstance].checkShareForSearch = NO;
        }
    } failure:^(NSError *error) {
        [CheckManager shareInstance].checkShareForSearch = NO;
    }];
}
+ (void)requestGetAllUserCollect:(NSString *)userName andLastUpdateTime:(NSString *)lastUpdateTime complete:(void (^)(BOOL, NSString *, NSMutableArray *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/userInfo/getAllUserCollect.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userName;
    params[@"lastUpdateTime"] = lastUpdateTime;
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            NSMutableArray * mutableArrayData = [NSMutableArray array];
            NSArray *beijingList = dic[@"resultBeiJinglist"];
            for (NSDictionary *tempdic in beijingList) {
                ZZUserCollect *model = [ZZUserCollect queryZZUserCollectModelWithDic:tempdic];
                model.address = @"北京";
                [mutableArrayData addObject:model];
            }
            
            NSArray *shanghaiList = dic[@"resultShangHailist"];
            for (NSDictionary *tempdic in shanghaiList) {
                ZZUserCollect *model = [ZZUserCollect queryZZUserCollectModelWithDic:tempdic];
                model.address = @"上海";
                [mutableArrayData addObject:model];

            }
            
            NSArray *shenzhenList = dic[@"resultShenZhenlist"];
            for (NSDictionary *tempdic in shenzhenList) {
                ZZUserCollect *model = [ZZUserCollect queryZZUserCollectModelWithDic:tempdic];
                model.address = @"深圳";
                [mutableArrayData addObject:model];
            }
            
            NSArray *guangzhouList = dic[@"resultGuangZhoulist"];
            for (NSDictionary *tempdic in guangzhouList) {
                ZZUserCollect *model = [ZZUserCollect queryZZUserCollectModelWithDic:tempdic];
                model.address = @"广州";
                [mutableArrayData addObject:model];

            }
            
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"getAllUserCollectTag"]],mutableArrayData);
        }
        else
        {
            complete(NO,nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil);
    }];


}

+ (void)requestGetAllUserAdd:(NSString *)userName andBeiJingMin:(NSString *)beiJingMin andBeiJingMax:(NSString *)beiJingMax andShangHaiMin:(NSString *)shangHaiMin andShangHaiMax:(NSString *)shangHaiMax andGuangZhouMin:(NSString *)guangZhouMin andGuangZhouMax:(NSString *)guangZhouMax andShenZhenMin:(NSString *)shenZhenMin andShenZhenMax:(NSString *)shenZhenMax complete:(void (^)(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *arrayData)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/userInfo/getAllUserAdd.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userName;
    params[@"beiJingMin"] = beiJingMin;
    params[@"beiJingMax"] = beiJingMax;
    params[@"shangHaiMin"] = shangHaiMin;
    params[@"shangHaiMax"] = shangHaiMax;
    params[@"guangZhouMin"] = guangZhouMin;
    params[@"guangZhouMax"] = guangZhouMax;
    params[@"shenZhenMin"] = shenZhenMin;
    params[@"shenZhenMax"] = shenZhenMax;
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            [DataManager setBeijingUersAddCount:[NSString stringWithFormat:@"%d",[[DataManager beijingUersAddCount] intValue] + [dic[@"resultBeiJinglistCount"] intValue] ]];
            [DataManager setShanghaiUersAddCount:[NSString stringWithFormat:@"%d",[[DataManager shanghaiUersAddCount] intValue] + [dic[@"resultShangHailistCount"] intValue] ]];
            [DataManager setGuangzhouUersAddCount:[NSString stringWithFormat:@"%d",[[DataManager guangzhouUersAddCount] intValue] + [dic[@"resultGuangZhoulistCount"] intValue] ]];
            [DataManager setShenzhenUersAddCount:[NSString stringWithFormat:@"%d",[[DataManager shenzhenUersAddCount] intValue] + [dic[@"resultShenZhenlistCount"] intValue] ]];
            
            
            
            BOOL isUpdate = FALSE;
           NSMutableArray * mutableArrayData = [NSMutableArray array];
            NSArray *beijingList = dic[@"resultBeiJinglist"];
            for (NSDictionary *tempdic in beijingList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserAdd *fpuserAdd =  [FPUserAdd MR_createEntity];
                fpuserAdd.sid = model.sid;
                fpuserAdd.parkName = model.parkName;
                fpuserAdd.reviewTime = model.reviewTime;
                fpuserAdd.isUpdate = model.isUpdate;
                fpuserAdd.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                fpuserAdd.cityIndex = @"0";
                
                [mutableArrayData addObject:fpuserAdd];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
            NSArray *shanghaiList = dic[@"resultShangHailist"];
            for (NSDictionary *tempdic in shanghaiList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserAdd *fpuserAdd =  [FPUserAdd MR_createEntity];
                fpuserAdd.sid = model.sid;
                fpuserAdd.parkName = model.parkName;
                fpuserAdd.reviewTime = model.reviewTime;
                fpuserAdd.isUpdate = model.isUpdate;
                fpuserAdd.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                  fpuserAdd.cityIndex = @"1";
                [mutableArrayData addObject:fpuserAdd];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
            NSArray *shenzhenList = dic[@"resultShenZhenlist"];
            for (NSDictionary *tempdic in shenzhenList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserAdd *fpuserAdd =  [FPUserAdd MR_createEntity];
                fpuserAdd.sid = model.sid;
                fpuserAdd.parkName = model.parkName;
                fpuserAdd.reviewTime = model.reviewTime;
                fpuserAdd.isUpdate = model.isUpdate;
                fpuserAdd.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                  fpuserAdd.cityIndex = @"3";
                [mutableArrayData addObject:fpuserAdd];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
            NSArray *guangzhouList = dic[@"resultGuangZhoulist"];
            for (NSDictionary *tempdic in guangzhouList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserAdd *fpuserAdd =  [FPUserAdd MR_createEntity];
                fpuserAdd.sid = model.sid;
                fpuserAdd.parkName = model.parkName;
                fpuserAdd.reviewTime = model.reviewTime;
                fpuserAdd.isUpdate = model.isUpdate;
                fpuserAdd.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                  fpuserAdd.cityIndex = @"2";
                [mutableArrayData addObject:fpuserAdd];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
           
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"getUserParkAddTag"]],isUpdate,mutableArrayData);
        }
        else
        {
            complete(NO,nil,nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil,nil);
    }];
    
}
+ (void)requestSetCollectOpenStatus:(NSString *)collectParkId andUserName:(NSString *)userName andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/userInfo/setCollectOpenStatus.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"collectParkId"] = collectParkId;
    params[@"userName"] = userName;
    params[@"cityIndex"] = cityIndex;
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"setCollectOpenStatusTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];

}
+ (void)requestGetAllUserReview:(NSString *)userName andBeiJingMin:(NSString *)beiJingMin andBeiJingMax:(NSString *)beiJingMax andShangHaiMin:(NSString *)shangHaiMin andShangHaiMax:(NSString *)shangHaiMax andGuangZhouMin:(NSString *)guangZhouMin andGuangZhouMax:(NSString *)guangZhouMax andShenZhenMin:(NSString *)shenZhenMin andShenZhenMax:(NSString *)shenZhenMax complete:(void (^)(BOOL, NSString *,BOOL,NSMutableArray *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/userInfo/getAllUserReview.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userName;
    params[@"beiJingMin"] = beiJingMin;
    params[@"beiJingMax"] = beiJingMax;
    params[@"shangHaiMin"] = shangHaiMin;
    params[@"shangHaiMax"] = shangHaiMax;
    params[@"guangZhouMin"] = guangZhouMin;
    params[@"guangZhouMax"] = guangZhouMax;
    params[@"shenZhenMin"] = shenZhenMin;
    params[@"shenZhenMax"] = shenZhenMax;
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            [DataManager setBeijingReviewCount:[NSString stringWithFormat:@"%d",[[DataManager beijingReviewCount] intValue] + [dic[@"resultBeiJinglistCount"] intValue] ]];
            [DataManager setShanghaiReviewCount:[NSString stringWithFormat:@"%d",[[DataManager shanghaiReviewCount] intValue] + [dic[@"resultShangHailistCount"] intValue] ]];
            [DataManager setGuangzhouReviewCount:[NSString stringWithFormat:@"%d",[[DataManager guangzhouReviewCount] intValue] + [dic[@"resultGuangZhoulistCount"] intValue] ]];
            [DataManager setShenzhenReviewCount:[NSString stringWithFormat:@"%d",[[DataManager shenzhenReviewCount] intValue] + [dic[@"resultShenZhenlistCount"] intValue] ]];
            
            
            BOOL isUpdate = FALSE;
             NSMutableArray * mutableArrayData = [NSMutableArray array];
            NSArray *beijingList = dic[@"resultBeiJinglist"];
            for (NSDictionary *tempdic in beijingList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserReview *fpuserReview= [FPUserReview MR_createEntity];
                fpuserReview.sid = model.sid;
                fpuserReview.parkName = model.parkName;
                fpuserReview.reviewTime = model.reviewTime;
                fpuserReview.isUpdate = model.isUpdate;
                fpuserReview.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                fpuserReview.cityIndex = @"0";
                [mutableArrayData addObject:fpuserReview];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
            NSArray *shanghaiList = dic[@"resultShangHailist"];
            for (NSDictionary *tempdic in shanghaiList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserReview *fpuserReview= [FPUserReview MR_createEntity];
                fpuserReview.sid = model.sid;
                fpuserReview.parkName = model.parkName;
                fpuserReview.reviewTime = model.reviewTime;
                fpuserReview.isUpdate = model.isUpdate;
                fpuserReview.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                 fpuserReview.cityIndex = @"1";
                [mutableArrayData addObject:fpuserReview];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
            NSArray *shenzhenList = dic[@"resultShenZhenlist"];
            for (NSDictionary *tempdic in shenzhenList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserReview *fpuserReview= [FPUserReview MR_createEntity];
                fpuserReview.sid = model.sid;
                fpuserReview.parkName = model.parkName;
                fpuserReview.reviewTime = model.reviewTime;
                fpuserReview.isUpdate = model.isUpdate;
                fpuserReview.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                 fpuserReview.cityIndex = @"3";
                [mutableArrayData addObject:fpuserReview];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
            NSArray *guangzhouList = dic[@"resultGuangZhoulist"];
            for (NSDictionary *tempdic in guangzhouList) {
                ZZUserAddOrReview *model = [ZZUserAddOrReview queryZZUserAddOrReviewModelWithDic:tempdic];
                FPUserReview *fpuserReview= [FPUserReview MR_createEntity];
                fpuserReview.sid = model.sid;
                fpuserReview.parkName = model.parkName;
                fpuserReview.reviewTime = model.reviewTime;
                fpuserReview.isUpdate = model.isUpdate;
                fpuserReview.posttime = model.posttime;
                if ([model.isUpdate isEqualToString:@"1"]) {
                    isUpdate = TRUE;
                }
                 fpuserReview.cityIndex = @"2";
                [mutableArrayData addObject:fpuserReview];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            
          
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"getUserParkReviewTag"]],isUpdate,mutableArrayData);
        }
        else
        {
            complete(NO,nil,nil,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil,nil,nil);
    }];
}

+ (void)requestPostSuggest:(NSString *)content andUserName:(NSString *)userName andUserMail:(NSString *)userMail complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/userInfo/postSuggest.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"content"] = content;
    params[@"userName"] = userName;
    params[@"userMail"] = userMail;
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"sendMailTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];
    
}

+ (void)requestPostAlreadyClickMyAddPark:(NSString *)parkId andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/postAlreadyClickMyAddPark.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parkId"] = parkId;
    params[@"cityIndex"] = cityIndex;

    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"PostClearTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];

}
+ (void)requestModifyParkHire:(NSString *)session_name andCaptcha:(NSString *)captcha complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/captcha/check.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"session_name"] = session_name;
    params[@"captcha"] = captcha;
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"captchaTag"]]);
        }
        else
        {
            complete(NO,nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO,nil);
    }];

}
+ (void)requestCreate:(NSString *)session_name complete:(void (^)(BOOL, NSData *, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/captcha/create.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"session_name"] = session_name;
    
    [WDHTTPTool postWithURLResponseImage:url params:params success:^(id nadata) {
        complete(YES,nadata,nil);
    } failure:^(NSError *error) {
        complete(NO,nil,nil);

    }];
//
//    [WDHTTPTool getWithURL:<#(NSString *)#> params:<#(NSDictionary *)#> fileStream:(NSData *) success:<#^(id)success#> failure:<#^(NSError *)failure#>]
//    [WDHTTPTool getWithURL:url params:params success:^(id json) {
//        if (json) {
////            NSDictionary *dic = (NSDictionary *)json;
////            
////            complete(YES,[NSString stringWithFormat:@"%@",dic[@"PostClearTag"]]);
//        }
//        else
//        {
////            complete(NO,nil);
//        }
//        
//    } failure:^(NSError *error) {
////        complete(NO,nil);
//    }];

}
+ (void)requestPostAlreadyClickMyCommentPark:(NSString *)parkId andCityIndex:(NSString *)cityIndex andUserName:(NSString*)userName complete:(void (^)(BOOL, NSString *))complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/postAlreadyClickMyCommentPark.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parkId"] = parkId;
    params[@"cityIndex"] = cityIndex;
    params[@"userName"] = userName;
    
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        if (json) {
            NSDictionary *dic = (NSDictionary *)json;
            
            complete(YES,[NSString stringWithFormat:@"%@",dic[@"PostClearTag"]]);
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
