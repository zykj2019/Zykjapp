//
//  Common.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/7/19.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "Common.h"

@implementation Common
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.detail = @"";
        self.numberOfLines = 1;
    }
    return self;
}

- (void)dealloc
{
    
}
@end
