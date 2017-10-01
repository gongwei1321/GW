//
//  ShareViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/26.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ShareViewController.h"
#import "UserRequests.h"
#import "SHViewController.h"
#import "WDTextField.h"
#import "ShareParkPlacePickVC.h"
#import "IQKeyboardManager.h"

@interface ShareViewController () <UITextViewDelegate,UITextFieldDelegate, ShareParkPlacePickVCDelegate>
@property (nonatomic,strong) UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLabelConstraint;
@property (weak, nonatomic) IBOutlet UILabel *priceDanweiLabel;
@property (weak, nonatomic) IBOutlet UIButton *freeButton;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UITextField *placePtTF;

@property (weak, nonatomic) IBOutlet UITextField *placeTextField;//地点
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;//价格
@property (weak, nonatomic) IBOutlet WDTextField *emailTextField;//邮箱
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;//详情
@property (weak, nonatomic) IBOutlet UITextView *shareTextView;//分享理由

@property (nonatomic) CLLocationCoordinate2D choosedPosition;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.detailTextView.delegate = self;
    self.shareTextView.delegate = self;
    self.priceTextField.delegate = self;
    self.emailTextField.type = WDTextFieldMail;

    self.detailTextView.layer.cornerRadius = 4;
    self.shareTextView.layer.cornerRadius = 4;
    
    [self radioClick:self.freeButton];
    
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
    
    
    self.detailTextView.inputAccessoryView = topView;
    self.shareTextView.inputAccessoryView = topView;
    self.emailTextField.inputAccessoryView = topView;
    self.priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)actionShowPlacePickView:(id)sender {
    ShareParkPlacePickVC *vc = [[ShareParkPlacePickVC alloc] initWithNibName:@"ShareParkPlacePickVC" bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)ShowSH:(id)sender {
    SHViewController *shVC = [[SHViewController alloc] init];
    [self.navigationController pushViewController:shVC animated:YES];
}

- (IBAction)commitClick:(id)sender {
    if (self.placeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入地点!"];
        return;
    }
    if (self.placePtTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地点坐标!"];
        return;
    }
    if(self.selectedButton.tag != 1)
    {
        if (self.priceTextField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入价格!"];
            return;
        }
    }
    if (self.emailTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱，方便我们联系您!"];
        return;
    }
    if (self.detailTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详情!"];
        return;
    }
    if (self.detailTextView.text.length < 30) {
        [SVProgressHUD showErrorWithStatus:@"详情不能少于30个字!"];
        return;
    }
    if (self.shareTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入分享理由!"];
        return;
    }
    if(![self.emailTextField check])
    {
        [SVProgressHUD showErrorWithStatus:@"邮箱不正确!"];
        return;

    }
    

    
    NSString *pricetype;
    if (self.selectedButton.tag ==1)//免费
    {
        self.priceTextField.text = @"0";
    }
    if (self.selectedButton.tag == 1 || self.selectedButton.tag == 2)//
    {
        pricetype = @"按小时收费";
    }
    else
    {
         pricetype = @"按次收费";
    }
    [SVProgressHUD show];
    [UserRequests requestAddParkByLocation:self.placeTextField.text andCoor:self.choosedPosition andPrice:self.priceTextField.text andDescription:self.detailTextView.text andEmail:self.emailTextField.text andPricetype:pricetype andShareReason:self.shareTextView.text andName:[DataManager getUserName] complete:^(BOOL issuccess, NSString *ret) {
        if(issuccess)
        {
            if([ret isEqualToString:@"80020"])
            {
//                [SVProgressHUD showSuccessWithStatus:@"提交成功,十分感谢!"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popViewControllerAnimated:YES];
//                });
                [SVProgressHUD dismiss];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已提交，请等待审核" preferredStyle:UIAlertControllerStyleAlert];
                
                
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }]];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];

            }
            else{
                [SVProgressHUD showErrorWithStatus:@"提交失败!"];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"提交失败!"];
 
        }
        
    }];
}
- (IBAction)radioClick:(UIButton *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    if(button.tag == 1)//免费
    {
        self.priceView.hidden = YES;
        self.detailLabelConstraint.constant = 30;

    }
    else{
        self.priceView.hidden = NO;
        self.detailLabelConstraint.constant = 92;
        if (button.tag == 2)//按小时计费
        {
            self.priceDanweiLabel.text = @"元/小时";
        }
        else if (button.tag == 3)//按次收费
        {
             self.priceDanweiLabel.text = @"元/次";
        }

    }
}

- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextField代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbersPeriod] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    return basic;

}
#pragma mark - TextView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if((textView.text.length - range.length+text.length)!= 0)
    {
        if (textView.tag == 1) {
            
            self.detailLabel.hidden = YES;
        }else{
            self.shareLabel.hidden = YES;
        }
      
    }
    else{
        if (textView.tag == 1) {
             self.detailLabel.hidden = NO;
        }
        else{
            self.shareLabel.hidden = NO;
        }
       
    }
    return TRUE;

}

- (void)chooseThePlace:(CLLocationCoordinate2D)place
{
    self.choosedPosition = place;
    self.placePtTF.text = [NSString stringWithFormat:@"%lf, %lf", place.longitude, place.latitude];
}

@end
