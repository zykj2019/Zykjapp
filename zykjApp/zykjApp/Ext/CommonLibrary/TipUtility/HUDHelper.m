//
//  HUDHelper.m
//
//
//  Created by Alexi on 12-11-28.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "HUDHelper.h"
#import "LEEAlert.h"
#import "TipView.h"

#import "NSString+Common.h"

@implementation HUDHelper

static HUDHelper *_instance = nil;


+ (HUDHelper *)sharedInstance
{
    @synchronized(_instance)
    {
        if (_instance == nil)
        {
            _instance = [[HUDHelper alloc] init];
        }
        return _instance;
    }
}

+ (void)alert:(NSString *)msg
{
    [HUDHelper alert:msg cancel:@"确定"];
}
+ (void)alert:(NSString *)msg action:(CommonVoidBlock)action
{
    [HUDHelper alert:msg cancel:@"确定" action:action];
}
+ (void)alert:(NSString *)msg cancel:(NSString *)cancel
{
    [HUDHelper alertTitle:@"提示" message:msg cancel:cancel];
}
+ (void)alert:(NSString *)msg cancel:(NSString *)cancel action:(CommonVoidBlock)action
{
    [HUDHelper alertTitle:@"提示" message:msg cancel:cancel action:action];
}
+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel
{
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    //    [alert show];
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeContent(msg)
    .LeeCancelAction(cancel, ^{
        // 取消点击事件Block
    })
    .LeeShow(); // 设置完成后 别忘记调用Show来显示
}

+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel action:(CommonVoidBlock)action
{
    //    UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:cancel otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
    //        if (action)
    //        {
    //            action();
    //        }
    //    }];
    //    [alert show];
    
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeContent(msg)
    .LeeCancelAction(cancel, ^{
        // 取消点击事件Block
        if (action)
        {
            action();
        }
    })
    .LeeShow(); // 设置完成后 别忘记调用Show来显示
    
}

+ (void)alertMessage:(NSString *)msg action:(CommonVoidBlock)action cancelAction:(CommonVoidBlock)cancelAction {
    [self alertTitle:@"提示" message:msg action:action cancelAction:cancelAction];
}
+ (void)alertTitle:(NSString *)title message:(NSString *)msg action:(CommonVoidBlock)action cancelAction:(CommonVoidBlock)cancelAction {
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeContent(msg)
    .LeeAction(@"确定", ^{
        if (action)
        {
            action();
        }
    })
    .LeeCancelAction(@"取消", ^{
        // 取消点击事件Block
        if (cancelAction)
        {
            cancelAction();
        }
    }).LeeShow();
}


- (MBProgressHUD *)loading
{
    return [self loading:nil];
}

- (MBProgressHUD *)loading:(NSString *)msg
{
    return [self loading:msg inView:nil];
}

- (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view
{
    
    UIView *inView = view ? view : [BaseAppDelegate sharedAppDelegate].window;
    MBProgressHUD *hud = [MBProgressHUD showOnlyTextToViewNoHidden:inView title:msg];
    return hud;
    
    
}

- (void)loading:(NSString *)msg delay:(CGFloat)seconds execute:(void (^)(void))exec completion:(void (^)(void))completion
{
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIView *inView = [BaseAppDelegate sharedAppDelegate].window;
    //        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    //        if (![NSString isEmpty:msg])
    //        {
    //            hud.mode = MBProgressHUDModeText;
    //            hud.labelText = msg;
    //        }
    //
    //        [inView addSubview:hud];
    //        [hud show:YES];
    //        if (exec)
    //        {
    //            exec();
    //        }
    //
    //        // 超时自动消失
    //        [hud hide:YES afterDelay:seconds];
    //
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            if (completion)
    //            {
    //                completion();
    //            }
    //        });
    //    });
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *inView = [BaseAppDelegate sharedAppDelegate].window;
        
        MBProgressHUD *hud = [MBProgressHUD showOnlyTextToViewNoHidden:inView title:msg];
        if (exec)
        {
            exec();
        }
        // 超时自动消失
        [hud hideAnimated:YES afterDelay:seconds];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion)
            {
                completion();
            }
        });
    });
    
    
}


- (void)stopLoading:(MBProgressHUD *)hud
{
    [self stopLoading:hud message:nil];
}

- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg
{
    [self stopLoading:hud message:msg delay:0 completion:nil];
}
- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)(void))completion
{
    __weak typeof(self) ws = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (hud && hud.superview) {
            if (![NSString isEmpty:msg]) {
                hud.label.text = msg;
                hud.mode = MBProgressHUDModeText;
            }
            [hud hideAnimated:YES afterDelay:seconds];
            ws.syncHUD = nil;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (completion)
                {
                    completion();
                }
            });
        }
        
        
    });
    
    
}


- (void)tipMessage:(NSString *)msg
{
    //    [self tipMessage:msg delay:2];
    [TipView showTipView:msg];
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds
{
    //    [self tipMessage:msg delay:seconds completion:nil];
    [TipView showTipView:msg];
    
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)(void))completion
{
    if ([NSString isEmpty:msg])
    {
        return;
    }
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[BaseAppDelegate sharedAppDelegate].window];
    //        [[BaseAppDelegate sharedAppDelegate].window addSubview:hud];
    //        hud.mode = MBProgressHUDModeText;
    //        hud.labelText = msg;
    //        [hud show:YES];
    //        [hud hide:YES afterDelay:seconds];
    //        CommonRelease(HUD);
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            if (completion)
    //            {
    //                completion();
    //            }
    //        });
    //    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showTitleToView:[BaseAppDelegate sharedAppDelegate].window contentStyle:NHHUDContentBlackStyle title:msg afterDelay:seconds completion:completion];
    });
}


#define kSyncHUDStartTag  100000

// 网络请求
- (void)syncLoading
{
    [self syncLoading:nil];
}
- (void)syncLoading:(NSString *)msg
{
    [self syncLoading:msg inView:nil];
}
- (void)syncLoading:(NSString *)msg inView:(UIView *)view
{
    __weak typeof(self) ws = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (ws.syncHUD)
        {
            ws.syncHUD.tag++;
            
            if (![NSString isEmpty:msg])
            {
                ws.syncHUD.label.text = msg;
                ws.syncHUD.mode = MBProgressHUDModeText;
            }
            else
            {
                ws.syncHUD.label.text = nil;
                ws.syncHUD.mode = MBProgressHUDModeIndeterminate;
            }
            
            [ws.syncHUD hideAnimated:NO];
        }
        
        ws.syncHUD = [self loading:msg inView:view];
        ws.syncHUD.tag = kSyncHUDStartTag;
    });
    
}

- (void)syncStopLoading
{    dispatch_async(dispatch_get_main_queue(), ^{
    [self syncStopLoadingMessage:nil delay:0 completion:nil];
});
    
}
- (void)syncStopLoadingMessage:(NSString *)msg
{
    [self syncStopLoadingMessage:msg delay:1 completion:nil];
}
- (void)syncStopLoadingMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)(void))completion
{
    //    _syncHUD.tag--;
    //    if (_syncHUD.tag > kSyncHUDStartTag)
    //    {
    //        if (![NSString isEmpty:msg])
    //        {
    //            _syncHUD.label.text = msg;
    //            _syncHUD.mode = MBProgressHUDModeText;
    //        }
    //        else
    //        {
    //            _syncHUD.label.text = nil;
    //            _syncHUD.mode = MBProgressHUDModeIndeterminate;
    //        }
    //
    //    }
    //    else
    //    {
    //        [self stopLoading:_syncHUD message:msg delay:seconds completion:completion];
    //    }
    [self stopLoading:_syncHUD message:msg delay:seconds completion:completion];
}

//得到上传进度

- (MBProgressHUD *)getUploadMediaProgessInView:(UIView *)view {
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.hudContentStyle(NHHUDContentBlackStyle);
    return HUD;
}

@end
