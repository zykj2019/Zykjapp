//
//  ServerInfo.m
//  WuYe
//
//  Created by zoulixiang on 16/6/29.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "ServerInfo.h"

static ServerInfo *_shareValue;

@implementation ServerInfo


+ (ServerInfo *)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareValue = [[ServerInfo alloc] init];
    });
    return _shareValue;
}

- (NSString *)getImgUrlWithId:(NSString *)fid andModel:(NSString *)model {
	
    return [NSString stringWithFormat:@"%@%@/%@.jpg",BASE_IMAGE_HOST,model,fid];
}
@end
