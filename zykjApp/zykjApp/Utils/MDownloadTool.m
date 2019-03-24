//
//  MDownloadTool.m
//  TwoView
//
//  Created by zoulixiang on 16/6/3.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "MDownloadTool.h"

@implementation MDownloadTool


+(BOOL)downloadImgName:(NSString *)imgName andExt:(NSString *)ext andUrl:(NSURL *)url {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *uniquePath = [paths[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",imgName,ext]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if ([ext isEqualToString:@"jpg"]) {
      return  [UIImageJPEGRepresentation(image, 0.75) writeToFile:uniquePath atomically:YES];
        
    } else if([ext isEqualToString:@"png"]){
        return [UIImagePNGRepresentation(image) writeToFile:uniquePath atomically:YES];
    } else {
        return NO;
    }
}
@end
