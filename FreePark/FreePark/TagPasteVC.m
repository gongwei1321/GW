//
//  TagPasteVC.m
//  FreePark
//
//  Created by zhangwx on 16/4/6.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "TagPasteVC.h"
#import "ParkRequests.h"
#import "TagPickerView.h"
#import "DataManager.h"
#import "MBProgressHUD.h"
#import "NSObject+Commen.h"

@interface TagPasteVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *listView;

@property (strong, nonatomic) IBOutlet UITableViewCell *tagPickCell;
@property (weak, nonatomic) TagPickerView *tagPickerView;

@property (strong, nonatomic) IBOutlet UIView *commitView;
@property (weak, nonatomic) IBOutlet UIButton *commitB;

@end

@implementation TagPasteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TagPickerView *pickView = [TagPickerView instanceFromNib];
    pickView.frame = CGRectMake(0, 0, 320, 145);
    pickView.backgroundColor = [UIColor clearColor];
    [pickView.changeTags addTarget:self action:@selector(refreshTags) forControlEvents:UIControlEventTouchUpInside];
    [self.tagPickCell.contentView addSubview:pickView];
    self.tagPickerView = pickView;
    
//    self.listView.tableFooterView = self.commitView;
//    self.commitB.layer.cornerRadius = 15;
    
    [self refreshTags];
    [self.tagPickerView.pickedTags removeAllObjects];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshTags
{
    [self.tagPickerView.pickedTags removeAllObjects];
    [ParkRequests requestParkCommentLabel: [DataManager cityIndex] andID:self.parkEntity.parkId  complete:^(BOOL issuccess, NSArray *parkTags) {
        if (issuccess) {
            NSMutableArray *retArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in parkTags) {
                ParkTag *parkTag = [[ParkTag alloc] init];
                parkTag.tagName = dic[@"labelContent"];
                parkTag.index = [dic[@"labelIndex"] integerValue];
                [retArr addObject:parkTag];
            }
            self.tagPickerView.readyPickTags = retArr;
            [self.tagPickerView.readySelectList reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.listView reloadData];
            });
        }
    }];
}

- (IBAction)actionCommit:(id)sender
{
    if (self.tagPickerView.pickedTags.count == 0) {
        [Utils showToastWithMessage:@"标签不能为空！"];
        return;
    }
    
    MBProgressHUD *hud = [self.navigationController.view showLoading:@"正在提交"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"id"] = self.parkEntity.parkId;
    param[@"userName"] = [DataManager getUserName];
    param[@"parkName"] = self.parkEntity.parkName;
    param[@"cityIndex"] = [DataManager cityIndex];
    for (int i = 0; i < (self.tagPickerView.pickedTags.count < 4 ? self.tagPickerView.pickedTags.count : 4); i++) {
        param[[NSString stringWithFormat:@"parkLabel%i", (i+1)]] = @(((ParkTag *)self.tagPickerView.pickedTags[i]).index);
    }
    
    [ParkRequests sendParkCommentLabel:param complete:^(BOOL issuccess, NSString *parkAddr) {
        [self.navigationController.view stopLoading:hud];
        if (issuccess) {
            [Utils showToastWithMessage:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Utils showToastWithMessage:@"提交失败"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tagPickCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tagPickerView.readySelectList.contentSize.height + 38;
}

@end
