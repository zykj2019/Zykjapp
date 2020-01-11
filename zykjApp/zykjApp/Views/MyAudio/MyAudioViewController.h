//
//  MyAudioViewController.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAudioAuditionBtn.h"

@interface MyAudioViewController : BaseViewController

@property (strong, nonatomic) MyAudioHelp *myAudioHelp;


/**
 完成的dict
 fileUrl:(NSUrl *)文件地址 audioTime:(NSInteger )时间
 */
@property (copy, nonatomic) CommonBlock finishBlock;
@end
