//
//  WCAnnouceNet.h
//  WelfareCommunity
//
//  Created by zoulixiang on 16/7/13.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCAnnouceNet : NSObject

//检测版本
- (void)checkVersion;
+ (instancetype)sharedInstance;

@end
