//
//  MyAudioBtn.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAudioHelp.h"

@interface MyAudioBtn : UIButton

@property (weak, nonatomic) MyAudioHelp *audioHelp;

@property (assign, nonatomic) MyAudioBtnStatus audioStatus;

/**
 录音时间:s
 */
@property (assign, nonatomic) NSInteger timeDuration;

//时间描述
- (NSString *)timeDurationStr;

@end
