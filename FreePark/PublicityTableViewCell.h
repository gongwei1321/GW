//
//  PublicityTableViewCell.h
//  FreePark
//
//  Created by 龚伟 on 15/12/27.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *parkImageView;
@property (weak, nonatomic) IBOutlet UILabel *parkPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkWhoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setContentText:(NSString *)text;
@end
