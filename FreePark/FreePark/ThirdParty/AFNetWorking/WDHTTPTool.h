//
//  WDHTTPTool.h
//  Wanda
//
//  Created by 龚伟 on 15/7/19.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Singleton.h"
@interface WDHTTPTool : NSObject
singleton_interface(WDHTTPTool)

+ (void)initHttps;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)getHtmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param fileStream 文件流
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params fileStream:(NSData *)fileStream success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURLResponseImage:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  上传图片函数
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param image   上传的图片
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)posImageWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
                 Image:(UIImage *)image
               success:(void (^)(NSDictionary *))success
               failure:(void (^)(NSError *))failure;

+ (NSString *)errorMsg:(NSDictionary *)rsp;
@end
