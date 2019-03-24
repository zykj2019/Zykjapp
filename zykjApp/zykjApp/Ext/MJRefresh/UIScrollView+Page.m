//
//  UIScrollView+Page.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/5/26.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "UIScrollView+Page.h"
#import "MJRefresh.h"

static NSString *const kLastObj = @"kLastObj";
static NSString *const kPageSize = @"kPageSize";
static NSString *const kPageNum = @"kPageNum";
static NSString *const kRefreshDatas = @"kRefreshDatas";


@implementation UIScrollView (Page)

- (NSObject *)lastObj {
    NSObject *obj = objc_getAssociatedObject(self, (__bridge const void *)kLastObj);
    return obj;
}

- (void)setLastObj:(NSObject *)obj {
      objc_setAssociatedObject(self, (__bridge const void *)kLastObj, obj, OBJC_ASSOCIATION_RETAIN);
    
}
- (NSInteger)pageSize {
 
    //默认20条
    NSNumber *num = objc_getAssociatedObject(self, (__bridge const void *)kPageSize);
    return num ? [num integerValue] : 20;
   
}

- (void)setPageSize:(NSInteger)pageSize {
     objc_setAssociatedObject(self, (__bridge const void *)kPageSize, @(pageSize), OBJC_ASSOCIATION_RETAIN);
}

- (void)setPageNum:(NSInteger)pageNum {
     objc_setAssociatedObject(self, (__bridge const void *)kPageNum, @(pageNum), OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)pageNum {
    NSNumber *num = objc_getAssociatedObject(self, (__bridge const void *)kPageNum);
    return [num integerValue];
}

- (NSMutableArray *)refreshDatas {
    return objc_getAssociatedObject(self, (__bridge const void *)kRefreshDatas);
}

- (void)setRefreshDatas:(NSMutableArray *)refreshDatas {
     objc_setAssociatedObject(self, (__bridge const void *)kRefreshDatas, refreshDatas, OBJC_ASSOCIATION_RETAIN);
}

- (void)refreshConfig {
    // 隐藏时间
    ((MJRefreshNormalHeader *)(self.mj_header)).lastUpdatedTimeLabel.hidden = YES;
//    ((MJRefreshNormalHeader *)(self.mj_header)).stateLabel.hidden = YES;
    
//    ((MJRefreshAutoNormalFooter *)self.mj_footer).refreshingTitleHidden = YES;
    [self refreshReset];
}

- (void)refreshReset {
    self.lastObj = nil;
    self.pageNum = 1;
    self.pageSize = self.pageSize;
    [self.mj_footer setHidden:YES];
     [self.mj_footer endRefreshingWithNoMoreData];
    self.mj_footer.hidden = YES;

    
}

- (void)hiddenMjAnimating {
      [self.mj_footer endRefreshing];
     [self.mj_header endRefreshing];
    
}
@end
