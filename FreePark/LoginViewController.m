//
//  LoginViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/24.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "LoginViewController.h"
#import "RegeditViewController.h"
#import "UserRequests.h"
#import "APService.h"
#import "WebUserLoginVC.h"
#import "FindPasswordVC.h"
#import "FindParkVC.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *passwordSwitchButton;
@property (weak, nonatomic) IBOutlet UITextField *paswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = ZZColor(244, 244, 244);
    self.paswordTextField.secureTextEntry = YES;
    self.paswordTextField.delegate = self;
    self.loginButton.enabled = NO;
    
    [self.paswordTextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nickNameTextField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
   
}


- (IBAction)passwordShowOrHide:(id)sender {
    
    self.passwordSwitchButton.selected = !self.passwordSwitchButton.selected;
    self.paswordTextField.secureTextEntry = !self.passwordSwitchButton.selected;
    [self.paswordTextField becomeFirstResponder];
}
- (IBAction)clickRegedit:(id)sender {
    RegeditViewController *regeditVC = [[RegeditViewController alloc] init];
    [self.navigationController pushViewController:regeditVC animated:YES];
}

- (IBAction)actionFindPassword:(id)sender {
    FindPasswordVC *vc = [[FindPasswordVC alloc] initWithNibName:@"FindPasswordVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
//定义UITextFiled的代理方法：

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    
    if((textField.text.length - range.length+string.length)!= 0)
    {
        self.loginButton.enabled = YES;
    }
    else{
       self.loginButton.enabled = NO;
    }
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    return basic;
}
- (IBAction)loginClick:(id)sender {
    
    [self.nickNameTextField resignFirstResponder];
    [self.paswordTextField resignFirstResponder];
    
    if (self.nickNameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名!"];
        return;
    }
    if (self.paswordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return;
    }
    [SVProgressHUD show];
    [UserRequests requestLoginByUserName:self.nickNameTextField.text andUserPwd:self.paswordTextField.text complete:^(BOOL issuccess, NSString *loginTag, NSString *loginUserName) {
        if (issuccess) {
            if ([loginTag isEqualToString:@"20010"]) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                [DataManager setUserName:loginUserName];
                
                NSSet *set = [NSSet setWithObjects:loginUserName, nil];
                [APService setTags:set alias:nil callbackSelector:nil object:nil];
                

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    
                    FindParkVC *mainVC = [[FindParkVC alloc] initWithNibName:@"FindParkVC" bundle:nil];
                    WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:mainVC];
                    [ZZTool sharedZZTool].wdNav = nav;
                    self.view.window.rootViewController = nav;
                });
            }
            else if([loginTag isEqualToString:@"20011"])
            {
                [SVProgressHUD showErrorWithStatus:@"用户名不存在!"];
            }
            else if([loginTag isEqualToString:@"20013"])
            {
                [SVProgressHUD showErrorWithStatus:@"密码错误!"];
            }else{
                
                [SVProgressHUD showSuccessWithStatus:@"您是网站用户，即将转入绑定页面"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    WebUserLoginVC *webLoginVC = [[WebUserLoginVC alloc] initWithNibName:@"WebUserLoginVC" bundle:nil];
                    
                    if ([loginTag isEqualToString:@"20014"]) {//北京web用户
                        webLoginVC.cityIndex = @"0";
                    }else if ([loginTag isEqualToString:@"20015"]){//上海web用户
                        webLoginVC.cityIndex = @"1";
                    }else if ([loginTag isEqualToString:@"20016"]){//广州web用户
                        webLoginVC.cityIndex = @"2";
                    }else if ([loginTag isEqualToString:@"20017"]){//深圳web用户
                        webLoginVC.cityIndex = @"3";
                    }
                    
                    [self.navigationController pushViewController:webLoginVC animated:YES];
                });
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


@end
