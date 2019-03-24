//
//  User.h
//  WuYe
//
//  Created by zoulixiang on 16/6/23.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (copy, nonatomic) NSString *uuid;                 // 全局唯一标识
@property (copy, nonatomic) NSString *name;                 // 用户名
@property (copy, nonatomic) NSString *tenementId;               //物业的id
@property (assign, nonatomic) unsigned long long createTime;    //创建时间
@property (copy, nonatomic) NSString *arch ;                   //户主
@property (copy, nonatomic) NSString *doorplate;               //门牌号
@property (assign, nonatomic) unsigned long long area;               //面积
@property (assign, nonatomic) unsigned long long propertyfee;               //物业费










@end
