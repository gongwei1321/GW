//
//  MyHireViewController.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/19.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "MyHireViewController.h"
#import "MyHireTableViewCell.h"
#import "ParkHireRequest.h"
#import "MJRefresh.h"
#import "ZZParkHire.h"
#import "AddInterleavedViewController.h"
#import "AddCSParkHireViewController.h"
#import "ParkHireDetailViewController.h"
@interface MyHireViewController ()<UITableViewDataSource,UITableViewDelegate,MyHireTableViewCellelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *hireArray;//租车位详情
@property (strong,nonatomic)UIAlertView *alterView;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic) BOOL isModify;
@end

@implementation MyHireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.hireArray = [NSMutableArray array];
    self.isModify = false;
    [self loadMoreHire];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^(){
        [self loadMoreHire];
    }];
    
}
- (void)loadMoreHire
{
    [SVProgressHUD show];
    [ParkHireRequest requestMyParkHireByName:[DataManager getUserName] complete:^(BOOL issuccess, NSString *ret, NSArray *resultlist) {
        if(issuccess)
        {
            [SVProgressHUD dismiss];
            if (resultlist.count < 20) {
                self.tableView.footer.hidden = YES;
            }
            [self.hireArray removeAllObjects];
            for (int i = 0; i<resultlist.count ; i++) {
                [self.hireArray addObject:resultlist[i]];
            }
            [self.tableView reloadData];
            
            
            [self.tableView.footer endRefreshing];
            
        }
        else{
            [self.tableView.footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"获取租车信息失败!"];
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    if(self.isModify)
    {
        [self loadMoreHire];
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hireArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"MyHireTableViewCell";
    MyHireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyHireTableViewCell" owner:nil options:nil][0];
    }
    cell.tag  = indexPath.row;
    ZZParkHire *model = (ZZParkHire *)self.hireArray[indexPath.row];
    cell.placeLabe.text = model.parkHireName;
    if([model.status isEqualToString:@"0"])
    {
        cell.statusLabel.text = @"未审核";
        [cell.textLabel setTextColor:[UIColor yellowColor]];
    }
    else  if([model.status isEqualToString:@"1"])
    {
        cell.statusLabel.text = @"已审核";
        [cell.textLabel setTextColor:[UIColor greenColor]];
    }
    else  if([model.status isEqualToString:@"2"])
    {
        cell.statusLabel.text = @"审核未通过";
        [cell.textLabel setTextColor:[UIColor redColor]];
        
    }
    
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@/月",model.price];
    
    if([model.isEntireRent isEqualToString:@"0"])
    {
        cell.hireTypeLabel.text = @"错时";
    }
    else if([model.isEntireRent isEqualToString:@"1"])
    {
        cell.hireTypeLabel.text = @"整租";
        
    }
    
    cell.beizhuLabel.text = model.parkHireRemarks;
    
    cell.delegate = self;
    
    
    //    cell.labelAddress.text = model.parkName;
    //    cell.delegate = self;
    //    cell.addTimeLabel.text = model.collectAddTime;
    //    if([model.isHaveNewComment intValue]==0)
    //    {
    //        cell.rightIcon.hidden = YES;
    //    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 300;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [SVProgressHUD dismiss];
}
- (void)detailHire:(NSInteger)index
{
    ZZParkHire *model = (ZZParkHire *)self.hireArray[index];
    ParkHireDetailViewController *parkHireDetailVC = [[ParkHireDetailViewController alloc] initWithNibName:@"ParkHireDetailViewController" bundle:nil];
    parkHireDetailVC.zzParkHire = model;
    self.isModify = true;
    [self.navigationController pushViewController:parkHireDetailVC animated:YES];
}
- (void)modifiyHire:(NSInteger)index
{
   ZZParkHire *model = (ZZParkHire *)self.hireArray[index];
   if([model.isEntireRent isEqualToString:@"0"])
   {
       AddCSParkHireViewController *addCSVC = [[AddCSParkHireViewController alloc] initWithNibName:@"AddCSParkHireViewController" bundle:nil];
       addCSVC.zzParkHire = model;
       [self.navigationController pushViewController:addCSVC animated:YES];
   }
    else if([model.isEntireRent isEqualToString:@"1"])
    {
        AddInterleavedViewController *addInterlVC = [[AddInterleavedViewController alloc] initWithNibName:@"AddInterleavedViewController" bundle:nil];
        addInterlVC.zzParkHire = model;
        [self.navigationController pushViewController:addInterlVC animated:YES];

    }
    self.isModify = true;

    
}
- (void)deleteHire:(NSInteger)index
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否删除本条出租信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    self.alterView = alert;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex==1)
    {
        ZZParkHire *model = (ZZParkHire *)self.hireArray[self.indexPath.row];
        NSString *cityIndex = 0;
        if([model.address isEqualToString:@"北京"])
        {
           cityIndex = @"0";
            
        }
        else if([model.address isEqualToString:@"上海"])
        {
           cityIndex = @"1";
            
        }
        else if([model.address isEqualToString:@"广州"])
        {
            cityIndex = @"2";
            
        }
        else if([model.address isEqualToString:@"深圳"])
        {
            cityIndex = @"3";
            
        }
        [ParkHireRequest requestDelParkHire:cityIndex andid:model.parkhireId complete:^(BOOL issuccess, NSString *ret) {
            if (issuccess) {
                [self.hireArray removeObjectAtIndex:self.indexPath.row];
                [SVProgressHUD showSuccessWithStatus:@"删除出租信息成功!"];
                [self.tableView reloadData];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"删除出租信息失败!"];
            }

        }];
        
       
    }
}
#pragma mark -tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    ZZUserCollect *model = (ZZUserCollect *)self.userCollectArray[indexPath.row];
    //    NSString *cityindex ;
    //
    //    ParkDetailVC *detailVC = [[ParkDetailVC alloc] initWithNibName:@"ParkDetailVC" bundle:nil];
    //    if([model.address isEqualToString:@"北京"])
    //    {
    //        cityindex = @"0";
    //
    //    }
    //    else if([model.address isEqualToString:@"上海"])
    //    {
    //        cityindex = @"1";
    //
    //    }
    //    else if([model.address isEqualToString:@"广州"])
    //    {
    //        cityindex = @"2";
    //
    //    }
    //    else if([model.address isEqualToString:@"深圳"])
    //    {
    //        cityindex = @"3";
    //
    //    }
    //    MyCollectTableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    //    cell.rightIcon.hidden = YES;
    //    [UserRequests requestSetCollectOpenStatus:model.collectParkId andUserName:[DataManager getUserName] andCityIndex:cityindex  complete:^(BOOL issuccess, NSString *ret) {
    //
    //    }];
    //
    //
    //    [UserRequests requestGetParkDetailById:model.collectParkId andCityIndex:cityindex complete:^(BOOL issuccess, NSString *name, NSString *description, NSString *stopPrice, NSString *priceTime, NSString *sid,NSString *lastModifyTime,NSString *creator,NSNumber *hasCollected) {
    //        if (issuccess) {
    //            ParkEntity *entity = [[ParkEntity alloc] init];
    //
    //            entity.parkName = name;
    //            entity.parkDescription = description;
    //            if(![stopPrice isEqualToString:@""])
    //            {
    //                entity.parkStopprice = stopPrice;
    //                if (![stopPrice containsString:@"/"]) {
    //                    entity.parkStopprice = [NSString stringWithFormat:@"%@元/小时",stopPrice];
    //                }
    //            }
    //            else{
    //                entity.parkStopprice = priceTime;
    //                if (![priceTime containsString:@"/"]) {
    //                    entity.parkStopprice = [NSString stringWithFormat:@"%@元/次",priceTime];
    //                }
    //            }
    //            //            entity.parkStopprice = stopPrice;
    //            entity.parPriceTime = priceTime;
    //            entity.parkId = sid;
    //            entity.cityIndex = cityindex;
    //            entity.hasCollected = hasCollected;
    //            detailVC.parkEntity = entity;
    //
    //            //            detailVC.backConstraint.constant = 1000;
    //            [self.navigationController pushViewController:detailVC animated:YES];
    //
    //        }
    //    }];
}

@end
