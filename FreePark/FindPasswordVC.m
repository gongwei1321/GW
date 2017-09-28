//
//  FindPasswordVC.m
//  FreePark
//
//  Created by zhangwx on 16/5/7.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "FindPasswordVC.h"
#import "UserRequests.h"
#import "WDTextField.h"
#import "YanZhenViewController.h"
@interface FindPasswordVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet WDTextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *yzmBtn;

@property (weak, nonatomic) IBOutlet UITextField *yzmField;

@property (weak, nonatomic) IBOutlet WDTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *hidePassBtn;

@property (nonatomic,assign) NSInteger randomNumber;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,assign) NSInteger iCountDown;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation FindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneNum.type = WDTextFieldPhoneNumber;
    self.passwordField.type  = WDTextFieldPass;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
    
    [self.passwordField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.yzmField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneNum setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (IBAction)passWordHideSwitch:(id)sender {
    self.hidePassBtn.selected = !self.hidePassBtn.selected;
    self.passwordField.secureTextEntry = !self.hidePassBtn.selected;
    [self.passwordField becomeFirstResponder];
}

- (IBAction)pinClick:(id)sender {
    if ([self.phoneNum.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    }
    if (![self.phoneNum check]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不正确"];
        return;
    }
    
    YanZhenViewController *yzVC = [[YanZhenViewController alloc] init];
    yzVC.userName = self.phoneNum.text;
    yzVC.view.frame = self.view.bounds;
    [self.view addSubview:yzVC.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
    [self addChildViewController:yzVC];

    
}
- (void)InfoNotificationAction:(NSNotification *)notification{
    self.iCountDown = 60;
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(CountDown) userInfo:nil repeats:YES];
    //加入主循环池中
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
    
    
    
    self.randomNumber = arc4random() % 1000000;
    [self.yzmField becomeFirstResponder];
    self.yzmBtn.enabled = NO;
    [UserRequests requestRegisterSMSByVerificationCode:[NSString stringWithFormat:@"%ld",self.randomNumber]  andPhoneNumber:self.phoneNum.text andSession_name:self.phoneNum.text andCaptcha:notification.userInfo[@"YanZheng"]  complete:^(BOOL issuccess, NSString *ret) {
        if(issuccess)
        {
            self.phoneNumber = self.phoneNum.text;
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"验证码发送失败"];
            self.yzmBtn.enabled = NO;
        }
        
        
    }];

}
- (void)CountDown
{
    self.iCountDown--;
    [self.yzmBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-3-拷贝"] forState:UIControlStateDisabled];
    [self.yzmBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)self.iCountDown] forState:UIControlStateNormal];
    [self.yzmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.yzmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (self.iCountDown == 0) {
        [self.timer invalidate];
        self.yzmBtn.enabled = YES;
        [self.yzmBtn setTitle:@"" forState:UIControlStateNormal];
        [self.yzmBtn setBackgroundImage:[UIImage imageNamed:@"获取验证码"] forState:UIControlStateNormal];
    }
}

- (IBAction)commitFindPassWord:(id)sender {
    
    [self.phoneNum resignFirstResponder];
    [self.yzmField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    if ([self.phoneNum.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号!"];
        return;
    }
    if ([self.yzmField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码!"];
        return;
    }
    if ([self.passwordField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return;
    }
    if(![self.yzmField.text isEqualToString:[NSString stringWithFormat:@"%ld",self.randomNumber]])
    {
        [SVProgressHUD showErrorWithStatus:@"验证码不正确!"];
        return;
    }
    if ((![self.phoneNum check])) {
        [SVProgressHUD showErrorWithStatus:@"手机号不正确!"];
        return;
    }
    if (![self.phoneNumber isEqualToString:self.phoneNum.text]) {
        [SVProgressHUD showErrorWithStatus:@"该手机号和获取验证码的手机号不一样!"];
        return;
        
    }
    if (self.passwordField.text.length < 6)
    {
        [SVProgressHUD showErrorWithStatus:@"密码必须大于等于6!"];
        return;
    }
    if (![self.passwordField check]) {
        [SVProgressHUD showErrorWithStatus:@"密码必须为字母数字组合!"];
        return;
        
    }
    [SVProgressHUD show];
    [UserRequests requestFindBackPassWord:self.phoneNum.text newPass:self.passwordField.text complete:^(BOOL issuccess, NSString *modifyTag) {
        if (issuccess) {
            
            if([modifyTag intValue] == 20060){
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"没有找到注册的手机号"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    return basic;
}

@end
