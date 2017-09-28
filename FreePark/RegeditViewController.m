//
//  RegeditViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/24.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "RegeditViewController.h"
#import "IQKeyboardManager.h"
#import "YanZhenViewController.h"
#import "UserRequests.h"
#import "WDTextField.h"
#import "GPSManager.h"
#import "APService.h"
#import "FindParkVC.h"

@interface RegeditViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet WDTextField *mobiePhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *yanzhenmaTextField;
@property (weak, nonatomic) IBOutlet WDTextField *password1TextField;
@property (weak, nonatomic) IBOutlet WDTextField *password2TextField;
@property (nonatomic,assign) NSInteger randomNumber;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;//获取验证码按钮
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,assign) NSInteger iCountDown;
@property (nonatomic,strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *passwordSwitchButton1;
@property (weak, nonatomic) IBOutlet UIButton *passwordSwitchButton2;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation RegeditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mobiePhoneTextField.type = WDTextFieldPhoneNumber;
    self.password1TextField.type  = WDTextFieldPass;
    self.password2TextField.type  = WDTextFieldPass;
    self.password1TextField.secureTextEntry = YES;
    self.password2TextField.secureTextEntry = YES;
    self.password1TextField.delegate = self;
    self.password2TextField.delegate = self;
    
    self.infoLabel.numberOfLines = 0;
    [self.infoLabel setText:@"服务已覆盖北京、上海、广州、深圳\r\n其他城市还请耐心等待"];
    
    
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
    self.password1TextField.inputAccessoryView = topView;
    self.password2TextField.inputAccessoryView = topView;
    self.mobiePhoneTextField.inputAccessoryView = topView;
    self.nickNameTextField.inputAccessoryView = topView;
    self.yanzhenmaTextField.inputAccessoryView = topView;
    
    
    [self.password1TextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.password2TextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.mobiePhoneTextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nickNameTextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.yanzhenmaTextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];

    
 
//    [self setInputAccessoryView:topView];
//    [self setAutocorrectionType:UITextAutocorrectionTypeNo];
//    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    //    NSLog(@"%.8f,%.8f",[DataManager latitude],[DataManager longitude]);
    
    
}
- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (IBAction)clickhideOrShow1:(id)sender {
    self.passwordSwitchButton1.selected = !self.passwordSwitchButton1.selected;
    self.password1TextField.secureTextEntry = !self.passwordSwitchButton1.selected;
    [self.password1TextField becomeFirstResponder];
    
}
- (IBAction)clickhideOrShow2:(id)sender {
    self.passwordSwitchButton2.selected = !self.passwordSwitchButton2.selected;
    self.password2TextField.secureTextEntry = !self.passwordSwitchButton2.selected;
    [self.password2TextField becomeFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //    [IQKeyboardManager sharedManager].enable = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    //    [IQKeyboardManager sharedManager].enable = YES;
    
}
- (IBAction)pinClick:(id)sender {
    if ([self.mobiePhoneTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    }
    if (![self.mobiePhoneTextField check]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不正确"];
        return;
    }
 
//    if(self.nickNameTextField.text.length==0)
//    {
//        [SVProgressHUD showErrorWithStatus:@"昵称不能为空"];
//        return;
//    }
    YanZhenViewController *yzVC = [[YanZhenViewController alloc] init];
    yzVC.userName = self.mobiePhoneTextField.text;
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
    [self.yanzhenmaTextField becomeFirstResponder];
    self.pinButton.enabled = NO;
    [UserRequests requestRegisterSMSByVerificationCode:[NSString stringWithFormat:@"%ld",self.randomNumber] andPhoneNumber:self.mobiePhoneTextField.text andSession_name:self.mobiePhoneTextField.text andCaptcha:notification.userInfo[@"YanZheng"] complete:^(BOOL issuccess, NSString *ret) {
        if(issuccess)
        {
            self.phoneNumber = self.mobiePhoneTextField.text;
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"验证码发送失败"];
            self.pinButton.enabled = NO;
        }
    }];
    
}
- (void)CountDown
{
    self.iCountDown--;
    [self.pinButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形-3-拷贝"] forState:UIControlStateDisabled];
    [self.pinButton setTitle:[NSString stringWithFormat:@"%ld秒",(long)self.iCountDown] forState:UIControlStateNormal];
    [self.pinButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.pinButton.titleLabel.font = [UIFont systemFontOfSize:14];
    if (self.iCountDown == 0) {
        [self.timer invalidate];
        self.pinButton.enabled = YES;
        [self.pinButton setTitle:@"" forState:UIControlStateNormal];
        [self.pinButton setBackgroundImage:[UIImage imageNamed:@"获取验证码"] forState:UIControlStateNormal];
    }
}
- (IBAction)completeRegedit:(id)sender {
    if ([self.nickNameTextField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名!"];
        return;
    }
    if ([self.mobiePhoneTextField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号!"];
        return;
    }
    if ([self.yanzhenmaTextField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码!"];
        return;
    }
    if ([self.password1TextField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return;
    }
    if ([self.password2TextField.text isEqualToString:@"" ]) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码!"];
        return;
    }
    if (![self.password1TextField.text isEqualToString:self.password2TextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致,请检查!"];
        return;
    }
    if(![self.yanzhenmaTextField.text isEqualToString:[NSString stringWithFormat:@"%ld",self.randomNumber]])
    {
        [SVProgressHUD showErrorWithStatus:@"验证码不正确!"];
        return;
    }
    if ((![self.mobiePhoneTextField check])) {
        [SVProgressHUD showErrorWithStatus:@"手机号不正确!"];
        return;
    }
    if (![self.phoneNumber isEqualToString:self.mobiePhoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"该手机号和获取验证码的手机号不一样!"];
        return;
        
    }
    if (self.password1TextField.text.length < 6)
    {
        [SVProgressHUD showErrorWithStatus:@"密码必须大于等于6!"];
        return;
    }
    if (![self.password1TextField check]) {
        [SVProgressHUD showErrorWithStatus:@"密码必须为字母数字组合!"];
        return;
        
    }
    [SVProgressHUD show];
    [UserRequests requestRegisterByUserName:self.nickNameTextField.text andUserPwd:self.password1TextField.text andphoneNumber:self.mobiePhoneTextField.text andMapLat:[NSString stringWithFormat:@"%.8f",[DataManager latitude]] andMapLng:[NSString stringWithFormat:@"%.8f",[DataManager longitude]] complete:^(BOOL issuccess, NSString *ret) {
        if (issuccess) {
            if ([ret isEqualToString:@"20010"]) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [DataManager setUserName:self.nickNameTextField.text];
                    
                    
                    NSSet *set = [NSSet setWithObjects:self.nickNameTextField.text, nil];
                    [APService setTags:set alias:nil callbackSelector:nil object:nil];
                    
                    
                    FindParkVC *mainVC = [[FindParkVC alloc] initWithNibName:@"FindParkVC" bundle:nil];
                    WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:mainVC];
                    [ZZTool sharedZZTool].wdNav = nav;
                    self.view.window.rootViewController = nav;
                    
                    
                });
            }
            else if([ret isEqualToString:@"20011"])
            {
                [SVProgressHUD showErrorWithStatus:@"用户名已存在!"];
            }
            else if([ret isEqualToString:@"20012"])
            {
                [SVProgressHUD showErrorWithStatus:@"手机号已存在!"];
            }
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"注册失败!"];
        }
        
    }];
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
//定义UITextFiled的代理方法：
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
