//
//  MyHireTableViewCell.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/19.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "MyHireTableViewCell.h"


@implementation MyHireTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)modifyClick:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(modifiyHire:)]) {
        
        [_delegate modifiyHire:self.tag];
    }
}
- (IBAction)deleteClick:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(deleteHire:)]) {
        
        [_delegate deleteHire:self.tag];
    }
}
- (IBAction)buttonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(detailHire:)]) {
        
        [_delegate detailHire:self.tag];
    }
}

@end
