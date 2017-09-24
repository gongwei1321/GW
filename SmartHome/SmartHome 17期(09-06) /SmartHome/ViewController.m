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
@property (nonatomic,strong) UIButton* leftRightDeskButton;//左右桌椅


@property (nonatomic,assign) CGFloat buttonWidth;//按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh;//按钮的高度
@property (nonatomic,assign) CGFloat buttonInterval;//图标之间的间隔

@property (nonatomic,strong) ScrollViewController *scrollVC;
@property (nonatomic,assign) BOOL m_bleftRightVC;


@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController
- (IBAction)click:(id)sender {
       

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    self.m_bleftRightVC = true;
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
    
    //左右桌椅
    LeftRightViewController *leftRightVC = [[LeftRightViewController alloc] init];
    leftRightVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:leftRightVC.view];
    [self addChildViewController:leftRightVC];
    self.leftRightVC = leftRightVC;
    
    //后桌椅
    BackDeskViewController *backDeskVC = [[BackDeskViewController alloc] init];
    backDeskVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:backDeskVC.view];
    [self addChildViewController:backDeskVC];
    self.backDeskVC = backDeskVC;
    

//
//   
//    //获取图标的大小
//    UIImage *image = [UIImage imageNamed:@"light"];
    self.buttonHeigh = self.view.frame.size.height * 0.168;
    self.buttonWidth = self.buttonHeigh;
//
    self.movieButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"01灯光效果_19-9"] selectImage:[UIImage imageNamed:@"01灯光效果_19-12"]];
    [self.movieButton addTarget:self action:@selector(clickMovie:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.movieButton];

    
   

    self.electricButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"01灯光效果_19-8"] selectImage:[UIImage imageNamed:@"01灯光效果_19-11"]];
    [self.electricButton addTarget:self action:@selector(clickElectric:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.electricButton];


    self.lightButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"01灯光效果_19"] selectImage:[UIImage imageNamed:@"01灯光效果_19-1"]];
    [self.lightButton addTarget:self action:@selector(clickLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lightButton];

    self.refineButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"01灯光效果_19-10"] selectImage:[UIImage imageNamed:@"01灯光效果_19-13"]];
    [self.refineButton addTarget:self action:@selector(clickRefineButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refineButton];
    
    
    self.leftRightDeskButton = [[GWTool sharedGWTool] setupButton3:[UIImage imageNamed:@"05"] selectImage:[UIImage imageNamed:@"05-1"]];
    [self.leftRightDeskButton addTarget:self action:@selector(clickLeftRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftRightDeskButton];

    
    
    WS(ws);
        [self.lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(-self.buttonWidth * 3.5);
            make.width.mas_equalTo(self.buttonWidth * 0.985);
            make.height.mas_equalTo(self.buttonHeigh * 0.985);
        }];
    
        [self.electricButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(-self.buttonWidth * 2);
            make.width.mas_equalTo(self.buttonWidth *  0.985);
            make.height.mas_equalTo(self.buttonHeigh *  0.985);
        }];
        
        [self.movieButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
            make.centerX.mas_equalTo(ws.view.mas_centerX).mas_offset(0);
            make.width.mas_equalTo(self.buttonWidth *  0.985 );
            make.height.mas_equalTo(self.buttonHeigh  *  0.985);
        }];
    
      [self.refineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(self.buttonWidth );
        make.width.mas_equalTo(self.buttonWidth *  0.985 );
        make.height.mas_equalTo(self.buttonHeigh  *  0.985 );
     }];
    
    [self.leftRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(ws.view.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(ws.view.mas_centerX).mas_offset(self.buttonWidth * 2.5);
        make.width.mas_equalTo(self.buttonWidth *  0.985 );
        make.height.mas_equalTo(self.buttonHeigh  *  0.985 );
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
    [self.leftRightVC.view removeFromSuperview];
    [self.backDeskVC.view removeFromSuperview];
    [self.view addSubview:self.refineVC.view];

    self.lightButton.selected = NO;
    self.movieButton.selected = NO;
    self.electricButton.selected = NO;
    self.leftRightDeskButton.selected  = NO;
    self.refineButton.selected = YES;
}

- (void)clickLeftRightButton:(UIButton *)button
{
    [self.electricVC.view removeFromSuperview];
    [self.lightVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.moviewVC.view removeFromSuperview];
    if( self.m_bleftRightVC == true)
    {
         [self.backDeskVC.view removeFromSuperview];
         [self.view addSubview:self.leftRightVC.view];
    }
    else{
        [self.leftRightVC.view removeFromSuperview];
        [self.view addSubview:self.backDeskVC.view];
    }
    
   
    
    self.lightButton.selected = NO;
    self.movieButton.selected = NO;
    self.electricButton.selected = NO;
    self.refineButton.selected = NO;
    self.leftRightDeskButton.selected  = YES;
    [self.imageView setImage:[UIImage imageNamed:@"04座椅（左右座椅）_02"]];
}
//影音
- (void)clickMovie:(UIButton *)button
{
    
    [self.electricVC.view removeFromSuperview];
    [self.lightVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.leftRightVC.view removeFromSuperview];
    [self.backDeskVC.view removeFromSuperview];
    [self.view addSubview:self.moviewVC.view];
    
    self.lightButton.selected = NO;
    self.movieButton.selected = YES;
    self.electricButton.selected = NO;
    self.refineButton.selected = NO;
    self.leftRightDeskButton.selected  = NO;
    [self.imageView setImage:[UIImage imageNamed:@"03电器背景_02"]];
}
//电器
-(void)clickElectric:(UIButton *)button
{
    [self.moviewVC.view removeFromSuperview];
    [self.lightVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.backDeskVC.view removeFromSuperview];
    [self.leftRightVC.view removeFromSuperview];
    [self.view addSubview:self.electricVC.view];
    
    self.lightButton.selected = NO;
    self.movieButton.selected = NO;
    self.electricButton.selected = YES;
     self.leftRightDeskButton.selected  = NO;
    self.refineButton.selected = NO;
    [self.imageView setImage:[UIImage imageNamed:@"02娱乐背景_02"]];
}
//灯光按钮点击
- (void)clickLight:(UIButton *)button
{
   
    [self.moviewVC.view removeFromSuperview];
    [self.electricVC.view removeFromSuperview];
    [self.backDeskVC.view removeFromSuperview];
    [self.leftRightVC.view removeFromSuperview];
    [self.refineVC.view removeFromSuperview];
    [self.view addSubview:self.lightVC.view];
    self.lightButton.selected = YES;
    self.movieButton.selected = NO;
    self.electricButton.selected = NO;
     self.leftRightDeskButton.selected  = NO;
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
- (void)backPage
{
    [self.backDeskVC.view removeFromSuperview];
    [self.view addSubview:self.leftRightVC.view];
    self.m_bleftRightVC = true;
}
- (void)nextPage
{
    [self.leftRightVC.view removeFromSuperview];
    [self.view addSubview:self.backDeskVC.view];
    self.m_bleftRightVC = false;
}
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
        if ([port isEqualToString:@"0113"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.topLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.topLightButton.selected = YES;
            }
        }
        
               
        if ([port isEqualToString:@"0117"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.sidewallLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.sidewallLightButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0116"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.barLightButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.barLightButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"010D"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.readLightLButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.readLightLButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"010E"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.readLightRButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.readLightRButton.selected = YES;
            }
        
        }
        if ([port isEqualToString:@"0114"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.starButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.starButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0115"]) {
            if ([state isEqualToString:@"02"]) {
                self.lightVC.mxQCDButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.lightVC.mxQCDButton.selected = YES;
            }
            
        }
        /**
         *后排椅子
         */
        if ([port isEqualToString:@"0029"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.heatButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.heatButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"002A"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.tripsisButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.tripsisButton.selected = YES;
            }
            
        }
    
        if ([port isEqualToString:@"002A"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.leftMidFrontButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.leftMidFrontButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0005"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.leftMidBackButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.leftMidBackButton.selected = YES;
            }
            
        }
        
        
        if ([port isEqualToString:@"0013"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.rightMidFrontButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.rightMidFrontButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0014"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.rightMidBackButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.rightMidBackButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0022"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.beiLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.beiLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0024"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.yaoLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.yaoLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0026"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.tuiLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.tuiLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0021"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.beiRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.beiRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0023"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.yaoRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.yaoRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0025"]) {
            if ([state isEqualToString:@"02"]) {
                self.backDeskVC.tuiRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.backDeskVC.tuiRightDeskButton.selected = YES;
            }
            
        }










        /**
         *左右椅子
         */
        
        if ([port isEqualToString:@"0002"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.beiLeftLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.beiLeftLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0004"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.yaoLeftLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.yaoLeftLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0006"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.tuiLeftLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.tuiLeftLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0001"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.beiRightLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.beiRightLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0003"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.yaoRightLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.yaoRightLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0005"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.tuiRightLeftDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.tuiRightLeftDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0011"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.beiLeftRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.beiLeftRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0013"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.yaoLeftRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.yaoLeftRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0015"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.tuiLeftRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.tuiLeftRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0012"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.beiRightRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.beiRightRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0014"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.yaoRightRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.yaoRightRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0016"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.tuiRightRightDeskButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.tuiRightRightDeskButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0009"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.leftwarmButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.leftwarmButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"000B"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.leftmassageButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.leftmassageButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0019"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.rightwarmButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.rightwarmButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"001A"]) {
            if ([state isEqualToString:@"02"]) {
                self.leftRightVC.rightmassageButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.leftRightVC.rightmassageButton.selected = YES;
            }
            
        }











        
     
        


        /**
         *  窗帘
         */

        if ([port isEqualToString:@"0107"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.leftFrontOpenButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.leftFrontOpenButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0109"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.leftBackOpenButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.leftBackOpenButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"010B"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.rightBackOpenButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.rightBackOpenButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"0108"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.leftFrontCloseButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.leftFrontCloseButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"010A"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.leftBackCloseButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.leftBackCloseButton.selected = YES;
            }
            
        }

        if ([port isEqualToString:@"010C"]) {
            if ([state isEqualToString:@"02"]) {
                self.moviewVC.rightBackCloseButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.moviewVC.rightBackCloseButton.selected = YES;
            }
            
        }

        /**
         *  电器
         */
        if ([port isEqualToString:@"010F"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.movieButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.movieButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0110"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.airCleanButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.airCleanButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"01C4"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.deskOpenButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.deskOpenButton.selected = YES;
            }
            
        }
        
        if ([port isEqualToString:@"01C5"]) {
            if ([state isEqualToString:@"02"]) {
                self.refineVC.deskCloseButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.refineVC.deskCloseButton.selected = YES;
            }
            
        }

        /**
         *  触屏
         */
       if ([port isEqualToString:@"0101"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.tvUpButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.tvUpButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0102"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.tvDownButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.tvDownButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0111"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.glassPulverizationButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.glassPulverizationButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0103"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.glassUpButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.glassUpButton.selected = YES;
            }
            
        }
        if ([port isEqualToString:@"0104"]) {
            if ([state isEqualToString:@"02"]) {
                self.electricVC.glassDownButton.selected = NO;
            }
            else if([state isEqualToString:@"03"])
            {
                self.electricVC.glassDownButton.selected = YES;
            }
            
        }
        
        
    }

    
}



@end
