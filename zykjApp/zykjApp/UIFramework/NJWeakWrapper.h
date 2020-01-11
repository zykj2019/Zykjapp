//
//  NJWeakWrapper.h
//  ZykjAppWork
//
//  Created by jsl on 2020/1/9.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 我们知道iOS的Category是不能添加ivar的，所以当给Category添加属性时都使用了runtime的objc_setAssociatedObject 方法。
///但是objc_AssociationPolicy 并不支持weak属性，那怎么给Category加一个weak的属性呢？ 我Google一下发现第一的答案做法还挺复杂。这里给个超简单的方案，就是包一层Object搞定。
@interface NJWeakWrapper : NSObject

@property (nonatomic, weak) id obj;

@end

