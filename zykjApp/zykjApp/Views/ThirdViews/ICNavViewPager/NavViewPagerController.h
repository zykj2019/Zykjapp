//
//  NavViewPagerController.h
//  ICNavViewPager
//
//  Created by zoulixiang on 16/6/30.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavViewPagerController : UIViewController

@property (nonatomic, strong) NSArray *vcArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (strong, nonatomic) UIColor *textColor;
@property (assign, nonatomic) NSInteger defaultIndex;
@end
