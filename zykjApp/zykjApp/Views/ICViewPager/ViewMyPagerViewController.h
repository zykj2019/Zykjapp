//
//  ViewMyPagerViewController.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/9/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "ViewPagerController.h"

@interface ViewMyPagerViewController : BaseViewController

@property (weak, nonatomic)  id<ViewPagerDataSource> dataSource;
@property (weak, nonatomic)  id<ViewPagerDelegate> delegate;

//0滑动 1 不滑动 2能滑动但自己添加手势
@property (assign, nonatomic) CGFloat scroll;

#pragma mark ViewPagerOptions
// Tab bar's height, defaults to 49.0

@property CGFloat tabHeight;
// Tab bar's offset from left, defaults to 56.0
@property CGFloat tabOffset;
// Any tab item's width, defaults to 128.0. To-do: make this dynamic
@property CGFloat tabFirstX;

@property CGFloat tabWidth;

// 1.0: Top, 0.0: Bottom, changes tab bar's location in the screen
// Defaults to Top
@property CGFloat tabLocation;

// 1.0: YES, 0.0: NO, defines if view should appear with the second or the first tab
// Defaults to NO
@property CGFloat startFromSecondTab;

// 1.0: YES, 0.0: NO, defines if tabs should be centered, with the given tabWidth
// Defaults to NO
@property CGFloat centerCurrentTab;

//是否tabs居中
@property CGFloat centerTabView;

// contentTop距离tab
@property CGFloat contentTop;

// tabTop
@property CGFloat tabTop;

//tabView底部选中模式
@property CGFloat tabBottomModel;

#pragma mark Colors
// Colors for several parts
@property (strong, nonatomic) UIColor *indicatorColor;
@property (strong, nonatomic) UIColor *indicatorTextColor;
@property (strong, nonatomic) UIColor *tabsViewBackgroundColor;
@property (strong, nonatomic) UIColor *contentViewBackgroundColor;

#pragma mark Methods
// Reload all tabs and contents
- (void)reloadData;

//左滑
- (void)leftScroll;

//右滑
- (void)rightScroll;

@end
