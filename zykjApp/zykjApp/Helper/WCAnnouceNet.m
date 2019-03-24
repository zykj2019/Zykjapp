//
//  WCAnnouceNet.m
//  WelfareCommunity
//
//  Created by zoulixiang on 16/7/13.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "WCAnnouceNet.h"
#import "UIAlertView+Blocks.h"
//#import "UserAPI.h"
//#import "CommonAPI.h"
//#import "Software.h"

static WCAnnouceNet *_announce;

@implementation WCAnnouceNet

+ (instancetype)sharedInstance {
	
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _announce = [[WCAnnouceNet alloc] init];
    });
    return _announce;
}

- (instancetype)init{
    
    if (self = [super init]) {
        [self addNotification];
    }
    return self;
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotification {
	
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(onReceiveLogout:) name:PERSON_LOGOUT object:nil];//用户下线通知
}

- (void)onReceiveLogout:(NSNotification *)sender {
	
//    UIAlertView *alert=[UIAlertView alertViewWithTitle:@"账号认证通知" message:@"您的账号需要重新认证" cancelButtonTitle:@"退出" otherButtonTitles:@[@"重新登录"] onDismiss:^(int buttonIndex) {
//        //重置用户保存的自动登录数据，下次不自动登录
//        [ApplicationDelegate logoutAccount];
//        
//    } onCancel:^{
//        //重置用户保存的自动登录数据，下次不自动登录
//            [ApplicationDelegate logoutAccount];
//    }];
//    [alert show];
}

////检测版本
//- (void)checkVersion {
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        UpdateSoftwareParams *params = [[UpdateSoftwareParams alloc] init];
//        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//        params.vcode = currentVersion;
//        
//        [CommonAPI updateSoftwareParams:params success:^(NSObject *result, int code, NSString *info) {
//            
//            Software *softWare = (Software *)result;
//            
//            if ([currentVersion floatValue] < softWare.vcode ) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *introduce = softWare.introduce;
//                    UIAlertView *alert=[UIAlertView alertViewWithTitle:@"软件更新" message:introduce cancelButtonTitle:@"暂不更新" otherButtonTitles:@[@"立即更新"] onDismiss:^(int buttonIndex) {
//                        
//                    } onCancel:^{
//                        
//                    }];
//                    [alert show];
//                    
//                });
//            }
//        } fail:^(NSString *description) {
//        }];
//    });
//
//}
@end
