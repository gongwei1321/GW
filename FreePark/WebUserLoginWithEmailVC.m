//
//  WebUserLoginWithEmailVC.m
//  FreePark
//
//  Created by zhangwx on 16/5/8.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "WebUserLoginWithEmailVC.h"
#import "WDTextField.h"
#import "PhoneNumBlindVC.h"
#import "UserRequests.h"

@interface WebUserLoginWithEmailVC ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet WDTextField *emailField;

@end

@implementation WebUserLoginWithEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailField.type = WDTextFieldMail;
    
    [self.usernameField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.emailField setValue:[UIColor colorWithRed:175.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (IBAction)actionLogin:(id)sender
{
    [self.usernameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    
    if (self.usernameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名!"];
        return;
    }
    if (self.emailField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱!"];
        return;
    }
    
    if (![self.emailField check]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱!"];
        return;
    }
    
    [SVProgressHUD show];
    [UserRequests requestLoginByEmail:self.emailField.text userName:self.usernameField.text complete:^(BOOL issuccess, NSString *ret) {
        if (issuccess) {
            
            PhoneNumBlindVC *vc = [[PhoneNumBlindVC alloc] initWithNibName:@"PhoneNumBlindVC" bundle:nil];
            
            if ([DataManager latitude] > 0 || [DataManager longitude] > 0) {
                vc.mapLat = [NSString stringWithFormat:@"%f", [DataManager latitude]];
                vc.mapLng = [NSString stringWithFormat:@"%f", [DataManager longitude]];
            }else{
                if ([self.cityIndex isEqualToString:@"0"]) {//北京web用户
                    vc.mapLat = @"116.382178";
                    vc.mapLng = @"39.913436";
                }else if ([self.cityIndex isEqualToString:@"1"]){//上海web用户
                    vc.mapLat = @"121.482321";
                    vc.mapLng = @"31.238281";
                }else if ([self.cityIndex isEqualToString:@"2"]){//广州web用户
                    vc.mapLat = @"113.272087";
                    vc.mapLng = @"23.132915";
                }else if ([self.cityIndex isEqualToString:@"3"]){//深圳web用户
                    vc.mapLat = @"114.067406";
                    vc.mapLng = @"22.547046";
                }
            }
            
            vc.userName = self.usernameField.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [SVProgressHUD showSuccessWithStatus:@"绑定失败!"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
