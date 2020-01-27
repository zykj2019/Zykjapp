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

#define BTN_TEXT_COLOR kMainTextColor
#define NAV_TEXT_COLOR   UIColorFromRGB(0x191919)

//空页面tag
#define  EMPTYVIEWTAG  1702

@interface UIViewController (ND)

- (UIView *)myContentView;
- (void)setMyContentView:(UIView *)myContentView;

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

- (void)setNavTitleView:(UIView *)view;

- (void)setBackAciton:(void(^)(id sender))block;

- (void)setBackAciton:(void(^)(id sender))block NormalImage:(UIImage *)normalImg SelectedImage:(UIImage *)selectedImage;

- (UIButton *)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (UIButton *)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage  withBlock:(void(^)(id sender))block;

- (void)setLeftBarView:(NSArray *)views;

- (void)setRightBarView:(NSArray *)views;

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block;

- (void)setRightBarButtonTitle:(NSString *)title  withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (void)showLeftBarButtonItemWithTitle:(NSString *)title withBlock:(void(^)(id sender))block;

- (void)showLeftBarButtonItemWithTitle:(NSString *)title btnColor:(UIColor *)color showAnimated:(BOOL)showAnimated withBlock:(void(^)(id sender))block;

//- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//
//- (void)showRightBarButtonItemWithTitle:(NSString *)title btnColor:(UIColor *)color target:(id)target action:(SEL)action;

- (void)showRightBarButtonItemWithTitle:(NSString *)title withBlock:(void(^)(id sender))block;

- (void)showRightBarButtonItemWithTitle:(NSString *)title btnColor:(UIColor *)color showAnimated:(BOOL)showAnimated withBlock:(void(^)(id sender))block;

////展示空页面
- (UIView *)showEmptyView:(NSString *)title resetRequestBlock:(CommonVoidBlock)resetRequestBlock;

- (UIView *)showEmptyView:(NSString *)title emptyImage:(UIImage *)emptyImage contentInset:(UIEdgeInsets)contentInset resetRequestBlock:(CommonVoidBlock)resetRequestBlock;

- (void)removeEmptyView;

@end
