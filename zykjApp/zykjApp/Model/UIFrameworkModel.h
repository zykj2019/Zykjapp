//
//  UIFrameworkModel.h
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/11/7.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestPageParamItem : NSObject

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) BOOL canLoadMore;

@end

