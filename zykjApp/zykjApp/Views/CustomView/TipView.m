//
//  TipView.m
//  LabelDemo
//
//  Created by air on 15/5/13.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "TipView.h"
#import <QuartzCore/QuartzCore.h>
//#import "IMichUtil.h"

@implementation TipView

static BOOL isShow = NO;

+ (void)showTipView:(NSString *)tip
{
    if (!tip && isShow)
    {
        return ;
    }
    
    isShow = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [self calcLabelWidth:tip fontSize:15 height:25] + 50;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth / 2 - width / 2, screenHeight  - 100, width, 30)];
    
    label.text = tip;
    label.numberOfLines = 1;
//    label.textColor = [UIColor darkGrayColor];
//    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0;
    
    // 设置圆角
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5.0;
    label.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:label.bounds];
    label.layer.shadowOpacity = 0.8f;
    
    label.layer.shadowPath = shadowPath.CGPath;
    [window addSubview:label];
    
    [UIView animateWithDuration:1.0 animations:^{
        CGRect lblViewFrame = CGRectMake(screenWidth / 2 - width / 2 , screenHeight  - 100, width, 30);
        label.frame = lblViewFrame;
        label.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:3.0 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        isShow = NO;
    }];
}

+ (CGFloat)calcLabelWidth:(NSString *)strText fontSize:(NSInteger)fontSize height:(CGFloat)height
{
    CGFloat width = [strText boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.width;
    
    return width + 1.0;
}

@end
