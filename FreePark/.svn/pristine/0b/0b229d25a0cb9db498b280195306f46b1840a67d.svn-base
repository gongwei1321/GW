//
//  ParkCommentVC.m
//  FreePark
//
//  Created by zhangwx on 15/12/14.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkCommentVC.h"
#import "ParkRequests.h"
#import "TagPickerView.h"
#import "DataManager.h"
#import "MBProgressHUD.h"
#import "NSObject+Commen.h"

@interface ParkCommentVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listView;

@property (strong, nonatomic) IBOutlet UITableViewCell *parkTitleCell;
@property (weak, nonatomic) IBOutlet UITextField *parkTitle;

@property (strong, nonatomic) IBOutlet UITableViewCell *commentCell;
@property (weak, nonatomic) IBOutlet UITextView *commentInput;

@property (strong, nonatomic) IBOutlet UITableViewCell *tagPickCell;
@property (weak, nonatomic) TagPickerView *tagPickerView;

@property (strong, nonatomic) IBOutlet UIView *commitView;
@property (weak, nonatomic) IBOutlet UIButton *commitB;

@end

@implementation ParkCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TagPickerView *pickView = [TagPickerView instanceFromNib];
    pickView.frame = CGRectMake(0, 0, 320, 145);
    pickView.backgroundColor = [UIColor clearColor];
    [pickView.changeTags addTarget:self action:@selector(refreshTags) forControlEvents:UIControlEventTouchUpInside];
    [self.tagPickCell.contentView addSubview:pickView];
    self.tagPickerView = pickView;
    
    self.parkTitle.text = self.parkEntity.parkName;
    
    self.listView.tableFooterView = self.commitView;
    self.commitB.layer.cornerRadius = 15;
    
    [self refreshTags];
    [self.tagPickerView.pickedTags removeAllObjects];
}

- (void)refreshTags
{
    [ParkRequests requestParkCommentLabel:self.parkEntity.parkName complete:^(BOOL issuccess, NSArray *parkTags) {
        if (issuccess) {
            NSMutableArray *retArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in parkTags) {
                ParkTag *parkTag = [[ParkTag alloc] init];
                parkTag.tagName = dic[@"labelContent"];
                parkTag.index = [dic[@"labelIndex"] integerValue];
                [retArr addObject:parkTag];
            }
            self.tagPickerView.readyPickTags = retArr;
        }
    }];
}

- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionCommit:(id)sender
{
    [self.commentInput resignFirstResponder];
    
    if (self.commentInput.text.length == 0 && self.tagPickerView.pickedTags.count == 0) {
        [Utils showToastWithMessage:@"评论和标签不能同时为空！"];
    }
    
    MBProgressHUD *hud = [self.navigationController.view showLoading:@"正在提交"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"id"] = self.parkEntity.parkId;
    param[@"userName"] = [DataManager getUserName];
    param[@"parkName"] = self.parkEntity.parkName;
    param[@"description"] = self.commentInput.text;
    
    for (int i = 0; i < (self.tagPickerView.pickedTags.count < 4 ? self.tagPickerView.pickedTags.count : 4); i++) {
        param[[NSString stringWithFormat:@"parkLabel%i", (i+1)]] = @(((ParkTag *)self.tagPickerView.pickedTags[i]).index);
    }
    
    [ParkRequests sendParkComment:param complete:^(BOOL issuccess, NSString *parkAddr) {
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.parkTitleCell;
    }else if (indexPath.row == 1) {
        return self.commentCell;
    }else if (indexPath.row == 2) {
        return self.tagPickCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }else if (indexPath.row == 1) {
        return 90;
    }else if (indexPath.row == 2) {
        return 147;
    }
    return 0;
}

@end
