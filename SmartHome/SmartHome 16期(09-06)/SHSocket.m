//
//  SHSocket.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/7.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "SHSocket.h"

@implementation SHSocket
singleton_implementation(SHSocket)
// socket连接
-(void)socketConnectHost{
    
    self.socket    = [[AsyncSocket alloc] initWithDelegate:self];
    
    NSError *error = nil;
    
    [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:-1 error:&error];
    [self.socket readDataWithTimeout:-1 tag:0];
    
}

#pragma mark  - 连接成功回调
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString  *)host port:(UInt16)port
{
    NSLog(@"socket连接成功");
    [GWTool sharedGWTool].isShowNotConnect = FALSE;

    [[NSNotificationCenter defaultCenter] postNotificationName:SOCKET_ON object:nil];
    
    // 每隔30s像服务器发送心跳包
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
    
    [self.connectTimer fire];
    
}

// 切断socket
-(void)cutOffSocket{
    
    self.socket.userData = SocketOfflineByUser;// 声明是由用户主动切断
    
    NSLog(@"cutOffSocket");
    [self.connectTimer invalidate];
    
    [self.socket disconnect];
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
//    NSLog([self hexStringFromData:data]);
//    NSLog(@"didReadData");
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSString *reciveMsg = [self hexStringFromData:data];
     NSLog(reciveMsg);
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"消息" message:reciveMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alter show];
    if (![reciveMsg hasPrefix:@"02"] && ![reciveMsg hasPrefix:@"03"]) {
        NSInteger pos1 = [reciveMsg rangeOfString:@"02"].location;
        NSInteger pos2 = [reciveMsg rangeOfString:@"03"].location;
        if(pos1!=NSNotFound)
        {
             reciveMsg = [reciveMsg substringFromIndex:pos1];
        }
        else if(pos2!=NSNotFound)
        {
            reciveMsg = [reciveMsg substringFromIndex:pos2];
        }
    }
    NSLog(reciveMsg);
     NSInteger iCount = reciveMsg.length/16;
     for (int i = 0; i<iCount; i++) {
        
         NSRange rang;
         rang.length = 16;
         rang.location = i*16;
//         NSLog(@"%d",rang.location);
         NSString *truemsg = [reciveMsg substringWithRange:rang];
//         NSLog(@"%d-----%@",i,truemsg);
         [[GWTool sharedGWTool].vc manageSocketMsg:truemsg]  ;
     }
    
     [self.socket readDataWithTimeout:-1 tag:0];
}

//data转换为十六进制的。
- (NSString *)hexStringFromData:(NSData *)myD{
    
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
//    NSLog(@"%@",hexStr.uppercaseString);
    
    return hexStr;
}

// 十六进制转换为普通字符串的。
- (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString; 
    
    
}

//重连
//实现代理方法
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"sorry the connect is failure %ld",sock.userData);
   
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:SOCKET_OFF object:nil];

    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        [self socketConnectHost];
    }
    else if (sock.userData == SocketOfflineByUser) {
        // 如果由用户断开，不进行重连
        return;
    }
    
}
-(void)sendSocketQueryDeviceState:(NSString *)port{
    
    NSString *msgLossen = [NSString stringWithFormat:@"AA5578%@00C33C",port];
    NSData *aDataLossen = [self stringToByte:msgLossen];
    [self.socket writeData:aDataLossen withTimeout:-1 tag:1];
    
}
- (void)sendSocketUp:(NSString *)port
{
    NSString *msgLossen = [NSString stringWithFormat:@"A278%@0D0A",port];
    NSData *aDataLossen = [self stringToByte:msgLossen];
    [self.socket writeData:aDataLossen withTimeout:-1 tag:1];
}
-(void)sendSocket:(NSString *)port
{
    
    //    [[SHSocket sharedSHSocket].socket writeData:aData withTimeout:-1 tag:1];
    NSString *msgPress = [NSString stringWithFormat:@"A279%@0D0A",port];
    NSData *aDataPress = [self stringToByte:msgPress];
    [self.socket writeData:aDataPress withTimeout:-1 tag:1];
    
    
}
// 心跳连接
-(void)longConnectToSocket{
    
    // 根据服务器要求发送固定格式的数据，假设为指令@"longConnect"，但是一般不会是这么简单的指令
    
//    NSString *longConnect = @"longConnect";
//    
//    NSData   *dataStream  = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [self.socket writeData:dataStream withTimeout:1 tag:1];
    
//    [self.socket readDataWithTimeout:-1 tag:0];
    
}

-(NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

@end
