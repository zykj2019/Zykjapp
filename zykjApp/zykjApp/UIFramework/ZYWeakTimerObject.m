//
//  ZYWeakTimerObject.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/8/10.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "ZYWeakTimerObject.h"

@interface ZYWeakTimerObject()

@property(nonatomic,weak)id target;

@property(nonatomic,assign)SEL selector;

@end
@implementation ZYWeakTimerObject
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:( id)userInfo repeats:(BOOL)yesOrNo
{
    ZYWeakTimerObject *weakObject = [[ZYWeakTimerObject alloc]init];
    weakObject.target = aTarget;
    weakObject.selector = aSelector;
    return [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:weakObject selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
}

- (void)fire:(id)obj
{
    if ([self.target respondsToSelector:self.selector]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        
        [self.target performSelector:self.selector withObject:obj];
        
        #pragma clang diagnostic pop
        
    }
   
}

+ (CADisplayLink *)displayLinkWithTarget:(id)aTarget selector:(SEL)aSelector; {
    ZYWeakTimerObject *weakObject = [[ZYWeakTimerObject alloc]init];
    weakObject.target = aTarget;
    weakObject.selector = aSelector;
     return [CADisplayLink displayLinkWithTarget:weakObject selector:@selector(fire:)];
}

- (void)dealloc
{
    NSLog(@"ZYWeakTimerObject已经离去");
}

@end
