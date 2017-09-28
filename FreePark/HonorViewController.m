//
//  HonorViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/25.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "HonorViewController.h"
#import "HonorTableViewCell.h"
#import "UserRequests.h"
#import "FPHonor.h"
@interface HonorViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) NSArray *arrayHonor;//光荣榜信息
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HonorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.backView.layer.cornerRadius = 20.0f;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每添加一条合格的停车场信息(免费、低价、无需消费)将获赠本站送出的10元手机充值卡或现金。"]];
//    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(33, 11)];
//    self.tipLabel.attributedText = str;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD show];
    [UserRequests requestGetAnnouncementByLat:[NSString stringWithFormat:@"%.8f",[DataManager latitude]] andLng:[NSString stringWithFormat:@"%.8f",[DataManager longitude]] complete:^(BOOL issuccess, NSString *ret, NSArray *resultlist) {
        if(issuccess)
        {
            [SVProgressHUD dismiss];
            if ([ret isEqualToString:@"40010"]) {
                self.arrayHonor = resultlist;
                [self.tableView reloadData];
            }
            else{
              [SVProgressHUD showErrorWithStatus:@"服务器发生未知错误!"];
            }
        }
        else{
            [SVProgressHUD dismiss];
            NSArray *fphonorArray =  [FPHonor MR_findAll];
            NSMutableArray *contentArray = [NSMutableArray array];
            for (FPHonor *fphonor in fphonorArray)
            {
                [contentArray addObject:fphonor.content];
            }
            self.arrayHonor = [contentArray mutableCopy];
            if (self.arrayHonor.count == 0) {
                [SVProgressHUD showErrorWithStatus:@"获取光荣榜信息失败!"];
            }
            else{
                [self.tableView reloadData];

            }
            
        }
        
    }];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [SVProgressHUD dismiss];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayHonor.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"AnnouncementCell";
    HonorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
       cell = [[NSBundle mainBundle] loadNibNamed:@"HonorTableViewCell" owner:nil options:nil][0];
    }
    [cell setContentText:self.arrayHonor[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



@end
