//
//  ZYWeakTimerObject.h
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/8/10.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYWeakTimerObject : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

+ (CADisplayLink *)displayLinkWithTarget:(id)aTarget selector:(SEL)aSelector;

@end
