//
//  MeViewController.m
//  FreePark
//
//  Created by 龚伟 on 16/4/24.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "MeZanOrPLViewController.h"
#import "TuCaoViewController.h"
#import "UserRequests.h"
#import "FPUserReview.h"
#import "FPUserAdd.h"
#import "ZZUserCollect.h"
#import "MyCollectViewController.h"
#import "AboutMeWebViewController.h"
#import "MyHireViewController.h"
#import "AddCSParkHireViewController.h"
#import "AddInterleavedViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) MeTableViewCell *fenxiangcell;
@property (strong,nonatomic) MeTableViewCell *dianpingcell;
@property (strong,nonatomic) MeTableViewCell *zancell;
@property (strong,nonatomic) MeTableViewCell *shoucangcell;
@property (strong,nonatomic) MeTableViewCell *hirecell;
@property (strong,nonatomic) UIAlertView *alterView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nickNameLabel.text = [DataManager getUserName];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled =NO;
}
//获取当前时间的时间戳
-(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    
    self.dianpingcell.rightIcon.hidden = YES;
    self.fenxiangcell.rightIcon.hidden = YES;
    self.shoucangcell.rightIcon.hidden = YES;
    self.dianpingcell.shuliangButton.hidden = YES;
    self.fenxiangcell.shuliangButton.hidden = YES;
    self.shoucangcell.shuliangButton.hidden = YES;
    self.hirecell.rightIcon.hidden = YES;
    self.hirecell.shuliangButton.hidden = YES;
    
    [UserRequests requestGetAllUserCollect:[DataManager getUserName] andLastUpdateTime:[self getCurrentTimestamp] complete:^(BOOL issuccess, NSString *ret, NSMutableArray *arrayData) {
        if(issuccess)
        {
             self.shoucangcell.shuliangButton.hidden = NO;
//            self.shoucangcell.
            for(int i = 0;i<arrayData.count;i++)
            {
                ZZUserCollect *collect  = arrayData[i];
                if([collect.isHaveNewComment intValue] != 0)
                {
                     self.shoucangcell.rightIcon.hidden = NO;
                     self.shoucangcell.shuliangButton.hidden = YES;
                }
                
            }
            
             [self.shoucangcell.shuliangButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)arrayData.count] forState:UIControlStateNormal];
            
        }
    }];

    
    [UserRequests requestGetAllUserReview:[DataManager getUserName] andBeiJingMin:[DataManager beijingReviewCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingReviewCount] intValue] + 1000]
                           andShangHaiMin:[DataManager shanghaiReviewCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiReviewCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouReviewCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouReviewCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenReviewCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenReviewCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *array) {
                               if([ret isEqualToString:@"110020"])
                               {
                                   //                                   if ([FPUserReview MR_findAll].count != 0) {
                                   if (isUpdate == FALSE)
                                   {
                                       self.dianpingcell.shuliangButton.hidden = NO;
                                       NSString *sum;
                                       if (array.count> 99)
                                       {
                                           sum = @"99+";
                                       }
                                       else{
                                           sum = [NSString stringWithFormat:@"%lu",(unsigned long)[FPUserReview MR_findAll].count];
                                       }
                                     [self.dianpingcell.shuliangButton setTitle:sum forState:UIControlStateNormal];
                                   }
                                   else{
                                       self.dianpingcell.rightIcon.hidden = NO;
                                       self.dianpingcell.shuliangButton.hidden = YES;
                                   }
                                   
                                   //                                   }
                                   
                               }
                               
                           }];
    
    
    [UserRequests requestGetAllUserAdd:[DataManager getUserName] andBeiJingMin:[DataManager beijingUersAddCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingUersAddCount] intValue] + 1000]
                        andShangHaiMin:[DataManager shanghaiUersAddCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiUersAddCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouUersAddCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouUersAddCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenUersAddCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenUersAddCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *array) {
                            if([ret isEqualToString:@"100020"])
                            {
                                //                                if ([FPUserAdd MR_findAll].count != 0) {
                                //                                    self.fenxiangcell.shuliangButton.hidden = NO;
                                //                                    [self.fenxiangcell.shuliangButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)[FPUserAdd MR_findAll].count] forState:UIControlStateNormal];
                                //                                }
                                if (isUpdate == FALSE) {
                                    self.fenxiangcell.shuliangButton.hidden = NO;
                                    NSString *sum;
                                    if (array.count> 99)
                                    {
                                        sum = @"99+";
                                    }
                                    else{
                                        sum = [NSString stringWithFormat:@"%lu",(unsigned long)[FPUserAdd MR_findAll].count];
                                    }
                                    
                                    [self.fenxiangcell.shuliangButton setTitle:sum forState:UIControlStateNormal];
                                }
                                else{
                                    self.fenxiangcell.rightIcon.hidden = NO;
                                    self.fenxiangcell.shuliangButton.hidden = YES;
                                    
                                }
                            }
                            
                        }];
    
    [self.tableView reloadData];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"MeTableViewCell";
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MeTableViewCell" owner:nil options:nil][0];
    }
    if (indexPath.row == 0) {
        self.fenxiangcell = cell;
    }
    if(indexPath.row == 1)
    {
       cell.cellImageView.image = [UIImage imageNamed:@"我的收藏"];
       cell.titleLabel.text = @"我的收藏";
        self.shoucangcell= cell;
    }
    if (indexPath.row == 2) {
        cell.cellImageView.image = [UIImage imageNamed:@"我的点评"];
        cell.titleLabel.text = @"我点评的";
        self.dianpingcell = cell;
    }
    if (indexPath.row == 3) {
        cell.cellImageView.image = [UIImage imageNamed:@"我的出租"];
        cell.titleLabel.text = @"我的出租";
        self.hirecell = cell;
    }


      if (indexPath.row == 4) {
            cell.cellImageView.image = [UIImage imageNamed:@"点个赞"];
            cell.titleLabel.text = @"点个赞吧";
          self.zancell = cell;
          if ([DataManager enterAppTimes]>4 && ![DataManager getEnterAppStore]) {
                    self.zancell.rightIcon.hidden = NO;
          }

        }
    if (indexPath.row == 5) {
        cell.cellImageView.image = [UIImage imageNamed:@"吐个槽"];
        cell.titleLabel.text = @"吐个槽吧";
    }
    if (indexPath.row == 6) {
        cell.cellImageView.image = [UIImage imageNamed:@"关于我们"];
        cell.titleLabel.text = @"关于我们";
    }
    if (indexPath.row == 7) {
        cell.cellImageView.image = [UIImage imageNamed:@"认证图标"];
        cell.titleLabel.text = @"退出登录";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0 || indexPath.row == 2)//我点赞  我评论
    {
        MeZanOrPLViewController *zanOrPLVC = [[MeZanOrPLViewController alloc] initWithNibName:@"MeZanOrPLViewController" bundle:nil];
        zanOrPLVC.requestType = (int)indexPath.row;
        [self.navigationController pushViewController:zanOrPLVC animated:YES];
    }
    else if(indexPath.row == 3)//我的模块
    {
        MyHireViewController *myhireVC = [[MyHireViewController alloc] initWithNibName:@"MyHireViewController" bundle:nil];
        [self.navigationController pushViewController:myhireVC animated:YES];
        
        
//       AddInterleavedViewController *addCSVC = [[AddInterleavedViewController alloc] initWithNibName:@"AddInterleavedViewController" bundle:nil];
//        [self.navigationController pushViewController:addCSVC animated:YES];
        
        
//      AddCSParkHireViewController *addCSVC = [[AddCSParkHireViewController alloc] initWithNibName:@"AddCSParkHireViewController" bundle:nil];
//        
//       [self.navigationController pushViewController:addCSVC animated:YES];
    }
    else if(indexPath.row == 4)//点赞
    {
        [DataManager setEnterAppStore:YES];
       
        self.zancell.rightIcon.hidden = YES;
       
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/mo/app/0yuan-ting-che/id1078076468?mt=8"]];
    }
    else if(indexPath.row == 1)//我收藏的
    {
        MyCollectViewController *myCollectVC = [[MyCollectViewController alloc] initWithNibName:@"MyCollectViewController" bundle:nil];
        [self.navigationController pushViewController:myCollectVC animated:YES];
    }

    else if(indexPath.row == 5)//吐槽
    {
        TuCaoViewController *tuCaoVC = [[TuCaoViewController alloc] initWithNibName:@"TuCaoViewController" bundle:nil];
        [self.navigationController pushViewController:tuCaoVC animated:YES];
    }
    else if(indexPath.row == 6)//关于我们
    {
        AboutMeWebViewController *aboutmeVC = [[AboutMeWebViewController alloc] init];
        [self.navigationController pushViewController:aboutmeVC animated:YES];
    }
    else if(indexPath.row == 7)//退出登录
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        self.alterView = alert;
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex==1)
    {
        [DataManager setUserName:@""];
        LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:vc];

       AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
       appDelegate.window.rootViewController = nav;
 
    }
}
- (IBAction)actionClose:(UIButton *)sender
{
    self.close();
}

@end
