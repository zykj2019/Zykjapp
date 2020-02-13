//
//  AppConfig.h
//  zykjApp
//
//  Created by zoulixiang on 2020/1/13.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppConfig : NSObject

//ios9以后主要的字体
@property (copy, nonatomic) NSString *iOS9LaterBaseFontName;

//ios9以后主要Light的字体
@property (copy, nonatomic) NSString *iOS9LaterBaseFontLightName;

//ios9以后主要Medium的字体
@property (copy, nonatomic) NSString *iOS9LaterBaseFontMediumName;

//view的基础颜色
@property (strong, nonatomic) UIColor *baseViewColor;

//app主题16进制颜色
@property (assign, nonatomic) NSUInteger appThemeHex;

//默认头像图片
@property (strong, nonatomic) UIImage *defaultHeaderImg;

//默认pic图片
@property (strong, nonatomic) UIImage *defaultPicImg;

//nav返回图标图片
@property (strong, nonatomic) UIImage *iconRetunImg;

//nav返回图标高亮图片
@property (strong, nonatomic) UIImage *iconRetunHighImg;

//nav返回按钮frame
@property (assign, nonatomic) CGRect navBackFrame;

//app 通用左右间距
@property (assign, nonatomic) CGFloat viewMargin;

//app 通用view与view之间间距
@property (assign, nonatomic) CGFloat viewObjMargin;

//app 间隔线宽
@property (assign, nonatomic) CGFloat bottomLineWidth;

//app 间隔线高
@property (assign, nonatomic) CGFloat bottomLineHeight;

//app 视频录制或转码bitsPerPixel
@property (assign, nonatomic) CGFloat bitsPerPixel;

//app 视频录制或转码的宽度
@property (assign, nonatomic) CGFloat videoWidth;

//app 视频录制或转码的高度
@property (assign, nonatomic) CGFloat videoHeight;

//app 视频录制或转码的最大时间
@property (assign, nonatomic) CGFloat videoMaxTime;

//app 视频录制或转码的最小时间
@property (assign, nonatomic) CGFloat videoMinTime;

// 支持哪些屏幕方向
@property (assign, nonatomic) UIInterfaceOrientationMask supportedInterfaceOrientations;

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
@property (assign, nonatomic) UIInterfaceOrientation preferredInterfaceOrientationForPresentation;

- (UIFont *)baseFont:(CGFloat)size;

- (UIFont *)baseFontLight:(CGFloat)size;

- (UIFont *)baseFontMedium:(CGFloat)size;

@end

