//
//  TuCaoViewController.m
//  FreePark
//
//  Created by 龚伟 on 16/4/24.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "TuCaoViewController.h"
#import "UserRequests.h"
@interface TuCaoViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tucaoTextView;
@property (weak, nonatomic) IBOutlet UITextView *lianxiTextView;
@property (weak, nonatomic) IBOutlet UILabel *tucaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *lianxiLabel;
@property (weak, nonatomic) IBOutlet UIButton *tijiaoBtn;

@end

@implementation TuCaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.tucaoTextView.delegate = self;
    self.lianxiTextView.delegate = self;
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(2, 5, 40, 25);
    [doneBtn addTarget:self action:@selector(dealKeyboardHide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBtn,doneBtnItem,nil];
    [topView setItems:buttonsArray];
    self.tucaoTextView.inputAccessoryView = topView;
    self.lianxiTextView.inputAccessoryView = topView;

    
}
- (IBAction)tucaoClick:(id)sender {
    if (self.tucaoTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您想反馈的问题或建议"];
        return;
    }
    [SVProgressHUD show];
    [UserRequests requestPostSuggest:self.tucaoTextView.text andUserName:[DataManager getUserName] andUserMail:self.lianxiTextView.text complete:^(BOOL issuccess, NSString *ret) {
        if ([ret isEqualToString:@"120020"]) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
        else{
            [SVProgressHUD showErrorWithStatus:@"提交失败，请检查网络!"];
        }
    }];

}
- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - TextView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if((textView.text.length - range.length+text.length)!= 0)
    {
        if (textView.tag == 0)
        {
            self.tucaoLabel.hidden = YES;
        }
        if (textView.tag == 1)
        {
            self.lianxiLabel.hidden = YES;
        }
        
    }
    else{
        if (textView.tag == 0) {
            self.tucaoLabel.hidden = NO;
        }
        else{
            self.lianxiLabel.hidden = NO;
        }
        
    }
    return TRUE;
    
}

@end

