//
//  MainBottomView.m
//  FreePark
//
//  Created by 龚伟 on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "MainBottomView.h"
#import "MainButton.h"
#import "ZZTool.h"
@interface MainBottomView()
@property (nonatomic,strong) MainButton *honorButton;//光荣榜
@property (nonatomic,strong) MainButton *publicityButton;//公示
@property (nonatomic,strong) MainButton *findButton;//发现
@property (nonatomic,strong) MainButton *meButton;//关于我们
@property (nonatomic,strong) MainButton *selectedButton;
@property (nonatomic,strong) NSArray *arrayButtons;//4个按钮
@end
@implementation MainBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //光荣榜
        self.honorButton = [self setupButtonWithTitle:@"光荣榜" image:@"guangrongbang" selectedImage:@"guangrongbang_selected" tag:0];
        
        //公示
        self.publicityButton = [self setupButtonWithTitle:@"公示" image:@"gongshi" selectedImage:@"gongshi_selected" tag:1];
        
        [ZZTool sharedZZTool].publicityButton = self.publicityButton;
        
        //发现
        self.findButton = [self setupButtonWithTitle:@"我的" image:@"me" selectedImage:@"me_selected" tag:2];
        [ZZTool sharedZZTool].findButton = self.findButton;
//        self.findButton.rightIcon2.hidden = NO;
   
        
        //关于我们
        self.meButton = [self setupButtonWithTitle:@"关于我们" image:@"faxianwomen" selectedImage:@"faxianwomen_seleted" tag:3];
        
        self.arrayButtons = @[self.honorButton,self.publicityButton,self.findButton,self.meButton];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.frame.size.width;
    CGFloat buttonWidth = viewWidth/4;
    CGFloat viewHeight = self.frame.size.height;
    
    for (int i = 0; i<self.arrayButtons.count; i++) {
        UIButton *btn = self.arrayButtons[i];
        btn.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, viewHeight);
        
    }
}
- (void)clickButton:(MainButton *)button
{
//    self.selectedButton.selected = NO;
//    self.selectedButton = button;
//    button.selected = YES;
    if ([self.delegate respondsToSelector:@selector(mainBottomViewClickedButton:)])
    {
        [self.delegate mainBottomViewClickedButton:button.tag];
    }

    
}
- (MainButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    MainButton *button = [MainButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeCenter;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.tag = tag;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;

}

@end
