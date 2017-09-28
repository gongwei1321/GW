//
//  MyCollectTableViewCell.h
//  FreePark
//
//  Created by 龚伟 on 2017/3/6.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCollectTableViewCellDelegate <NSObject>

- (void)choosePark:(NSInteger )index;

@end
@interface MyCollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (assign, nonatomic) id<MyCollectTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;

@end
