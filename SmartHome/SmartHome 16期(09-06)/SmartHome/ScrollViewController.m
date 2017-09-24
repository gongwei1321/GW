//
//  ScrollViewController.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/11.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "ScrollViewController.h"
#import "MainViewController.h"
#import "ElectricViewController.h"
#import "MovieViewController.h"
#import "DeskViewController.h"
@interface ScrollViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) MainViewController *lightVC;
@property (nonatomic,strong) MovieViewController *moviewVC;
@property (nonatomic,strong) ElectricViewController *electricVC;
//@property (nonatomic,strong) RightDeskViewController *rightDeskVC;
@property (nonatomic,strong) DeskViewController *deskVC;
@property (nonatomic,assign) NSInteger countSum;
@property (nonatomic,strong) NSMutableArray *mutableArrayVC;


@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,assign) NSInteger currentVCIndex;
@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    //加入ScrollView
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    scrollview.showsHorizontalScrollIndicator =  NO;
    scrollview.contentSize = CGSizeMake(screenWidth*3, 0);
    [scrollview setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    scrollview.delegate = self;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = NO;
    [self.view addSubview:scrollview];
    self.scrollview = scrollview;
    
    
    // 初始化 pagecontrol
    
//    self.pageControl = [[UIPageControl alloc] init];
//    self.pageControl.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 30);
//    self.pageControl.bounds = CGRectMake(0, 0, 100, 18);
////    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
//    [self.pageControl setPageIndicatorTintColor:[UIColor grayColor]];
//    self.pageControl.numberOfPages = 4;
//    
//    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
//    [self.view addSubview:self.pageControl];

    //初始化可变数组
    self.mutableArrayVC = [NSMutableArray array];
  
    //左座椅
//    LeftDeskViewController *leftDeskVC = [[LeftDeskViewController alloc] init];
//    leftDeskVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//    [self.scrollview addSubview:leftDeskVC.view];
//    [self addChildViewController:leftDeskVC];
//    self.leftDeskVC = leftDeskVC;
//    [self.mutableArrayVC addObject:self.leftDeskVC];
    
    //灯光
    MainViewController *lightVC = [[MainViewController alloc] init];
    lightVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.scrollview addSubview:lightVC.view];
    [self addChildViewController:lightVC];
    self.lightVC = lightVC;
    [self.mutableArrayVC addObject:self.lightVC];
    
    //影音
    MovieViewController *moviewVC = [[MovieViewController alloc] init];
    moviewVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.scrollview addSubview:moviewVC.view];
    [self addChildViewController:moviewVC];
    self.moviewVC = moviewVC;
    [self.mutableArrayVC addObject:self.moviewVC];
    
    
    //电动电器
    ElectricViewController *electricVC = [[ElectricViewController alloc] init];
    electricVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.scrollview addSubview:electricVC.view];
    [self addChildViewController:electricVC];
    self.electricVC = electricVC;
    [self.mutableArrayVC addObject:self.electricVC];
    
    //桌椅
    DeskViewController *deskVC = [[DeskViewController alloc] init];
    deskVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.scrollview addSubview:deskVC.view];
    [self addChildViewController:deskVC];
    self.deskVC = deskVC;
    [self.mutableArrayVC addObject:self.deskVC];
    
    
    [[SHSocket sharedSHSocket] sendSocketQueryDeviceState:@"FF"];
    [GWTool sharedGWTool].scrollVc = self;

//    self.scrollview.contentOffset = CGPointMake(self.offset*screenWidth, 0);
    
    self.pageControl.currentPage = self.offset;
    
    self.countSum = 0;
    
    
    //添加那几个对应的view
    self.leftView = [[UIView alloc] init];
    self.leftView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//    self.leftView.backgroundColor = [UIColor redColor];
    [self.scrollview addSubview:self.leftView];
    
    self.centerView = [[UIView alloc] init];
    self.centerView.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
//    self.centerView.backgroundColor = [UIColor greenColor];
    [self.scrollview addSubview:self.centerView];
    
    
    self.rightView = [[UIView alloc] init];
    self.rightView.frame = CGRectMake(2 * screenWidth, 0, screenWidth, screenHeight);
//    self.rightView.backgroundColor = [UIColor yellowColor];
    [self.scrollview addSubview:self.rightView];

//    UIViewController *vc = self.mutableArrayVC[self.offset];
//    [self.centerView addSubview:vc.view];
    
    self.currentVCIndex = self.offset;
    [self scrollViewDidEndDecelerating:self.scrollview];
    
       
    
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
- (void)manageSocketMsg:(NSString *)msg
{
//    //03 01 14 01 00 0F 00 00
//    self.countSum ++;
//    NSLog(@"%ld",(long)self.countSum);
//    msg = msg.uppercaseString;
//    
//    NSLog(msg);
//   if(![msg hasPrefix:@"02"] && ![msg hasPrefix:@"03"])
//   {
////       NSLog(@"5AA5058200");
//       return;
//   }
//  
//
//    
//        //02是关  03是开
//        NSRange rang;
//        rang.location = 2;
//        rang.length = 4;
//        NSString *port = [msg substringWithRange:rang];
//        rang.location = 10;
//        rang.length = 2;
//        NSString *enable = [msg substringWithRange:rang];
//        rang.location = 0;
//        rang.length = 2;
//        NSString *state = [msg substringWithRange:rang];
//        if ([enable isEqualToString:@"0F"]) {
//            
//            /**
//             *  灯光页
//             */
//
//            if ([port isEqualToString:@"0113"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.lightVC.barButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.lightVC.barButton.selected = YES;
//                }
//            }
//            
//           
//            
//            if ([port isEqualToString:@"0115"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.lightVC.crestingButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.lightVC.crestingButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"0116"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.lightVC.sideWallButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.lightVC.sideWallButton.selected = YES;
//                }
//                
//            }
//            /**
//             *  影音
//             */
//            if ([port isEqualToString:@"0190"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.tvPowerButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.tvPowerButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"0191"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.tvFullButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.tvFullButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"0197"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.tvOkButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.tvOkButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01B8"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.satelliteCHAddButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.satelliteCHAddButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01B9"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.satelliteCHReduceButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.satelliteCHReduceButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"010D"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.satellitePowerButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.satellitePowerButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01B6"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.satelliteSoundAddButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.satelliteSoundAddButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01B7"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.satelliteSoundReduceButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.satelliteSoundReduceButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01C0"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.bosePowerButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.bosePowerButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01C3"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.boseSoundAddButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.boseSoundAddButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01C1"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.boseSoundReduceButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.boseSoundReduceButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01C2"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.boseSoundZeroButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.boseSoundZeroButton.selected = YES;
//                }
//                
//            }
//
//            
//            if ([port isEqualToString:@"01C5"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.boseCBLButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.boseCBLButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"01CB"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.boseSoundBlueToothButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.boseSoundBlueToothButton.selected = YES;
//                }
//                
//            }
//            
//            if ([port isEqualToString:@"010E"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.moviewVC.bose220VButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.moviewVC.bose220VButton.selected = YES;
//                }
//                
//            }
//            /**
//             *  净化
//             */
//            if ([port isEqualToString:@"01BA"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.deskVC.switchsButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.deskVC.switchsButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"01BB"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.deskVC.AirVolumeAddButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.deskVC.AirVolumeAddButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"01BC"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.deskVC.AirVolumeDecreaseButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.deskVC.AirVolumeDecreaseButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"01BD"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.deskVC.AutoButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.deskVC.AutoButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"01BE"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.deskVC.DisinfectionDown.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.deskVC.DisinfectionDown.selected = YES;
//                }
//                
//            }
//            /**
//             *  电动电器
//             */
//            if ([port isEqualToString:@"011F"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.electricVC.switchsButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.electricVC.switchsButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"0122"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.electricVC.AirVolumeAddButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.electricVC.AirVolumeAddButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"0123"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.electricVC.AirVolumeDecreaseButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.electricVC.AirVolumeDecreaseButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"0117"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.electricVC.airPurificationButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.electricVC.airPurificationButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"0101"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.electricVC.tvUpButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.electricVC.tvUpButton.selected = YES;
//                }
//                
//            }
//            if ([port isEqualToString:@"0102"]) {
//                if ([state isEqualToString:@"02"]) {
//                    self.electricVC.tvDownButton.selected = NO;
//                }
//                else if([state isEqualToString:@"03"])
//                {
//                    self.electricVC.tvDownButton.selected = YES;
//                }
//                
//            }
//
//        }
//
    


    
}

- (NSString *)getBrightness:(NSString *)brightness
{
    if ([brightness isEqualToString:@"01"]) {
        return @"10%";
    }
    else  if ([brightness isEqualToString:@"02"]) {
        return @"20%";
    }
    else  if ([brightness isEqualToString:@"03"]) {
        return @"30%";
    }
    else  if ([brightness isEqualToString:@"04"]) {
        return @"40%";
    }
    else  if ([brightness isEqualToString:@"05"]) {
        return @"50%";
    }
    else  if ([brightness isEqualToString:@"06"]) {
        return @"60%";
    }
    else  if ([brightness isEqualToString:@"07"]) {
        return @"70%";
    }
    else  if ([brightness isEqualToString:@"08"]) {
        return @"80%";
    }
    else  if ([brightness isEqualToString:@"09"]) {
        return @"90%";
    }
    else  if ([brightness isEqualToString:@"0A"]) {
        return @"100%";
    }
    return @"";
}

- (void)viewWillAppear:(BOOL)animated
{
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketOFF) name:SOCKET_OFF object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketON) name:SOCKET_ON object:nil];

}
- (void)viewWillDisappear:(BOOL)animated
{
    //清除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc
{
    //清除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)reloadViewControllView
{
    CGFloat screenWidth;
    screenWidth = self.view.frame.size.width;
    NSUInteger leftImageIndex,rightImageIndex;
    CGPoint offsetTmp = [self.scrollview contentOffset];
    if(offsetTmp.x == 2*screenWidth)
    {
        self.currentVCIndex   = (self.currentVCIndex  + 1)%4;
        self.pageControl.currentPage = (self.pageControl.currentPage +1)%4;
    }else if(offsetTmp.x == 0)
    {
        self.currentVCIndex  = (self.currentVCIndex  - 1)%5;
        if(self.currentVCIndex == -1)
        {
            self.currentVCIndex = 3;
        }
        self.pageControl.currentPage = (self.pageControl.currentPage -1)%4;
    }
    
    leftImageIndex = (self.currentVCIndex - 1)%4;
    rightImageIndex = (self.currentVCIndex + 1)%4;
    if(leftImageIndex == -1)
    {
        leftImageIndex =3;
    }
//    NSLog(@"%d",leftImageIndex);
//    NSLog(@"%d",rightImageIndex);
    UIViewController *leftvc = self.mutableArrayVC[leftImageIndex];
    [self.leftView addSubview:leftvc.view];
    
    
    UIViewController *rightvc = self.mutableArrayVC[rightImageIndex];
    [self.rightView addSubview:rightvc.view];
    
    UIViewController *centervC = self.mutableArrayVC[self.currentVCIndex];
    [self.centerView addSubview:centervC.view];
    
    
}
#pragma mark scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    double page = scrollView.contentOffset.x/scrollView.bounds.size.width;
//    self.pageControl.currentPage = page;
    [self reloadViewControllView];
    
    CGFloat screenWidth;
    screenWidth = self.view.frame.size.width;
    [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    
    self.pageControl.currentPage = self.currentVCIndex;
}

#pragma mark pageChange代理
- (void)pageChanged:(UIPageControl *)pageControl
{
    CGFloat x = (pageControl.currentPage)*self.scrollview.bounds.size.width;
    
    [self.scrollview setContentOffset:CGPointMake(x,0) animated:NO];
}

@end
