//
//  MeZanOrPLTableViewCell.h
//  FreePark
//
//  Created by 龚伟 on 16/5/4.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeZanOrPLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *parkNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@end
