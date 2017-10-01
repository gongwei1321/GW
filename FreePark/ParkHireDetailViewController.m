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
#import "ContactViewController.h"
@interface ParkHireDetailViewController ()<UIAlertViewDelegate,BMKLocationServiceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *hireLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong,nonatomic)UIAlertView *alterView;
//@property (weak, nonatomic) IBOutlet UIButton *modifyButton;
@property (nonatomic,copy)NSString *address;
//@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic)BOOL isModify;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *rentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentMoneyLabel;
@property (strong, nonatomic)  BMKLocationService *locService;  //定位
@end

@implementation ParkHireDetailViewController
-(void)startLocation

{
    
    //初始化BMKLocationService
    
    self.locService = [[BMKLocationService alloc]init];
    
     self.locService.delegate = self;
    
     self.locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //启动LocationService
    
    [ self.locService startUserLocationService];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation

{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.locService.delegate = nil;
    [self.locService stopUserLocationService];
    
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.address =self.zzParkHire.address;
    [self startLocation];
    [self loadParkDetail];
    self.isModify = false;
    
    [self initMiniMap];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenHeight > 667)
    {
       self.mapViewHeightConstraint.constant = 250;
    }
    else  if(screenHeight > 568){
        self.mapViewHeightConstraint.constant = 190;
    }
    else
    {
        self.mapViewHeightConstraint.constant = 90;
    }

    
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
//    [self.deleteBtn setHidden:YES];
//    [self.modifyButton setHidden:YES];
    [ParkHireRequest requsetParkHireDetail:cityIndex andid:self.zzParkHire.parkhireId complete:^(BOOL issuccess, NSString *ret, NSArray *resultlist) {
        if(issuccess)
        {
            self.zzParkHire = ((ZZParkHire *)resultlist[0]);
            self.zzParkHire.address  = self.address;
            self.placeLabel.text = self.zzParkHire.parkHireName;
//            self.publicTimeLabel.text = [self timeWithTimeIntervalString:self.zzParkHire.addTime];
//            self.contactLabel.text = self.zzParkHire.contact;
            
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
            self.timeLabel.text = [self updateTimeForRow:[self.zzParkHire.addTime doubleValue]];
            if([self.zzParkHire.subName isEqualToString:[DataManager getUserName]])
            {
//                [self.deleteBtn setHidden:NO];
//                [self.modifyButton setHidden:NO];
            };
            self.rentMoneyLabel.text = [NSString stringWithFormat:@"%@ 元/月",self.zzParkHire.price];
            if([self.zzParkHire.isEntireRent  isEqual: @"1"])//整租
            {
//                self.beginTimeLabel.hidden = YES;
//                self.endTimeLabel.hidden = YES;
//                self.beginTime.hidden = YES;
//                self.endTime.hidden = YES;
              CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
                if(screenHeight > 667)
                {
                    self.mapViewHeightConstraint.constant = 250 + 50;
                }
                else  if(screenHeight > 568){
                    self.mapViewHeightConstraint.constant = 190 + 50;
                }
                else
                {
                    self.mapViewHeightConstraint.constant = 90 + 50;
                }
                self.rentTitleLabel.hidden = YES;
                self.lineView.hidden = YES;
                self.rentTimeLabel.hidden = YES;
                self.miaosuTopConstraint.constant = 71;
                self.miaosuTextViewConstraint.constant = 64;
                self.titleLable.text =  @"整租车位详情";
                self.hireLabel.text = @"整租";
               
                

            }
            else{
                self.rentTimeLabel.text = [NSString stringWithFormat:@"%@ - %@",[self getDayTimeString:self.zzParkHire.beginTime],[self getDayTimeString:self.zzParkHire.endTime]];
                self.titleLable.text =  @"分时车位详情";
                self.hireLabel.text = @"分时";
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

-(double) gps2m:(double)x1 _y1:(double)y1 _x2:(double)x2 _y2:(double)y2{
    
    double radLat1 = (x1 * 3.1416 / 180.0);
    
    double radLat2 = (x2 * 3.1416 / 180.0);
    
    double a = radLat1 - radLat2;
    
    double b = (y1 - y2) * 3.1416 / 180.0;
    
    double s = 2 * asin(sqrt(pow(sin(a / 2), 2)
                             
                             + cos(radLat1) * cos(radLat2)
                             
                             * pow(sin(b / 2), 2)));
    
    s = s * 6378137.0;
    
    s = round(s * 10000) / 10000;
    
    return s;
    
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
- (NSString *)updateTimeForRow:(NSInteger)timestamp {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    //    NSTimeInterval createTime = timestamp/1000;
    // 时间差
    NSTimeInterval time = currentTime - timestamp;
    
    // 秒转小时
    NSInteger hours = time/3600;
    if(hours == 0)
    {
        NSInteger minutes = time/60;
        return [NSString stringWithFormat:@"%ld分钟前",minutes];
    }
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}
- (IBAction)deleteClcik:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否删除本条出租信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.alterView = alert;
    [alert show];
    
}
- (IBAction)contactClick:(id)sender {
    ContactViewController *contactVC = [[ContactViewController alloc] init];
    contactVC.contact = self.zzParkHire.contact;;
    contactVC.view.frame = self.view.bounds;
    [self.view addSubview:contactVC.view];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
    [self addChildViewController:contactVC];
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
