//
//  MyAudioHelp.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import "MyAudioHelp.h"
#import "MyAudioBtn.h"
#import "amrFileCodec.h"

@interface MyAudioHelp() <AVAudioRecorderDelegate>

@property (copy, nonatomic) NSString *fileName;

@property (strong, nonatomic) NSTimer *sendTimer;

@end

@implementation MyAudioHelp

- (void)dealloc {
    if (_sendTimer) {
        [_sendTimer invalidate];
        _sendTimer = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSString *)fileName {
    if (_fileName == nil) {
        unsigned long long currentimeInterval = [[NSDate date] timeIntervalSince1970];
        _fileName = [NSString stringWithFormat:@"MyAudio%llu",currentimeInterval];
    }
    return _fileName;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
        [self setAudioSession];
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
- (NSDictionary *)getAudioSetting {
    
    NSDictionary *recordSetting =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                    [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                    [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                    [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                    [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                    [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,nil];//采样信号是整数还是浮点数
    
//  mp3
//    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
//    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEGLayer3] forKey:AVFormatIDKey];
//    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
//    [recordSetting setValue:[NSNumber numberWithFloat:22150] forKey:AVSampleRateKey];
//    //录音通道数  1 或 2
//    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
//    //线性采样位数  8、16、24、32
//    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//
//     [recordSetting setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
//    //录音的质量
//    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    return recordSetting;
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
- (NSURL *)getSavePath {
    
    //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJAudio",[PathUtility getCachePath]];
    
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",self.fileName,File_Format_Audio]];
    NSLog(@"file path:%@",path);
    NSURL *url=[NSURL fileURLWithPath:path];
    return url;
}

- (void)setAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    //AVAudioSessionCategoryPlayAndRecord用于录音和播放
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil) {
        NSLog(@"Error creating session: %@", [sessionError description]);
    } else {
        [session setActive:YES error:nil];
    }
    
}

/**
 完成录音
 
 @return 保存的url
 */
- (NSDictionary *)finishAudio {
    NSDictionary *params;
    NSInteger audioTime = ceil(self.audioRecorder.currentTime);
    NSURL *fileUrl = [self getSavePath];
    if (fileUrl) {
        params = @{@"audioTime":@(audioTime),@"fileUrl":fileUrl};
    }
    [self resetAudio];
    return params;
    
    
}

/**
 重置录音文件
 */
- (void)resetAudio {
    //停止录音
    [self.audioRecorder stop];
    
    self.myAudioBtn.audioStatus = MyAudioBtnStatusNoStart;
    //停止计时
    if (_sendTimer) {
        [_sendTimer invalidate];
        _sendTimer = nil;
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    //恢复外部正在播放的音乐
    [[AVAudioSession sharedInstance] setActive:NO
                                   withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                                         error:nil];
}

/**
 取消录音
 */
- (void)cancelAudio {
    //停止录音
    if (self.audioRecorder.isRecording) {
        [self.audioRecorder stop];
        [self.audioRecorder deleteRecording];
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    //恢复外部正在播放的音乐
    [[AVAudioSession sharedInstance] setActive:NO
                                   withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                                         error:nil];
   
}

#pragma mark - target
/**
 MyAudioBtn的点击响应事件
 
 @param sender MyAudioBtn *sender
 */
- (void)clickAction:(MyAudioBtn *)sender {
    
    @synchronized (self) {
        if (sender.audioStatus == MyAudioBtnStatusNoStart) {
            // 获取麦克风权限
            AVAudioSession *avSession = [AVAudioSession sharedInstance];
            if ([avSession respondsToSelector:@selector(requestRecordPermission:)])
            {
                [avSession requestRecordPermission:^(BOOL available) {
                    if (!available)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[[UIAlertView alloc] initWithTitle:@"无法录音" message:@"请在“设置-隐私-麦克风”中允许访问麦克风。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                        
                        });
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //开始录制
                            if (self.sendTimer) {
                                return;
                            }
                            if ([self.audioRecorder prepareToRecord]) {
                                //删除之前的
                                [self.audioRecorder deleteRecording];
                                
                                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
                                
                                //开始计时
                                self.sendTimer = [ZYWeakTimerObject scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendTimerFunc) userInfo:nil repeats:YES];
                                [[NSRunLoop currentRunLoop] addTimer:self.sendTimer forMode:NSDefaultRunLoopMode];
                                //准备好开始录音
                                sender.audioStatus = MyAudioBtnStatusStarting;
                                
                               
                                //开始录音
                                [self.audioRecorder record];
                            }
                        });
                    }
                }];
            }
          
            
        } else if (sender.audioStatus == MyAudioBtnStatusStarting) {
            //暂停计时
            [_sendTimer setFireDate:[NSDate distantFuture]];
            //暂停录音
            [self.audioRecorder pause];
            
            sender.audioStatus = MyAudioBtnStatusPause;
        } else if (sender.audioStatus == MyAudioBtnStatusPause) {
            if ([self.audioRecorder record]) {
                //继续计时
                [_sendTimer setFireDate:[NSDate distantPast]];
                //继续录音
                sender.audioStatus = MyAudioBtnStatusStarting;
            }
            
        }
    }
   
}

- (void)sendTimerFunc {
    self.myAudioBtn.timeDuration++;
    if (self.myAudioBtn.timeDuration >= Max_Audio_Time) {
//        [self finishAudio];
        if (self.maxTimeVideoBlock) {
            self.maxTimeVideoBlock();
        } else {
            NSLog(@"录制最大时间");
             [self finishAudio];
            
        }
    }
}
@end

/**
 播放工具
 */
@interface MyAudioPlayHelp () <AVAudioPlayerDelegate> {
}

@property (nonatomic, strong) NSOperationQueue *audioDataOperationQueue;

@end

@implementation MyAudioPlayHelp

static MyAudioPlayHelp *_myAudioPlayHelp = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _myAudioPlayHelp = [[MyAudioPlayHelp alloc] init];
    });
    
    return _myAudioPlayHelp;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _audioDataOperationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
- (NSString *)getSavePath {
    
    //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJAudio",[PathUtility getCachePath]];
    
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

- (void)setDelegate:(id<MyAudioPlayHelpDelegate>)delegate {
    if (_delegate != delegate) {
        //如果不一样则先停止播放
        [self stop];
    }
    _delegate = delegate;
}

- (void)playWithUrl:(NSURL *)url delegate:(id <MyAudioPlayHelpDelegate>)delegate{
     self.delegate = delegate;
    self.playUrl = url;
    
    NSError *err = nil;
    NSString *scheme = url.scheme;
    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
         __block id <MyAudioPlayHelpDelegate> tdelegate= delegate;
       __block NSString *path = [self getSavePath];
        NSString *fileName = [url.lastPathComponent md5];
        //缓存路径path
        path = [NSString stringWithFormat:@"%@/%@",path,fileName];
        if ([fm fileExistsAtPath:path]) {
            //如果文件存在读取缓存
            NSData *audioData = [[NSData alloc] initWithContentsOfFile:path];
            if (!audioData) {
                [self error];
                return;
            }
            [self playAudioWithData:audioData delegate:tdelegate];
        } else {
            //下载
            [self wait];
            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            
                NSData *audioData = [NSData dataWithContentsOfURL:url];
                if (!audioData) {
                    [self error];
                    return;
                }
                
                NSString *pathExtension = url.pathExtension;
                if ([pathExtension isEqualToString:@"arm"]) {
                    audioData = DecodeAMRToWAVE(audioData);
                }
                
                [audioData writeToFile:path atomically:YES];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self playAudioWithData:audioData delegate:tdelegate];
                });
            }];
            
             [_audioDataOperationQueue addOperation:blockOperation];
        }
        
        
        
        
    } else {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
        _soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
        _soundPlayer.delegate = self;
        _soundPlayer.meteringEnabled = YES;
        if (!err) {
            [self play];
        }else {
            NSLog(@"AVAudioPlayer:播放错误");
            [self error];
        }
       
    }
   
    
}



- (void)play {
    @synchronized (self) {
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:0 error:nil];
         [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
        
        if ([self.soundPlayer prepareToPlay]) {
            if ([self.soundPlayer play]) {
                self.audioStatus = MyAudioBtnStatusStarting;
                _delegate.audioStatus = MyAudioBtnStatusStarting;
            }
        }
    }
    
}

- (void)pause {
    @synchronized (self) {
        [self.soundPlayer pause];
        self.audioStatus = MyAudioBtnStatusPause;
        _delegate.audioStatus = MyAudioBtnStatusPause;
    }
    
}

- (void)stop {
    @synchronized (self) {
        [self.soundPlayer stop];
        self.audioStatus = MyAudioBtnStatusNoStart;
        _delegate.audioStatus = MyAudioBtnStatusNoStart;
        _delegate = nil;
    }
    

}

- (void)error {
     self.audioStatus = MyAudioBtnStatusError;
    _delegate.audioStatus = MyAudioBtnStatusError;
    _delegate = nil;
}

- (void)wait {
     self.audioStatus = MyAudioBtnStatusWait;
     _delegate.audioStatus = MyAudioBtnStatusWait;
}

#pragma mark -
- (void)playAudioWithData:(NSData *)audioData delegate:(id <MyAudioPlayHelpDelegate>)delegate{
    if (delegate != self.delegate) {
        return;
    }
    if (!audioData) {
        [self error];
        return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
    NSError *audioPlayerError;
    _soundPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&audioPlayerError];
    _soundPlayer.delegate = self;
    _soundPlayer.meteringEnabled = YES;
    if (!audioPlayerError) {
         [self play];
    } else {
         NSLog(@"AVAudioPlayer:播放错误");
        [self error];
    }
   
}
#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stop];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
     [self stop];
}

#pragma mark - 转数据
- (NSData *)convertWavtoAMR:(NSData *)wavData {
    NSData *data = nil;
    if (wavData) {
        data = EncodeWAVEToAMR(wavData,1,16);
    }
    return data;
}

@end
