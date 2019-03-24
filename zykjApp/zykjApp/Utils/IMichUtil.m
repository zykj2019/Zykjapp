//
//  IMichUtil.m
//  MeiQuan
//
//  Created by air on 15/4/22.
//  Copyright (c) 2015年 ilikeido. All rights reserved.
//

#import "IMichUtil.h"
#import "UIImage+External.h"
#import "LK_NSDictionary2Object.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <netdb.h>
#include <arpa/inet.h>
#import <objc/runtime.h>
#import "ServerConfig.h"

#define DotNumbers       @"0123456789.\n"
#define Numbers          @"0123456789\n"


@interface IMichUtil()

@property (nonatomic, strong) NSString *baseAppHost;

@end



@implementation IMichUtil

+ (IMichUtil *)shareInstance
{
    static IMichUtil *shareIMichUtil = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareIMichUtil = [[self alloc] init];
    });

    return shareIMichUtil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString *baseAppHostIP = [self convertDomainNameToIPAddr:BASE_HOST];
        if (baseAppHostIP)
        {
            self.baseAppHost = [NSString stringWithFormat:@"http://%@%@%@/", baseAppHostIP, BASE_PORT,BASE_FIXED_MIDDLE];
        }
        else
        {
            self.baseAppHost = nil;
        }
    }
    
    return self;
}

- (NSString *)getBaseAppHostIP
{
    if (self.baseAppHost)
    {
        return self.baseAppHost;
    }
    else
    {
        NSString *baseAppHostIP = [self convertDomainNameToIPAddr:BASE_HOST];
        if (baseAppHostIP)
        {
            self.baseAppHost = [NSString stringWithFormat:@"http://%@%@%@", baseAppHostIP, BASE_PORT,BASE_FIXED_MIDDLE];
            return self.baseAppHost;
        }
        else
        {
            self.baseAppHost = nil;
        }
        
        return [NSString stringWithFormat:@"http://%s%@%@", BASE_HOST, BASE_PORT,BASE_FIXED_MIDDLE];
    }
}

// 时间戳转日期
+ (NSString *)convertDateStrFromDigt:(unsigned long long)dateTime
{
    unsigned long long lDateTime = dateTime / MSECS_OF_ONE_SEC;             // 时间
    unsigned long long curDateTime = [[NSDate date] timeIntervalSince1970]; // 当天时间
    unsigned long long diffDateTime = curDateTime - lDateTime;  // 时间差
    //NSLog(@"时间差 %lld  一天时间：%ld", diffDateTime, SECS_OF_ONE_DAY);
    if (diffDateTime > SECS_OF_ONE_DAY)  // 一天前（超过24小时）
    {
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:lDateTime];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:MM"];
        NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
        
        //NSLog(@"日期：%@", dateStr);
        return dateStr;
    }
    else if (diffDateTime <= SECS_OF_ONE_DAY && diffDateTime > SECS_OF_ONE_HOUR)
    {
        int hours = (int)(diffDateTime / SECS_OF_ONE_HOUR) ; // 小时
        
        return [NSString stringWithFormat:@"%d小时前", (int)hours];
    }
    else
    {
        int mins = (int)(diffDateTime / SECS_OF_ONE_MIN) ; // 分钟
        
        return [NSString stringWithFormat:@"%d分钟前", (int)mins];
    }
    
    return [self getCurDate];
}

// 时间戳转日期时间
+ (NSString *)convert2Date:(unsigned long long)dateTime
{
    unsigned long long lDateTime = dateTime / MSECS_OF_ONE_SEC;             // 时间

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:lDateTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
        
    //NSLog(@"日期：%@", dateStr);
    return dateStr;
}

// 时间戳转日期
+ (NSString *)longTime2Date:(unsigned long long)longTime
{
    unsigned long long lDateTime = longTime;             // 时间
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:lDateTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    
    return dateStr;
}

// 时间戳转日期
+ (NSString *)longTimeToDate:(unsigned long long)longTime type:(NSInteger)type
{
    unsigned long long lDateTime = longTime;             // 时间
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:lDateTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (type == 0)
    {
        [dateFormatter setDateFormat:@"MM月dd日"];
    }
    else if (type == 1)
    {
        [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
    }
    
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    
    return dateStr;
}

// 获取当前时间戳
+ (unsigned long long)getCurTimeStamp
{
    unsigned long long retTime = [[NSDate date] timeIntervalSince1970] * MSECS_OF_ONE_SEC;
    
    return retTime;
}

// 获取当前时间
+ (NSString *)getCurDate
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *curDateTime = [dateformatter stringFromDate:senddate];
    
    //NSLog(@"当前时间:%@ ",curDateTime);
    return curDateTime;
}


+ (CGFloat)calcLabelHeight:(NSString *)strText fontSize:(NSInteger)fontSize width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSLineBreakByWordWrapping;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraph};
    CGSize size = [strText boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.height;
}

+ (CGFloat)calcLabelWidth:(NSString *)strText fontSize:(NSInteger)fontSize height:(CGFloat)height
{
    CGFloat width = [strText boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.width;
    
    return width + 1.0;
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return sizeToFit;
}

+ (NSInteger)lineWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width {
    CGFloat lineH = [self sizeWithText:@"计算文字尺寸" fontSize:fontSize andWidth:width].height;
    CGFloat contentH = [self sizeWithText:value fontSize:fontSize andWidth:width].height;
    
    return ceilf(contentH / lineH);
}


+ (NSArray *)getArrayFromJsonString:(NSString *)jsonString fail:(void (^)(NSString *description))fail
{
    if (jsonString == nil && jsonString.length == 0)
    {
        return nil;
    }
    
    
    NSData *jsonData;
    NSArray *retArray;
    NSError *err;
    
    if (jsonString)
    {
        jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
    }
    
    if (err)
    {
        NSLog(@"json解析失败：%@",err);
        fail(@"json解析失败");
        //return nil;
    }
    
    return retArray;
}

+ (NSArray *)convertArrayDict2Obj:(NSArray *)array class:(Class)resultClass
{
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array)
    {
        [mArray addObject:[dict objectByClass:resultClass]];
    }
    
    return mArray;
}

// 转化结果集 为列表
+ (NSArray *)parseResultToArray:(NSDictionary *)resultDict withKey:(NSString *)key
{
    if (!resultDict || !key)
    {
        return nil;
    }
    
    NSData *jsonData = nil;
    NSArray *dataArray = nil;
    NSError *err = nil;
    
    NSString *jsonString = [resultDict objectForKey:key];
    if (!jsonString)
    {
        return nil;
    }
    
    jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableLeaves error: &err];

    if (err)
    {
        return nil;
    }
    
    return dataArray;
}



+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

+ (NSString *)convertArray2JsonStr:(NSArray *)array
{
    if (!array)
    {
        return nil;
    }
    
    NSString *node = [array objectAtIndex:0];
    NSString *retStr = [NSString stringWithFormat:@"[\"%@\"]", node];
    
    return [retStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)applicationDocumentsDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSInteger)calcCollectionCellRows:(NSInteger)count
{
    NSInteger rows = count / 3;
    
    if (count % 3 == 1 || count % 3 == 2)
    {
        rows += 1;
    }
    
    return rows;
}

// 创建UUID
+ (NSString *)cutStr:(NSString *)str
{
    if (!str || str.length == 0)
    {
        return str;
    }
    
    return [str substringToIndex:str.length - 1];
}

+ (void)logFrame:(CGRect)frame{
    NSLog(@"x:%f,y:%f,width:%f,height:%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    else if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    else if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    else if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4";
    
    else if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    else if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    else if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    else if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    else if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    else if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s Plus";    // add
    else if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s";         // add
    
    else if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    else if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    else if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    else if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    else if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    else if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    else if ([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"])
        return @"iPad 2";
    
    else if ([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,6"])
        return @"iPad Mini 1G";
    
    else if ([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"])
        return @"iPad 3";
    
    else if ([platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] || [platform isEqualToString:@"iPad3,6"])
        return @"iPad 4";
    
    else if ([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"])
        return @"iPad Air";
    
    else if ([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] || [platform isEqualToString:@"iPad4,6"])
        return @"iPad Mini 2G";
    else if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    
    return platform;
}


- (NSString *)convertDomainNameToIPAddr:(const char *)domainName
{
    NSString *ipStr = nil;
    
    @try {
        struct hostent *remoteHostEnt = gethostbyname(domainName);
        if (remoteHostEnt)
        {
            struct in_addr *remoteInAddr = (struct in_addr *) remoteHostEnt->h_addr_list[0];
            char *sRemoteInAddr = inet_ntoa(*remoteInAddr);
            ipStr = [[NSString alloc] initWithCString:(const char *)sRemoteInAddr encoding:NSASCIIStringEncoding];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception = %@", exception.description);
    }

    return ipStr;
}

+ (void)printException:(NSException*)exception{
    NSLog(@"异常打印：name(%@),reason(%@)",exception.name,exception.reason);
}

+ (NSString *)getUUIDFromUrl:(NSString *)url
{
    NSRange range = [url rangeOfString:@"active?aid="];
    NSInteger startPos = range.location + range.length;
    NSInteger len = url.length - startPos;
    
    return [url substringWithRange:NSMakeRange(startPos, len)];
}

+ (BOOL)checkMoneyString:(NSString *)moneyStr range:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"] || [string isEqualToString:@""])   // 按下return键
    {
        return YES;
    }
    else if (moneyStr.length == 0 && [string isEqualToString:@"."]) // 第一格输入小数点
    {
        return NO;
    }
    
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [moneyStr rangeOfString:@"."].location;
    if (nDotLoc == NSNotFound && range.location != 0)
    {
        if ([[moneyStr substringToIndex:1] isEqualToString:@"0"])    // 首字母是0
        {
            if (![string isEqualToString:@"."])
            {
                return NO;
            }
        }
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:Numbers] invertedSet];
        if ([string isEqualToString:@"."])
        {
            return YES;
        }
        
        if (moneyStr.length >= 6)      // 小数点前面6位
        {
            return NO;
        }
    }
    else
    {
        if ([string isEqualToString:@"."])   // 不允许输入多个小数点
        {
            return NO;
        }
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:DotNumbers] invertedSet];
        if (moneyStr.length >= 9)
        {
            return NO;
        }
    }
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];    // 拆分字符串
    BOOL basicFilter = [string isEqualToString:filtered];
    if (!basicFilter)
    {
        return NO;
    }
    
    if (nDotLoc != NSNotFound && range.location > nDotLoc + 2)  // 小数点后面只允许2个
    {
        return NO;
    }
    
    return YES;
}

+ (NSMutableArray *)getArrayWithArray:(NSArray *)dataArray andClass:(Class)clazz {
	
    NSMutableArray *retArray = @[].mutableCopy;
    if ([dataArray isKindOfClass:[NSDictionary class]]) {
        dataArray = [NSArray arrayWithObject:dataArray];
    }
    
    for (NSDictionary *subDict in dataArray)
    {
        NSObject *m = [subDict objectByClass:clazz];
        
        [retArray addObject:m];
    }

    return retArray;
}

+(NSString *)convertArrayToString:(NSArray *)array {
	
    return [array componentsJoinedByString:@","];
}



@end
