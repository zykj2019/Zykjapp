//
//  UIView+GACommon.h
//  zykjApp
//
//  Created by zoulixiang on 2018/3/31.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LineView;
@interface UIView (ND)

- (void)addRoundBorder;

+ (CGFloat)showHeight;

- (CGFloat)showHeight;

- (void)huggingPriority:(UILayoutConstraintAxis)layoutConstraintAxis;

- (void)removeHuggingPriority:(UILayoutConstraintAxis)layoutConstraintAxis;

//增加bottom线条并加入约束
- (void)addTBottomLine;

//增加深色bottom线条并加入约束
- (void)addDarkTBottomLine;

//增加top线条并加入约束
- (void)addTTopLine;

//增加深色top线条并加入约束
- (void)addDarkTTopLine;

//底部线
- (LineView *)tbottomLine;

//顶部线
- (LineView *)ttopLine;

////增加阴影
- (void)addCommonShadow;

@end
