//
//  MyCollectTableViewCell.m
//  FreePark
//
//  Created by 龚伟 on 2017/3/6.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "MyCollectTableViewCell.h"

@implementation MyCollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)collectClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(choosePark:)]) {
        
        [_delegate choosePark:self.tag];
    }
}

@end
