//
//  SMButton.m
//  SmartHome
//
//  Created by 龚伟 on 2017/1/20.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import "SMButton.h"

@implementation SMButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.DownBtn = nil;
        self.upBtn = nil;
        self.isUp = NO;
        self.isDown = NO;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    CGRect rect = self.frame;
    if(point.y < rect.size.height * 0.3 || point.y > rect.size.height * 0.7)
    {
        if ((point.y < rect.size.height * 0.3) && self.isUp){
            [self.upBtn sendActionsForControlEvents:UIControlEventTouchDown];
            [self.upBtn setSelected:YES];
           
        }
        else if ((point.y > rect.size.height * 0.7) && self.isDown){
            [self.DownBtn sendActionsForControlEvents:UIControlEventTouchDown];
            [self.DownBtn setSelected:YES];
        }
        return;
    }

    [super touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    CGRect rect = self.frame;
    if(point.y < rect.size.height * 0.3 || point.y > rect.size.height * 0.7)
    {
        if ((point.y < rect.size.height * 0.3) && self.isUp){
            [self.upBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            [self.upBtn setSelected:NO];
           
        }
        else if ((point.y > rect.size.height * 0.7) && self.isDown){
            [self.DownBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            [self.DownBtn setSelected:NO];
        }
        return;
    }
    if (  self.isUp) {
         [self.upBtn setSelected:NO];
    }
    if ( self.isDown) {
        [self.DownBtn setSelected:NO];
    }
    [super touchesEnded:touches withEvent:event];

}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    UITouch *touch=[touches anyObject];
//    CGPoint point=[touch locationInView:[touch view]];
//    CGRect rect = self.frame;
//    if(point.y < rect.size.height * 0.3 || point.y > rect.size.height * 0.7)
//    {
//        return;
//    }
//    return NO;
//
//}
@end
