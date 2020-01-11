//
//  UIViewController+ND.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/7/19.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "UIViewController+ND.h"
#import "UILabel+ND.h"

static NSString *const kHiddenNav = @"kHiddenNav";
static NSString *const kOnlyHiddenNav = @"kOnlyHiddenNav";
static NSString *const kCustomNav = @"kCustomNav";
static NSString *const kNavLbl = @"kNavLbl";
@implementation UIViewController (ND)
#pragma mark - nav

- (UILabel *)navLbl {
    UILabel *t_lable = objc_getAssociatedObject(self, (__bridge const void *)kNavLbl);
    if (!t_lable) {
        t_lable = [UILabel navLbl];
         [t_lable setAdjustsFontSizeToFitWidth:YES];
        objc_setAssociatedObject(self, (__bridge const void *)kNavLbl, t_lable, OBJC_ASSOCIATION_RETAIN);
    }
    
    return t_lable;
}

- (void)setNavLbl:(UILabel *)navLbl {
    objc_setAssociatedObject(self, (__bridge const void *)kNavLbl, navLbl, OBJC_ASSOCIATION_RETAIN);
}

- (UIButton *)getBarButton:(UIColor *)textColor {
    
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = [UIColor clearColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    //[button.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:15]];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:kHighlightedColor forState:UIControlStateHighlighted];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [button setBackgroundColor:[UIColor clearColor]];
    return button;
}

- (void)setNavTitle:(NSString *)title{
    
    [self setNavTitle:title withColor:NAV_TEXT_COLOR];
}

- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color
{
    UILabel *t_lable = [self navLbl];
    [t_lable setText:title];
    [t_lable setTextColor:color];
    
    //self.navigationItem.titleView 会把view给移除在添加
    if (self.hiddenNav && self.customNav) {
        self.customNav.titleView = t_lable;
    } else {
        self.navigationItem.titleView = t_lable;
    }
   
    
}

- (void)setHiddenNav:(BOOL)hiddenNav {
    objc_setAssociatedObject(self, (__bridge const void *)kHiddenNav, [NSNumber numberWithBool:hiddenNav], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hiddenNav {
    NSNumber *num = objc_getAssociatedObject(self, (__bridge const void *)kHiddenNav);
    return [num boolValue];
}

/// 仅仅隐藏系统nav 为了跟hiddenNav防止冲突
/// @param onlyHiddenNav 是否隐藏系统nav
- (void)setOnlyHiddenNav:(BOOL)onlyHiddenNav {
    objc_setAssociatedObject(self, (__bridge const void *)kOnlyHiddenNav, [NSNumber numberWithBool:onlyHiddenNav], OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)onlyHiddenNav {
    NSNumber *num = objc_getAssociatedObject(self, (__bridge const void *)kOnlyHiddenNav);
    return [num boolValue];
}

- (CustomNav *)customNav {
    return  objc_getAssociatedObject(self, (__bridge const void *)kCustomNav);
}
- (void)setCustomNav:(CustomNav *)customNav {
    objc_setAssociatedObject(self, (__bridge const void *)kCustomNav, customNav, OBJC_ASSOCIATION_RETAIN);
}

- (void)showLoading:(NSString *)message {
    [self showLoading:message inView:self.view];
}

- (void)showLoading:(NSString *)message inView:(UIView *)view {
     [[HUDHelper sharedInstance] syncLoading:message inView:view];
}
@end
