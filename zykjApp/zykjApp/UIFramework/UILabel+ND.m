//
//  UILabel+ND.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/10/10.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//


#import "UILabel+ND.h"

static NSString *const klbl_noempty = @"lbl_noempty";

@implementation UILabel (ND)
+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [self swizzleInstanceMethodWithOriginSel:@selector(setText:)
                                         swizzledSel:@selector(sx_setText:)];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    });
}

- (BOOL)noEmpty {
    
    NSNumber *noempty = objc_getAssociatedObject(self, (__bridge const void *)klbl_noempty);
    return [noempty boolValue];
}

- (void)setNoEmpty:(BOOL)noEmpty {
    objc_setAssociatedObject(self, (__bridge const void *)klbl_noempty, [NSNumber numberWithBool:noEmpty], OBJC_ASSOCIATION_RETAIN);
}

- (void)sx_setText:(NSString *)text {
    if (self.noEmpty) {
        text = text.length > 0 ? text : @" ";
    }
    [self sx_setText:text];
   
}
+ (instancetype)navLbl {
    UILabel *t_lable;
    t_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    [t_lable setBackgroundColor:[UIColor clearColor]];
    [t_lable setTextAlignment:NSTextAlignmentCenter];
    [t_lable setFont:BaesFont(18.0)];   // 华文细黑
    //    [t_lable setAdjustsFontSizeToFitWidth:YES];
    [t_lable setMinimumScaleFactor:0.5];
    
    return t_lable;
}


+ (void)swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel {
    Method originAddObserverMethod = class_getInstanceMethod(self, oriSel);
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, swiSel);
    
    [self swizzleMethodWithOriginSel:oriSel oriMethod:originAddObserverMethod swizzledSel:swiSel swizzledMethod:swizzledAddObserverMethod class:self];
}

+ (void)swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                       swizzledSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls {
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
}


@end
