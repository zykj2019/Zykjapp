//
//  UITableView+custom.h
//  zykjApp
//
//  Created by zoulixiang on 2018/4/10.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (custom)

+ (instancetype)customInst;

//右滑的自定义配置 Common
- (NSDictionary *)rightSlideConfig;

- (void)setRightSlideConfig:(NSDictionary *)rightSlideConfig;

@end
