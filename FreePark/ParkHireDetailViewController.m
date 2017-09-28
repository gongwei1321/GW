//
//  ParkHireDetailViewController.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/26.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ParkHireDetailViewController.h"
#import "ParkHireRequest.h"
#import "AddCSParkHireViewController.h"
#import "AddInterleavedViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface ParkHireDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong,nonatomic)UIAlertView *alterView;
@property (weak, nonatomic) IBOutlet UIButton *modifyButton;
@property (nonatomic,copy)NSString *address;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic)BOOL isModify;
@end

@implementation ParkHireDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.address =self.zzParkHire.address;
    [self loadParkDetail];
    self.isModify = false;
    
    [self initMiniMap];
}

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initMiniMap
{
    self.mapView.zoomLevel = 18;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake([self.zzParkHire.mapLat doubleValue], [self.zzParkHire.mapLng doubleValue]);
    self.mapView.userInteractionEnabled = NO;
    BMKPointAnnotation *currAnno = [[BMKPointAnnotation alloc] init];
    currAnno.coordinate = CLLocationCoordinate2DMake([self.zzParkHire.mapLat doubleValue], [self.zzParkHire.mapLng doubleValue]);
    [self.mapView addAnnotation:currAnno];
}

-(void)loadParkDetail
{
    NSString *cityIndex = @"0";
    
    if([self.zzParkHire.address isEqualToString:@"北京"])
    {
        cityIndex = @"0";
        
    }
    else if([self.zzParkHire.address isEqualToString:@"上海"])
    {
        cityIndex = @"1";
        
    }
    else if([self.zzParkHire.address isEqualToString:@"广州"])
    {
        cityIndex = @"2";
        
    }
    else if([self.zzParkHire.address isEqualToString:@"深圳"])
    {
        cityIndex = @"3";
        
    }
    [self.deleteBtn setHidden:YES];
    [self.modifyButton setHidden:YES];
    [ParkHireRequest requsetParkHireDetail:cityIndex andid:self.zzParkHire.parkhireId complete:^(BOOL issuccess, NSString *ret, NSArray *resultlist) {
        if(issuccess)
        {
            self.zzParkHire = ((ZZParkHire *)resultlist[0]);
            self.zzParkHire.address  = self.address;
            self.placeLabel.text = self.zzParkHire.parkHireName;
            self.publicTimeLabel.text = [self timeWithTimeIntervalString:self.zzParkHire.addTime];
            self.contactLabel.text = self.zzParkHire.contact;
            
            NSString *hireTypeLabel = @"";
            if([self.zzParkHire.parkHireType isEqualToString:@"0"])
            {
                hireTypeLabel =@"小区";
            }
            else if([self.zzParkHire.parkHireType isEqualToString:@"1"])
            {
                hireTypeLabel =@"写字楼";
            }
            else if([self.zzParkHire.parkHireType isEqualToString:@"2"])
            {
                hireTypeLabel =@"其他";
            }
            
            
            self.hireTypeLabel.text = hireTypeLabel;
            self.miaosuTextView.text = self.zzParkHire.parkHireRemarks;
            
            if([self.zzParkHire.subName isEqualToString:[DataManager getUserName]])
            {
                [self.deleteBtn setHidden:NO];
                [self.modifyButton setHidden:NO];
            };
            if([self.zzParkHire.isEntireRent  isEqual: @"1"])//整租
            {
                self.beginTimeLabel.hidden = YES;
                self.endTimeLabel.hidden = YES;
                self.beginTime.hidden = YES;
                self.endTime.hidden = YES;
                self.miaosuTopConstraint.constant = 8;
                self.miaosuTextViewConstraint.constant = 0;

            }
            else{
                self.beginTime.text = [self getDayTimeString:self.zzParkHire.beginTime];
                self.endTime.text = [self getDayTimeString:self.zzParkHire.endTime];
            }
                
        
        }
    }];
    
}
- (NSString *)getDayTimeString:(NSString *)dattime
{
    NSUInteger index = [dattime integerValue];
    return [NSString stringWithFormat:@"%02lu:00",(unsigned long)index];
}
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = NO;
    if(self.isModify)
    {
        [self loadParkDetail];
    }
    
    
}
- (IBAction)modifyClick:(id)sender {
    
    
    if([self.zzParkHire.isEntireRent isEqualToString:@"0"])
    {
        AddCSParkHireViewController *addCSVC = [[AddCSParkHireViewController alloc] initWithNibName:@"AddCSParkHireViewController" bundle:nil];
        addCSVC.zzParkHire = self.zzParkHire;
        [self.navigationController pushViewController:addCSVC animated:YES];
    }
    else if([self.zzParkHire.isEntireRent isEqualToString:@"1"])
    {
        AddInterleavedViewController *addInterlVC = [[AddInterleavedViewController alloc] initWithNibName:@"AddInterleavedViewController" bundle:nil];
        addInterlVC.zzParkHire = self.zzParkHire;
        [self.navigationController pushViewController:addInterlVC animated:YES];
        
    }
    self.isModify = true;
}
- (IBAction)deleteClcik:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否删除本条出租信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.alterView = alert;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex==1)
    {
        NSString *cityIndex = 0;
        if([self.zzParkHire.address isEqualToString:@"北京"])
        {
            cityIndex = @"0";
            
        }
        else if([self.zzParkHire.address isEqualToString:@"上海"])
        {
            cityIndex = @"1";
            
        }
        else if([self.zzParkHire.address isEqualToString:@"广州"])
        {
            cityIndex = @"2";
            
        }
        else if([self.zzParkHire.address isEqualToString:@"深圳"])
        {
            cityIndex = @"3";
            
        }
        [ParkHireRequest requestDelParkHire:cityIndex andid:self.zzParkHire.parkhireId complete:^(BOOL issuccess, NSString *ret) {
            if (issuccess) {
                [SVProgressHUD showSuccessWithStatus:@"删除出租信息成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"删除出租信息失败!"];
            }
            
        }];
        
        
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
