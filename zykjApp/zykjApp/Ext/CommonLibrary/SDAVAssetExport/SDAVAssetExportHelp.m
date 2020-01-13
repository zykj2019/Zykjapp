//
//  SDAVAssetExportHelp.m
//  ZykjAppClient
//
//  Created by jsl on 2019/12/4.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "SDAVAssetExportHelp.h"

static SDAVAssetExportHelp *_SDAVAssetExportHelp = nil;

//当前正在转换的数量  最多只能同时2个进行
static NSInteger _currentExportingCount = 0;

@interface SDAVAssetExportHelp ()

@property (strong, nonatomic) NSMutableDictionary *exportSessionDict;

@end

@implementation SDAVAssetExportHelp

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SDAVAssetExportHelp = [[SDAVAssetExportHelp alloc] init];
    });
    return _SDAVAssetExportHelp;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.exportSessionDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (SDAVAssetExportSession *)getExportSessionForKey:(NSString *)key {
    @synchronized (self) {
        if (key.length) {
            return self.exportSessionDict[key];
        }
        return nil;
    }
}

- (BOOL)setExportSessionForKey:(NSString *)key exportSession:(SDAVAssetExportSession *)exportSession {
    @synchronized (self) {
        if (key.length) {
            if (self.exportSessionDict[key]) {
                return NO;
            }
            self.exportSessionDict[key] = exportSession;
            [self beginExportNextSession];
            return YES;
        }
        return NO;
    }
}


- (void)removeExportSession:(SDAVAssetExportSession *)exportSession {
    @synchronized (self) {
        for (NSString *key in self.exportSessionDict.allKeys) {
            if (self.exportSessionDict[key] == exportSession ) {
                [self.exportSessionDict removeObjectForKey:key];
                
                _currentExportingCount--;
                NSLog(@"removeExportSession:%ld",(long)_currentExportingCount);
                [self beginExportNextSession];
                break;
            }
        }
    }
}

- (void)beginExportNextSession {
    NSLog(@"beginExportNextSession:%ld",(long)_currentExportingCount);
    if (_currentExportingCount < 0) {
        _currentExportingCount = 0;
    }
    
    if (_currentExportingCount >= 2) {
        //已经达到压缩任务上限
        return;
    }
    SDAVAssetExportSession *emptyExportSession = [self emptyExportSession];
    if (emptyExportSession) {
        NSLog(@"beginExportNextSessionbeginExportNextSession");
        //在exportAsynchronouslyWithCompletionHandler前赋值 因为exportAsynchronouslyWithCompletionHandler异步会有问题
        emptyExportSession.isEnterExportMethod = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
             [emptyExportSession exportAsynchronouslyWithCompletionHandler:emptyExportSession.completionHandler];
        });
//         [emptyExportSession exportAsynchronouslyWithCompletionHandler:emptyExportSession.completionHandler];
           _currentExportingCount++;
    }
   
}

//- (SDAVAssetExportSession *)emptyExportSession:(NSInteger)index {
//    NSArray *exportSessions = self.exportSessionDict.allValues;
//    if (index>=0 && index < exportSessions.count) {
//        SDAVAssetExportSession *exportSession = exportSessions[index];
//        if (exportSession.status == AVAssetExportSessionStatusUnknown) {
//            return exportSession;
//        }
//    } else {
//        return nil;
//    }
//    return [self emptyExportSession:++index];
//
//}

- (SDAVAssetExportSession *)emptyExportSession {
     NSArray *exportSessions = self.exportSessionDict.allValues;
    for (int i = 0; i < exportSessions.count; i++) {
        SDAVAssetExportSession *exportSession = exportSessions[i];
        if (!exportSession.isEnterExportMethod) {
            //返回空闲的exportSession
            return exportSession;
        }
    }
    return nil;
}
@end
