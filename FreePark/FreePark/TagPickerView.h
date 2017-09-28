//
//  TagPickerView.h
//  FreePark
//
//  Created by zhangwx on 15/12/14.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagPickerView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *readySelectList;
@property (strong, nonatomic) NSMutableArray *readyPickTags;
@property (strong, nonatomic) NSMutableArray *pickedTags;
@property (weak, nonatomic) IBOutlet UIButton *changeTags;

+ (instancetype)instanceFromNib;

@end

@interface ParkTag : NSObject

@property (nonatomic, strong) NSString *tagName;
@property (nonatomic) NSInteger index;

@end
