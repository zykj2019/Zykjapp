//
//  CustomNav.h
//  CustomNav
//
//  Created by zoulixiang on 2018/7/22.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWRDefaultTitleSize 18
#define kWRDefaultTitleColor [UIColor blackColor]
#define kWRDefaultBackgroundColor [UIColor whiteColor]
#define kWRScreenWidth [UIScreen mainScreen].bounds.size.width
#define kWRLeft  HT_iPhoneX ? 20.0 : 16.0
#define kWRRight  HT_iPhoneX ? 20.0 : 16.0
#define objMargin 14.0
@interface CustomNav : UIView

@property (strong, nonatomic) UIView *leftView;

@property (strong, nonatomic) UIView *middleView;

@property (strong, nonatomic) UIView *rightView;

@property (strong, nonatomic) NSArray *leftBarButtonItems;

@property (strong, nonatomic) NSArray *rightBarButtonItems;

@property (strong, nonatomic) UIView *titleView;

+ (int)navBarBottom;

//子view透明度
- (void)elementViewAlpha:(CGFloat)alpha;
@end
