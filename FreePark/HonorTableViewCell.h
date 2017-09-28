//
//  HonorTableViewCell.h
//  FreePark
//
//  Created by 龚伟 on 15/12/27.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HonorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)setContentText:(NSString *)text;
@end
