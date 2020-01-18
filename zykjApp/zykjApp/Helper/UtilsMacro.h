//
//  UtilsMacro.h
//  项目框架
//
//  Created by Hcat on 14-3-17.
//  Copyright (c) 2014年 Hcat. All rights reserved.
//

/**
 Synthsize a weak or strong reference.
 
 Example:
    @weakify(self)
    [self doSomething^{
        @strongify(self)
        if (!self) return;
        ...
    }];

 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

// 判断是否高清屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(scale)] ? (2 == [[UIScreen mainScreen] scale]) : NO)

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


#define ApplicationDelegate                 ((BaseAppDelegate *)[[UIApplication sharedApplication] delegate])
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

#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsIOS7Later                         !(IOSVersion < 7.0)
#define IsIOS9Later                          !(IOSVersion < 9.0)
#define IsIOS11Later                          !(IOSVersion < 11.0)
#define IsIOS13Later                          !(IOSVersion < 13.0)
#define StatusbarSize ((IOSVersion >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)

#define YOURSYSTEM_OR_LATER(yoursystem) [[[UIDevice currentDevice] systemVersion] compare:(yoursystem)] != NSOrderedAscending


//#define RGB(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//
//#define RGBA(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

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


//主窗口的宽、高
#define kMainScreenWidth  MainScreenWidth()
#define kMainScreenHeight MainScreenHeight()

#define Localized(Str) NSLocalizedString(Str, Str)

//static __inline__ CGFloat MainScreenWidth()
//{
//    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
//}
//
//static __inline__ CGFloat MainScreenHeight()
//{
//    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
//}

//iphonex适配
// UIScreen width.
#define  HT_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  HT_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
#define  HT_iPhoneX (((HT_ScreenWidth == 375.f && HT_ScreenHeight == 812.f) || (HT_ScreenWidth == 414.f && HT_ScreenHeight == 896.f)) ? YES : NO)

// Status bar height.
#define  HT_StatusBarHeight      (HT_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  HT_NavigationBarHeight  44.f

// Tabbar height.
#define  HT_TabbarHeight         (HT_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar height.
#define  HT_TabbarHeight_normal         49.f

// Tabbar safe bottom margin.
#define  HT_TabbarSafeBottomMargin         (HT_iPhoneX ? 34.f : 0.f)

// Tabbar safe top margin.
#define  HT_NavSafeTopMargin         (HT_iPhoneX ? 24.f : 0.f)

// Status bar & navigation bar height.
#define  HT_StatusBarAndNavigationBarHeight  (HT_iPhoneX ? 88.f : 64.f)

#define HT_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define WS(weakSelf)   __weak __typeof(self)weakSelf = self;

#define WVAR(variable,instancetype)   __weak __typeof(instancetype)variable = instancetype;

//基础颜色配置
#define WCBLUE          [UIColor blueColor]
#define WCWHITE         UIColorFromRGB(0xFFFFFF)
#define WCBLACK         UIColorFromRGB(0x353535)
#define WCGRAY          UIColorFromRGB(0x717171)
#define WCRED           UIColorFromRGB(0xf43e34)
#define WCPURPLE        UIColorFromRGB(0x667af8)

//灰色颜色
#define WCGRAYFONT   UIColorFromRGB(0xb2b2b2)
#define WCGRAYDARKFONT   UIColorFromRGB(0x9b9b9b)
#define WCGRAYTHINFONT   UIColorFromRGB(0xcbcbcb)

// 默认界面之间的间距
#define kDefaultMargin     8

//字体比例
#define kScale ((ScreenWidth > 375) ? 1 : ScreenWidth/375)
#define SizeScale kScale


#define degreeToRadians(x) (M_PI *(x)/180.0)

#define empty_array         [NSArray array]


//
//  ServerInfoHeader.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/5/26.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#ifndef ServerInfoHeader_h
#define ServerInfoHeader_h

/*
 1、所有的负数和1开头的代码直接返回网络异常
 2、所有2开头的代码做逻辑判断（主观选择是否弹出提示）
 3、所有3开头的直接显示给用户看
 
 **/
/*
 注意当产生新的2开头的code需要在
 +(NSURLSessionDataTask *)sendRestRequest:(BaseRestRequest *)request apiPath:(NSString *)apiPath success:(SuccBlock)success fail:(FailBlock)fail class:(Class)resultClass method:(NSString *)method 加入对应的code
 **/
typedef  enum : NSInteger {
    CODETYPE_FAIL  = 0, //负数和1
    CODETYPE_NORMAL, //正常 0
    CODETYPE_LOGIC, //2开头
    CODETYPE_SHOW,  //3开头
}CODETYPE;


#define Appconfig        ((AppConfig *)[IMichUtil shareInstance].appConfig)
#define emptyImgTop             5.0
#define emptyLblBottom          25.0

#define Page_Size                20

//录音
//最大录制时间
#define Pro_Audio_Max_Time  300
//录音格式
#define Pro_Audio_File_Format  @"wav"


// 默认的字体颜色

#define BaesFont(sizes) (UIFont *)[Appconfig baseFont:sizes]

#define BaesFontLight(sizes)   (UIFont *)[Appconfig baseFontLight:sizes]

#define BaesFontMedium(sizes)   (UIFont *)[Appconfig baseFontMedium:sizes]


#define kAppThemeHex                Appconfig.appThemeHex         //16进制颜色
#define kAppThemeColor              UIColorFromRGB(kAppThemeHex)
#define kMainTextColor              kAppThemeColor
#define kHighlightedColor           UIColorFromRGB(0xf3f3f3)

#define WCVIEWCOLOR   UIColorFromRGB(0xF0F0F0)
#define kAppBakgroundColor        WCVIEWCOLOR
#define WCTABLEVIEWCOLOR  WCVIEWCOLOR
#define WCLINECOLOR    RGB(228, 228, 228)
#define WCLINECOLOR1   RGBA(219, 219, 219, 1.0)
#define WCLINECOLOR2   RGBA(210, 210, 210, 1.0)

//导航栏颜色
#define kNavColor                   RGB(251, 251, 251)
#define kAppModalBackgroundColor    [kBlackColor colorWithAlphaComponent:0.6]
#define kAppModalDimbackgroundColor [RGB(16, 16, 16) colorWithAlphaComponent:0.3]

// 主色调
// 导航按钮
#define kNavBarThemeColor             RGB(128, 64, 122)
#define kNavBarHighlightThemeColor    RGB(161, 92, 154)

#define kNavImg                 [UIImage imageWithColor:kNavColor]

//占位图片
#define kDefaultPicColor           RGB(200, 200, 200)
#define kIconHeaderImg          [Appconfig defaultHeaderImg]
#define kIconPicImg             [Appconfig defaultPicImg]

//返回图标
#define kIconRetun              [Appconfig iconRetunImg]
#define kIconRetun_High         [Appconfig iconRetunHighImg]

//View
//通用全局间距
#define View_margin                   [Appconfig viewMargin]
#define View_obj_margin              [Appconfig viewObjMargin]

#define BottomLineWidth         [Appconfig bottomLineWidth]
#define BottomLineHeight        [Appconfig bottomLineHeight]


#define WCS(key)                      NSLocalizedStringFromTable(key,NSStringFromClass([self class]), nil)


#endif /* ServerInfoHeader_h */

