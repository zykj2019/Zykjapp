//
//  UIBarButtonItem+ND.h
//  99JiaJuMarketPlace
//
//  Created by ndcq on 15/5/22.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ND)

/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithIconImg:(UIImage *)icon highIconImg:(UIImage *)highIcon target:(id)target action:(SEL)action;

@end
