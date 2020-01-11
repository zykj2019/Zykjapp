//
//  UIFrameworkModel.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/11/7.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "UIFrameworkModel.h"

@implementation RequestPageParamItem

- (instancetype)init
{
    if (self = [super init])
    {
        _pageIndex = 0;
        _pageSize = 20;
        _canLoadMore = YES;
    }
    return self;
}


@end
