//
//  IMichUtil.h
//  MeiQuan
//
//  Created by air on 15/4/22.
//  Copyright (c) 2015年 ilikeido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SECS_OF_ONE_DAY    (24 * 60 * 60)  // 一天
#define SECS_OF_ONE_HOUR   (60 * 60)       // 一小时
#define SECS_OF_ONE_MIN    60              // 一分钟
#define MSECS_OF_ONE_SEC   1000            // 一秒毫秒数

@interface IMichUtil : NSObject

+ (IMichUtil *)shareInstance;

// 时间戳转日期时间
+ (NSString *)convertDateStrFromDigt:(unsigned long long)dateTime;

// 时间戳转日期时间
+ (NSString *)convert2Date:(unsigned long long)dateTime;

// 时间戳转日期
+ (NSString *)longTime2Date:(unsigned long long)longTime;

// 时间戳转日期
+ (NSString *)longTimeToDate:(unsigned long long)longTime type:(NSInteger)type;

// 获取当前时间戳
+ (unsigned long long)getCurTimeStamp;

// 获取当前时间
+ (NSString *)getCurDate;

// 计算文本高度
+ (CGFloat)calcLabelHeight:(NSString *)strText fontSize:(NSInteger)fontSize width:(CGFloat)width;

// 计算文本宽度
+ (CGFloat)calcLabelWidth:(NSString *)strText fontSize:(NSInteger)fontSize height:(CGFloat)height;



+ (NSArray *)getArrayFromJsonString:(NSString *)jsonString fail:(void (^)(NSString *description))fail;

+ (NSArray *)convertArrayDict2Obj:(NSArray *)array class:(Class)resultClass;


+ (NSString *)convertArray2JsonStr:(NSArray *)array;
// 转化结果集 为列表
+ (NSArray *)parseResultToArray:(NSDictionary *)resultDict withKey:(NSString *)key;


+ (NSDictionary*)getObjectData:(id)obj;

+ (id)getObjectInternal:(id)obj;

+ (NSURL *)applicationDocumentsDirectory;

+ (NSString *)applicationDocumentsDirectoryPath;

+ (NSInteger)calcCollectionCellRows:(NSInteger)count;

+ (NSString *)cutStr:(NSString *)str;

+ (void)logFrame:(CGRect)frame;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;

- (NSString *)getBaseAppHostIP;

+ (void)printException:(NSException*)exception;

+ (NSString *)getUUIDFromUrl:(NSString *)url;

// 金额校验
+ (BOOL)checkMoneyString:(NSString *)moneyStr range:(NSRange)range replacementString:(NSString *)string;

//字典数组转模型数组
+ (NSMutableArray *)getArrayWithArray:(NSArray *)dataArray andClass:(Class)clazz;

+(NSString *)convertArrayToString:(NSArray *)array;

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (NSInteger)lineWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

@end
