//
//  MyRegularExpressionManager.h
//  WFCoretext
//
//  Created by zoulixiang on 16/9/26.
//  Copyright © 2016年 tigerwf. All rights reserved.
//
//匹配正则表达式

#import <Foundation/Foundation.h>

@interface MyRegularExpressionManager : NSObject

+ (NSArray *)itemIndexesWithPattern:(NSString *)pattern inString:(NSString *)findingString;

+ (NSMutableArray *)matchMobileLink:(NSString *)pattern;

+ (NSMutableArray *)matchWebLink:(NSString *)pattern;

@end
