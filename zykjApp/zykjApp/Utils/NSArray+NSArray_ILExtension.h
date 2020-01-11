//
//  NSArray+NSArray_ILExtension.h
//  ILCoretext
//
//  Created by 阿虎 on 14/10/22.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSArray_ILExtension)

- (NSMutableArray *)offsetRangesInArrayBy:(NSUInteger)offset;

- (BOOL)containsString:(NSString *)string;

- (NSInteger)indexOfString:(NSString *)string;

//根据key获取所对应的values
- (NSArray *)valuesForKey:(NSString *)key;

//根据findId 找到对应对象
- (NSObject *)findObjForKey:(NSString *)key findId:(NSString *)findId;

//根据findid 找到对应索引
- (NSInteger)findIndexForKey:(NSString *)key findId:(NSString *)findId;

@end
