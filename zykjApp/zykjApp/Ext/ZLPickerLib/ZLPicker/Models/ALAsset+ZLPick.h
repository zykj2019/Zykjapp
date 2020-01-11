//
//  ALAsset+ZLPick.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/5.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAsset (ZLPick)

- (BOOL)isVideo;

- (NSInteger)videoDuration;
@end

