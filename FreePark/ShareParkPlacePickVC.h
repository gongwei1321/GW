//
//  ShareParkPlacePickVC.h
//  FreePark
//
//  Created by zhangwx on 2016/10/14.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@protocol ShareParkPlacePickVCDelegate <NSObject>

- (void)chooseThePlace:(CLLocationCoordinate2D)place;

@end

@interface ShareParkPlacePickVC : UIViewController

@property (nonatomic, weak) id<ShareParkPlacePickVCDelegate> delegate;

@end
