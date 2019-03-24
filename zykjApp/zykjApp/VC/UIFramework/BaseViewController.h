//
//  BaseViewController.h
//  SuperMama
//
//  Created by macbook on 15/7/7.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonBaseViewController.h"

#define BTN_TEXT_COLOR  RGB(53.0, 148.0, 255.0)
#define TEXT_COLOR    UIColorFromRGB(0x191919)

@interface BaseViewController : CommonBaseViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void)setNavTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color;

- (void)setBackAciton:(void(^)(id sender))block;

- (void)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (void)setRightBarButtonTitle:(NSString *)title  withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (void)showEmptyView:(NSString *)title;

- (void)removeEmptyView;

// 对于界面上有输入框的，可以选择性调用些方法进行收起键盘
- (void)addTapBlankToHideKeyboardGesture;

- (void)callImagePickerActionSheet;

@end
