//
//  FindParkVC.m
//  FreePark
//
//  Created by zhangwx on 15/12/12.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "FindParkVC.h"
#import "ParkDetailVC.h"
#import "ParkSearchVC.h"
#import "ShareViewController.h"
#import "LoginViewController.h"
#import "ParkPaopaoView.h"
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetItem.h>
#import "Share.h"
//#import "BNCoreServices.h"
//#import "BNLocation.h"
#import "ParkJieJingVC.h"
#import "MBProgressHUD.h"
#import "NSObject+Commen.h"
#import "ParkRequests.h"
#import "UserRequests.h"
#import "ParkEntity.h"
#import "NSString+StringSize.h"
#import "ShareAlterViewNodelete.h"
#import "SVProgressHUD.h"
#import "CheckManager.h"
#import "ZZTool.h"

#import "HonorViewController.h"
#import "PublicityViewController.h"
#import "MeViewController.h"
#import "UserRequests.h"
#import "ZZUserCollect.h"
#import "ParkForRentVC.h"

#define kBaseParkAnnoTag 54321

@interface FindParkVC ()<BMKMapViewDelegate, /*BNNaviRoutePlanDelegate, BNNaviUIManagerDelegate,*/ BMKLocationServiceDelegate, ParkSearchDelegate, UIAlertViewDelegate, ShareAlterViewNodeleteDelegate, UIActionSheetDelegate>
{
    NSInteger currentOpenIndex;
    CLLocation *userCurrLocation;
    BOOL notUpdateParkAnnos;
    UIView *userArrowView;
    
    BMKAnnotationView *currAnimAnno;
    CADisplayLink *animLink;
    
    CLLocationDirection arrowRotate;
    CADisplayLink *arrowRotateLink;
    
    BOOL needPickParkForSearch;
    BOOL isShowShareAlert;
    NSInteger nearestSearchRetIndex;
}

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *daoHangSelArr;

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (weak, nonatomic) IBOutlet UIView *parkDetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *parkDetailBottom;
@property (weak, nonatomic) IBOutlet UIButton *hornerBorderBtn;
@property (weak, nonatomic) IBOutlet UIButton *currPositionBtn;
@property (weak, nonatomic) IBOutlet MainButton *showAreaBtn;
@property (weak, nonatomic) IBOutlet MainButton *userCenterBtn;
@property (weak, nonatomic) IBOutlet ParkDetailContentView *parkDetailContentView;
@property (weak, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) BMKPointAnnotation *userAnno;

@property (nonatomic,strong) ShareAlterViewNodelete *shareNotDeleteView;

@property (nonatomic) BOOL hasShared;
@property (nonatomic) BOOL canUseSearch;
@property (nonatomic) BOOL canUseAllFunc;

@property (weak, nonatomic) UIPanGestureRecognizer *noSharePan;
@property (weak, nonatomic) UIPinchGestureRecognizer *noSharePinch;

@end

@implementation FindParkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.zoomLevel = 16;
    self.mapView.rotateEnabled = NO;
    self.parkDetailContentView.layer.cornerRadius = 4;
    
    self.showAreaBtn.layer.cornerRadius = 22.5;
    self.showAreaBtn.backgroundColor = [UIColor whiteColor];
    self.showAreaBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.showAreaBtn.layer.shadowColor = UIColorFromHex(0xdddddd).CGColor;
    
    self.hornerBorderBtn.layer.cornerRadius = 22.5;
    self.hornerBorderBtn.backgroundColor = [UIColor whiteColor];
    self.hornerBorderBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.hornerBorderBtn.layer.shadowColor = UIColorFromHex(0xdddddd).CGColor;
    
    self.currPositionBtn.layer.cornerRadius = 22.5;
    self.currPositionBtn.backgroundColor = [UIColor whiteColor];
    self.currPositionBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.currPositionBtn.layer.shadowColor = UIColorFromHex(0xdddddd).CGColor;
    
    self.locationService = [[BMKLocationService alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    self.daoHangSelArr = [[NSMutableArray alloc] init];
    
    [ZZTool sharedZZTool].publicityButton = self.showAreaBtn;
    
    [self setupShareView];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(refreshUserRedPoint) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    arrowRotateLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshArrowRotate)];
    [arrowRotateLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [self judgeAlreadyShare];
}

- (void)refreshUserRedPoint
{
    [UserRequests requestGetAllUserCollect:[DataManager getUserName] andLastUpdateTime:[self getCurrentTimestamp] complete:^(BOOL issuccess, NSString *ret, NSMutableArray *arrayData) {
        if(issuccess)
        {
            self.userCenterBtn.rightIcon.hidden = YES;
            for(int i = 0;i<arrayData.count;i++)
            {
                ZZUserCollect *collect  = arrayData[i];
                if([collect.isHaveNewComment intValue] != 0)
                {
                    self.userCenterBtn.rightIcon.hidden = NO;
                }
            }
        }
    }];
}

//获取当前时间的时间戳
-(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

- (void)judgeAlreadyShare
{
    __weak FindParkVC *wself = self;
    self.canUseSearch = YES;
    self.canUseAllFunc = YES;
    self.hasShared = YES;
    [self setMapUseLimit:YES];
    if (![CheckManager shareInstance].donotCheckShare && ![CheckManager shareInstance].checkShareForSearch) {
        return;
    }
    
    if ([DataManager getUserName].length == 0) {
        self.hasShared = ([CheckManager shareInstance].checkShareForSearch);
        [self setMapUseLimit:([CheckManager shareInstance].checkShareForSearch)];
        self.canUseSearch = !([CheckManager shareInstance].checkShareForSearch);
        return;
    }
    
    if ([DataManager getCurrUserShared]) {
        self.hasShared = ([CheckManager shareInstance].checkShareForSearch);
        [self setMapUseLimit:([CheckManager shareInstance].checkShareForSearch)];
        self.canUseSearch = !([CheckManager shareInstance].checkShareForSearch);
        return;
    }
    
    // 判断是否已经分享--分享之后hasShared为TRUE
    [UserRequests requestJudgeAlreadyShare:^(BOOL hasShared) {
        // 如果开启分享才能进行搜索
        if ([CheckManager shareInstance].checkShareForSearch) {
            wself.hasShared = hasShared;
            wself.canUseSearch = hasShared;
        }
        if ([CheckManager shareInstance].donotCheckShare) {
            self.hasShared = hasShared;
            self.canUseAllFunc = hasShared;
            [self setMapUseLimit:hasShared];
        }
        // 如果没有开启
//        wself.hasShared = hasShared;
//        [wself setMapUseLimit:hasShared];
        
    }];
}

// 对地图进行限制
- (void)setMapUseLimit:(BOOL)hasShared
{
    self.mapView.scrollEnabled = hasShared;
    self.mapView.zoomEnabled = hasShared;
    self.mapView.zoomEnabledWithTap = hasShared;
    self.mapView.overlookEnabled = hasShared;
    self.mapView.rotateEnabled = hasShared;
    
    if (!hasShared) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(noShareAlert)];
        [self.mapView addGestureRecognizer:pan];
        self.noSharePan = pan;
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(noShareAlert)];
        [self.mapView addGestureRecognizer:pinch];
        self.noSharePinch = pinch;
    }else{
        if (self.noSharePinch) {
            [self.mapView removeGestureRecognizer:self.noSharePinch];
        }
        
        if (self.noSharePan) {
            [self.mapView removeGestureRecognizer:self.noSharePan];
        }
    }
}

- (void)noShareAlert
{
    if (!self.hasShared) {
        [self showShareAlert];
    }
}

- (void)showShareAlert
{
    NSString *content = @"为获得全部功能，请分享给身边的朋友。越多人的参与，意味着越高的信息准确性";
    [self showAlert:content];
}

- (void)showNoSeachFuncAlert
{
    NSString *content = @"为获得搜索功能，请分享给身边的朋友。越多人的参与，意味着越高的信息准确性";
    [self showAlert:content];
}

- (void)showAlert:(NSString *)content
{
    if (!isShowShareAlert) {
        isShowShareAlert = YES;
        [[[UIAlertView alloc] initWithTitle:content message:nil delegate:self cancelButtonTitle:@"暂不分享" otherButtonTitles:@"立即分享", nil] show];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [arrowRotateLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionAdd:(id)sender
{
    if([DataManager getUserName].length != 0)
    {
        ShareViewController *shareVC = [[ShareViewController alloc] init];
        [self.navigationController pushViewController:shareVC animated:YES];
    }
    else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

// 点击搜索之后执行的动作
- (IBAction)actionSearch:(id)sender
{
//    if (!self.hasShared) {
//        [self showShareAlert];
//        return;
//    }
    if (!self.canUseSearch) {
        [self showNoSeachFuncAlert];
        return;
    }
    ParkSearchVC *parkSearchVC = [[ParkSearchVC alloc] initWithNibName:@"ParkSearchVC" bundle:nil];
    parkSearchVC.delegate = self;
    [self.navigationController pushViewController:parkSearchVC animated:YES];
}

- (IBAction)actionZoomIn:(id)sender
{
    if (!self.canUseAllFunc) {
        [self showShareAlert];
        return;
    }
    notUpdateParkAnnos = YES;
    [self.mapView zoomIn];
}

- (IBAction)actionZoomOut:(id)sender
{
    if (!self.canUseAllFunc) {
        [self showShareAlert];
        return;
    }
    notUpdateParkAnnos = YES;
    [self.mapView zoomOut];
}

- (IBAction)actionBackToCurrPlace:(id)sender
{
    [self.mapView setCenterCoordinate:userCurrLocation.coordinate animated:YES];
}

- (IBAction)actionGotoHonor:(id)sender
{
    HonorViewController *vc = [[HonorViewController alloc] initWithNibName:@"HonorViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionPublicity:(id)sender
{
    PublicityViewController *vc = [[PublicityViewController alloc] initWithNibName:@"PublicityViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    [ZZTool sharedZZTool].publicityButton.rightIcon.hidden = YES;
    [ZZTool sharedZZTool].publicityButton.numberLabel.hidden = YES;
    [ZZTool sharedZZTool].publicityButton.numberLabel.text = @"0";
    [DataManager setRemoteNoticeNumber:0];
}

- (IBAction)actionUserInfo:(id)sender {
    MeViewController *vc = [[MeViewController alloc] initWithNibName:@"MeViewController" bundle:nil];
    vc.view.frame = CGRectMake(vc.view.frame.origin.x, vc.view.frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    __weak MeViewController *weakVC = vc;
    vc.close = ^{
        [weakVC removeFromParentViewController];
        [weakVC.view removeFromSuperview];
        [self.navigationController setNavigationBarHidden:YES];
    };
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

- (IBAction)actionGotoParkRent:(id)sender {
    ParkForRentVC *vc = [[ParkForRentVC alloc] initWithNibName:@"ParkForRentVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionGotoQuanJin:(id)sender {
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    ParkJieJingVC *vc = [[ParkJieJingVC alloc] initWithNibName:@"ParkJieJingVC" bundle:nil];
    vc.lat = anno.coordinate.latitude;
    vc.lng = anno.coordinate.longitude;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupShareView
{
    //没有删除的view
    ShareAlterViewNodelete *shareViewNodelete = [[NSBundle mainBundle] loadNibNamed:@"ShareAlterViewNodelete" owner:nil options:nil][0];
    shareViewNodelete.delegate = self;
    shareViewNodelete.supperVC = self;
    //TODO影藏分享微信好友
    shareViewNodelete.wxShareBWidth.constant = 0;
    shareViewNodelete.frame = CGRectMake(0, self.navigationController.view.frame.size.height, self.navigationController.view.frame.size.width, 180);
    [self.navigationController.view addSubview:shareViewNodelete];
    self.shareNotDeleteView = shareViewNodelete;
    
}

#pragma mark - shareViewNodelete代理
- (void)chooseActionNodeleteAtIndex:(NSInteger)index
{
    [self.shareNotDeleteView hideView];
}
- (void)chooseShareNodeleteTypeAtIndex:(NSInteger)index{
    [self shareToPlatform:index];
}
- (void)shareToPlatform:(NSInteger)index
{
    [self.shareNotDeleteView hideView];
    SSDKPlatformType ssdkType;
    if(index == 0)//新浪微博
    {
        ssdkType = SSDKPlatformTypeSinaWeibo;
    }
    else if(index == 1)//微信会话
    {
        ssdkType = SSDKPlatformSubTypeWechatSession;
    }
    else if(index == 2)//微信朋友圈
    {
        ssdkType = SSDKPlatformSubTypeWechatTimeline;
    }
    //    self.ssdkType = ssdkType;
    NSString *shareTxt = @"众人拾柴火焰高，一起加入“0元停车”，每年节省3000元停车费。http://a.app.qq.com/o/simple.jsp?pkgname=com.water.park";
    NSString *shareTitle = @"众人拾柴火焰高，一起加入“0元停车”，每年节省3000元停车费。";
    
    UIImage *shareImg = [UIImage imageNamed:@"shareIcon"];
    [Share shareWithType:ssdkType content:shareTxt defaultContent:shareTxt image:shareImg title:shareTitle url:[NSString stringWithFormat:@"http://a.app.qq.com/o/simple.jsp?pkgname=com.water.park"] description:nil result:^{
        [self judgeAlreadyShare];
    }];
    
}

#pragma mark AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isShowShareAlert = NO;
    if (buttonIndex == 0) {
        
    }else{
        [self.shareNotDeleteView showView];
    }
}

#pragma mark 定位代理

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    userCurrLocation = userLocation.location;
    [self.mapView updateLocationData:userLocation];
    arrowRotate = userLocation.heading.trueHeading/180*M_PI;
}

- (void)refreshArrowRotate
{
//    userArrowView.transform = CGAffineTransformMakeRotation(arrowRotate);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!userCurrLocation) {
        [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        userCurrLocation = userLocation.location;
        [self refreshParks];
    }
    userLocation.title = nil;
    userCurrLocation = userLocation.location;
    [self.mapView updateLocationData:userLocation];
    
    if (!self.userAnno) {
        BMKPointAnnotation *userAnno = [[BMKPointAnnotation alloc] init];
        userAnno.coordinate = userLocation.location.coordinate;
        self.userAnno = userAnno;
        [self.mapView addAnnotation:userAnno];
    }
    [self.mapView removeAnnotation:self.userAnno];
    self.userAnno.coordinate = userLocation.location.coordinate;
    [self.mapView addAnnotation:self.userAnno];
}

#pragma mark 停车场搜索回调

- (void)parkSearchResult:(CLLocationCoordinate2D) result searchStr:(NSString *)searchStr
{
    needPickParkForSearch = YES;
    notUpdateParkAnnos = NO;
    [self.mapView setCenterCoordinate:result animated:YES];
}

#pragma mark 停车场泡泡按钮事件

- (void)actionTapParkPaopaoDetailButton:(UIButton *)sender
{
    self.parkDetailView.hidden = NO;
    self.parkDetailBottom.constant = 20;
    BMKActionPaopaoView *annoPaopao = (BMKActionPaopaoView *)sender.superview.superview.superview;
    currentOpenIndex = annoPaopao.tag - kBaseParkAnnoTag;
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    self.parkDetailContentView.titleLabel.text = anno.parkName;
    self.parkDetailContentView.priceLabel.text = [NSString stringWithFormat:@"价格：%@",anno.parkStopprice];
    CLLocationDistance distance = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(userCurrLocation.coordinate), BMKMapPointForCoordinate(anno.coordinate));
    
    self.parkDetailContentView.distanceLabel.text = [NSString stringWithFormat:@"距离：%.2fm", distance];
    [self.parkDetailContentView showPDetailContentView];
}

#pragma mark 停车场导航按钮

- (IBAction)actionTapParkNavButton:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"苹果地图", nil];
    
    [self.daoHangSelArr addObject:@"actionPingguoDaohang"];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        [actionSheet addButtonWithTitle:@"百度地图"];
        [self.daoHangSelArr addObject:@"actionBaiduDaohang"];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        [actionSheet addButtonWithTitle:@"高德地图"];
        [self.daoHangSelArr addObject:@"actionGaodeDaohang"];
    }
    
    //    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    //    {
    //        [actionSheet addButtonWithTitle:@"谷歌地图"];
    //        [self.daoHangSelArr addObject:@"actionGugeDaohang"];
    //    }
    
    [actionSheet showInView:self.view];
}

- (void)actionPingguoDaohang
{
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(anno.coordinate.latitude, anno.coordinate.longitude) addressDictionary:nil]];
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

- (void)actionBaiduDaohang
{
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",anno.coordinate.latitude, anno.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",urlString);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)actionGaodeDaohang
{
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"0元停车",@"FreePark",anno.coordinate.latitude, anno.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",urlString);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)actionGugeDaohang
{
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"0元停车",@"FreePark",anno.coordinate.latitude, anno.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",urlString);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger index = 0;
    if (buttonIndex > 1) {//后添加的需要减1，因为1是取消按钮
        index = buttonIndex - 1;
    }else if(buttonIndex == 1){//取消按钮下标为1
        return;
    }
    
    if (index < self.daoHangSelArr.count) {
        NSString *selName = self.daoHangSelArr[index];
        [self performSelector:NSSelectorFromString(selName)];
    }
}

#pragma mark 停车场详情

- (IBAction)actionGotoParkDetail:(id)sender
{
    ParkDetailVC *detailVC = [[ParkDetailVC alloc] initWithNibName:@"ParkDetailVC" bundle:nil];
    ParkAnno *anno = self.dataSource[currentOpenIndex];
    
    ParkEntity *entity = [[ParkEntity alloc] init];
    entity.mapLat = [NSString stringWithFormat:@"%lf", anno.coordinate.latitude];
    entity.mapLng = [NSString stringWithFormat:@"%lf", anno.coordinate.longitude];
    entity.parkName = anno.parkName;
    entity.parkDescription = anno.parkDescription;
    entity.parkStopprice = anno.parkStopprice;
    entity.parPriceTime = anno.parPriceTime;
    entity.parkId = anno.parkId;
    entity.cityIndex = [DataManager cityIndex];
    detailVC.parkEntity = entity;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 百度地图代理

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if (annotation == self.userAnno) {
        static NSString *userAnnoReuseID = @"userAnnoReuseID";
        BMKAnnotationView *annoView = [mapView viewForAnnotation:annotation];
        if (annoView == nil) {
            annoView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userAnnoReuseID];
            UIImageView *v = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userPositionIcon"]];
            v.frame = CGRectMake(0, 0, 24, 39);
            v.tag = 1561;
            [annoView addSubview:v];
        }
        annoView.image = [UIImage imageNamed:@"userPositionClearIcon"];
        
        userArrowView = [annoView viewWithTag:1561];
        return annoView;
    }
    
    
    static NSString *annoReuseID = @"reuseID";
    BMKAnnotationView *annoView = [mapView viewForAnnotation:annotation];
    if (annoView == nil) {
        annoView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annoReuseID];
        ParkPaopaoView *customView = [ParkPaopaoView instanceFromNib];
        [customView.detailButton addTarget:self action:@selector(actionTapParkPaopaoDetailButton:) forControlEvents:UIControlEventTouchUpInside];
        annoView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:customView];
        annoView.paopaoView.hidden = YES;
        customView.userInteractionEnabled = YES;
    }
    
    ParkAnno *anno = annotation;
    annoView.tag = kBaseParkAnnoTag + anno.index;
    annoView.userInteractionEnabled = YES;
    
    annoView.calloutOffset = CGPointMake(257/2+31/4, (56+31/2)/2);
    
    if ((anno.parkStopprice.length == 0 || [anno.parkStopprice hasPrefix:@"0元"])
        && (anno.parPriceTime.length == 0 || [anno.parPriceTime hasPrefix:@"0元"])) {
        annoView.image = [UIImage imageNamed:@"parkAnnoIconFree"];
    }else{
        annoView.image = [UIImage imageNamed:@"parkAnnoIcon"];
    }
    
    return annoView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    view.image = [UIImage imageNamed:@"parkAnnoIcon_s"];
//    ParkPaopaoView *paopaoView = view.paopaoView.subviews[0];
    ParkAnno *anno = view.annotation;
//    paopaoView.titleLabel.text = anno.parkName;
//    
//    CGFloat paopaoWidth = [anno.parkName stringSizeConstrainedToSize:CGSizeMake(1000, 20) WithFont:[UIFont systemFontOfSize:15]].width;
//    CGRect rect = paopaoView.frame;
//    rect.size.width = paopaoWidth + 50;
//    paopaoView.frame = rect;
//    paopaoView.priceLabel.text = anno.parkStopprice;
//    
    notUpdateParkAnnos = YES;
//
    if (self.mapView.region.span.latitudeDelta > 0.05 && self.hasShared) {
        [self.mapView setRegion:BMKCoordinateRegionMake(CLLocationCoordinate2DMake(anno.coordinate.latitude, anno.coordinate.longitude), BMKCoordinateSpanMake(0.05, 0.05)) animated:YES];
    }
    
    currAnimAnno = view;
    if (animLink) {
        [animLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    animLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshZ)];
    [animLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        animLink = nil;
    });
    
//    [paopaoView showAnimation:^{
//        [animLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//        animLink = nil;
//    }];
    
    
    self.parkDetailView.hidden = NO;
    self.parkDetailBottom.constant = 20;
//    BMKActionPaopaoView *annoPaopao = (BMKActionPaopaoView *)sender.superview.superview.superview;
    currentOpenIndex = view.tag - kBaseParkAnnoTag;
//    ParkAnno *anno = self.dataSource[currentOpenIndex];
    self.parkDetailContentView.titleLabel.text = anno.parkName;
    
    if (anno.parkStopprice.length > 0)
    {
        self.parkDetailContentView.priceLabel.text = [NSString stringWithFormat:@"价格：%@",anno.parkStopprice];
    }else if (anno.parPriceTime.length > 0){
        self.parkDetailContentView.priceLabel.text = [NSString stringWithFormat:@"价格：%@",anno.parPriceTime];
    }
    
    CLLocationDistance distance = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(userCurrLocation.coordinate), BMKMapPointForCoordinate(anno.coordinate));
    
    self.parkDetailContentView.distanceLabel.text = [NSString stringWithFormat:@"距离：%.2fm", distance];
    [self.parkDetailContentView showPDetailContentView];
    
}

- (void)refreshZ
{
//    [currAnimAnno.superview bringSubviewToFront:currAnimAnno.paopaoView];
    [currAnimAnno.superview bringSubviewToFront:currAnimAnno];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    if (view.annotation != self.userAnno) {
        if ((((ParkAnno *)view.annotation).parkStopprice.length == 0 || [((ParkAnno *)view.annotation).parkStopprice hasPrefix:@"0元"])
            && (((ParkAnno *)view.annotation).parPriceTime.length == 0 || [((ParkAnno *)view.annotation).parPriceTime hasPrefix:@"0元"])) {
            view.image = [UIImage imageNamed:@"parkAnnoIconFree"];
        }else{
            view.image = [UIImage imageNamed:@"parkAnnoIcon"];
        }
    }
    
    [self.parkDetailContentView hidePDetailContentView];
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.parkDetailBottom.constant = -106;
    });
    [self.parkDetailContentView hidePDetailContentView];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!notUpdateParkAnnos) {
        [self refreshParks];
    }else{
        notUpdateParkAnnos = NO;
    }
}

- (void)refreshParks
{
    [ParkRequests requestParksByPoint:self.mapView.centerCoordinate complete:^(BOOL issuccess, NSMutableArray *retArr) {
        if (issuccess) {
            [self.mapView removeAnnotations:self.dataSource];
            [self.dataSource removeAllObjects];
            
            NSInteger i = 0;
            CLLocationDistance minDis = 0;
            nearestSearchRetIndex = 0;
            
            for (ParkEntity *entity in retArr) {
                ParkAnno *anno = [[ParkAnno alloc] init];
                anno.coordinate = CLLocationCoordinate2DMake([entity.mapLat doubleValue], [entity.mapLng doubleValue]);
                
                if (i == 0) {
                    minDis = [self distanceFrom:(self.mapView.centerCoordinate) to:anno.coordinate];
                }else{
                    double dis = [self distanceFrom:(self.mapView.centerCoordinate) to:anno.coordinate];
                    if (dis < minDis) {
                        minDis = dis;
                        nearestSearchRetIndex = i;
                    }
                }
                
                anno.parkName = entity.parkName;
                anno.parkDescription = entity.parkDescription;
                anno.parkStopprice = entity.parkStopprice;
                anno.parPriceTime = entity.parPriceTime;
                anno.parkId = entity.parkId;
                anno.index = i;
                [self.dataSource addObject:anno];
                i++;
            }
            [self.mapView addAnnotations:self.dataSource];
            
            if (needPickParkForSearch) {
                needPickParkForSearch = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    notUpdateParkAnnos = YES;
                    [self.mapView selectAnnotation:self.dataSource[nearestSearchRetIndex] animated:YES];
                });
            }
        }
    }];
}

- (double) distanceFrom:(CLLocationCoordinate2D) from to:(CLLocationCoordinate2D)to
{
    return sqrt((from.latitude-to.latitude)*(from.latitude-to.latitude) + (from.longitude-to.longitude)*(from.longitude-to.longitude));
}

@end

@implementation ParkAnno

@end

@implementation ParkDetailContentView

- (void)showPDetailContentView
{
    [self layoutIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        self.topConstrain.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)hidePDetailContentView
{
    [self layoutIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        self.topConstrain.constant = 86;
        [self layoutIfNeeded];
    }];
}

@end
