//
//  ViewController.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/7.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "ViewController.h"
#import "CodeViewController.h"

@interface ViewController ()
/**
 *  主页的几个按钮
 */
@property (nonatomic,strong) UIButton* lightButton; // 灯光
@property (nonatomic,strong) UIButton* movieButton;//影音
@property (nonatomic,strong) UIButton* electricButton;//电器
@property (nonatomic,strong) UIButton* refineButton;//净化



@property (nonatomic,assign) CGFloat buttonWidth;//按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh;//按钮的高度
@property (nonatomic,assign) CGFloat buttonInterval;//图标之间的间隔

@property (nonatomic,strong) ScrollViewController *scrollVC;



@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController
- (IBAction)click:(id)sender {
       

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"03电器背景_02"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, self.view.frame.size.height * 0.85, self.view.frame.size.width, self.view.frame.size.height * 0.15);


//    [imageView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:imageView];
    self.imageView = imageView;

    
    //灯光
    MainViewController *lightVC = [[MainViewController alloc] init];
    lightVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:lightVC.view];
    [self addChildViewController:lightVC];
     self.lightVC = lightVC;
    
    
    //电器
    ElectricViewController *electricVC = [[ElectricViewController alloc] init];
    electricVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:electricVC.view];
    [self addChildViewController:electricVC];
    self.electricVC = electricVC;
    
    //影音
    MovieViewController *moviewVC = [[MovieViewController alloc] init];
    moviewVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:electricVC.view];
    [self addChildViewController:moviewVC];
    self.moviewVC = moviewVC;
    
    //净化
    DeskViewController *refineVC = [[DeskViewController alloc] init];
    refineVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:refineVC.view];
    [self addChildViewController:refineVC];
    self.refineVC = refineVC;
    

//
//   
//    //获取图标的大小
//    UIImage *image = [UIImage imageNamed:@"light"];
    self.buttonHeigh = self.view.frame.size.height * 0.168;
    self.buttonWidth = self.buttonHeigh;
//
    self.movieButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"00灯光_14-7"] selectImage:[UIImage imageNamed:@"00灯光_14-8"]];
    [self.movieButton addTarget:self action:@selector(clickMovie:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.movieButton];

    
   

    self.electricButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"00灯光_14-6"] selectImage:[UIImage imageNamed:@"00灯光_14-9"]];
    [self.electricButton addTarget:self action:@selector(clickElectric:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.electricButton];


    self.lightButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"00灯光_14-1"] selectImage:[UIImage imageNamed:@"00灯光_14"]];
    [self.lightButton addTarget:self action:@selector(clickLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lightButton];
//
//    self.refineButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"nav_default3"] selectImage:[UIImage imageNamed:@"nav_selectsd3"]];
//    [self.refineButton addTarget:self action:@selector(clickRefineButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.refineButton];
//    
//    if(self.view.frame.size.height > 500)
//    {
//        //
//        //    //排列图标
//        WS(ws);
//        [self.lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(-self.view.frame.size.height * 0.005);
//            make.left.mas_equalTo(self.view.frame.size.width * 0.08);
//            make.width.mas_equalTo(self.buttonWidth);
//            make.height.mas_equalTo(self.buttonHeigh);
//        }];
//        
//        [self.refineButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(-self.view.frame.size.height * 0.005);
//            make.left.mas_equalTo(self.view.frame.size.width * 0.08 + self.buttonWidth * 2);
//            make.width.mas_equalTo(self.buttonWidth );
//            make.height.mas_equalTo(self.buttonHeigh );
//            
//        }];
//        
//        [self.movieButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(-self.view.frame.size.height * 0.005);
//            make.left.mas_equalTo(self.view.frame.size.width * 0.08 + self.buttonWidth );
//            make.width.mas_equalTo(self.buttonWidth );
//            make.height.mas_equalTo(self.buttonHeigh );
//        }];
//        
//        [self.electricButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(-self.view.frame.size.height * 0.005);
//            make.left.mas_equalTo(self.view.frame.size.width *  0.08 + self.buttonWidth * 3);
//            make.width.mas_equalTo(self.buttonWidth );
//            make.height.mas_equalTo(self.buttonHeigh );
//        }];
//
//    }
//    else{
        WS(ws);
        [self.lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(-self.buttonWidth * 2.8);
            make.width.mas_equalTo(self.buttonWidth);
            make.height.mas_equalTo(self.buttonHeigh);
        }];
    
        [self.electricButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(-self.buttonWidth * 0.5);
            make.width.mas_equalTo(self.buttonWidth );
            make.height.mas_equalTo(self.buttonHeigh);
        }];
        
        [self.movieButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
             make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(self.buttonWidth * 1.8);
            make.width.mas_equalTo(self.buttonWidth );
            make.height.mas_equalTo(self.buttonHeigh );
        }];

//    }


    


   
    [GWTool sharedGWTool].vc = self;
        
   
    
    [self clickLight:self.lightButton];
    
    [MBProgressHUD showMessage:@"正在连接" toView:self.view];
    [GWTool sharedGWTool].isShowNotConnect = TRUE;

//    char * a = (char*)malloc(sizeof('c'));
//    NSData *aData = [NSData dataWithBytes: a   length:strlen(a)];//    NSData* aData= [@"0x48" dataUsingEncoding: NSUTF8StringEncoding];
//    NSData* aData= [@"48" dataUsingEncoding: NSASCIIStringEncoding];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    //清除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketOFF) name:SOCKET_OFF object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketON) name:SOCKET_ON object:nil];
}
- (void)socketOFF
{
    if ([GWTool sharedGWTool].isShowNotConnect == FALSE) {
        [MBProgressHUD showMessage:@"正在连接" toView:self.view];
        [GWTool sharedGWTool].isShowNotConnect = TRUE;
    }
    
    
}
- (void)socketON
{
  [MBProgressHUD hideHUDForView:self.view];
}
-(void)dealloc
{
    //清除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


//右座椅
- (void)clickRightDesk:(UIButton *)button
{
//    if([GWTool sharedGWTool].scrollVc == nil)
//    {
//       [GWTool sharedGWTool].scrollVc  = [[ScrollViewController alloc] init];
//    }
//    self.view.window.rootViewController = [GWTool sharedGWTool].scrollVc;
    self.scrollVC = [[ScrollViewController alloc] init];
    self.scrollVC.offset = 3;
    self.view.window.rootViewController = self.scrollVC;
    
}
- (void)clickRefineButton:(UIButton *)button
{
    [self.moviewVC.view removeFromSuperview];
    [self.lightVC.view removeFromSuperview];
    [self.electricVC.view removeFromSuperview];
    [self.view addSubview:self.refineVC.view];

    self.lightButton.selected = NO;
    self.movieButton.selected = NO;
    self.electricButton.selected = NO;
    self.refineButton.selected = YES;
}
//影音
- (void)clickMovie:(UIButton *)button
{
    
    
  
    [self.electricVC.view removeFromSuperview];
    [self.lightVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.view addSubview:self.moviewVC.view];
    
    self.lightButton.selected = NO;
    self.movieButton.selected = YES;
    self.electricButton.selected = NO;
    self.refineButton.selected = NO;
    [self.imageView setImage:[UIImage imageNamed:@"03电器背景_02"]];
}
//电器
-(void)clickElectric:(UIButton *)button
{
    [self.moviewVC.view removeFromSuperview];
    [self.lightVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.view addSubview:self.electricVC.view];
    
    self.lightButton.selected = NO;
    self.movieButton.selected = NO;
    self.electricButton.selected = YES;
    self.refineButton.selected = NO;
    [self.imageView setImage:[UIImage imageNamed:@"02娱乐背景_02"]];
}
//灯光按钮点击
- (void)clickLight:(UIButton *)button
{
   
    [self.moviewVC.view removeFromSuperview];
    [self.electricVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.view addSubview:self.lightVC.view];
    self.lightButton.selected = YES;
    self.movieButton.selected = NO;
    self.electricButton.selected = NO;
    self.refineButton.selected = NO;
    [self.imageView setImage:[UIImage imageNamed:@"01灯光背景_02"]];
}


//-(NSData*)stringToByte:(NSString*)string
//{
//    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([hexString length]%2!=0) {
//        return nil;
//    }
//    Byte tempbyt[1]={0};
//    NSMutableData* bytes=[NSMutableData data];
//    for(int i=0;i<[hexString length];i++)
//    {
//        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
//        int int_ch1;
//        if(hex_char1 >= '0' && hex_char1 <='9')
//            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
//        else if(hex_char1 >= 'A' && hex_char1 <='F')
//            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
//        else
//            return nil;
//        i++;
//        
//        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
//        int int_ch2;
//        if(hex_char2 >= '0' && hex_char2 <='9')
//            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
//        else if(hex_char2 >= 'A' && hex_char2 <='F')
//            int_ch2 = hex_char2-55; //// A 的Ascll - 65
//        else
//            return nil;
//        
//        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
//        [bytes appendBytes:tempbyt length:1];
//    }
//    return bytes;
//}

- (void)manageSocketMsg:(NSString *)msg
{

    msg = msg.uppercaseString;
    
    NSLog(msg);
    if(![msg hasPrefix:@"02"] && ![msg hasPrefix:@"03"])
    {
        //       NSLog(@"5AA5058200");
        return;
    }
    
    
    
    //02是关  03是开
    NSRange rang;
    rang.location = 2;
    rang.length = 4;
    NSString *port = [msg substringWithRange:rang];
    rang.location = 10;
    rang.length = 2;
    NSString *enable = [msg substringWithRange:rang];
    NSLog(enable);
    rang.location = 0;
    rang.length = 2;
    NSString *state = [msg substringWithRange:rang];
    if ([enable isEqualToString:@"0F"]) {
        
        /**
         *  灯光页
         */
        if ([port isEqualToString:@"0078"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.topLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.topLightButton.selected = YES;
            }
        }
        
               
        if ([port isEqualToString:@"0079"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.atmosphereLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.atmosphereLightButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"007A"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.wallLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.wallLightButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"007B"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.barLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.barLightButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0113"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.readLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.readLightButton.selected = YES;
            }
            
        }


        /**
         *  座椅
         */
       
        /*左椅子*/
       
        
        
        
        
        
        
        if ([port isEqualToString:@"0001"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.upLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.upLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0002"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.downLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.downLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0004"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.beiLeftLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.beiLeftLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0006"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.yaoLeftLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.yaoLeftLeftDeskButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0008"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.tuiLeftLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.tuiLeftLeftDeskButton.selected = YES;
            }
            
        }

        if ([port isEqualToString:@"0003"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.beiRightLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.beiRightLeftDeskButton.selected = YES;
            }
            
        }

        if ([port isEqualToString:@"0005"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.yaoRightLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.yaoRightLeftDeskButton.selected = YES;
            }
            
        }

        if ([port isEqualToString:@"0007"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.tuiRightLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.tuiRightLeftDeskButton.selected = YES;
            }
            
        }
        
        
        
        
        
        
        
        
        if ([port isEqualToString:@"0011"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.upRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.upRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0012"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.downRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.downRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0013"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.beiLeftRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.beiLeftRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0015"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.yaoLeftRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.yaoLeftRightDeskButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0017"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.tuiLeftRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.tuiLeftRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0014"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.beiRightRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.beiRightRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0016"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.yaoRightRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.yaoRightRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0018"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.tuiRightRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.tuiRightRightDeskButton.selected = YES;
            }
            
        }

        
        /**
         *  天窗
         */
        if ([port isEqualToString:@"0105"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.scuttleUpButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.scuttleUpButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0104"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.scuttleOpenButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.scuttleOpenButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0106"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.scuttleCloseButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.scuttleCloseButton.selected = YES;
            }
            
        }
        /**
         *  电动电器
         */
        
       if ([port isEqualToString:@"0114"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.moviePowerButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.moviePowerButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0122"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.airVolumeAddButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.airVolumeAddButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0123"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.airVolumeReduceButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.airVolumeReduceButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"01B1"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.volumeAddButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.volumeAddButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"01B2"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.volumeZeroButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.volumeZeroButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"01B3"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.volumeReduceButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.volumeReduceButton.selected = YES;
            }
            
        }
        
        
    }

    
}



@end
