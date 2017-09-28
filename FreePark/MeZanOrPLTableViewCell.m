//
//  MeZanOrPLTableViewCell.m
//  FreePark
//
//  Created by 龚伟 on 16/5/4.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "MeZanOrPLTableViewCell.h"

@implementation MeZanOrPLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
