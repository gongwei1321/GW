//
//  ParkTagCell.h
//  FreePark
//
//  Created by zhangwx on 15/12/14.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ParkTagPlusCount) {
    ParkTagPlusCountLow,
    ParkTagPlusCountMiddle,
    ParkTagPlusCountHigh,
};

@interface ParkTagCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagTitle;
@property (nonatomic) ParkTagPlusCount plusCount;

+ (instancetype)instanceFromXib;

@end
