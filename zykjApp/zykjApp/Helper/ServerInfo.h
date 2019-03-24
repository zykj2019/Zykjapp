//
//  ServerInfo.h
//  WuYe
//
//  Created by zoulixiang on 16/6/29.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerInfo : NSObject

+ (ServerInfo *)sharedInstance;

- (NSString *)getImgUrlWithId:(NSString *)fid andModel:(NSString *)model;

@end
