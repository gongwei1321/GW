//
//  ParkForRentVC.m
//  FreePark
//
//  Created by zhangwx on 2017/8/22.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ParkForRentVC.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "AddCSParkHireViewController.h"
#import "AddInterleavedViewController.h"
#import "ParkPaopaoView.h"
#import "ParkSearchVC.h"
#import "ParkHireAnnoView.h"
#import "ParkHireDetailViewController.h"

@interface ParkForRentVC ()<BMKMapViewDelegate, BMKLocationServiceDelegate,ParkSearchDelegate>
{
    CLLocation *userCurrLocation;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) NSMutableArray<BMKPointAnnotation *> *parkArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLineLeft;
@property (nonatomic) NSInteger rentType;
@end

@implementation ParkForRentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rentType = 1;
    self.locationService = [[BMKLocationService alloc] init];
    self.parkArr = [[NSMutableArray<BMKPointAnnotation *> alloc] init];
    [self initMap];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    [self refreshParks];
}

- (void)initMap
{
    self.mapView.zoomLevel = 16;
    self.mapView.rotateEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBackToCurrPlace:(id)sender
{
    [self.mapView setCenterCoordinate:userCurrLocation.coordinate animated:YES];
}

- (IBAction)actionPublish:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"整租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddInterleavedViewController *vc = [[AddInterleavedViewController alloc] initWithNibName:@"AddInterleavedViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"错时" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddCSParkHireViewController *vc = [[AddCSParkHireViewController alloc] initWithNibName:@"AddCSParkHireViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionRentTypeChange:(UIButton *)sender {
    if (sender.tag == 1) {//整租
        self.typeLineLeft.constant = 45;
    }else if (sender.tag == 2){//错时
        self.typeLineLeft.constant = 91;
    }
    self.rentType = sender.tag;
}

- (IBAction)actionSearch:(id)sender
{
    ParkSearchVC *parkSearchVC = [[ParkSearchVC alloc] initWithNibName:@"ParkSearchVC" bundle:nil];
    parkSearchVC.delegate = self;
    [self.navigationController pushViewController:parkSearchVC animated:YES];
}

- (void)setRentType:(NSInteger)rentType
{
    _rentType = rentType;
    [self refreshParks];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([NSStringFromClass(annotation.class) isEqualToString:
         NSStringFromClass([BMKPointAnnotation class])]) {
        BMKPinAnnotationView *ann = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"1"];
        return ann;
    }
    
    static NSString *annoReuseID = @"reuseID";
    ParkHireAnnoView *annoView = (ParkHireAnnoView *)[mapView viewForAnnotation:annotation];
    if (annoView == nil) {
        annoView = [[ParkHireAnnoView alloc] initWithAnnotation:annotation reuseIdentifier:annoReuseID];
        ParkPaopaoView *customView = [ParkPaopaoView instanceFromNib];
        annoView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:customView];
        annoView.paopaoView.hidden = YES;
        customView.userInteractionEnabled = YES;
    }
    
    HireParkAnno *anno = annotation;
    annoView.tag = 98765 + [anno.parkInfo.parkhireId integerValue];
    annoView.userInteractionEnabled = YES;
    annoView.image = [anno.parkInfo.isEntireRent integerValue] == 0 ? [UIImage imageNamed:@"ParkHirePrice"] : [UIImage imageNamed:@"ParkHirePrice_FD"];
    annoView.price = anno.parkInfo.price;
    
    return annoView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    ParkHireDetailViewController *vc = [[ParkHireDetailViewController alloc] initWithNibName:@"ParkHireDetailViewController" bundle:nil];
    HireParkAnno *anno = view.annotation;
    vc.zzParkHire = anno.parkInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self refreshParks];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    userCurrLocation = userLocation.location;
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

- (void)refreshParks
{
    NSString *lat = [NSString stringWithFormat:@"%lf", self.mapView.centerCoordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%lf", self.mapView.centerCoordinate.longitude];
    NSString *rentType = self.rentType == 1 ? @"1" : @"0";
    [ParkHireRequest requsetNearParkHire:lat andlng:lng andisEntireRent:rentType complete:^(BOOL issuccess, NSString *ret, NSString *cityIndex, NSString *totalSize, NSArray *resultlist) {
        [self.mapView removeAnnotations:self.parkArr];
        [self.parkArr removeAllObjects];
        
        for (ZZParkHire *park in resultlist) {
            HireParkAnno *anno = [[HireParkAnno alloc] init];
            anno.coordinate = CLLocationCoordinate2DMake([park.mapLat doubleValue], [park.mapLng doubleValue]);
            anno.parkInfo = park;
            [self.parkArr addObject:anno];
        }
        [self.mapView addAnnotations:self.parkArr];
    }];
}

#pragma mark 停车场搜索回调

- (void)parkSearchResult:(CLLocationCoordinate2D) result searchStr:(NSString *)searchStr
{
    [self.mapView setCenterCoordinate:result animated:YES];
}

@end

@implementation HireParkAnno
@end
