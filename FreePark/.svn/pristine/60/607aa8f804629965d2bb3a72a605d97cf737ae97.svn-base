//
//  ParkTagCell.m
//  FreePark
//
//  Created by zhangwx on 15/12/14.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkTagCell.h"

@interface ParkTagCell ()

@end

@implementation ParkTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 4;
    
    if ([UIScreen mainScreen].bounds.size.width < 330) {
        self.tagTitle.font = [UIFont systemFontOfSize:8];
    }else{
        self.tagTitle.font = [UIFont systemFontOfSize:12];
    }
    self.tagTitle.layer.cornerRadius = 4;
    self.tagTitle.layer.borderWidth = 1;
    self.tagTitle.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:147.0/255.0 blue:190.0/255.0 alpha:1].CGColor;
}

+ (instancetype)instanceFromXib
{
    ParkTagCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ParkTagCell" owner:nil options:nil][0];
    return cell;
}

- (void)setPlusCount:(ParkTagPlusCount)plusCount
{
    _plusCount = plusCount;
    switch (plusCount) {
        case ParkTagPlusCountLow:
        {
            self.backgroundColor = UIColorFromHex(0xffffff);
        }
            break;
        case ParkTagPlusCountMiddle:
        {
            self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:238.0/255.0 blue:244.0/255.0 alpha:1];
        }
            break;
        case ParkTagPlusCountHigh:
        {
            self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:213.0/255.0 blue:230.0/255.0 alpha:1];
        }
            break;
            
        default:
            break;
    }
    
}

@end
