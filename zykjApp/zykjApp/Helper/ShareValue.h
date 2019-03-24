//
//  ShareValue.h
//  WuYe
//
//  Created by zoulixiang on 16/6/23.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ShareValue : NSObject

@property (strong, nonatomic) User *user;

+ (ShareValue *)sharedInstance;

@end
