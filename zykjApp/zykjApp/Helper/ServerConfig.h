//
//  ServerConfig.h
//  SuperMama
//
//  Created by macbook on 15/7/8.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求方式
#define HTTP_METHOD_GET   @"GET"
#define HTTP_METHOD_POST  @"POST"

/*
 * 用户相关
 */
#define URLPATH_USER_LOGINFORTHIRD        @"loginForThird"         // 用第三方登陆
#define URLPATH_USER_SENDVERFICODE        @"sendVerifyCodeSms"     // 发送注册验证码短信
#define URLPATH_USER_LOGINBYPHONENUMBER   @"loginByPhoneNumber"    // 登录（使用手机号）
#define URLPATH_USER_LOGINBYPASSWORD      @"loginByPassword"       // 登录（使用密码）
#define URLPATH_USER_UPDATE_PASSWORD      @"updatePassword"        // 更新密码
#define URLPATH_USER_REGISTER             @"register"              // 注册用户
#define URLPATH_USER_UPDATE_USER_INFO     @"updateUserInfo"        // 更新用户信息
#define URLPATH_USER_GETUSERINFOBYTHIRDID @"getUserInfoByThirdId"  // 通过第三方平台id获取用户信息
#define URLPATH_USER_GETUSERINFOBYID      @"getUserInfo"           // 获取单个用户信息接口

/*
 * 记录相关
 */
#define URLPATH_UPLOAD_RECORD            @"uploadRecord"     // 上传记录
#define URLPATH_RECORD_GETMYRECORDSANDWORTHSTATISTICS  @"getMyRecordsAndWorthStatistics"   //获取我的记录首页内容
#define URLPATH_RECORD_FIND              @"findRecords"      // 查询记录列表
#define URLPATH_RECORD_GET_DETAIL        @"getRecordDetails" // 查询记录详细信息
#define URLPATH_RECORD_GET_WORK_WORTH_STATISTICS        @"getWorkWorthStatistics" // 获取工作价值统计
#define URLPATH_RECORD_DELETERECORD      @"deleteRecord"     // 删除记录
#define URLPATH_RECORD_REPORT            @"reportRecord"     // 举报记录

#define URLPATH_RECORD_CALCULATE_SELL_PRICE @"calculateSellPrice"  // 计算价格

/*
 * 订单相关
 */
#define URLPATH_ORDER_CREATE                                 @"createOrder"     // 创建订单
#define URLPATH_ORDER_FIND_BY_CREATORID                      @"findOrdersByCreatorId"     // 创建订单
#define URLPATH_ORDER_FIND_BY_RECEPTERID                     @"findOrdersByRecepterId"     // 创建订单
#define URLPATH_ORDER_CANCEL                                 @"cancelOrder"     // 取消订单
#define URLPATH_ORDER_COMPLETE                               @"completeOrder"     // 取消订单
#define URLPATH_ORDER_BUYER_DELETE                           @"buyerDeleteOrder"     // 买家删除订单
#define URLPATH_ORDER_SELLER_DELETE                          @"sellerDeleteOrder"     // 卖家删除订单
#define URLPATH_ORDER_DELIVER                                @"deliverOrder"   // 设置订单为已发货/可取货


/*
 * 分类相关
 */
#define URLPATH_ORDER_GET_DEFAULT_CLASSIFICATIONS            @"getDefaultClassifications" // 获取默认分类信息

/*
 * 问题相关
 */

#define URLPATH_ADD_TROUBLE                                 @"addTrouble"     // 添加遇到的问题

/*
 * 交易相关
 */
#define URLPATH_PAY_GET_CHARGE            @"getCharge"     // 获取交易信息

/*
 * 打赏相关
 */
#define URLPATH_PAY_GET_REWARDCHARGE     @"getRewardCharge" //打赏

/*
 * 图片相关
 */
#define URLPATH_PHOTO_UPLOAD_USER_IMAGE   @"uploadHeaderImage"     // 上传头像

/*
 * 评论相关
 */
#define URLPATH_COMMENT_CANCEL_COMMENT   @"cancelComment"     // 删除评论
#define URLPATH_COMMENT_GET_RECORD_COMMENT   @"getRecordComments"     // 获取记录的评论
#define URLPATH_COMMENT_UPLOAD_RECORD_COMMENT   @"uploadRecordComment"     // 获取记录的评论

/*
 * 小区相关
 */
#define URLPATH_COMMUNITY_ADD_NEW   @"addNewCommunity"     // 添加新小区
#define URLPATH_COMMUNITY_CREATECOMMUNITYCHATGROUP   @"createCommunityChatGroup"     // 创建小区聊天群
#define URLPATH_COMMUNITY_UPDATE_COMMUNITY_ANNOUNCEMENT  @"updateCommunityAnnouncement"     // 修改小区公告
#define URLPATH_COMMUNITY_GET_COMMUNITYINFO  @"getCommunityInfo"     // 获取小区信息
#define URLPATH_COMMUNITY_FIND_COMMUNITY_BY_LOCATION  @"findCommunityByLocation"     // 根据具体位置信息查找小区
#define URLPATH_COMMUNITY_SEARCH_COMMUNITY  @"searchCommunity"     // 查找小区
#define URLPATH_COMMUNITY_ADD_USER_TO_COMMUNITY @"addUserToCommunity"     // 添加用户到小区
#define URLPATH_COMMUNITY_EXIT_COMMUNITY @"exitCommunity"     // 添加用户到小区
#define URLPATH_COMMUNITY_FIND_USERS_OF_COMMUNITY @"findUsersOfCommunity"     // 获取小区用户列表信息

/*
 * 行为相关
 */
#define URLPATH_ACTION_CANCEL_RECORD_FAVOUR   @"cancelRecordFavour"     // 取消点赞
#define URLPATH_ACTION_DO_COLLORECORD   @"doCollorecord"                // 收藏记录
#define URLPATH_ACTION_DO_RECORD_FAVOUR   @"doRecordFavour"             // 给记录点赞

/*
 * Feed相关
 */
#define URLPATH_FEED_FIND_USER_BUY_FEEDS   @"findUserBuyFeeds"     // 查询用户订购动态消息
#define URLPATH_FEED_FIND_USER_FAVORECORD_FEEDS  @"findUserFavorecordFeeds"     // 查询用户点赞动态消息
#define URLPATH_FEED_FIND_USER_COMMENT_FEEDS  @"findUserCommentFeeds"     // 查询用户评论动态消息
#define URLPATH_FEED_FIND_CHILD_FEEDS  @"findChildFeeds"       // 查询儿童监督动态消息
#define URLPATH_FEED_FIND_COMMON_FEEDS  @"findCommonFeeds"     // 查询通用动态消息

/*
 * Common相关
 */
#define URLPATH_GET_FOUND_DATA   @"getFoundData"                   // 获取发现界面数据

/*
 ** 优惠券相关
 */
#define URLPATH_FIND_USER_AVAILABLE_COUPONS   @"findUserAvailableCoupons"     // 查询我的优惠券 列表
#define URLPATH_FIND_USER_UNUSED_COUPONS      @"findUserUnusedCoupons"        // 查询领取优惠券 列表
#define URLPATH_TAKE_COUPON                   @"takeCoupon"                   // 领取优惠
#define URLPATH_GET_RECORD_UNABLE_COUPONS     @"getRecordUsableCoupon"        // 获取用户在某条记录上可用的优惠券

/*
 ** 托管相关
 */
#define URLPATH_GET_CHILD_OF_USER                 @"getChildOfUser"                  // 妈妈用户查询我的孩子信息
#define URLPATH_GET_CHILD                         @"getChild"                        // 根据ID查询孩子信息
#define URLPATH_SIGH_CHILD                        @"signChild"                       // 儿童签到
#define URLPATH_SIGNOUT_CHILD                     @"signoutChild"                    // 儿童签退
#define URLPATH_UPLOAD_CHILD_CARE_APPLICATION     @"uploadChildCareApplication"      // 申请儿童托管
#define URLPATH_CHILD_GETCHILDRENOFTEACHER        @"getChildrenOfTeacher"            // 查询老师负责的学生
#define URLPATH_CHILD_GETATTENDANCECHILDIDLISTOFTEACHER   @"getAttendanceChildIdListOfTeacher"            // 获取有签到的儿童ID列表

/*
 ** 横幅相关
 */
#define URLPATH_GET_BANNERS                       @"getBanners"                      // 横幅查询

/*
 ** 老师相关
 */
#define URLPATH_GET_CENTRE_TEACHERS               @"getCentreTeachers"               // 获取教师列表
#define URLPATH_GET_LINK_MAN                      @"getLinkman"                      // 获取教师列表

/*
 ** 请假相关
 */
#define URLPATH_GET_CHILD_LEAVES                  @"getChildLeaves"                  // 获取孩子对应的所有请假条
#define URLPATH_UPLOAD_LEAVE                      @"uploadLeave"                     // 上传请假条

/*
 ** 老师提醒相关
 */
#define URLPATH_UPLOAD_TEACHER_WARM               @"uploadTeacherWarm"               // 上传提醒老师记录
#define URLPATH_GET_CHILD_WARMS                   @"getChildWarms"                   // 获取孩子对应的所有提醒老师记录
#define URLPATH_GET_CENTRE_WARMS                   @"getCentreWarms"                 // 获取托管中心对应的所有提醒老师记录

// 测试环境:
#define BASE_HOST               "dev-ip.thedeer.cn"
#define BASE_PORT               @":89"
#define BASE_API_HOST_DOMAIN    ([[IMichUtil shareInstance] getBaseAppHostIP])
#define BASE_API_HOST           ([[IMichUtil shareInstance] getBaseAppHostIP])
#define BASE_FIXED_MIDDLE       @"/zykj-api/userapp/"
//#define BASE_API_HOST_DOMAIN    @"http://test.api.mama.imich.cn:8080/s1/"
//#define BASE_API_HOST           ([[IMichUtil shareInstance] getBaseAppHostIP])
#define BASE_IMAGE_HOST         @"http://test.image.mama.devstudio.cn"
#define APP_KEY                 @"a6cfa19a-ba0f-7f54-27b6-f73baeb48d5b"
#define APP_SECRET              @"1598fe33-7848-a4de-f2e8-437956d1cccc"

// 正式环境:
//#define BASE_HOST               "api.mama.imich.cn"
//#define BASE_PORT               @""
////#define BASE_HOST               "41.devstudio.cn"
////#define BASE_PORT               @":8080"
//#define BASE_API_HOST_DOMAIN    ([[IMichUtil shareInstance] getBaseAppHostIP])
//#define BASE_API_HOST           ([[IMichUtil shareInstance] getBaseAppHostIP])
//#define BASE_FIXED_MIDDLE       @"/test/uschool/service/"
////#define BASE_API_HOST_DOMAIN    @"http://api.mama.imich.cn/s1/"
////#define BASE_API_HOST           ([[IMichUtil shareInstance] getBaseAppHostIP])
//#define BASE_IMAGE_HOST         @"http://image.mama.devstudio.cn"
//#define APP_KEY                 @"66cc7301-ccb5-d9d6-9cb2-82d873ec7b67"
//#define APP_SECRET              @"5026f646-528e-90c4-295c-155b60e95ffe"

// ----------图片配置常量开始----------
// 头像
#define HEADER_SIZE_SMALL        @"@72w_72h_100Q.jpg"
#define HEADER_SIZE_MEDIUM       @"@96w_96h_100Q.jpg"
#define HEADER_SIZE_LARGE        @"@144w_144h_100Q.jpg"

// 图片
#define IMAGE_SIZE_SMALL        @"@144w_144h_100Q.jpg"
#define IMAGE_SIZE_MEDIUM       @"@300w_300h_100Q.jpg"
#define IMAGE_SIZE_LARGE        @"@800w_800h_100Q.jpg"

#define PHOTO_DEFAULT           [UIImage imageNamed:@"photoDefault"]

// ----------图片配置常量结束----------

//拼接APIUrl
#define CREATE_API_URL(base,model) [[NSString alloc] initWithFormat:@"%@%@%@",base,model,@"/"]
//拼接ImageUrl
#define CREATE_IMAGE_URL(width,heigh) [[NSString alloc] initWithFormat:@"@%dw_%dh_100Q.jpg",width,heigh]

#define MAX_IMAGE_COUNT   9
#define MAX_LONG_TIME     9223372036854775807
#define NAV_CTRL_COLOR    RGB(255.0, 255.0, 255.0)
//#define NAV_CTRL_COLOR    RGB(248.0, 109.0, 143.0)


