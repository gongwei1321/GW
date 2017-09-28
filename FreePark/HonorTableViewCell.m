//
//  HonorTableViewCell.m
//  FreePark
//
//  Created by 龚伟 on 15/12/27.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "HonorTableViewCell.h"
@interface HonorTableViewCell()


@end
@implementation HonorTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContentText:(NSString *)text
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange rangebegin,rangeend;
     rangebegin = [text rangeOfString:@"“"];
     rangeend = [text rangeOfString:@"”"];
    if(rangebegin.location != NSNotFound &&  rangeend.location != NSNotFound  )
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:85.0f/255.0f green:95.0f/255.0f blue:143.0f/255.0f alpha:1] range:NSMakeRange(rangebegin.location,rangeend.location+1  - rangebegin.location)];
   
    self.contentLabel.attributedText = str;
}
@end
