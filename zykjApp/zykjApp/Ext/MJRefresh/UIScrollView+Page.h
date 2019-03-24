//
//  UIScrollView+Page.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/5/26.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Page)

- (NSObject *)lastObj;

- (void)setLastObj:(NSObject *)obj;

- (NSInteger)pageSize;

- (void)setPageSize:(NSInteger)pageSize;

- (void)setPageNum:(NSInteger)pageNum;

- (NSInteger)pageNum;

- (NSMutableArray *)refreshDatas;

- (void)setRefreshDatas:(NSMutableArray *)refreshDatas;

- (void)refreshConfig;

- (void)refreshReset;

//失败隐藏刷新
- (void)hiddenMjAnimating;

@end
