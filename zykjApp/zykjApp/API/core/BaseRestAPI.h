//
//  BaseRestAPI.h
//  AFNetwork
//
//  Created by zoulixiang on 2016/11/14.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpEncryptTool.h"
/*
 1、所有的负数和1开头的代码直接返回网络异常
 2、所有2开头的代码做逻辑判断（主观选择是否弹出提示）
 3、所有3开头的直接显示给用户看

 **/
typedef  enum : NSInteger {
    CODETYPE_FAIL  = 0, //负数和1
    CODETYPE_NORMAL, //正常 0
    CODETYPE_LOGIC, //2开头
    CODETYPE_SHOW,  //3开头
}CODETYPE;
typedef void (^SuccBlock)(NSObject *result, CODETYPE codeType ,NSString *info,NSString *code);
typedef void (^FailBlock)(NSString *description,CODETYPE codeType,NSString *code);

//code类型
@interface NSString (CODETYPE)
-(CODETYPE)conveCodeToEnumcode;
@end
@interface WCPageParams : NSObject

@property (assign, nonatomic) int pi;                   //页码，从1开始
@property (assign, nonatomic) int ps;                   //每页条数

@end

@interface BaseRestHeader : NSObject

@property(nonatomic,strong) NSString *ud;
@property(nonatomic,strong) NSString *client;
@property(nonatomic,strong) NSString *vcode;
@property(nonatomic,strong) NSString *vname;
@property(nonatomic,strong) NSString *abi;
@property(nonatomic,strong) NSString *density;
@property(nonatomic,strong) NSString *firmware;
@property(nonatomic,strong) NSString *imei;
@property(nonatomic,strong) NSString *model;
@property(nonatomic,strong) NSString *resolution;
@property(nonatomic,strong) NSString *sdk;
@property(nonatomic,strong) NSString *screenwidth;
@property(nonatomic,strong) NSString *screenheight;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *auth;
@property(nonatomic,strong) NSString *ak;
@property (strong, nonatomic) NSString *sessionId;
@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *clientMark;

@end

@interface BaseRestRequest : NSObject

@property(nonatomic,strong) BaseRestHeader *header;
@property(nonatomic,strong) NSObject *params;

@end

@interface BaseRestResponse : NSObject

@property(nonatomic,copy) NSString * error_code;


@property(nonatomic,strong) NSDictionary *data;

@property (copy, nonatomic) NSString *message;

@property (assign, nonatomic) CODETYPE codeType;


@end

@interface BaseRestAPI : NSObject

+(void)requestParams:(NSObject *)params apiPath:(NSString *)apiPath success:(SuccBlock)success fail:(FailBlock)fail class:(Class)resultClass;


+(void)getRequestParams:(NSObject *)params  apiPath:(NSString *)apiPath success:(SuccBlock)success fail:(FailBlock)fail class:(Class)resultClass;

@end
