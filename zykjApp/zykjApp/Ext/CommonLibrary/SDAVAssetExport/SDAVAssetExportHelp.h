//
//  SDAVAssetExportHelp.h
//  ZykjAppClient
//
//  Created by jsl on 2019/12/4.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDAVAssetExportSession+Custom.h"

@interface SDAVAssetExportHelp : NSObject

+ (instancetype)sharedClient;

- (SDAVAssetExportSession *)getExportSessionForKey:(NSString *)key;

- (BOOL)setExportSessionForKey:(NSString *)key exportSession:(SDAVAssetExportSession *)exportSession;

- (void)removeExportSession:(SDAVAssetExportSession *)exportSession;

@end
