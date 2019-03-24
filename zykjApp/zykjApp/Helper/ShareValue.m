//
//  ShareValue.m
//  WuYe
//
//  Created by zoulixiang on 16/6/23.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "ShareValue.h"

static ShareValue *_shareValue;

@implementation ShareValue

+ (ShareValue *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareValue = [[ShareValue alloc] init];
    });
    return _shareValue;
}

@end
