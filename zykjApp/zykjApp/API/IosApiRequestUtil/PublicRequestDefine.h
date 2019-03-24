//
//  PublicRequestDefine.h
//  SadjAppClient
//
//  Created by huang on 2017/7/3.
//  Copyright © 2017年 huang. All rights reserved.
//

#ifndef PublicRequestDefine_h
#define PublicRequestDefine_h

//#import "UserInfoManager.h"

#define APP_SYSTEM_THIRD_PLATFORM_SHARE_WEIXIN_APPKEY @""
#define APP_SYSTEM_THIRD_PLATFORM_SHARE_WEIXIN_APPSECRET @""
#define APP_SYSTEM_THIRD_PLATFORM_SHARE_WEIXIN_AUTH_SCOPE @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"


/*
 ===============================================================================================
 =========================================APP版本================================================
 ===============================================================================================
 */
#define APP_SYSTEM_APP_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]  //App版本号 （build）

#define APP_SYSTEM_APP_VERSIONSTRING  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  //App版本号String
#define APP_SYSTEM_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]    //ios版本
/*
 ===============================================================================================
 =========================================密匙信息===============================================
 ===============================================================================================
 */
#define APP_ITUNES_APPID @""
//请求编号   用户端 4538567  工作端 9865343
#define APP_SYSTEM_REQUEST_ID @"4538567"
//密码加密密匙
#define APP_SYSTEM_REQUEST_PASSWORD_KEY @"FE605C9343A3A47764598FDC184EC66F"

//MD5加密密钥  用户端：B7302E121B6F4864226D8387A102A489    工作端：9BCEBEBD38A05D98A3D734C3E7625BE6
#define APP_SYSTEM_NETWORK_REQUEST_PHONE_API_KEY @"B7302E121B6F4864226D8387A102A489"
 //AES加密密钥    用户端：E6876647D98615ED662BEF60A26A524D    工作端：BC84008D0717AC87E1F185488513D6BE
#define APP_SYSTEM_NETWORK_REQUEST_AES_KEY @"E6876647D98615ED662BEF60A26A524D"

/*
 ===============================================================================================
 =========================================常量信息===============================================
 ===============================================================================================
 */
//客服电话
#define APP_SYSTEM_CUSTOMER_SERVICE_TEL @""
//用户编号和密码
#define APP_SYSTEM_USER_ID  @"0"// [UserInfoManager getUserID]  //用户编号//用户编号和密码
#define APP_SYSTEM_USER_IMUniqueId @"0" //通讯Id
#define APP_SYSTEM_USER_IMPASSWORD @"0" //通讯密码

#endif /* PublicDefine_h */
