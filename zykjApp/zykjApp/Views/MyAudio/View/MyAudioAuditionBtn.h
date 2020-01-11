//
//  MyAudioAuditionBtn.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
// 试听btn

#import <UIKit/UIKit.h>
#import "MyAudioBtn.h"

@interface MyAudioAuditionBtn : MyAudioBtn <MyAudioPlayHelpDelegate>

@property (weak, nonatomic) NSURL *fileUrl;

@end

