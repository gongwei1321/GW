//
//  SHSocket.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/7.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};

@interface SHSocket : NSObject
singleton_interface(SHSocket)
@property (nonatomic, strong) AsyncSocket    *socket;       // socket
@property (nonatomic, copy  ) NSString       *socketHost;   // socket的Host
@property (nonatomic, assign) UInt16         socketPort;    // socket的prot
@property (nonatomic, retain) NSTimer        *connectTimer; // 计时器


-(void)socketConnectHost;// socket连接
-(void)cutOffSocket; // 断开socket连接
-(void)sendSocket:(NSString *)port;//发送数据
-(void)sendSocketUp:(NSString *)port;//发送数据
-(void)sendSocketQueryDeviceState:(NSString *)port;//发送数据
@end
