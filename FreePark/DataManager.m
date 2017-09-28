//
//  DataManager.m
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#define SET_OBJECT(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define SET_DOUBLE(value, key) [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key]
#define GET_DOUBLE(key) [[NSUserDefaults standardUserDefaults] doubleForKey:key]


#define SET_INTEGER(value, key) [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key]
#define GET_INTEGER(key) [[NSUserDefaults standardUserDefaults] integerForKey:key]
#import "DataManager.h"
@interface DataManager ()

@end

static DataManager *dataManager;

@implementation DataManager

+ (void)initialize {
  if(!dataManager) {
    dataManager = [[DataManager alloc] init];
    
  }
}

+ (BOOL)getEnterAppStore
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"EnterAppStore"];
}
+ (void)setEnterAppStore:(BOOL)enterAppStore
{
     [[NSUserDefaults standardUserDefaults] setBool:enterAppStore forKey:@"EnterAppStore"];
}
+ (BOOL)isShowWelcomeAlready {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"welcome"];
}
+ (BOOL)isSetAppcountAlready
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"appcount"];
}
+ (void)setAppcountAlready
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"appcount"];
}
+ (NSString *)modifyLastTime
{
    return  GET_OBJECT(@"modifyLastTime");

}
+ (void)setModifyLastTime:(NSString *)modifyLastTime
{
    [[NSUserDefaults standardUserDefaults] setObject:modifyLastTime forKey:@"modifyLastTime"];
}
+ (void)setShowWelcomeAlready {
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"welcome"];
}
+ (void)setNotNotice:(NSString *)version
{
   [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"notNoticeVersion"];
}
+ (void)setUserName:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"nickName"];
}
+ (NSString *)getNotNoticeVersion
{
     return  GET_OBJECT(@"notNoticeVersion");
}

+ (NSString *)getUserName
{
   return  GET_OBJECT(@"nickName");
}

+ (void)setCityIndex:(NSString *)cityIndex
{
    SET_OBJECT(cityIndex, @"cityIndex");
}
+ (NSString *)cityIndex
{
    NSString *cityindex = GET_OBJECT(@"cityIndex");
    if ([cityindex isEqualToString:@""] || cityindex == nil) {
        return @"0";
    }
    return cityindex;
}

+ (void)setCurrUserShared:(BOOL)shared
{
    if ([DataManager getUserName]) {
        SET_OBJECT(shared?@(1):@(0), [DataManager getUserName]);
    }
}


+ (BOOL)getCurrUserShared
{
    if ([DataManager getUserName]) {
        return GET_OBJECT([DataManager getUserName]);
    }
    return NO;
}

+ (void)setLatitude:(double) latitude{
    SET_DOUBLE(latitude, @"latitude");
}
+ (void)setRemoteNoticeNumber:(NSInteger)count
{
    SET_INTEGER(count, @"noticeNumber");
}
+ (NSInteger)remoteNoticeNumber
{
   return  GET_INTEGER(@"noticeNumber");
}

+ (double)latitude {
    //  return 30.465293;
    return GET_DOUBLE(@"latitude");
}

+ (void)setLongitude:(double)longitude {
    SET_DOUBLE(longitude, @"longitude");
}

+ (double)longitude {
    //  return 114.393719;
    return GET_DOUBLE(@"longitude");
}


+ (void)setServerIP:(NSString *)ip
{
    [[NSUserDefaults standardUserDefaults] setValue:ip forKey:@"ServerIP"];
}

+ (NSString *)serverIp
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"ServerIP"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"ServerIP"];
}

+ (void)setBeijingReviewCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"BeijingReviewCount"];
}
+ (NSString *)beijingReviewCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"BeijingReviewCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"BeijingReviewCount"];
}


+ (void)setBeijingUersAddCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"BeijingUersAddCount"];
}
+ (NSString *)beijingUersAddCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"BeijingUersAddCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"BeijingUersAddCount"];
}




+ (void)setShanghaiReviewCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"ShanghaiReviewCount"];
}
+ (NSString *)shanghaiReviewCount
{

    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"ShanghaiReviewCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"ShanghaiReviewCount"];
}


+ (void)setShanghaiUersAddCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"ShangHaiUersAddCount"];
}
+ (NSString *)shanghaiUersAddCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"ShangHaiUersAddCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"ShangHaiUersAddCount"];
}




+ (void)setGuangzhouReviewCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"GuangzhouReviewCount"];
}
+ (NSString *)guangzhouReviewCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"GuangzhouReviewCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"GuangzhouReviewCount"];
}


+ (void)setGuangzhouUersAddCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"GuangzhouUersAddCount"];
}
+ (NSString *)guangzhouUersAddCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"GuangzhouUersAddCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"GuangzhouUersAddCount"];
}




+ (void)setShenzhenReviewCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"ShenzhenReviewCount"];
}
+ (NSString *)shenzhenReviewCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"ShenzhenReviewCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"ShenzhenReviewCount"];
}


+ (void)setShenzhenUersAddCount:(NSString *)count
{
    [[NSUserDefaults standardUserDefaults] setValue:count forKey:@"ShenzhenUersAddCount"];
}
+ (NSString *)shenzhenUersAddCount
{
    if( [[NSUserDefaults standardUserDefaults] valueForKey:@"ShenzhenUersAddCount"] == nil)
    {
        return @"0";
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"ShenzhenUersAddCount"];
}
+ (void)setEnterAppTimes:(NSInteger)times
{
     [[NSUserDefaults standardUserDefaults] setInteger:times forKey:@"EnterAppTimes"];
}
+ (NSInteger)enterAppTimes
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"EnterAppTimes"];
}
@end
