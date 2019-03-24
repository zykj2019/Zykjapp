//
//  UtilsMacro.h
//  项目框架
//
//  Created by Hcat on 14-3-17.
//  Copyright (c) 2014年 Hcat. All rights reserved.
//

/**
 *  调试栏颜色插件的宏定义
 *
 *  @return nil
 *
 */

#define PROGRAMNAME @""

#define XCODE_COLORS_ESCAPE_IOS                    @"\033["

#define XCODE_COLORS_ESCAPE                        XCODE_COLORS_ESCAPE_IOS

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;"                 // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;"                 // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"                   // Clear any foreground or background color

#define LogPink(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg209,57,168;" XCODE_COLORS_ESCAPE @"bg255,255,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,150,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg250,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogGreen(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,235,30;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)



#if __IPHONE_6_0 // iOS6 and later

#   define kTextAlignmentCenter    NSTextAlignmentCenter
#   define kTextAlignmentLeft      NSTextAlignmentLeft
#   define kTextAlignmentRight     NSTextAlignmentRight

#   define kTextLineBreakByWordWrapping      NSLineBreakByWordWrapping
#   define kTextLineBreakByCharWrapping      NSLineBreakByCharWrapping
#   define kTextLineBreakByClipping          NSLineBreakByClipping
#   define kTextLineBreakByTruncatingHead    NSLineBreakByTruncatingHead
#   define kTextLineBreakByTruncatingTail    NSLineBreakByTruncatingTail
#   define kTextLineBreakByTruncatingMiddle  NSLineBreakByTruncatingMiddle

#else // older versions

#   define kTextAlignmentCenter    UITextAlignmentCenter
#   define kTextAlignmentLeft      UITextAlignmentLeft
#   define kTextAlignmentRight     UITextAlignmentRight

#   define kTextLineBreakByWordWrapping       UILineBreakModeWordWrap
#   define kTextLineBreakByCharWrapping       UILineBreakModeCharacterWrap
#   define kTextLineBreakByClipping           UILineBreakModeClip
#   define kTextLineBreakByTruncatingHead     UILineBreakModeHeadTruncation
#   define kTextLineBreakByTruncatingTail     UILineBreakModeTailTruncation
#   define kTextLineBreakByTruncatingMiddle   UILineBreakModeMiddleTruncation

#endif

//! 1、XCode中设置控制
// Target > Get Info > Build > GCC_PREPROCESSOR_DEFINITIONS
// Configuration = Release: <empty>
//               = Debug:   DEBUG_MODE=1
//！2、人为控制
//#define DEBUG
#ifdef DEBUG
#define DELOG(...) NSLog(__VA_ARGS__)
#define DELOGPINK(...) LogPink(__VA_ARGS__)
#define DELOGBLUE(...) LogBlue(__VA_ARGS__)
#define DELOGRED(...) LogRed(__VA_ARGS__)
#else
#define DELOG(...) do { } while (0);
#define DELOGPINK(...) do { } while (0);
#define DELOGBLUE(...) do { } while (0);
#define DELOGRED(...) do { } while (0);
#endif

/*
 #define DELOG( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 #else
 #define DELOG( s, ... )
 #endif
*/

#pragma mark -Redefine


#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]

#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define MainScreen                          [UIScreen mainScreen]
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define SelfNavBar                          self.navigationController.navigationBar
#define SelfTabBar                          self.tabBarController.tabBar
#define SelfNavBarHeight                    self.navigationController.navigationBar.bounds.size.height
#define SelfTabBarHeight                    self.tabBarController.tabBar.bounds.size.height

#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height

#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))

#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)

#define DATE_COMPONENTS1                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit

#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsIOS7Later                         !(IOSVersion < 7.0)
#define StatusbarSize ((IOSVersion >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define TabBarHeight                        49.0f
#define NaviBarHeight                       44.0f
#define HeightFor4InchScreen                568.0f
#define HeightFor3p5InchScreen              480.0f

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)

#define YOURSYSTEM_OR_LATER(yoursystem) [[[UIDevice currentDevice] systemVersion] compare:(yoursystem)] != NSOrderedAscending


#define RGB(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBA(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define UIIMAGE_RESIZE(image)  [image stretchableImageWithLeftCapWidth:floorf(image.size.width / 2) topCapHeight:floorf(image.size.height / 2)]

#define IMAGE_RESIZE(image, top, left, bottom, right)    [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch]


//iphonex适配
// UIScreen width.
#define  HT_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  HT_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
#define  HT_iPhoneX (HT_ScreenWidth == 375.f && HT_ScreenHeight == 812.f ? YES : NO)

// Status bar height.
#define  HT_StatusBarHeight      (HT_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  HT_NavigationBarHeight  44.f

// Tabbar height.
#define  HT_TabbarHeight         (HT_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  HT_TabbarSafeBottomMargin         (HT_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  HT_StatusBarAndNavigationBarHeight  (HT_iPhoneX ? 88.f : 64.f)

#define HT_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

//基础配置
#define kAppBakgroundColor          RGBOF(0xF9F7F8)
#define kAppModalBackgroundColor    [kBlackColor colorWithAlphaComponent:0.6]
#define kAppModalDimbackgroundColor [RGB(16, 16, 16) colorWithAlphaComponent:0.3]

// 主色调
// 导航按钮
#define kNavBarThemeColor             RGB(128, 64, 122)
#define kNavBarHighlightThemeColor    RGB(161, 92, 154)

// 默认TableViewCell高度
#define kDefaultCellHeight 50
// 默认界面之间的间距
#define kDefaultMargin     8

// 默认的字体颜色
#define kMainTextColor                kBlackColor

#define kDetailTextColor              RGB(145, 145, 145)


#define kDownRefreshLoadOver    @"没有更多了"

#define kDownReleaseToRefresh   @"松开即可更新..."

#define kDownDragUpToRefresh    @"上拉即可更新..."

#define kDownRefreshLoading     @"加载中..."

// CommonLibrary中常用的字体
#define kCommonLargeTextFont       [UIFont systemFontOfSize:16]
#define kCommonMiddleTextFont      [UIFont systemFontOfSize:14]
#define kCommonSmallTextFont       [UIFont systemFontOfSize:12]


