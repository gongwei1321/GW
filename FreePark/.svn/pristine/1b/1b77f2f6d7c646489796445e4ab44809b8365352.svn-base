//
//  ParkSearchVC.h
//  FreePark
//
//  Created by zhangwx on 15/12/26.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol ParkSearchDelegate <NSObject>

- (void)parkSearchResult:(CLLocationCoordinate2D) result searchStr:(NSString *)searchStr;

@end

@interface ParkSearchVC : UIViewController

@property (nonatomic, weak) id<ParkSearchDelegate> delegate;
@property (nonatomic, strong) NSString *searchText;

@end
