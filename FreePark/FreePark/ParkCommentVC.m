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

@interface ParkCommentVC () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listView;

@property (strong, nonatomic) IBOutlet UITableViewCell *parkTitleCell;
@property (weak, nonatomic) IBOutlet UITextField *parkTitle;

@property (strong, nonatomic) IBOutlet UITableViewCell *commentCell;
@property (weak, nonatomic) IBOutlet UITextView *commentInput;
@property (weak, nonatomic) IBOutlet UILabel *inputPlaceholder;

@property (strong, nonatomic) IBOutlet UIView *commitView;
@property (weak, nonatomic) IBOutlet UIButton *commitB;

@end

@implementation ParkCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.parkTitle.text = self.parkEntity.parkName;
    
//    self.listView.tableFooterView = self.commitView;
//    self.commitB.layer.cornerRadius = 15;
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

- (IBAction)actionCommit:(id)sender
{
    [self.commentInput resignFirstResponder];
    
    if (self.commentInput.text.length == 0) {
        [Utils showToastWithMessage:@"评论不能为空！"];
    }
    
    MBProgressHUD *hud = [self.navigationController.view showLoading:@"正在提交"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"id"] = self.parkEntity.parkId;
    param[@"userName"] = [DataManager getUserName];
    param[@"parkName"] = self.parkEntity.parkName;
    param[@"description"] = self.commentInput.text;
    param[@"cityIndex"] = [DataManager cityIndex];
    
    [ParkRequests sendParkComment:param complete:^(BOOL issuccess, NSString *parkAddr) {
        [self.navigationController.view stopLoading:hud];
        if (issuccess) {
            [Utils showToastWithMessage:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (parkAddr.length > 0) {
                [Utils showToastWithMessage:parkAddr];
            }else{
                [Utils showToastWithMessage:@"提交失败"];
            }
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
//    if (indexPath.row == 0) {
//        return self.parkTitleCell;
//    }else if (indexPath.row == 1) {
        return self.commentCell;
//    }
//    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        return 44;
//    }else if (indexPath.row == 1) {
        return 200;
//    }
//    return 0;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.inputPlaceholder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.inputPlaceholder.hidden = (textView.text.length > 0);
}

@end
