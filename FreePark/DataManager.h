//
//  DataManager.h
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataManager : NSObject


+ (BOOL)isShowWelcomeAlready;
+ (void)setShowWelcomeAlready;

+ (NSString *)modifyLastTime;
+ (void)setModifyLastTime:(NSString *)modifyLastTime;

+ (void)setUserName:(NSString *)name;
+ (NSString *)getUserName;

+ (void)setAppcountAlready;
+ (BOOL)isSetAppcountAlready;

+ (void)setNotNotice:(NSString *)version;
+ (NSString *)getNotNoticeVersion;


+ (void)setLatitude:(double)latitude;
+ (double)latitude;
+ (void)setLongitude:(double)longitude;
+ (double)longitude;

+ (void)setCityIndex:(NSString *)cityIndex;
+ (NSString *)cityIndex;

+ (void)setCurrUserShared:(BOOL)shared;
+ (BOOL)getCurrUserShared;

+ (void)setRemoteNoticeNumber:(NSInteger)count;
+ (long)remoteNoticeNumber;



+ (void)setBeijingReviewCount:(NSString *)count;
+ (NSString *)beijingReviewCount;


+ (void)setBeijingUersAddCount:(NSString *)count;
+ (NSString *)beijingUersAddCount;


+ (void)setShanghaiReviewCount:(NSString *)count;
+ (NSString *)shanghaiReviewCount;


+ (void)setShanghaiUersAddCount:(NSString *)count;
+ (NSString *)shanghaiUersAddCount;


+ (void)setGuangzhouReviewCount:(NSString *)count;
+ (NSString *)guangzhouReviewCount;


+ (void)setGuangzhouUersAddCount:(NSString *)count;
+ (NSString *)guangzhouUersAddCount;


+ (void)setShenzhenReviewCount:(NSString *)count;
+ (NSString *)shenzhenReviewCount;


+ (void)setShenzhenUersAddCount:(NSString *)count;
+ (NSString *)shenzhenUersAddCount;

+(void)setEnterAppTimes:(NSInteger)times;
+(NSInteger)enterAppTimes;

+(void)setEnterAppStore:(BOOL)enterAppStore;
+(BOOL)getEnterAppStore;

+(NSString *)serverIp;
+(void)setServerIP:(NSString *)ip;

@end
