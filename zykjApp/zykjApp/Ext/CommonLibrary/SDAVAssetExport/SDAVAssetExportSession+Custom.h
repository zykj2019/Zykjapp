//
//  SDAVAssetExportSession+Custom.h
//  ZykjAppWork
//
//  Created by jsl on 2019/8/3.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "SDAVAssetExportSession.h"

#define XFCamera_bitsPerPixel      6.0
#define XFCamera_video_width      960
#define XFCamera_video_height      540


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define SafeViewBottomHeight (kScreenHeight == 812.0 ? 34.0 : 0.0)
#define iSiPhoneX  HT_iPhoneX
#define VIDEO_FILEPATH                                              @"video"
//#define TIMER_INTERVAL 0.01f                                        // 定时器记录视频间隔
#define TIMER_INTERVAL 1.0f                                        // 定时器记录视频间隔
#define VIDEO_RECORDER_MAX_TIME 300.0f                               // 视频最大时长 (单位/秒)
#define VIDEO_RECORDER_MIN_TIME 1.0f                                // 最短视频时长 (单位/秒)
#define START_VIDEO_ANIMATION_DURATION 0.3f                         // 录制视频前的动画时间
#define DEFAULT_VIDEO_ZOOM_FACTOR 3.0f

typedef void (^CompletionWriteBlock)(BOOL isFinished);

@protocol ExportSessionDelegate <NSObject>

///获取视频秒数
- (int)videoSeconds;

///获取视频每秒多少kb
- (long long)videoSizeBySeconds;

- (void)writeFileToLocalWithFilePath:(NSString *)filePath WithBlock:(CompletionWriteBlock)completionWriteBlock;

@end

#define IM_MAX_FILE_SIZE     19 * 1024 * 1024

@interface SDAVAssetExportSession (Custom)

@property (copy, nonatomic) NSString *fileName;

@property (strong, nonatomic) NSURL *fileUrl;

@property (strong, nonatomic) ALAsset *aLAsset;

//转码错误信息
@property (copy, nonatomic) NSString *errorMsg;

//是否进入了压缩方法（exportAsynchronouslyWithCompletionHandler）(如果为yes说明self不是空闲状态)
@property (nonatomic, assign) BOOL isEnterExportMethod;

/**
 用这个方法构建实体

 @param asset AVAsset
 @param aLAsset ALAsset
 @param fileUrl fileUrl
 @return 实体
 */
- (instancetype)initWithAsset:(AVAsset *)asset aLAsset:(id <ExportSessionDelegate>)aLAsset fileUrl:(NSURL *)fileUrl;

//手动设置完成下载
- (void)finishs;

//手动设置失败下载
- (void)errors;

//是否需要压缩
- (BOOL)isNeedCompress;


/// 构建error
/// @param code
/// @param errorMsg
- (void)errorCode:(NSInteger)code errorMsg:(NSString *)errorMsg;

/// 配置压缩信息
/// @param exportSession
- (void)configExportParam;

//将相册选中的文件写到本地
- (void)asynWriteFileToLocalWithFilePath:(NSString *)filePath IsAsyn:(BOOL)isAsyn WithBlock:(CompletionWriteBlock)completionWriteBlock;

///获取视频秒数
- (int)videoSeconds;

///获取视频每秒多少kb
- (long long)videoSizeBySeconds;


@end
