//
//  UIViewController+ND.h
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/7/19.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNav.h"
#import "CustomNavView.h"

@interface UIViewController (ND)

- (UIButton *)getBarButton:(UIColor *)textColor;
- (UILabel *)navLbl;
- (void)setNavLbl:(UILabel *)navLbl;

- (void)setNavTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color;

/**
 隐藏系统nav
 如果隐藏增加自定义nav
 
 @param hiddenNav 是否隐藏系统nav
 */
- (void)setHiddenNav:(BOOL)hiddenNav;
- (BOOL)hiddenNav;


/// 仅仅隐藏系统nav (不增加customNav) 为了跟hiddenNav防止冲突
/// @param onlyHiddenNav 是否隐藏系统nav
- (void)setOnlyHiddenNav:(BOOL)onlyHiddenNav;
- (BOOL)onlyHiddenNav;

- (CustomNav *)customNav;
- (void)setCustomNav:(CustomNav *)customNav;

- (void)showLoading:(NSString *)message;

- (void)showLoading:(NSString *)message inView:(UIView *)view;

@end
