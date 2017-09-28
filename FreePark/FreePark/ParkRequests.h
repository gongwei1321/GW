//
//  ParkRequests.h
//  FreePark
//
//  Created by zhangwx on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ParkRequests : NSObject

+ (void) requestParksByPoint:(CLLocationCoordinate2D)point complete:(void (^)(BOOL issuccess, NSMutableArray *retArr)) complete;

+ (void)requestCurrentAddress:(void (^)(BOOL issuccess, NSString *ret)) complete;

+ (void)requestParkSearchToCoor:(NSString *)placeName City:(NSString *)city complete:(void (^)(BOOL issuccess, NSArray *retPositions)) complete;

+ (void)requestParkTags:(NSString *)parkID andCityIndex:(NSString *)cityIndex  complete:(void (^)(BOOL issuccess, NSArray *parkTags)) complete;

+ (void)requestParkShareReason:(NSString *)parkName complete:(void (^)(BOOL issuccess, NSString *reason)) complete;

+ (void)requestParkComment:(NSString *)parkID pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSArray *parkCommens, NSInteger totalPage)) complete;

+ (void)requestParkAddressByPoint:(CLLocationCoordinate2D)point complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)sendParkComment:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)sendParkCommentReply:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)sendParkCommentEdit:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)sendParkCommentDelete:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)sendParkCommentLabel:(NSDictionary *)comment complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)requestParkCommentLabel:(NSString *)cityIndex andID:(NSString *)parkID complete:(void (^)(BOOL issuccess, NSArray *parkTags)) complete;

+ (void)sendParkCollect:(NSDictionary *)param complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

+ (void)sendParkUnCollect:(NSDictionary *)param complete:(void (^)(BOOL issuccess, NSString *parkAddr)) complete;

@end
