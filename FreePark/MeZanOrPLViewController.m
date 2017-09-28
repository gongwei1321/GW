//
//  MeZanOrPLViewController.m
//  FreePark
//
//  Created by 龚伟 on 16/4/24.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "MeZanOrPLViewController.h"
#import "ZZUserAddOrReview.h"
#import "UserRequests.h"
#import "FPUserReview.h"
#import "FPUserAdd.h"
#import "ParkDetailVC.h"
#import "MeZanOrPLTableViewCell.h"
@interface MeZanOrPLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *arrayData;

@end

@implementation MeZanOrPLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
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
    if(self.requestType == 0)
    {
        [self.LabelTitle setText:@"我的分享"] ;
    }else if(self.requestType == 2){
        [self.LabelTitle setText:@"我的评论"] ;
        
    }

    
    if (self.requestType == 0) {
        [UserRequests requestGetAllUserAdd:[DataManager getUserName] andBeiJingMin:[DataManager beijingUersAddCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingUersAddCount] intValue] + 1000]
                               andShangHaiMin:[DataManager shanghaiUersAddCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiUersAddCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouUersAddCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouUersAddCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenUersAddCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenUersAddCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *mutableArray) {
                                   if([ret isEqualToString:@"100020"])
                                   {
                                       NSArray *array = [mutableArray copy];
//                                       self.arrayData = [array sortedArrayUsingComparator:^NSComparisonResult(ZZUserAddOrReview *obj1, ZZUserAddOrReview *obj2) {
//                                           return ![obj1.posttime compare:obj2.posttime];
//                                       }];
                                       self.arrayData = [array sortedArrayUsingComparator:^NSComparisonResult(FPUserReview *obj1, FPUserReview *obj2) {
                                           return [obj1.posttime integerValue] < [obj2.posttime integerValue];
                                       }];
                                       [self.tableView reloadData];
                                   }
                                   if (self.arrayData.count == 0) {
                                       [SVProgressHUD showErrorWithStatus:@"未分享任何停车位信息"];
                                   }
                                   
                               }];

    }
    else if(self.requestType == 2){
        [UserRequests requestGetAllUserReview:[DataManager getUserName] andBeiJingMin:[DataManager beijingReviewCount]   andBeiJingMax: [NSString stringWithFormat:@"%d",[[DataManager beijingReviewCount] intValue] + 1000]
                               andShangHaiMin:[DataManager shanghaiReviewCount] andShangHaiMax: [NSString stringWithFormat:@"%d",[[DataManager shanghaiReviewCount] intValue] + 1000] andGuangZhouMin:[DataManager guangzhouReviewCount] andGuangZhouMax:[NSString stringWithFormat:@"%d",[[DataManager guangzhouReviewCount] intValue] + 1000] andShenZhenMin:[DataManager shenzhenReviewCount] andShenZhenMax: [NSString stringWithFormat:@"%d",[[DataManager shenzhenReviewCount] intValue] + 1000] complete:^(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *mutableArray) {
                                   if([ret isEqualToString:@"110020"])
                                   {
                                       NSArray *array = [mutableArray copy];
                                       self.arrayData = [array sortedArrayUsingComparator:^NSComparisonResult(FPUserReview *obj1, FPUserReview *obj2) {
                                           return [obj1.posttime integerValue] < [obj2.posttime integerValue];
                                       }];
                                       [self.tableView reloadData];
                                       
                                   }
                                   if (self.arrayData.count == 0) {
                                       [SVProgressHUD showErrorWithStatus:@"未点评任何停车位信息"];
                                   }
                               }];

    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
   }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"MeZanOrPLTableViewCell";
    MeZanOrPLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MeZanOrPLTableViewCell" owner:nil options:nil][0];
    }
    if(self.requestType == 0)
    {
        FPUserAdd *model = (FPUserAdd *)self.arrayData[indexPath.row];
        cell.parkNameLabel.text = [NSString stringWithFormat:@"%@",model.parkName];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",model.reviewTime];
        if ([model.isUpdate isEqualToString:@"1"]) {
            cell.rightImage.hidden = NO;
        }
        else
        {
            cell.rightImage.hidden = YES;
        }

    }
    else if(self.requestType == 2)
    {
        FPUserReview *model = (FPUserReview *)self.arrayData[indexPath.row];
        cell.parkNameLabel.text = [NSString stringWithFormat:@"%@",model.parkName];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",model.reviewTime];
        if ([model.isUpdate isEqualToString:@"1"]) {
            cell.rightImage.hidden = NO;
        }
        else
        {
            cell.rightImage.hidden = YES;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark -tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParkDetailVC *detailVC = [[ParkDetailVC alloc] initWithNibName:@"ParkDetailVC" bundle:nil];
    NSString *sid = @"";
    NSString *cityIndex = @"0";
    if(self.requestType == 0)
    {
        FPUserAdd *model = (FPUserAdd *)self.arrayData[indexPath.row];
        sid = model.sid;
        cityIndex = model.cityIndex;
        MeZanOrPLTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.rightImage.hidden = YES;
        [UserRequests requestPostAlreadyClickMyAddPark:sid andCityIndex:model.cityIndex complete:^(BOOL issuccess, NSString *ret) {
            
        }];
    }
    else if(self.requestType == 2)
    {
        FPUserReview *model = (FPUserReview *)self.arrayData[indexPath.row];
        sid = model.sid;
        cityIndex = model.cityIndex;
        MeZanOrPLTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.rightImage.hidden = YES;
        [UserRequests requestPostAlreadyClickMyCommentPark:sid andCityIndex:model.cityIndex andUserName:[DataManager getUserName]  complete:^(BOOL issuccess, NSString *ret) {
            
        }];
    }
    [UserRequests requestGetParkDetailById:sid andCityIndex:cityIndex complete:^(BOOL issuccess, NSString *name, NSString *description, NSString *stopPrice, NSString *priceTime, NSString *sid,NSString *lastModifyTime,NSString *creator,NSNumber *hasCollected) {
        if (issuccess) {
            ParkEntity *entity = [[ParkEntity alloc] init];
            entity.parkName = name;
            entity.parkDescription = description;
            if(![[stopPrice stringByReplacingOccurrencesOfString:@"元/小时" withString:@""] isEqualToString:@""])
            {
                entity.parkStopprice = stopPrice;
                if (![stopPrice containsString:@"/"]) {
                    entity.parkStopprice = [NSString stringWithFormat:@"%@元/小时",stopPrice];
                }
            }
            else{
                entity.parkStopprice = priceTime;
                if (![priceTime containsString:@"/"]) {
                    entity.parkStopprice = [NSString stringWithFormat:@"%@元/次",priceTime];
                }
            }
            entity.parPriceTime = priceTime;
            entity.parkId = sid;
            entity.cityIndex = cityIndex;
            entity.hasCollected = hasCollected;
            detailVC.parkEntity = entity;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"获取停车场详情失败!"];
        }
    }];
    
}


@end
