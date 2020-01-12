//
//  ViewPagerController.h
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "BaseViewController.h"

#define kDefaultTabHeight 38.0 // Default tab height
#define kDefaultTabOffset 56.0 // Offset of the second and further tabs' from left
#define kDefaultTabWidth 128.0
#define kDefaultTabX 0.0
#define kDefaultTabLocation 1.0 // 1.0: Top, 0.0: Bottom

#define kDefaultStartFromSecondTab 0.0 // 1.0: YES, 0.0: NO

#define kDefaultCenterCurrentTab 0.0 // 1.0: YES, 0.0: NO

#define kDefaultCenterTabView 0.0 // 1.0: YES, 0.0: NO

#define kTabBottomModel 0.0 //

#define kPageViewTag 34

#define kContentTop 0

#define kTabTop 0 //

#define kDefaultIndicatorColor [UIColor colorWithRed:178.0/255.0 green:203.0/255.0 blue:57.0/255.0 alpha:0.75]
//#define kDefaultTabsViewBackgroundColor [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:0.75]
#define kDefaultTabsViewBackgroundColor kNavColor
#define kDefaultContentViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:0.75]
//#define kDefaultTabsViewBottomLineColor [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0]
#define kDefaultTabsViewBottomLineColor WCLINECOLOR

typedef NS_ENUM(NSUInteger, ViewPagerOption) {
    ViewPagerOptionTabHeight,
    
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionFirstTabX,
    ViewPagerOptionTabTop,
    ViewPagerOptionContentTop,
    ViewPagerOptionCenterCurrentTab,
    ViewPagerOptionCenterTabView,
    ViewPagerOptionTabBottomModel
    
    
};

typedef NS_ENUM(NSUInteger, ViewPagerComponent) {
    ViewPagerIndicator,
    ViewPagerTabsView,
    ViewPagerContent,
    ViewPagerTextIndicator
    
};


@protocol ViewPagerDataSource;
@protocol ViewPagerDelegate;

@interface ViewPagerScrollView : UIScrollView
@end

@interface TabView : UIView

@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic,strong) UIColor *indicatorColor;
@property (weak, nonatomic) UIView *tabViewContent;
@property (assign, nonatomic) CGFloat tabBottomModel;

@end

@interface ViewPagerController : BaseViewController


@property (weak, nonatomic)  id<ViewPagerDataSource> dataSource;
@property (weak, nonatomic)  id<ViewPagerDelegate> delegate;

//0滑动 1 不滑动 2能滑动但自己添加手势
@property (assign, nonatomic) CGFloat scroll;

#pragma mark ViewPagerOptions
// Tab bar's height, defaults to 38.0

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

- (void)scrollIndex:(NSInteger)index animated:(BOOL)animated;

@end

#pragma mark dataSource
@protocol ViewPagerDataSource <NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForViewPager:(UIViewController *)viewPager;
// Asks dataSource to give a view to display as a tab item
// It is suggested to return a view with a clearColor background
// So that un/selected states can be clearly seen
- (UIView *)viewPager:(UIViewController *)viewPager viewForTabAtIndex:(NSUInteger)index;

@optional
// The content for any tab. Return a view controller and ViewPager will use its view to show as content
- (UIViewController *)viewPager:(UIViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(UIViewController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

@end

#pragma mark delegate
@protocol ViewPagerDelegate <NSObject>

@optional
// delegate object must implement this method if wants to be informed when a tab changes
- (void)viewPager:(UIViewController *)viewPager didChangeTabToIndex:(NSUInteger)index;
// Every time - reloadData called, ViewPager will ask its delegate for option values
// So you don't have to set options from ViewPager itself
- (CGFloat)viewPager:(UIViewController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;
/*
 * Use this method to customize the look and feel.
 * viewPager will ask its delegate for colors for its components.
 * And if they are provided, it will use them, otherwise it will use default colors.
 * Also not that, colors for tab and content views will change the tabView's and contentView's background
 * (you should provide these views with a clearColor to see the colors),
 * and indicator will change its own color.
 */

- (UIColor *)viewPager:(UIViewController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color;

//tabWidth
- (CGFloat)viewPager:(UIViewController *)viewPager tabWidthForTabAtIndex:(NSUInteger)index;

//获取自定义view里面
- (UIView *)viewPagerForCustomView:(UIViewController *)viewPager;

@end
