//
//  SDAVAssetExportSession+Custom.m
//  ZykjAppWork
//
//  Created by jsl on 2019/8/3.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "SDAVAssetExportSession+Custom.h"

static NSString *const kSDAVAssetExportSessionFileName = @"kSDAVAssetExportSessionFileName";
static NSString *const kSDAVAssetExportSessionFileUrl = @"kSDAVAssetExportSessionFileUrl";
static NSString *const kSDAVAssetExportSessionALAsset = @"kSDAVAssetExportSessionALAsset";
static NSString *const kSDAVAssetExportSessionErrorMsg = @"kSDAVAssetExportSessionErrorMsg";
static NSString *const kSDAVAssetExportSessionIsEnterExportMethod = @"kSDAVAssetExportSessionIsEnterExportMethod";

@implementation SDAVAssetExportSession (Custom)


- (instancetype)initWithAsset:(AVAsset *)asset aLAsset:(id <ExportSessionDelegate>)aLAsset fileUrl:(NSURL *)fileUrl {
    if (self = [self initWithAsset:asset]) {
        self.fileUrl = fileUrl;
        self.aLAsset = aLAsset;
        
        [self configExportParam];
        
    }
    return self;
    
}
- (NSString *)fileName {
    NSString *fileName = objc_getAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionFileName);
    if (fileName.length == 0) {
         NSString *absoluteString = self.fileUrl.absoluteString;
        //问号位置
        NSString *idParams = [self paramValueOfUrl:absoluteString withParam:@"id"];
        
        if (idParams.length) {
         fileName = [idParams md5];
        } else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
            [formatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss"]; //每次启动后都保存一个新的日志文件中
            NSString *dateStr = [formatter stringFromDate:[NSDate date]];
            fileName = [self.fileUrl.lastPathComponent md5];
            fileName = dateStr;
        }
        self.fileName = fileName;
       
    }
    return fileName;
}

- (void)setFileName:(NSString *)fileName {
    objc_setAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionFileName, fileName, OBJC_ASSOCIATION_RETAIN);
}

- (NSURL *)fileUrl {
    return objc_getAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionFileUrl);
}

- (void)setFileUrl:(NSURL *)fileUrl {
    objc_setAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionFileUrl, fileUrl, OBJC_ASSOCIATION_RETAIN);
}

- (void)setALAsset:(id <ExportSessionDelegate>)aLAsset {
    objc_setAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionALAsset, aLAsset, OBJC_ASSOCIATION_RETAIN);
}

- (id <ExportSessionDelegate>)aLAsset {
    return (id <ExportSessionDelegate>)objc_getAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionALAsset);
}

- (NSString *)errorMsg {
    if (self.error) {
        return self.error.description;
    }
     return objc_getAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionErrorMsg);
}

- (void)setErrorMsg:(NSString *)errorMsg {
     objc_setAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionErrorMsg, errorMsg, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isEnterExportMethod {
    NSNumber *value = objc_getAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionIsEnterExportMethod);
    return [value boolValue];
}

- (void)setIsEnterExportMethod:(BOOL)isEnterExportMethod {
      objc_setAssociatedObject(self, (__bridge const void *)kSDAVAssetExportSessionIsEnterExportMethod, @(isEnterExportMethod), OBJC_ASSOCIATION_RETAIN);
}

//手动设置完成下载
- (void)finishs {
    self.progress = 1.0;
    self.status = AVAssetExportSessionStatusCompleted;
}

//手动设置失败下载
- (void)errors {
    NSError *err = self.error;
    if (err == nil) {
        //构建自己的error
        NSString *domain = @"com.zykj.work.ErrorDomain";
        NSString *desc = @"FFmpeg error";
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        err = [NSError errorWithDomain:domain
                                             code:-1
                                         userInfo:userInfo];
    }
    self.error = err;
    self.status = AVAssetExportSessionStatusFailed;
    self.progress = 0;
}

//是否需要压缩
- (BOOL)isNeedCompress {
    NSString *pathExtension =  [self.fileUrl.pathExtension lowercaseString];
    if ([pathExtension isEqualToString:@"mov"] ) {
        return YES;
    }
    
    //每秒钟多大
    long long bitRate_KB = [self videoSizeBySeconds];
    
    return (bitRate_KB > (360 + (50 * MAX(0, (ExportSession_bitsPerPixel - 6)))));
}

/// 配置压缩信息
/// @param exportSession
- (void)configExportParam {
    SDAVAssetExportSession *exportSession = self;
    exportSession.errorMsg = nil;
    NSString *pathExtension =  [exportSession.fileUrl.pathExtension lowercaseString];
    if (![pathExtension isEqualToString:@"mov"] && ![pathExtension isEqualToString:@"mp4"]) {
        [self errorCode:1000 errorMsg:@"只能上传MP4或者MOV格式的视频"];
        return;
    }
    
    if (![self isNeedCompress]) {
        //不需要压缩
        [self errorCode:999 errorMsg:@"不需要压缩视频,可以直接发送视频"];
           
        return;
        
    }
//    if (exportSession.outputURL == nil) {
//        exportSession.errorMsg = @"视频存储路径无效";
//        return;
//    }

    AVAsset *asset = exportSession.asset;
    
    int seconds = [exportSession videoSeconds];
    
    //时间大于超过时间不让上传
    if (seconds > ExportSession_Max_Time) {
        //时长大于限制返回no
         [self errorCode:1001 errorMsg:[NSString stringWithFormat:@"视频时间不能大于%d秒",(int)ExportSession_Max_Time]];
        return;
    }
    
    //时间小于最短时间不让上传
    if (seconds < ExportSession_Min_Time) {
        //时长大于限制返回no
        [self errorCode:1002 errorMsg:[NSString stringWithFormat:@"视频时间不能小于%d秒",(int)ExportSession_Min_Time]];
        return;
    }
    
    if (!exportSession.outputFileType) {
        exportSession.outputFileType = AVFileTypeMPEG4;
        
    }
    
    //写入视频大小
    NSInteger numPixels = ExportSession_video_width  * ExportSession_video_height / 2;
    
    //每像素比特
    CGFloat bitsPerPixel = ExportSession_bitsPerPixel;
    NSInteger bitsPerSecond = numPixels * bitsPerPixel;
    
    
    //是否是竖屏视频
    BOOL isP = YES;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
         CGAffineTransform t = videoTrack.preferredTransform;
       
        CGSize naturalSize = videoTrack.naturalSize;
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
//            degress = 90;
            //旋转90
            naturalSize.width = videoTrack.naturalSize.height;
            naturalSize.height = videoTrack.naturalSize.width;
        }else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
//            degress = 270;
            naturalSize.width = videoTrack.naturalSize.height;
            naturalSize.height = videoTrack.naturalSize.width;
        }else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
//            degress = 0;
           
        }else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
//            degress = 180;
        }
     
         isP = naturalSize.width < naturalSize.height;
//         NSLog(@"=====hello  width:%f===height:%f====%d",videoTrack.naturalSize.width,videoTrack.naturalSize.height,isP);
    }
    
     
    
    
    if (isP) {
        exportSession.videoSettings = @
        {
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: @(ExportSession_video_height),
        AVVideoHeightKey: @(ExportSession_video_width),
        AVVideoCompressionPropertiesKey: @
            {
            AVVideoAverageBitRateKey: @(bitsPerSecond),
            AVVideoProfileLevelKey: AVVideoProfileLevelH264BaselineAutoLevel,
            },
        };
    } else {
        exportSession.videoSettings = @
        {
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: @(ExportSession_video_width),
        AVVideoHeightKey: @(ExportSession_video_height),
        AVVideoCompressionPropertiesKey: @
            {
            AVVideoAverageBitRateKey: @(bitsPerSecond),
            AVVideoProfileLevelKey: AVVideoProfileLevelH264BaselineAutoLevel,
            },
        };
    }
    
    exportSession.audioSettings = @
    {
    AVFormatIDKey: @(kAudioFormatMPEG4AAC),
    AVNumberOfChannelsKey: @(1),
    AVSampleRateKey: @(22050),
        //                    AVEncoderBitRateKey: @128000,
        AVEncoderBitRatePerChannelKey : @(28000)
    };
    exportSession.shouldOptimizeForNetworkUse = YES;
    
    
}

//将相册选中的文件写到本地
- (void)asynWriteFileToLocalWithFilePath:(NSString *)filePath IsAsyn:(BOOL)isAsyn WithBlock:(CompletionWriteBlock)completionWriteBlock {
    
//    if (isAsyn) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            ALAssetRepresentation *rep = [self.aLAsset defaultRepresentation];
//            BOOL success =  [self writeFilePath:filePath ALAssetRepresentation:rep];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (completionWriteBlock) {
//                    completionWriteBlock(self,success);
//                }
//            });
//
//        });
//
//    } else {
//        ALAssetRepresentation *rep = [self.aLAsset defaultRepresentation];
//        BOOL success =  [self writeFilePath:filePath ALAssetRepresentation:rep];
//        if (completionWriteBlock) {
//            completionWriteBlock(self,success);
//        }
//    }
    
    if ([self.aLAsset respondsToSelector:@selector(writeFileToLocalWithFilePath:WithBlock:)]) {
        if (isAsyn) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [(id <ExportSessionDelegate>)self.aLAsset writeFileToLocalWithFilePath:filePath WithBlock:^( BOOL isFinished) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completionWriteBlock) {
                            completionWriteBlock(isFinished);
                        }
                    });
                }];
            });
            
        } else {
            [(id <ExportSessionDelegate>)self.aLAsset writeFileToLocalWithFilePath:filePath WithBlock:^( BOOL isFinished) {
                if (completionWriteBlock) {
                    completionWriteBlock(isFinished);
                }
            }];
        }
    } else {
        NSLog(@"代理需要实现@selector(writeFileToLocalWithFilePath:WithBlock:！");
         completionWriteBlock(NO);
    }
    
}

///获取视频秒数
- (int)videoSeconds {
//    CMTime time = [self.asset duration];
//    //时间
//    int seconds = ceil(time.value/time.timescale);
//    return seconds;
    int seconds = 0;
    if ([self.aLAsset respondsToSelector:@selector(videoSeconds)]) {
        seconds = [(id <ExportSessionDelegate>)self.aLAsset videoSeconds];
    }
    return seconds;
}

///获取视频大小
- (long long)videoSizeBySeconds {
//    ALAssetRepresentation *rep = [self.aLAsset defaultRepresentation];
//      int seconds =[self videoSeconds];
//    //每秒钟多大
//    long long bitRate_KB = (rep.size / seconds) / 1024;
//    return bitRate_KB;
    long long bitRate_KB = 0;
    if ([self.aLAsset respondsToSelector:@selector(videoSizeBySeconds)]) {
           bitRate_KB = [(id <ExportSessionDelegate>)self.aLAsset videoSizeBySeconds];
       }
       return bitRate_KB;
}


#pragma mark -
//取url参数
- (NSString *)paramValueOfUrl:(NSString *) url withParam:(NSString *) param {
    if (!url) {
        return nil;
    }
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}

- (void)errorCode:(NSInteger)code errorMsg:(NSString *)errorMsg {
    NSError *err = self.error;
       if (err == nil) {
           //构建自己的error
           NSString *domain = @"com.zykj.work.ErrorDomain";
           NSString *desc = errorMsg;
           NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
           
           err = [NSError errorWithDomain:domain
                                                code:code
                                            userInfo:userInfo];
       }
       self.error = err;
       self.status = AVAssetExportSessionStatusFailed;
       self.progress = 0;
}

- (BOOL)writeFilePath:(NSString *)filePath ALAssetRepresentation:(ALAssetRepresentation *)rep {
    
    if (!filePath.length) {
        return NO;
    }
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
    unsigned long long fileCurrentOffset = 0;
    unsigned long long fileSize = rep.size;
    while (fileCurrentOffset < fileSize) {
        unsigned long long readSize = 1024 * 1024;
        Byte *buffer = (Byte*)malloc(readSize);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:fileCurrentOffset length:readSize error:nil];
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        [fileHandle writeData:data];
        [fileHandle seekToEndOfFile];
        
        fileCurrentOffset+= buffered;
    }
    [fileHandle closeFile];
    
    return YES;
}
@end
