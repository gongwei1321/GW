//
//  MyCollectViewController.m
//  FreePark
//
//  Created by 龚伟 on 2017/3/6.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MyCollectTableViewCell.h"
#import "UserRequests.h"
#import "ZZUserCollect.h"
#import "MJRefresh.h"
#import "ParkRequests.h"
#import "MBProgressHUD.h"
#import "ParkDetailVC.h"
#import "UserRequests.h"
#import "ZZPublicity.h"
@interface MyCollectViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MyCollectTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic)UIAlertView *alterView;
@property (nonatomic,strong) NSMutableArray *userCollectArray;//收藏数组
@property (nonatomic,strong) NSArray *userCollectArrayNow;//收藏数组
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation MyCollectViewController
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
//获取当前时间的时间戳
-(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.userCollectArray = [NSMutableArray array];
    
    
    [self loadUserCollect];
    self.tableview.header = [MJRefreshHeader headerWithRefreshingBlock:^(){
        [self loadUserCollect];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadUserCollect];
}
- (void)loadUserCollect
{
    [SVProgressHUD show];
    [UserRequests requestGetAllUserCollect:[DataManager getUserName] andLastUpdateTime:[self getCurrentTimestamp] complete:^(BOOL issuccess, NSString *ret, NSMutableArray *arrayData) {
        if(issuccess)
        {
            [SVProgressHUD dismiss];
            [self.userCollectArray removeAllObjects];
            for (int i = 0; i<arrayData.count ; i++) {
                [self.userCollectArray addObject:arrayData[i]];
            }
//            ZZUserCollect * object = [ZZUserCollect alloc]
//            [self.userCollectArray addObject:<#(nonnull id)#>]
            self.userCollectArrayNow = [self.userCollectArray sortedArrayUsingComparator:^NSComparisonResult(ZZUserCollect * obj1, ZZUserCollect * obj2) {
                
              
                
               if([obj1.collectAddTime doubleValue] < [obj2.collectAddTime doubleValue])
               {
                   return true;
               }
               else{
                   return false;
               }
//                return result == NSOrderedDescending; // 升序
                //        return result == NSOrderedAscending;  // 降序
            }];
            [self.userCollectArray removeAllObjects];
            for(int i = 0;i<self.userCollectArrayNow.count;i++)
            {
                ZZUserCollect *collect = self.userCollectArrayNow[i];
                collect.collectAddTime = [self timeWithTimeIntervalString:collect.collectAddTime];
                [self.userCollectArray addObject:collect];
            }
            [self.tableview reloadData];
            [self.tableview.header endRefreshing];
        }
        else{
            [self.tableview.header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"获取收藏信息失败!"];
        }
    }];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userCollectArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"MyCollectTableViewCell";
    MyCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyCollectTableViewCell" owner:nil options:nil][0];
    }
    cell.tag  = indexPath.row;
    ZZUserCollect *model = (ZZUserCollect *)self.userCollectArray[indexPath.row];
    cell.labelAddress.text = model.parkName;
    cell.delegate = self;
    cell.addTimeLabel.text = model.collectAddTime;
    if([model.isHaveNewComment intValue]==0)
    {
        cell.rightIcon.hidden = YES;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 52;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否取消本条收藏？" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"确定", nil];
        self.indexPath = indexPath;
        self.alterView = alert;
        [alert show];
        
        
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex==1)
    {
        ZZUserCollect *model = (ZZUserCollect *)self.userCollectArray[self.indexPath.row];
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        param[@"id"] = model.collectParkId;
        param[@"userName"] = [DataManager getUserName];
        param[@"parkName"] = model.parkName;
        if([model.address isEqualToString:@"北京"])
        {
            param[@"cityIndex"] = @"0";
            
        }
        else if([model.address isEqualToString:@"上海"])
        {
            param[@"cityIndex"] = @"1";
            
        }
        else if([model.address isEqualToString:@"广州"])
        {
            param[@"cityIndex"] = @"2";
            
        }
        else if([model.address isEqualToString:@"深圳"])
        {
            param[@"cityIndex"] = @"3";
            
        }
        
        
        [ParkRequests sendParkUnCollect:param complete:^(BOOL issuccess, NSString *parkAddr) {
            if (issuccess) {
                [self.userCollectArray removeObjectAtIndex:self.indexPath.row];
                // Delete the row from the data source.
                [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPath] withRowAnimation:UITableViewRowAnimationRight];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"取消收藏信息失败!"];
            }
            
        }];
    }else{
        
        //
        
    }
}
- (void)choosePark:(NSInteger )index
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否取消本条收藏？" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"确定", nil];
    self.indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    self.alterView = alert;
    [alert show];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark -tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZZUserCollect *model = (ZZUserCollect *)self.userCollectArray[indexPath.row];
    NSString *cityindex ;
    
    ParkDetailVC *detailVC = [[ParkDetailVC alloc] initWithNibName:@"ParkDetailVC" bundle:nil];
    if([model.address isEqualToString:@"北京"])
    {
        cityindex = @"0";
        
    }
    else if([model.address isEqualToString:@"上海"])
    {
       cityindex = @"1";
        
    }
    else if([model.address isEqualToString:@"广州"])
    {
        cityindex = @"2";
        
    }
    else if([model.address isEqualToString:@"深圳"])
    {
        cityindex = @"3";
        
    }
    MyCollectTableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    cell.rightIcon.hidden = YES;
    [UserRequests requestSetCollectOpenStatus:model.collectParkId andUserName:[DataManager getUserName] andCityIndex:cityindex  complete:^(BOOL issuccess, NSString *ret) {
        
    }];
    
    
    [UserRequests requestGetParkDetailById:model.collectParkId andCityIndex:cityindex complete:^(BOOL issuccess, NSString *name, NSString *description, NSString *stopPrice, NSString *priceTime, NSString *sid,NSString *lastModifyTime,NSString *creator,NSNumber *hasCollected) {
        if (issuccess) {
            ParkEntity *entity = [[ParkEntity alloc] init];
            
            entity.parkName = name;
            entity.parkDescription = description;
            if(![stopPrice isEqualToString:@""])
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
            //            entity.parkStopprice = stopPrice;
            entity.parPriceTime = priceTime;
            entity.parkId = sid;
            entity.cityIndex = cityindex;
            entity.hasCollected = hasCollected;
            detailVC.parkEntity = entity;
            
            //            detailVC.backConstraint.constant = 1000;
            [self.navigationController pushViewController:detailVC animated:YES];
            
        }
    }];
}
     @end
