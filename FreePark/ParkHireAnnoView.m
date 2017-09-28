//
//  ParkHireAnnoView.m
//  FreePark
//
//  Created by zhangwx on 2017/8/27.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ParkHireAnnoView.h"

@interface ParkHireAnnoView()
@property (weak, nonatomic) ParkHireAnnoContentView *contentV;
@property (strong, nonatomic) void(^onTap)(ParkHireAnnoView *anno);
@end

@implementation ParkHireAnnoView

- (void)setPrice:(NSString *)price
{
    _price = price;
    self.image = [self CSImage:self.image AddText:[price stringByAppendingString:@"元/月"]];
}

-(UIImage *)CSImage:(UIImage *)img AddText:(NSString *)text
{
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    view.image = img;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    label.font = font;
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    [view addSubview:label];
    
    return [self convertViewToImage:view];
}

-(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [v.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    v.layer.contents = nil;
    return image;
}

- (void)addPriceView:(void(^)(ParkHireAnnoView *anno))onTap
{
    if(!self.contentV)
    {
        ParkHireAnnoContentView *v = [[NSBundle mainBundle] loadNibNamed:@"ParkHireAnnoView" owner:nil options:nil][0];
        v.userInteractionEnabled = YES;
        [v.button addTarget:self action:@selector(bonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:v];
        v.button.userInteractionEnabled = YES;
        self.contentV = v;
        self.onTap = onTap;
    }
}

- (void)bonTap:(UIButton *)g
{
    self.onTap(self);
}

@end

@interface ParkHireAnnoContentView()
@end

@implementation ParkHireAnnoContentView

@end
