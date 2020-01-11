//
//  MyAudioAuditionBtn.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import "MyAudioAuditionBtn.h"

@interface MyAudioAuditionBtn () {
    unsigned long long _currentTime;
}

@property (strong, nonatomic) NSTimer *sendTimer;

@end

@implementation MyAudioAuditionBtn
- (void)dealloc {
    if (_sendTimer) {
        [_sendTimer invalidate];
        _sendTimer = nil;
    }
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    MyAudioAuditionBtn *btn = [super buttonWithType:buttonType];
    [btn addTarget:btn action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)setAudioStatus:(MyAudioBtnStatus)audioStatus {
    [super setAudioStatus:audioStatus];
    switch (audioStatus) {
        case MyAudioBtnStatusNoStart: {
            //停止计时
            if (_sendTimer) {
                [_sendTimer invalidate];
                _sendTimer = nil;
            }
            self.timeDuration = 0;
            UIImage *img = [UIImage imageNamed:@"kaishi"];
            NSString *text = nil;
            [self setImage:img forState:UIControlStateNormal];
            [self setTitle:text forState:UIControlStateNormal];
            
        }
            
            break;
        case MyAudioBtnStatusStarting: {
            //恢复计时或者开始计时
             NSLog(@"MyAudioBtnStatusStarting");
            if (_sendTimer) {
                //恢复计时
                 [_sendTimer setFireDate:[NSDate date]];
            } else {
                //新建计时
                _sendTimer = [ZYWeakTimerObject scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendTimerFunc) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:_sendTimer forMode:NSDefaultRunLoopMode];
            }
            UIImage *img = [UIImage new];
            NSString *text = self.timeDurationStr;
            [self setImage:img forState:UIControlStateNormal];
            [self setTitle:text forState:UIControlStateNormal];
        }
            break;
            
        case MyAudioBtnStatusPause: {
            //暂停计时
            NSLog(@"MyAudioBtnStatusPause");
            [_sendTimer setFireDate:[NSDate distantFuture]];
            
            UIImage *img = [UIImage imageNamed:@"kaishi"];
            NSString *text = nil;
            [self setImage:img forState:UIControlStateNormal];
            [self setTitle:text forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - target
- (void)playAudioAction:(MyAudioAuditionBtn *)sender {
   
    //防止过多点击
//     unsigned long long currentTime = [[NSDate date] timeIntervalSince1970] * 1000 ;
//    if (currentTime - _currentTime < 450) {
//        return;
//    }
//    _currentTime = currentTime;
    
    @synchronized (self) {
        if (self.audioStatus == MyAudioBtnStatusNoStart) {
            //开始播放
            if (self.fileUrl) {
                [[MyAudioPlayHelp sharedInstance] playWithUrl:self.fileUrl delegate:self];
            }
        } else if (self.audioStatus == MyAudioBtnStatusStarting) {
            //暂停播放
            [[MyAudioPlayHelp sharedInstance] stop];
        } else if (self.audioStatus == MyAudioBtnStatusPause) {
            //继续播放
            [[MyAudioPlayHelp sharedInstance] play];
        }
    }
    
    
    
}
- (void)sendTimerFunc {
    self.timeDuration = (NSInteger)round([MyAudioPlayHelp sharedInstance].soundPlayer.currentTime);
}

@end
