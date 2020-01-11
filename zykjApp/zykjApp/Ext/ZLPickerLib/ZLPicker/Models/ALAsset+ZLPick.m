//
//  ALAsset+ZLPick.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/5.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import "ALAsset+ZLPick.h"

@implementation ALAsset (ZLPick)

- (BOOL)isVideo {
    return ![[self valueForProperty:ALAssetPropertyDuration] isKindOfClass:[NSString class]];
}

- (NSInteger)videoDuration {
    if ([self isVideo]) {
        NSString *time = [NSString stringWithFormat:@"%@",[self valueForProperty:ALAssetPropertyDuration]];
        return ceilf([time floatValue]);
    }
    return 0;
}
@end
