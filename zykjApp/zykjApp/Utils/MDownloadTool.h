//
//  MDownloadTool.h
//  TwoView
//
//  Created by zoulixiang on 16/6/3.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDownloadTool : NSObject

+(BOOL)downloadImgName:(NSString *)imgName andExt:(NSString *)ext andUrl:(NSURL *)url;
@end
