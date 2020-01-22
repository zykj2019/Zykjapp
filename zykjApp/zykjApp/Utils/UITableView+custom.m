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

- (void)registerClass:(nullable Class)cellClass {
    NSString *idStr = [self idStrWithClass:cellClass];
    [self registerClass:cellClass forCellReuseIdentifier:idStr];
}

- (CGFloat)fd_heightForCellCacheByIndexPath:(NSIndexPath *)indexPath Class:(nullable Class)cellClass configuration:(void (^)(id cell))configuration {
    if (self.width == 0) {
        return 0;
    }
    
    NSString *idStr = [self idStrWithClass:cellClass];
    if (![self fd_onlyTemplateCellForReuseIdentifier:idStr]) {
        //注册class
        [self registerClass:cellClass];
    }
    return [self fd_heightForCellWithIdentifier:idStr cacheByIndexPath:indexPath configuration:configuration];
}

- (NSString *)idStrWithClass:(nullable Class)cellClass {
    return [NSString stringWithFormat:@"%@_sizing_id",NSStringFromClass(cellClass)];
}


@end
