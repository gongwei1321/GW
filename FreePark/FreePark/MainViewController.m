//
//  MainViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "MainViewController.h"
#import "FindMeViewController.h"
#import "FindParkVC.h"
#import "HonorViewController.h"
#import "PublicityViewController.h"
#import "AboutMeWebViewController.h"
#import "MainBottomView.h"
#import "ShareViewController.h"
#import "HonorViewController.h"
#import "LoginViewController.h"
#import "PublicityViewController.h"
#import "MeViewController.h"
#import "UserRequests.h"
#import "FPUserAdd.h"
#import "FPUserReview.h"

@interface MainViewController () <MainBottomViewDelegate>
@property (nonatomic,strong) UIButton *carButton;
@property (nonatomic,strong) UIButton *parkButton;
@property (nonatomic,assign) BOOL isUpdate1;
@property (nonatomic,assign) BOOL isUpdate2;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZZColor(88, 195, 218);
    
    
    
    CGFloat screenW = self.view.frame.size.width;
    CGFloat screenH = self.view.frame.size.height;
    
    
    MainBottomView *mainBottomView = [[MainBottomView alloc] init];
    mainBottomView.frame = CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 80);
    mainBottomView.delegate = self;
    [self.view addSubview:mainBottomView];
    
    //0元停车
    UIImageView *parkcarImageView = [[UIImageView alloc] init];
    parkcarImageView.contentMode = UIViewContentModeCenter;
    parkcarImageView.image = [UIImage imageNamed:@"parkcar"];
    parkcarImageView.frame = CGRectMake(0, screenH * 0.05, screenW, screenH * 0.06);
    [self.view addSubview:parkcarImageView];
    
    //停车按钮
    self.carButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.carButton setImage:[UIImage imageNamed:@"carbutton"] forState:UIControlStateNormal];
    [self.carButton setImage:[UIImage imageNamed:@"carbutton_selected"] forState:UIControlStateHighlighted];
    self.carButton.imageView.contentMode = UIViewContentModeCenter;
    self.carButton.frame = CGRectMake(0, screenH * 0.12, screenW, screenH * 0.25);
    [self.carButton addTarget:self action:@selector(clickCarButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.carButton];
    
    //查找停车场
    UIImageView *findParkImageView = [[UIImageView alloc] init];
    findParkImageView.contentMode = UIViewContentModeCenter;
    findParkImageView.image = [UIImage imageNamed:@"chazhaotingche"];
    findParkImageView.frame = CGRectMake(0, screenH * 0.32, screenW, screenH * 0.1);
    [self.view addSubview:findParkImageView];
    
    //Park按钮
    self.parkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.parkButton setImage:[UIImage imageNamed:@"park"] forState:UIControlStateNormal];
    [self.parkButton setImage:[UIImage imageNamed:@"park_selected"] forState:UIControlStateHighlighted];
    self.parkButton.imageView.contentMode = UIViewContentModeCenter;
    self.parkButton.frame = CGRectMake(0, screenH * 0.40, screenW, screenH * 0.4);
    [self.parkButton addTarget:self action:@selector(clickParkButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.parkButton];

    //分享停车
    UIImageView *shareParkImageView = [[UIImageView alloc] init];
    shareParkImageView.contentMode = UIViewContentModeCenter;
    shareParkImageView.image = [UIImage imageNamed:@"fenxiangtingche"];
    shareParkImageView.frame = CGRectMake(0, screenH * 0.75, screenW, screenH * 0.1);
    [self.view addSubview:shareParkImageView];
    
    
    
    
    
    //检查是否有新版
    [UserRequests requestCheckUpdateDiscoveryByVersion:@"1.0" complete:^(BOOL issuccess, NSString *ret) {
        if (issuccess) {
            if ([ret isEqualToString:@"10010"]) {
                if ([[DataManager getNotNoticeVersion] isEqualToString: @""] || [DataManager getNotNoticeVersion] == nil) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"检测到有新版本,是否需要更新?" preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }]];
                    [alert addAction:[UIAlertAction actionWithTitle:@"不再提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [DataManager setNotNotice:@"1.0"];
                        
                    }]];
                    
                    [self presentViewController:alert animated:YES completion:^{
                        
                    }];

                }
            }
        }
    }];
    
        
}
- (void)clickParkButton
{
    if([DataManager getUserName].length != 0)
    {
        ShareViewController *shareVC = [[ShareViewController alloc] init];
        [self.navigationController pushViewController:shareVC animated:YES];
    }
    else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([ZZTool sharedZZTool].findButton != nil) {
//        //检查发现页面是否更新
//        if (([[DataManager modifyLastTime] isEqualToString:@""] || ([DataManager modifyLastTime] == nil))) {
//            [ZZTool sharedZZTool].findButton.rightIcon2.hidden = NO;
//        }
//        else{
//            
//            [UserRequests requestCheckUpdateDiscovery:[DataManager modifyLastTime] complete:^(BOOL issuccess, NSString *ret) {
//                if (issuccess) {
//                    if ([ret isEqualToString:@"10010"]) {
//                         [ZZTool sharedZZTool].findButton.rightIcon2.hidden = NO;
//                    }
//                    else{
//                        [ZZTool sharedZZTool].findButton.rightIcon2.hidden = YES;
//                    }
//                }
//            }];
//        }
//    }
    
    [DataManager setBeijingReviewCount:@"0"];
    [DataManager setShanghaiReviewCount:@"0"];
    [DataManager setGuangzhouReviewCount:@"0"];
    [DataManager setShenzhenReviewCount:@"0"];
    
    [DataManager setBeijingUersAddCount:@"0"];
    [DataManager setShanghaiUersAddCount:@"0"];
    [DataManager setGuangzhouUersAddCount:@"0"];
    [DataManager setShenzhenUersAddCount:@"0"];
    
    [FPUserAdd MR_truncateAll];
    [FPUserReview MR_truncateAll];

     [ZZTool sharedZZTool].findButton.rightIcon2.hidden = YES;
    
    
    if ([DataManager getUserName].length!=0) {
        [UserRequests requestGetAllUserReview:[DataManager getUserName] andBeiJingMin:[DataManager beijingReviewCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingReviewCount] intValue] + 1000]
                               andShangHaiMin:[DataManager shanghaiReviewCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiReviewCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouReviewCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouReviewCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenReviewCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenReviewCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *array) {
                                   if([ret isEqualToString:@"110020"])
                                   {
                                       self.isUpdate2 = isUpdate;
                                       //                                   if ([FPUserReview MR_findAll].count != 0) {
                                       if (self.isUpdate1 != FALSE || self.isUpdate2 != FALSE || ([DataManager enterAppTimes]>4 && ![DataManager getEnterAppStore]))
                                       {
                                           [ZZTool sharedZZTool].findButton.rightIcon2.hidden = NO;
                                       }
                                       
                                   }
                                   
                               }];
        
        
        [UserRequests requestGetAllUserAdd:[DataManager getUserName] andBeiJingMin:[DataManager beijingUersAddCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingUersAddCount] intValue] + 1000]
                            andShangHaiMin:[DataManager shanghaiUersAddCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiUersAddCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouUersAddCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouUersAddCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenUersAddCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenUersAddCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *array) {
                                if([ret isEqualToString:@"100020"])
                                {
                                    self.isUpdate1 = isUpdate;
                                    //                                   if ([FPUserReview MR_findAll].count != 0) {
                                    if (self.isUpdate1 != FALSE || self.isUpdate2 != FALSE || ([DataManager enterAppTimes]>4 && ![DataManager getEnterAppStore]))
                                    {
                                        [ZZTool sharedZZTool].findButton.rightIcon2.hidden = NO;
                                    }
                                }
                                
                            }];
    }
   

    
   
//    [UserRequests requestGetAllUserReview:[DataManager getUserName] andBeiJingMin:[DataManager beijingReviewCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingReviewCount] intValue] + 1000]
//                           andShangHaiMin:[DataManager shanghaiReviewCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiReviewCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouReviewCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouReviewCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenReviewCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenReviewCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *array) {
//                               if([ret isEqualToString:@"110020"])
//                               {
//                                   self.isUpdate1 = isUpdate;
//                                   //                                   if ([FPUserReview MR_findAll].count != 0) {
//                                   if (self.isUpdate1 != FALSE || self.isUpdate2 != FALSE)
//                                   {
//                                        [ZZTool sharedZZTool].findButton.rightIcon2.hidden = YES;
//                                   }
//                                  
//                               }
//                               
//                           }];
//    
//    
//    [UserRequests requestGetAllUserAdd:[DataManager getUserName] andBeiJingMin:[DataManager beijingUersAddCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingUersAddCount] intValue] + 1000]
//                        andShangHaiMin:[DataManager shanghaiUersAddCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiUersAddCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouUersAddCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouUersAddCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenUersAddCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenUersAddCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *array) {
//                            if([ret isEqualToString:@"100020"])
//                            {
//                                self.isUpdate2 = isUpdate;
//                                if (self.isUpdate1 != FALSE || self.isUpdate2 != FALSE) {
//                                    [ZZTool sharedZZTool].findButton.rightIcon2.hidden = YES;
//                                }
//                            }
//                            
//                        }];
//    
   
}

- (void)clickCarButton
{
    if([DataManager getUserName].length != 0)
    {
        FindParkVC *findParkVC = [[FindParkVC alloc] initWithNibName:@"FindParkVC" bundle:nil];
        [self.navigationController pushViewController:findParkVC animated:YES];
    }
    else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
#pragma mark mainBottomView代理
- (void)mainBottomViewClickedButton:(NSInteger)buttonType
{
    switch (buttonType) {
        case 0://光荣榜
        {
            HonorViewController *honorVC = [[HonorViewController alloc] init];
            [self.navigationController pushViewController:honorVC animated:YES];
        }
            break;
        case 1://公示
        {
            PublicityViewController *publicityVC = [[PublicityViewController alloc] init];
            
            [ZZTool sharedZZTool].publicityButton.rightIcon.hidden = YES;
            [ZZTool sharedZZTool].publicityButton.numberLabel.hidden = YES;
            [ZZTool sharedZZTool].publicityButton.numberLabel.text = @"0";
            [DataManager setRemoteNoticeNumber:0];
            
            [self.navigationController pushViewController:publicityVC animated:YES];
        }
            break;
        case 2://我的
        {
            if([DataManager getUserName].length != 0)
            {
                MeViewController *meVC = [[MeViewController alloc] init];
                [self.navigationController pushViewController:meVC animated:YES];
            }
            else{
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
           
        }
            break;
        case 3://关于我们
        {
            AboutMeWebViewController *aboutmeVC = [[AboutMeWebViewController alloc] init];
            [self.navigationController pushViewController:aboutmeVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
