//
//  ParkRequests.m
//  FreePark
//
//  Created by zhangwx on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkRequests.h"
#import "ParkEntity.h"
#import "WDHTTPTool.h"
#import "DataManager.h"
@implementation ParkRequests

+ (void) requestParksByPoint:(CLLocationCoordinate2D)point complete:(void (^)(BOOL issuccess, NSMutableArray *retArr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/getNearPark.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lat"] = [NSString stringWithFormat:@"%lf", point.latitude];
    params[@"lng"] = [NSString stringWithFormat:@"%lf", point.longitude];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            
            NSNumber *cityIndex = dic[@"cityIndex"];
            [DataManager setCityIndex:[NSString stringWithFormat:@"%@",cityIndex]];
            if ([dic[@"resultlist"] isKindOfClass:[NSArray class]] && ((NSArray *)dic[@"resultlist"]).count > 0) {
                NSMutableArray *retArr = [[NSMutableArray alloc] init];
                
                for (NSDictionary *parkDic in (NSArray *)dic[@"resultlist"]) {
                    ParkEntity *entity = [ParkEntity instanceFromDic:parkDic];
                    [retArr addObject:entity];
                }
                complete(YES, retArr);
            }else{
                complete(NO, nil);
            }
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestCurrentAddress:(void (^)(BOOL issuccess, NSString *ret)) complete
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = [NSString stringWithFormat:@"%lf,%lf",[DataManager latitude],[DataManager longitude]];
    params[@"output"] = @"json";
    params[@"ak"] = @"sP43bnhmQCWI6zqSm6ZiKgtT";
    
    [WDHTTPTool getWithURL:@"http://api.map.baidu.com/geocoder/v2/" params:params success:^(id json) {
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            if ([dic[@"result"] isKindOfClass:[NSDictionary class]]) {
                if (dic[@"result"][@"formatted_address"]) {
                    complete(YES, dic[@"result"][@"formatted_address"]);
                }else{
                    complete(NO, nil);
                }
            }else{
                complete(NO, nil);
            }
        }
        else{
            complete(NO, nil);
        }
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestParkSearchToCoor:(NSString *)placeName City:(NSString *)city complete:(void (^)(BOOL issuccess, NSArray *retPositions)) complete
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"q"] = placeName;
    params[@"output"] = @"json";
    params[@"ak"] = @"sP43bnhmQCWI6zqSm6ZiKgtT";
    params[@"region"] = city;
    
    [WDHTTPTool getWithURL:@"http://api.map.baidu.com/place/v2/suggestion" params:params success:^(id json) {
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            if ([dic[@"result"] isKindOfClass:[NSArray class]] && ((NSArray *)dic[@"result"]).count > 0) {
                NSMutableArray *retArr = [[NSMutableArray alloc] init];
                
                for (NSDictionary *parkDic in (NSArray *)dic[@"result"]) {
                    NSMutableDictionary *park = [[NSMutableDictionary alloc] init];
                    park[@"parkName"] = parkDic[@"name"];
                    park[@"parkPosition"] = parkDic[@"location"];
                    [retArr addObject:park];
                }
                complete(YES, retArr);
            }else{
                complete(NO, nil);
            }
        }
        else{
            complete(NO, nil);
        }
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestParkTags:(NSString *)parkID andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSArray *parkTags)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getParkInfo/getParkLabel.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = parkID;
    params[@"cityIndex"] = cityIndex;
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            if ([dic[@"resultlist"] isKindOfClass:[NSArray class]] && ((NSArray *)dic[@"resultlist"]).count > 0) {
                NSMutableArray *retArr = [[NSMutableArray alloc] init];
                [retArr addObjectsFromArray:((NSArray *)dic[@"resultlist"])];
                complete(YES, retArr);
            }else{
                complete(NO, nil);
            }
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestParkShareReason:(NSString *)parkName complete:(void (^)(BOOL issuccess, NSString *reason)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getParkInfo/getParkShareReason.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parkName"] = parkName;
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            if ([dic[@"shareReason"] isKindOfClass:[NSString class]] && ((NSString *)dic[@"shareReason"]).length > 0) {
                complete(YES, ((NSString *)dic[@"shareReason"]));
            }else{
                complete(NO, nil);
            }
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestParkComment:(NSString *)parkID pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex andCityIndex:(NSString *)cityIndex  complete:(void (^)(BOOL issuccess, NSArray *parkCommens, NSInteger totalPage)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getParkInfo/getReviewById.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = parkID;
    params[@"pageSize"] = pageSize;
    params[@"pageIndex"] = pageIndex;
    params[@"cityIndex"] = cityIndex;
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            if ([dic[@"resultlist"] isKindOfClass:[NSArray class]] && ((NSArray *)dic[@"resultlist"]).count > 0) {
                NSMutableArray *retArr = [[NSMutableArray alloc] init];
                [retArr addObjectsFromArray:((NSArray *)dic[@"resultlist"])];
                complete(YES, retArr, [dic[@"totalPage"] integerValue]);
            }else{
                complete(NO, nil, 0);
            }
        }
        else{
            complete(NO, nil, 0);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil, 0);
    }];
}

+ (void)requestParkAddressByPoint:(CLLocationCoordinate2D)point complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    
}

+ (void)sendParkComment:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/postComment.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:comment];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            if ([json[@"postCommentTag"] intValue] == 70020) {
                complete(YES, nil);
            }else{
                complete(NO, @"您评论的过于频繁，请稍后再试");
            }
            
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)sendParkCommentReply:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/postCommentReply.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:comment];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            complete(YES, json[@"postCommentReplyTag"]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)sendParkCommentEdit:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/modifyMyCommnet.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:comment];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            complete(YES, json);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)sendParkCommentDelete:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/delMyCommnet.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:comment];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            complete(YES, json);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)sendParkCommentLabel:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/postLabel.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:comment];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            complete(YES, nil);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)requestParkCommentLabel:(NSString *)cityIndex andID:(NSString *)parkID complete:(void (^)(BOOL issuccess, NSArray *parkTags)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/getParkCommentLabel/getParkCommentLabel.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = parkID;
    params[@"cityIndex"] = cityIndex;
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            if ([dic[@"resultlist"] isKindOfClass:[NSArray class]] && ((NSArray *)dic[@"resultlist"]).count > 0) {
                NSMutableArray *retArr = [[NSMutableArray alloc] init];
                
                [retArr addObjectsFromArray:((NSArray *)dic[@"resultlist"])];
                complete(YES, retArr);
            }else{
                complete(NO, nil);
            }
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)sendParkCollect:(NSDictionary *)param complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/parkCollect.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            complete(YES, json[@"parkCollectTag"]);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

+ (void)sendParkUnCollect:(NSDictionary *)param complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete
{
    NSString *url = [NSString stringWithFormat:@"%@api/app/parkRelation/parkCollectCancel.php",[DataManager serverIp]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [WDHTTPTool postWithURL:url params:params success:^(id json) {
        
        if (json) {
            
            complete(YES, nil);
        }
        else{
            complete(NO, nil);
        }
        
    } failure:^(NSError *error) {
        complete(NO, nil);
    }];
}

@end
