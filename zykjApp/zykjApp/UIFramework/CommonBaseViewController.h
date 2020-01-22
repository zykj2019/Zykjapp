//
//  CommonBaseViewController.h
//  CommonLibrary
//
//  Created by Alexi Chen on 2/28/13.
//  Copyright (c) 2013 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNav.h"

@interface CommonBaseViewController : UIViewController
{
    CustomNav *_customNav;
    UIView *_myContentView;
    CGFloat _topToViewMargin;
    CGFloat _tableViewTopToViewMargin;
@protected
    UIImageView *_backgroundView;
    
}

@property (strong, nonatomic) UIView *myContentView;

@property (nonatomic, strong) UIImageView  *backgroundView;

@property (nonatomic, assign) BOOL hiddenNavBottmLine;

/**
 如果以后自定义nav 约束距离
 也就是自定义nav的高度
 以后的self.view里的第一个view不是从y = 0开始算 应该从 y = topToViewMargin开始算
 后面所有约束top-self.view 都要加上topToViewMargin
 */
@property (assign, nonatomic) CGFloat topToViewMargin;

/**
 如果以后自定义nav
 tableview约束距离
 */
@property (assign, nonatomic) CGFloat tableViewTopToViewMargin;

//导航栏底部1px的线条
@property (strong, nonatomic) UIView *navBottomLine;

// 是否有背景图
- (BOOL)hasBackgroundView;

// 样式是否与iOS6之前一致
- (BOOL)sameWithIOS6;

// 配置界面的初始化的参数
- (void)configParams;

// hasBackgroundView 返回YES, 使用此方法添加背景
- (void)addBackground;

- (void)configContainer;
// 有背景时，使用此方法配置背景
- (void)configBackground;

// 有背景时，布局背景
- (void)layoutBackground;

//// 布局子控件
//- (void)layoutSubviewsFrame;

- (void)addCustomNav;

///增加内容ContentView
- (UIView *)addMyContentView;

/// //透明nav
/// @param isTransparent 是否隐藏nav
- (void)navIsTransparent:(BOOL)isTransparent;

@end

@interface CommonBaseViewController (AutoLayout)

// 是否支持autoLayout
- (BOOL)isAutoLayout;

// 添加自动布局相关的constraints
- (void)autoLayoutOwnViews;



@end
