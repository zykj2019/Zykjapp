//
//  MyAudioHelp.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

//最大录音时间
#define Max_Audio_Time  Pro_Audio_Max_Time
//录音格式
#define File_Format_Audio  Pro_Audio_File_Format
typedef enum : NSInteger {
    MyAudioBtnStatusNoStart,                  //没开始
    MyAudioBtnStatusStarting,                //正在开始
    MyAudioBtnStatusPause,                  //暂停
    MyAudioBtnStatusWait,                   //下载中
    MyAudioBtnStatusError,                  //播放失败
    
}MyAudioBtnStatus;

@protocol MyAudioPlayHelpDelegate <NSObject>

@property (assign, nonatomic) MyAudioBtnStatus audioStatus;

@end

@class MyAudioBtn;

@interface MyAudioHelp : NSObject

@property (weak, nonatomic) MyAudioBtn *myAudioBtn;

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机

@property (copy, nonatomic) CommonVoidBlock maxTimeVideoBlock;

/**
 MyAudioBtn的点击响应事件

 @param sender MyAudioBtn *sender
 */
- (void)clickAction:(MyAudioBtn *)sender;



/**
 完成录音
 
 @return fileUrl:(NSUrl *)文件地址 audioTime:(NSInteger )时间
 */
- (NSDictionary *)finishAudio;
/**
 重置录音文件
 */
- (void)resetAudio;


/**
 取消录音
 */
- (void)cancelAudio;

@end


//停止播放通知
#define MyAudioPlayHelpStop_Notification    @"MyAudioPlayHelpStop_Notification"
/**
 播放工具
 */
@interface MyAudioPlayHelp : NSObject

@property (nonatomic, strong) AVAudioPlayer *soundPlayer;

/**
 播放url
 */
@property (weak, nonatomic) NSURL *playUrl;


/**
 实现MyAudioPlayHelpDelegate 可以是数据模型，view
 */
@property (weak, nonatomic) id <MyAudioPlayHelpDelegate> delegate;
/**
 播放状态
 */
@property (assign, nonatomic) MyAudioBtnStatus audioStatus;


+ (instancetype)sharedInstance;

- (void)play;

- (void)pause;

- (void)stop;

- (void)playWithUrl:(NSURL *)url delegate:(id <MyAudioPlayHelpDelegate>)delegate;

- (NSData *)convertWavtoAMR:(NSData *)wavData;

@end
