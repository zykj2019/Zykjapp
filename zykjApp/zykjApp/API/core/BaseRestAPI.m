//
//  BaseRestAPI.m
//  AFNetwork
//
//  Created by zoulixiang on 2016/11/14.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "BaseRestAPI.h"
#import "AFNetworking.h"
#import "LK_NSDictionary2Object.h"
#import "ServerConfig.h"
#import "FCUUID.h"
#import "Auth.h"
#import "IMichUtil.h"
#import "DES3Util.h"
#import "YYKit.h"
@implementation NSString (CODETYPE)
-(CODETYPE)conveCodeToEnumcode {
    NSRange range;
    if ([self isEqualToString:@"0"]) {
        return CODETYPE_NORMAL;
    }
    //如果以-开头
    range = [self rangeOfString:@"^-" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return CODETYPE_FAIL;
    }
    //如果以1开头
     range = [self rangeOfString:@"^1" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return CODETYPE_FAIL;
    }
    
    //如果以2开头
    range = [self rangeOfString:@"^2" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return CODETYPE_LOGIC;
    }
    
    //如果以3开头
    range = [self rangeOfString:@"^3" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return CODETYPE_SHOW;
    }
    
    return CODETYPE_FAIL;
}
@end
@implementation WCPageParams

@end

@implementation BaseRestHeader

-(id)init{
    self = [super init];
    if (self) {
        // 加密数据
        Auth *mAuth = [[Auth alloc]init];
        mAuth.authId = [FCUUID uuid];
        mAuth.appKey = APP_KEY;
        NSDictionary *dic = [IMichUtil getObjectData:mAuth];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        self.auth = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        self.auth = [DES3Util encrypt:APP_SECRET input:self.auth];
        //NSLog(@"auth:%@",self.auth);
        
        // 应用key
       // self.ak = APP_KEY;
        
        // 用户id
        self.ud = [ShareValue sharedInstance].user.uuid;
        
        // 终端类型
        self.client = @"1010";
        
        // 版本名
        self.vname = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
        
        // cpu架构
        self.abi = @"arm-apple";
        
        // 屏幕密度
        self.density = @"0.0";
        
        // 手机类型
        self.firmware = [[UIDevice currentDevice] systemName];
        
        // imei
        self.imei =  [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        // 固件类型
        self.model = [[UIDevice currentDevice] model];
        
        // 分辨率
        self.resolution = [[NSString alloc]initWithFormat:@"%fx%f",ScreenWidth, ScreenHeight];
        
        // sdk版本号
        self.sdk = [[UIDevice currentDevice] systemVersion]; ;
        
        // 屏幕宽度
        self.screenwidth = [[NSString alloc]initWithFormat:@"%f",ScreenWidth];
        
        // 屏幕高度
        self.screenheight = [[NSString alloc]initWithFormat:@"%f",ScreenHeight];
        
        // 请求时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY－MM－dd，HH-mm-ss"];
        self.time =[dateformatter stringFromDate:senddate];
        
        self.clientMark = @"2";
    }
    return self;
}

@end

@implementation BaseRestRequest

-(id)init{
    self = [super init];
    if (self) {
//        self.header = [[BaseRestHeader alloc]init];
         self.header = nil;
    }
    return self;
}

@end

@interface BaseRestResponse ()

@end
@implementation BaseRestResponse
-(void)setError_code:(NSString *)error_code {
    _error_code = error_code;
    _codeType =[_error_code conveCodeToEnumcode];
}
@end

@implementation BaseRestAPI

+(void)sendRestRequest:(BaseRestRequest *)request apiPath:(NSString *)apiPath success:(SuccBlock)success fail:(FailBlock)fail class:(Class)resultClass method:(NSString *)method {
    
    if (!resultClass) {
        resultClass = [NSObject class];
    }
    
    NSObject *object = request.params;
    NSDictionary *paramsDict;
    if (object == nil)
    {
        paramsDict = nil;
    }
    else
    {
//        paramsDict = object.lkDictionary;
        paramsDict = [object yy_modelToJSONObject];
    }
    
    NSDictionary *requestBody= [HttpEncryptTool encodingJsonNetworkDataWithFunction:apiPath
                                                                       token:nil
                                                                   inputData:paramsDict
                                                                      expand:nil
                                                                   timestamp:[NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
  NSString *requestUrl = BASE_API_HOST_DOMAIN;

    NSDictionary *headersDict = request.header.yy_modelToJSONObject;
    
    if(headersDict) {
        for (NSString *key in headersDict.allKeys) {
            NSString *value = [headersDict objectForKey:key];
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
 
        manager.requestSerializer.timeoutInterval = 40;
         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
        //https
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;

        
        if ([method isEqual:@"GET"]) {
            [manager GET:requestUrl parameters:requestBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                
                if (responseObject) {
//
                    BaseRestResponse *response = [BaseRestResponse yy_modelWithJSON:responseObject];
                    if (response.codeType == CODETYPE_NORMAL) {
                        success(responseObject,response.codeType,response.message,response.error_code);
                    } else if(response.codeType == CODETYPE_SHOW){
                         success(responseObject,response.codeType,response.message,response.error_code);
                    } else if (response.codeType == CODETYPE_FAIL) {
                        fail(@"网络异常",CODETYPE_FAIL,response.error_code);
                    }
                    
                }else{
                    fail(@"服务器异常",CODETYPE_FAIL,@"-1");
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 fail(error.localizedDescription,CODETYPE_FAIL,@"-1");
            }];
        } else {
           [manager POST:requestUrl parameters:requestBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@",responseObject);
               
               if (responseObject) {
                   BaseRestResponse *response = [BaseRestResponse yy_modelWithJSON:responseObject];
                   if (response.codeType == CODETYPE_NORMAL) {
                     success(responseObject,response.codeType,response.message,response.error_code);
                   } else if(response.codeType == CODETYPE_SHOW){
                      success(responseObject,response.codeType,response.message,response.error_code);
                   } else if (response.codeType == CODETYPE_FAIL) {
                       fail(@"网络异常",CODETYPE_FAIL,response.error_code);
                   }
                   
               }else{
                   fail(@"服务器异常",CODETYPE_FAIL,@"-1");
               }

           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSLog(@"%@",error.localizedDescription);
                fail(error.localizedDescription,CODETYPE_FAIL,@"-1");
           }];
        }
    
}



+(void)requestParams:(NSObject *)params apiPath:(NSString *)apiPath success:(SuccBlock)success fail:(FailBlock)fail class:(Class)resultClass {
    BaseRestRequest *request = [[BaseRestRequest alloc] init];
    request.params = params;
    
    
    [self sendRestRequest:request apiPath:apiPath success:^(NSObject *result, CODETYPE codeType, NSString *info, NSString *code) {
         success(result,codeType,info,code);
    } fail:^(NSString *description, CODETYPE codeType, NSString *code) {
         fail(description,codeType,code);
    } class:resultClass method:@"POST"];
}

+(void)getRequestParams:(NSObject *)params  apiPath:(NSString *)apiPath success:(SuccBlock)success fail:(FailBlock)fail class:(Class)resultClass {
    
    BaseRestRequest *request = [[BaseRestRequest alloc]init];
    request.params = params;
    
    
    [self sendRestRequest:request apiPath:apiPath success:^(NSObject *result, CODETYPE codeType, NSString *info, NSString *code) {
          success(result,codeType,info,code);
    } fail:^(NSString *description, CODETYPE codeType, NSString *code) {
        fail(description,codeType,code);
    } class:resultClass method:@"GET"];

}

@end
