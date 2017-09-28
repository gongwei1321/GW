//
//  FindParkVC.h
//  FreePark
//
//  Created by zhangwx on 15/12/12.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface FindParkVC : UIViewController

@end

@interface ParkAnno : BMKPointAnnotation

@property (nonatomic, strong) NSString *parkName;
@property (nonatomic, strong) NSString *parkDescription;
@property (nonatomic, strong) NSString *parkStopprice;
@property (nonatomic, strong) NSString *parPriceTime;
@property (nonatomic, strong) NSString *parkId;
@property (nonatomic) NSInteger index;

@end

@interface ParkDetailContentView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrain;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (void)showPDetailContentView;
- (void)hidePDetailContentView;

@end