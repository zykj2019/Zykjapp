//
//  ZykjRouter.h
//  LCLibs
//
//  Created by lyman on 2020/1/11.
//  Copyright © 2020 lyman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZykjRouter : NSObject


+ (instancetype)sharedRouter;

/// push到指定VC， 带参数
- (void)pushTo: (Class) vcClass withDict: (NSDictionary* _Nullable)dict;

/// 用指定的naviVC push到指定VC，带参数
- (void)pushTo:(Class)vcClass withDict:(NSDictionary<NSString*,id> *)dict withNaviVC:(UINavigationController*) naviVC;

/// present指定VC， 带参数
- (void)presentVC: (Class) vcClass withDict: (NSDictionary* _Nullable)dict;

@end

NS_ASSUME_NONNULL_END
