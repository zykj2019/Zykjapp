//
//  ZykjRouter.m
//
//
//  Created by lyman on 2020/1/11.
//  Copyright © 2020 lyman. All rights reserved.
//

#import "ZykjRouter.h"

static ZykjRouter *sharedRouter = nil;

@implementation ZykjRouter

/// push跳转本app的VC
- (void)pushTo:(Class)vcClass withDict:(NSDictionary<NSString*,id> *)dict {
    
    [self pushTo:vcClass withDict:dict withNaviVC:ApplicationDelegate.navigationViewController];
}

/// push跳转本app的VC, 指定一个UINavigationController
- (void)pushTo:(Class)vcClass withDict:(NSDictionary<NSString*,id> *)dict withNaviVC:(UINavigationController*) naviVC {
    UIViewController *vc = [vcClass yy_modelWithJSON:dict];
    [naviVC pushViewController:vc animated:YES];
}

/// present展示
- (void)presentVC:(Class)vcClass withDict:(NSDictionary *)dict {
    UIViewController *vc = [vcClass yy_modelWithJSON:dict];
    [ApplicationDelegate presentViewController:vc animated:true completion:nil];
}

#pragma mark - 单例

+ (instancetype)sharedRouter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRouter = [[self alloc]init];
    });
    return sharedRouter;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       sharedRouter  = [super allocWithZone:zone];
    });
    return sharedRouter;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return sharedRouter;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return sharedRouter;
}
@end
