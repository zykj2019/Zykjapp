//
//  NSArray+NSArray_ILExtension.m
//  ILCoretext
//
//  Created by 阿虎 on 14/10/22.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
//

#import "NSArray+NSArray_ILExtension.h"

@implementation NSArray (NSArray_ILExtension)

- (NSMutableArray *)offsetRangesInArrayBy:(NSUInteger)offset
{
    NSUInteger aOffset = 0;
    NSUInteger prevLength = 0;
    
    
    NSMutableArray *ranges = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for(NSInteger i = 0; i < [self count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[self objectAtIndex:i] rangeValue];
            prevLength    = range.length;
            
            range.location -= aOffset;
            range.length    = offset;
//            [ranges addObject:NSStringFromRange(range)];
            [ranges addObject:[NSValue valueWithRange:range]];
            
            aOffset = aOffset + prevLength - offset;
        }
    }
    
    return ranges;
}

- (BOOL)containsString:(NSString *)string {
    for (id obj in self) {
        if ([obj isKindOfClass:[NSString class]]) {
            if ([string isEqualToString:obj]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSInteger)indexOfString:(NSString *)string {
    NSInteger index = 0;
    for (id obj in self) {
        if ([obj isKindOfClass:[NSString class]]) {
            if ([string isEqualToString:obj]) {
                return index;
            }
        }
        index++;
    }
    return NSNotFound;
}

//根据key获取所对应的values
- (NSArray *)valuesForKey:(NSString *)key {
    NSMutableArray *values = @[].mutableCopy;
    for (id obj in self) {
        if ([obj respondsToSelector:NSSelectorFromString(key)]) {
            NSString *value = [obj valueForKey:key];
            if (value) {
                 [values addObject:value];
            }
           
        }
    }
    return values;
}

//根据findId 找到对应对象
- (NSObject *)findObjForKey:(NSString *)key findId:(NSString *)findId {
    for (id obj in self) {
        if ([obj respondsToSelector:NSSelectorFromString(key)]) {
            NSString *tId = [obj valueForKey:key];
            if ([tId isEqualToString:findId]) {
                return obj;
            }
        }
    }
    return nil;
}

//根据findid 找到对应索引
- (NSInteger)findIndexForKey:(NSString *)key findId:(NSString *)findId {
    NSInteger index = 0;
    for (id obj in self) {
            NSString *tId = [obj valueForKey:key];
            if ([tId isEqualToString:findId]) {
                return index;
            }
            index++;
    }
    return NSNotFound;
}

@end
