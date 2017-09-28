//
//  ParkForRentVC.h
//  FreePark
//
//  Created by zhangwx on 2017/8/22.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "ParkHireRequest.h"

@interface ParkForRentVC : UIViewController

@end

@interface HireParkAnno : BMKPointAnnotation

@property (nonatomic, strong) ZZParkHire *parkInfo;

@end
