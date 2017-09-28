//
//  ParkHireAnnoView.h
//  FreePark
//
//  Created by zhangwx on 2017/8/27.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface ParkHireAnnoView : BMKAnnotationView
@property (nonatomic, strong) NSString *price;
- (void)addPriceView:(void(^)(ParkHireAnnoView *anno))onTap;
@end

@interface ParkHireAnnoContentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
