//
//  NavigationViewController.h
//
//
//  Created by Alexi on 13-7-3.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController


@property (nonatomic, assign) BOOL asChild;

@property (nonatomic, assign) CGSize childSize;

//- (void)setNavigationBarAppearance;

//导航栏底部1px的线条
@property (strong, nonatomic) UIView *navBottomLine;

- (void)layoutSubviewsFrame;

@end
