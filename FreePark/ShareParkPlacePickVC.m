//
//  ShareParkPlacePickVC.m
//  FreePark
//
//  Created by zhangwx on 2016/10/14.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "ShareParkPlacePickVC.h"
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

#import "ParkRequests.h"
#import "ParkEntity.h"
#import "FindParkVC.h"
#import "ParkPaopaoView.h"

@interface ShareParkPlacePickVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate>
{
    NSString *currCityStr;
    CLLocationCoordinate2D choosedPoint;
    BMKPointAnnotation *choosedAnn;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retTop;
@property (nonatomic) CLLocationCoordinate2D currPickPosition;
@property (strong, nonatomic) BMKGeoCodeSearch *geoSearch;

@property (weak, nonatomic) IBOutlet UIButton *currCity;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet UITableView *cityList;
@property (weak, nonatomic) IBOutlet UIView *citylistdimView;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *cities;
@property (strong, nonatomic) NSMutableArray *mapDataSource;

@property (weak, nonatomic) MBProgressHUD *hud;

@end

@implementation ShareParkPlacePickVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currCityStr = @"北京市";
    
    self.cities = [[NSMutableArray alloc] initWithArray:@[@"北京",@"上海",@"广州",@"深圳"]];
    self.dataSource = [[NSMutableArray alloc] init];
    self.mapDataSource = [[NSMutableArray alloc] init];
    
    self.geoSearch = [[BMKGeoCodeSearch alloc] init];
    self.geoSearch.delegate = self;
    
    self.locationService = [[BMKLocationService alloc] init];
    
    [self initMap];
    
    [[[UIAlertView alloc] initWithTitle:nil message:@"点击地图即可进行位置标注，为了方便其他车友，请务必进行精确标注。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil] show];
}

- (void)initMap
{
    self.mapView.zoomLevel = 16;
    self.mapView.rotateEnabled = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

#pragma mark maps

- (void)refreshParks
{
    [ParkRequests requestParksByPoint:self.mapView.centerCoordinate complete:^(BOOL issuccess, NSMutableArray *retArr) {
        if (issuccess) {
            [self.mapView removeAnnotations:self.mapDataSource];
            [self.mapDataSource removeAllObjects];
            
            NSInteger i = 0;
            
            for (ParkEntity *entity in retArr) {
                ParkAnno *anno = [[ParkAnno alloc] init];
                anno.coordinate = CLLocationCoordinate2DMake([entity.mapLat doubleValue], [entity.mapLng doubleValue]);
                
                anno.parkName = entity.parkName;
                anno.parkDescription = entity.parkDescription;
                anno.parkStopprice = entity.parkStopprice;
                anno.parPriceTime = entity.parPriceTime;
                anno.parkId = entity.parkId;
                anno.index = i;
                [self.mapDataSource addObject:anno];
                i++;
            }
            [self.mapView addAnnotations:self.mapDataSource];
        }
    }];
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    if(choosedAnn)[self.mapView removeAnnotations:@[choosedAnn]];
    self.currPickPosition = coordinate;
    BMKPointAnnotation *ann = [[BMKPointAnnotation alloc] init];
    ann.coordinate = coordinate;
    [self.mapView addAnnotation:ann];
    choosedAnn = ann;
    choosedPoint = coordinate;
    self.commitButton.hidden = NO;
    self.retTop.constant = -240;
//    [self searchByPoint];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseThePlace:)]) {
//        [self.delegate chooseThePlace:coordinate];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    if(choosedAnn)[self.mapView removeAnnotations:@[choosedAnn]];
    self.currPickPosition = mapPoi.pt;
    BMKPointAnnotation *ann = [[BMKPointAnnotation alloc] init];
    ann.coordinate = mapPoi.pt;
    [self.mapView addAnnotation:ann];
    choosedAnn = ann;
    choosedPoint = mapPoi.pt;
    self.commitButton.hidden = NO;
    self.retTop.constant = -240;
//    [self searchByPoint];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseThePlace:)]) {
//        [self.delegate chooseThePlace:mapPoi.pt];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([NSStringFromClass(annotation.class) isEqualToString:
         NSStringFromClass([BMKPointAnnotation class])]) {
        BMKPinAnnotationView *ann = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"1"];
        return ann;
    }
    
    static NSString *annoReuseID = @"reuseID";
    BMKAnnotationView *annoView = [mapView viewForAnnotation:annotation];
    if (annoView == nil) {
        annoView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annoReuseID];
        ParkPaopaoView *customView = [ParkPaopaoView instanceFromNib];
        annoView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:customView];
        annoView.paopaoView.hidden = YES;
        customView.userInteractionEnabled = YES;
    }
    
    ParkAnno *anno = annotation;
    annoView.tag = 98765 + anno.index;
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

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self refreshParks];
}

#pragma mark searchs

- (void)searchByPoint
{
    /**
     *根据地理坐标获取地址信息
     *异步函数，返回结果在BMKGeoCodeSearchDelegate的onGetAddrResult通知
     *@param reverseGeoCodeOption 反geo检索信息类
     *@return 成功返回YES，否则返回NO
     */
    [SVProgressHUD show];
    BMKReverseGeoCodeOption *opt = [[BMKReverseGeoCodeOption alloc] init];
    opt.reverseGeoPoint = self.currPickPosition;
    [self.geoSearch reverseGeoCode:opt];
}

- (void)searchByAddress:(NSString *)addr
{
    [ParkRequests requestParkSearchToCoor:addr City:currCityStr complete:^(BOOL issuccess, NSArray *retPositions) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:retPositions];
        [self.listView reloadData];
        self.retTop.constant = 108;
        [SVProgressHUD dismiss];
    }];
    /**
     *根据地址名称获取地理信息
     *异步函数，返回结果在BMKGeoCodeSearchDelegate的onGetAddrResult通知
     *@param geoCodeOption       geo检索信息类
     *@return 成功返回YES，否则返回NO
     */
//    BMKGeoCodeSearchOption *opt = [[BMKGeoCodeSearchOption alloc] init];
//    opt.city = currCityStr;
//    opt.address = addr;
//    [self.geoSearch geoCode:opt];
}

#pragma mark BMKGeoCodeSearchDelegate

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    self.currPickPosition = result.location;
    [self.mapView setCenterCoordinate:result.location animated:YES];
    [self searchByPoint];
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:result.poiList];
    [self.listView reloadData];
    self.retTop.constant = 108;
    [SVProgressHUD dismiss];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

#pragma mark Actions
- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionShowCityChoice:(id)sender
{
    self.citylistdimView.hidden = NO;
}

- (IBAction)actionSearch:(id)sender
{
    [self.searchField resignFirstResponder];
    [self searchPark:self.searchField.text];
}

- (IBAction)tapDimView
{
    self.citylistdimView.hidden = YES;
}

- (IBAction)tapComplete:(id)sender {
    
    if (choosedPoint.latitude == 0 && choosedPoint.longitude == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击地图即可进行位置标注，为了方便其他车友，请务必进行精确标注。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseThePlace:)]) {
        [self.delegate chooseThePlace:choosedPoint];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *retStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self searchPark:retStr];
    return YES;
}

#pragma mark Search

- (void)searchPark:(NSString *)str
{
    self.retTop.constant = 108;
    [self searchByAddress:str];
}

#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.cityList) {
        return self.cities.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityList) {
        static NSString *cityCellID = @"citycell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cityCellID];
        }
        cell.textLabel.text = self.cities[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
        return cell;
    }else{
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        NSDictionary *entity = self.dataSource[indexPath.row];
        cell.textLabel.text = entity[@"parkName"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityList) {
        NSString *city = self.cities[indexPath.row];
        currCityStr = [city stringByAppendingString:@"市"];
        [self.currCity setTitle:city forState:UIControlStateNormal];
        self.citylistdimView.hidden = YES;
    }else{
        NSDictionary *entity = self.dataSource[indexPath.row];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([entity[@"parkPosition"][@"lat"] doubleValue], [entity[@"parkPosition"][@"lng"] doubleValue]);
        [self.mapView setCenterCoordinate:position animated:YES];
        self.retTop.constant = -240;
        [self.searchField resignFirstResponder];
    }
}

@end
