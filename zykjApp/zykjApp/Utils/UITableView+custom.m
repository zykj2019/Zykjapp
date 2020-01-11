//
//  UITableView+custom.m
//  zykjApp
//
//  Created by zoulixiang on 2018/4/10.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "UITableView+custom.h"

static NSString *const krightSlideConfig = @"krightSlideConfig";

@implementation UITableView (custom)

+ (instancetype)customInst {
    
    UITableView *tableView = [[self.class alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = WCTABLEVIEWCOLOR;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    return tableView;
}

- (NSDictionary *)rightSlideConfig {
      return objc_getAssociatedObject(self, (__bridge const void *)krightSlideConfig);
}

- (void)setRightSlideConfig:(NSDictionary *)rightSlideConfig {
     objc_setAssociatedObject(self, (__bridge const void *)krightSlideConfig, rightSlideConfig, OBJC_ASSOCIATION_RETAIN);
}


@end
